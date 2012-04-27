import apt
import xapian
import re
import os, os.path, urllib
try:
    from debian import deb822
except ImportError:
    from debian_bundle import deb822

APTLISTDIR="/var/lib/apt/lists"

def translationFiles(langs=None):
    # Look for files like: ftp.uk.debian.org_debian_dists_sid_main_i18n_Translation-it
    # And extract the language code at the end
    tfile = re.compile(r"_i18n_Translation-([^-]+)$")
    for f in os.listdir(APTLISTDIR):
        mo = tfile.search(f)
        if not mo: continue
        if langs and not mo.group(1) in langs: continue
        yield urllib.unquote(mo.group(1)), os.path.join(APTLISTDIR, f)

class Indexer:
    def __init__(self, lang, file):
        self.lang = lang
        self.xlang = lang.split("_")[0]
        self.indexer = xapian.TermGenerator()
        # Get a stemmer for this language, if available
        try:
            self.stemmer = xapian.Stem(self.xlang)
            self.indexer.set_stemmer(self.stemmer)
        except xapian.InvalidArgumentError:
            pass

        # Read the translated descriptions
        self.descs = dict()
        desckey = "Description-"+self.lang
        for pkg in deb822.Deb822.iter_paragraphs(open(file)):
            # I need this if because in some translation files, some packages
            # have a different Description header.  For example, in the -de
            # translations, I once found a Description-de.noguide: header
            # instead of Description-de:
            if desckey in pkg:
                self.descs[pkg["Package"]] = pkg[desckey]

    def index(self, document):
        name = document.get_data()
        self.indexer.set_document(document)
        self.indexer.index_text_without_positions(self.descs.get(name, ""))

class TranslatedDescriptions:
    def __init__(self, langs):
        self.langs = langs

    def info(self):
        """
        Return general information about the plugin.

        The information returned is a dict with various keywords:
         
         timestamp (required)
           the last modified timestamp of this data source.  This will be used
           to see if we need to update the database or not.  A timestamp of 0
           means that this data source is either missing or always up to date.
         values (optional)
           an array of dicts { name: name, desc: description }, one for every
           numeric value indexed by this data source.

        Note that this method can be called before init.  The idea is that, if
        the timestamp shows that this plugin is currently not needed, then the
        long initialisation can just be skipped.
        """
        maxts = max([0] + [os.path.getmtime(f) for l, f in translationFiles(self.langs)])
        return dict(timestamp = maxts)

    def init(self, info, progress):
        """
        If needed, perform long initialisation tasks here.

        info is a dictionary with useful information.  Currently it contains
        the following values:

          "values": a dict mapping index mnemonics to index numbers

        The progress indicator can be used to report progress.
        """

        self.indexers = []
        for lang, file in translationFiles(self.langs):
            progress.begin("Reading %s translations from %s" % (lang, file))
            self.indexers.append(Indexer(lang, file))
            progress.end()

    def doc(self):
        """
        Return documentation information for this data source.

        The documentation information is a dictionary with these keys:
          name: the name for this data source
          shortDesc: a short description
          fullDoc: the full description as a chapter in ReST format
        """
        return dict(
            name = "Translated package descriptions",
            shortDesc = "terms extracted from the translated package descriptions using Xapian's TermGenerator",
            fullDoc = """
            The TranslatedDescriptions data source reads translated description
            files from %s, then uses Xapian's TermGenerator to tokenise and
            index their content.

            Currently this creates normal terms as well as stemmed terms
            prefixed with ``Z``.
            """ % APTLISTDIR
        )

    def index(self, document, pkg):
        """
        Update the document with the information from this data source.

        document  is the document to update
        pkg       is the python-apt Package object for this package
        """
        for i in self.indexers:
            i.index(document)

    def indexDeb822(self, document, pkg):
        """
        Update the document with the information from this data source.

        This is alternative to index, and it is used when indexing with package
        data taken from a custom Packages file.

        document  is the document to update
        pkg       is the Deb822 object for this package
        """
        for i in self.indexers:
            i.index(document)

def init(langs=None, **kw):
    """
    Create and return the plugin object.
    """
    if not langs: return None
    files = [f for l, f in translationFiles(langs)]
    if len(files) == 0:
        return None
    return TranslatedDescriptions(langs=langs)
