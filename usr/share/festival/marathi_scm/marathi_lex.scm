;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                             ;;
;;;  Lexical Analysis: lexical lookup, letter-to-sound rules (words to phones)  ;;
;;;                                                                             ;;
;;;  Copyright (c) 2005, Chaitanya Kamisetty <chaitanya@atc.tcs.co.in>          ;;
;;;  										;;
;;;  Copyright (c) 2006, Priti Patil, janabhaaratii, C-DAC, Mumbai              ;;
;;;                     <prithisd@cdacmumbai.in>, <prithisd@gmail.com>          ;;
;;;  										;;
;;;  This program is a part of festival-mr.					;;
;;;  										;;
;;;  festival-mr is free software; you can redistribute it and/or modify        ;;
;;;  it under the terms of the GNU General Public License as published by	;;
;;;  the Free Software Foundation; either version 2 of the License, or		;;
;;;  (at your option) any later version.					;;
;;;										;;
;;;  This program is distributed in the hope that it will be useful,		;;
;;;  but WITHOUT ANY WARRANTY; without even the implied warranty of		;;
;;;  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the		;;
;;;  GNU General Public License for more details.				;;
;;;										;;
;;;  You should have received a copy of the GNU General Public License		;;
;;;  along with this program; if not, write to the Free Software		;;
;;;  Foundation, Inc., 51 Franklin St, Fifth Floor, Boston, MA  02110-1301 USA  ;;
;;;										;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(define (marathi_addenda)
  "(marathi_addenda)
Basic lexicon should (must ?) basic letters and punctuation."
;; Basic punctuation must be in with nil pronunciation
(lex.add.entry '("'" punc nil))
(lex.add.entry '(":" punc nil))
(lex.add.entry '(";" punc nil))
(lex.add.entry '("," punc nil))
(lex.add.entry '("." punc nil))
(lex.add.entry '("-" punc nil))
(lex.add.entry '("\"" punc nil))
(lex.add.entry '("`" punc nil))
(lex.add.entry '("?" punc nil))
(lex.add.entry '("!" punc nil))
(lex.add.entry '("(" punc nil))
(lex.add.entry '(")" punc nil))
(lex.add.entry '("{" punc nil))
(lex.add.entry '("}" punc nil))
(lex.add.entry '("[" punc nil))
(lex.add.entry '("]" punc nil))
)

(lts.ruleset
 marathi
  ( 
	; Matras can be formed by (OCT340 OCT244 MAT1 )  and (OCT340 OCT245 MAT2)
	( OCT340 � ) 
	( OCT244 � )
	( OCT245 � )
	( MAT1 � � )
	( MAT2 � � � � � � � � � � � � � � � � � � � � )
  )
  (
;; single vowels
( [ � � � ] = a ) ;marathi letter A 
( [ � � � ] = aa ) ;marathi letter AA
( [ � � � ] = ih ) ;marathi letter I
( [ � � � ] = iy ) ;marathi letter II
( [ � � � ] = uh ) ;marathi letter U
( [ � � � ] = uw ) ;marathi letter UU 
( [ � � � ] = r uh ) ;marathi letter vocalic R 
( [ � � � ]  = r uw ) ;marathi letter vocalic RR 
([ � � � ] =  l uh ) ; marathi letter vocalic L (using 'lu' sound)
([ � � � ] = l uw ) ; marathi letter vocalic LL (uinsg 'luu' sound)
( [ � � � ] = eh ) ;U+090D marathi letter chandra E
( [ � � �  ] = ay ) ;U+090E DEVANAGARI LETTER SHORT E (for transcribing Dravidian short e)
( [ � � � ] = eh ) ;marathi letter E
;( [ � � � ] = ee ) ;no marathi letter EE
( [ � � � ] = ay ) ;marathi letter AI
( [ � � � ] = oo ) ;U+0911 DEVANAGARI LETTER CANDRA O
( [ � � � ] = oh )  ;marathi letter O 
( [ � � � ] = oh )  ;U+0912 DEVANAGARI LETTER SHORT O 
( [ � � � ] = aw ) ;marathi letter AU
( [ � � � ]  = m ) ;marathi sign anusvara (sunna) (using 'ma' sound)
([ � � � ] = h a ) ;marathi sign visarga (using 'ha' sound)
;; consonants in half forms i.e. consonant + halant
( [ � � � � � � ]  = k ) ;marathi letter K
( [ � � � � � � ]  = k ) ;U+0958 DEVANAGARI LETTER QA ( U+0915 DEVANAGARI LETTER KA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � � � � ] = kh ) ;marathi letter KH
( [ � � � � � � ]  = kh ) ;U+0959 DEVANAGARI LETTER KHHA (U+0916 DEVANAGARI LETTER KHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � � � � ] = g ) ;marathi letter G
( [ � � � � � � ]  = g ) ;U+095A DEVANAGARI LETTER GHHA (U+0917 DEVANAGARI LETTER GA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � � � � ] = g h ) ;marathi letter GH
( [ � � � � � � ] = n y ) ;marathi letter NG
( [ � � � � � � ] = ch ) ;marathi letter C
( [ � � � � � � ] = ch h )	;marathi letter CH 
( [ � � � � � � ] = j ) ;marathi letter J
( [ � � � � � � ]  = j ) ;U+095B DEVANAGARI LETTER ZA ( U+091C DEVANAGARI LETTER JA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � � � � ] = j h )	;marathi letter JH (missing in phoneset)
( [ � � � � � � ] = eh n eh )	;marathi letter NY (missing in phoneset)
( [ � � � � � � ] = T ) ;marathi letter TT
( [ � � � � � � ] = T h )	;marathi letter TTH (missing in phoneset)
( [ � � � � � � ] = D ) ;marathi letter DD
( [ � � � � � � ]  = D ) ;U+095C DEVANAGARI LETTER DDDHA (U+0921 DEVANAGARI LETTER DDA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � � � � ] = D h ) ;marathi letter DDH (missing in phoneset)
( [ � � � � � � ]  = D h) ;U+095D DEVANAGARI LETTER RHA (U+0922 DEVANAGARI LETTER DDHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � � � � ] = N ) ;marathi letter NN (missing in phoneset)
( [ � � � � � � ] = th )	;marathi letter T (missing in phoneset)
( [ � � � � � � ] = tth ) ;marathi letter TH
( [ � � � � � � ] = dh )	;marathi letter D (missing in phoneset)
( [ � � � � � � ] = ddh )	;marathi letter DH
( [ � � � � � � ] = n ) ;marathi letter N
( [ � � � � � � ] = n ) ;half marathi letter NNNA (U+0928 DEVANAGARI LETTER NA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � � � � ] = p ) ;marathi letter P
( [ � � � � � � ] = f ) ;marathi letter PH
( [ � � � � � � ]  = f ) ;U+095E DEVANAGARI LETTER FA (U+092B DEVANAGARI LETTER PHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � � � � ] = b ) ;marathi letter B
( [ � � � � � � ] = bh ) ;marathi letter BH
( [ � � � � � � ] = m ) ;marathi letter M
( [ � � � � � � ] = y ) ;marathi letter Y
( [ � � � � � � ]  = y ) ;U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � � � � ] = r ) ;marathi letter R
( [ � � � � � � ] = r ) ;half marathi letter U+0931 RRA ( U+0930 DEVANAGARI LETTER RA + U+093C DEVANAGARI SIGN NUKTA)  for transcribing Dravidian alveolar r and half form is represented as "Eyelash RA"
( [ � � � � � � ] = l ) ;marathi letter L 
( [ � � � � � � ] = L ) ;marathi letter LL
( [ � � � � � � ] = L ) ;half marathi letter LLLA, U+0934 DEVANAGARI LETTER LLLA (U+0933 DEVANAGARI LETTER LLA + U+093C DEVANAGARI SIGN NUKTA) for transcribing Dravidian l
( [ � � � � � � ] = v ) ;marathi letter V
( [ � � � � � � ] = sh ) ;marathi letter SH
( [ � � � � � � ] = sh h ) ;marathi letter SS
( [ � � � � � � ] = s ) ;marathi letter S (missing in phoneset)
( [ � � � � � � ] = h ) ;marathi letter H
;;consonants occuring as vattulu
;; matches the regex [consonant]{consonant}
( [ � � � ]  OCT340 OCT244 MAT1  =  k ) ;marathi letter K
( [ � � � ]  OCT340 OCT244 MAT1  =  k ) ;marathi letter K U+0958 DEVANAGARI LETTER QA ( U+0915 DEVANAGARI LETTER KA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]  OCT340 OCT244 MAT1 = kh ) ;marathi letter KH
( [ � � � ]  OCT340 OCT244 MAT1 = kh ) ;marathi letter KH U+0959 DEVANAGARI LETTER KHHA (U+0916 DEVANAGARI LETTER KHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT244 MAT1 = g ) ;marathi letter G
( [ � � � ]   OCT340 OCT244 MAT1 = g ) ;marathi letter G U+095A DEVANAGARI LETTER GHHA (U+0917 DEVANAGARI LETTER GA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT244 MAT1 = g h ) ;marathi letter GH
( [ � � � ]  OCT340 OCT244 MAT1 = n y ) ;marathi letter NG
( [ � � � ]   OCT340 OCT244 MAT1 = ch ) ;marathi letter C
( [ � � � ]  OCT340 OCT244 MAT1  = ch h ) ;marathi letter CH
( [ � � � ]  OCT340 OCT244 MAT1  = j ) ;marathi letter J
( [ � � � ]  OCT340 OCT244 MAT1  = j ) ;marathi letter J U+095B DEVANAGARI LETTER ZA ( U+091C DEVANAGARI LETTER JA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT244 MAT1 = j h ) ;marathi letter JH
( [ � � � ]   OCT340 OCT244 MAT1 = eh n eh ) ;marathi letter NY
( [ � � � ]   OCT340 OCT244 MAT1 = T ) ;marathi letter TT
( [ � � � ]   OCT340 OCT244 MAT1 = T h ) ;marathi letter TTH
( [ � � � ]   OCT340 OCT244 MAT1 = D ) ;marathi letter DD 
( [ � � � ]   OCT340 OCT244 MAT1 = D ) ;marathi letter DD U+095C DEVANAGARI LETTER DDDHA (U+0921 DEVANAGARI LETTER DDA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT244 MAT1 = D h ) ;marathi letter DDH 
( [ � � � ]   OCT340 OCT244 MAT1 = D h ) ;marathi letter DDH U+095D DEVANAGARI LETTER RHA (U+0922 DEVANAGARI LETTER DDHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT244 MAT1 = N ) ;marathi letter NN
( [ � � � ]   OCT340 OCT244 MAT1 = th ) ;marathi letter T
( [ � � � ]  OCT340 OCT244 MAT1  = tth ) ;marathi letter TH
( [ � � � ]   OCT340 OCT244 MAT1 = dh ) ;marathi letter D
( [ � � � ]   OCT340 OCT244 MAT1 = ddh ) ;marathi letter DH
( [ � � � ]   OCT340 OCT244 MAT1 = n ) ;marathi letter N
( [ � � � ]   OCT340 OCT244 MAT1 = n ) ;marathi letter N
( [ � � � ]   OCT340 OCT244 MAT1 = p ) ;marathi letter P
( [ � � � ]   OCT340 OCT244 MAT1 = f ) ;marathi letter PH 
( [ � � � ]   OCT340 OCT244 MAT1 = f ) ;marathi letter PH U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT244 MAT1 = b ) ;marathi letter B
( [ � � � ]   OCT340 OCT244 MAT1 = bh ) ;marathi letter BH
( [ � � � ]   OCT340 OCT244 MAT1 = m ) ;marathi letter M
( [ � � � ]   OCT340 OCT244 MAT1 = y ) ;marathi letter Y 
( [ � � � ]   OCT340 OCT244 MAT1 = y ) ;marathi letter Y U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT244 MAT1 = r ) ;marathi letter R
( [ � � � ] OCT340 OCT244 MAT1 = r ) ;marathi letter RR
( [ � � � ]  OCT340 OCT244 MAT1  = l) ;marathi letter L
( [ � � � ]   OCT340 OCT244 MAT1 = L ) ;marathi letter LL
( [ � � � ]   OCT340 OCT244 MAT1 = L ) ;marathi letter LLLA, U+0934 DEVANAGARI LETTER LLLA (U+0933 DEVANAGARI LETTER LLA + U+093C DEVANAGARI SIGN NUKTA) for transcribing Dravidian l
( [ � � � ]   OCT340 OCT244 MAT1 = v ) ;marathi letter V
( [ � � � ]   OCT340 OCT244 MAT1 = sh ) ;marathi letter SH
( [ � � � ]   OCT340 OCT244 MAT1 = sh h ) ;marathi letter SS
( [ � � � ]   OCT340 OCT244 MAT1 = s ) ;marathi letter S
( [ � � � ]   OCT340 OCT244 MAT1 = h ) ;marathi letter H
( [ � � � ]   OCT340 OCT245 MAT2  =  k ) ;marathi letter K
( [ � � � ]  OCT340 OCT245 MAT2  =  k ) ;marathi letter K U+0958 DEVANAGARI LETTER QA ( U+0915 DEVANAGARI LETTER KA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]  OCT340 OCT245 MAT2   = kh ) ;marathi letter KH
( [ � � � ]  OCT340 OCT245 MAT2 = kh ) ;marathi letter KH U+0959 DEVANAGARI LETTER KHHA (U+0916 DEVANAGARI LETTER KHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]  OCT340 OCT245 MAT2   = g ) ;marathi letter G
( [ � � � ]   OCT340 OCT245 MAT2 = g ) ;marathi letter G U+095A DEVANAGARI LETTER GHHA (U+0917 DEVANAGARI LETTER GA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT245 MAT2  = g h ) ;marathi letter GH
( [ � � � ]   OCT340 OCT245 MAT2  = n y ) ;marathi letter NG
( [ � � � ]   OCT340 OCT245 MAT2  = ch ) ;marathi letter C
( [ � � � ]  OCT340 OCT245 MAT2  = ch h ) ;marathi letter CH
( [ � � � ]  OCT340 OCT245 MAT2  = j ) ;marathi letter J
( [ � � � ]  OCT340 OCT245 MAT2  = j ) ;marathi letter J U+095B DEVANAGARI LETTER ZA ( U+091C DEVANAGARI LETTER JA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT245 MAT2  = j h ) ;marathi letter JH
( [ � � � ]   OCT340 OCT245 MAT2  = eh n eh ) ;marathi letter NY
( [ � � � ]  OCT340 OCT245 MAT2   = T ) ;marathi letter TT
( [ � � � ]   OCT340 OCT245 MAT2  = T h ) ;marathi letter TTH
( [ � � � ]   OCT340 OCT245 MAT2  = D ) ;marathi letter DD
( [ � � � ]   OCT340 OCT245 MAT2 = D ) ;marathi letter DD U+095C DEVANAGARI LETTER DDDHA (U+0921 DEVANAGARI LETTER DDA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT245 MAT2  = D h ) ;marathi letter DDH
( [ � � � ]   OCT340 OCT245 MAT2 = D h ) ;marathi letter DDH U+095D DEVANAGARI LETTER RHA (U+0922 DEVANAGARI LETTER DDHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]  OCT340 OCT245 MAT2   = N ) ;marathi letter NN
( [ � � � ]   OCT340 OCT245 MAT2  = th ) ;marathi letter T
( [ � � � ]  OCT340 OCT245 MAT2   = tth ) ;marathi letter TH
( [ � � � ]   OCT340 OCT245 MAT2  = dh ) ;marathi letter D
( [ � � � ]   OCT340 OCT245 MAT2  = ddh ) ;marathi letter DH
( [ � � � ]   OCT340 OCT245 MAT2  = n ) ;marathi letter N
( [ � � � ]   OCT340 OCT245 MAT2  = n ) ;marathi letter N
( [ � � � ]   OCT340 OCT245 MAT2  = p ) ;marathi letter P
( [ � � � ]   OCT340 OCT245 MAT2  = f ) ;marathi letter PH
( [ � � � ]   OCT340 OCT244 MAT2 = f ) ;marathi letter PH U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]   OCT340 OCT245 MAT2  = b ) ;marathi letter B
( [ � � � ]   OCT340 OCT245 MAT2  = bh ) ;marathi letter BH
( [ � � � ]   OCT340 OCT245 MAT2  = m ) ;marathi letter M
( [ � � � ]   OCT340 OCT245 MAT2  = y ) ;marathi letter Y
( [ � � � ]   OCT340 OCT245 MAT2 = y ) ;marathi letter Y U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ]  OCT340 OCT245 MAT2   = r ) ;marathi letter R
([ � � � ] OCT340 OCT245 MAT2  = r ) ;marathi letter RR
( [ � � � ]   OCT340 OCT245 MAT2  = l) ;marathi letter L
( [ � � � ]  OCT340 OCT245 MAT2   = L ) ;marathi letter LL
( [ � � � ]   OCT340 OCT245 MAT2 = L ) ;marathi letter LLLA, U+0934 DEVANAGARI LETTER LLLA (U+0933 DEVANAGARI LETTER LLA + U+093C DEVANAGARI SIGN NUKTA) for transcribing Dravidian l
( [ � � � ]   OCT340 OCT245 MAT2  = v ) ;marathi letter V
( [ � � � ]   OCT340 OCT245 MAT2  = sh ) ;marathi letter SH
( [ � � � ]   OCT340 OCT245 MAT2  = sh h ) ;marathi letter SS
( [ � � � ]  OCT340 OCT245 MAT2   = s ) ;marathi letter S
( [ � � � ]   OCT340 OCT245 MAT2  = h ) ;marathi letter H
;consonants
( [ � � � ]   =  k a ) ;marathi letter KA
( [ � � � ]  =  k a ) ;marathi letter KA U+0958 DEVANAGARI LETTER QA ( U+0915 DEVANAGARI LETTER KA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ] = kh a ) ;marathi letter KHA
( [ � � � ] = kh a ) ;marathi letter KHA +0959 DEVANAGARI LETTER KHHA (U+0916 DEVANAGARI LETTER KHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ] = g a ) ;marathi letter GA
( [ � � � ] = g a ) ;marathi letter GA U+095A DEVANAGARI LETTER GHHA (U+0917 DEVANAGARI LETTER GA + U+093C DEVANAGARI SIGN NUKTA) 
( [ � � � ] = g h a ) ;marathi letter GHA
( [ � � � ] = n y a ) ;marathi letter NGA
( [ � � � ] = ch a ) ;marathi letter CA
( [ � � � ] = ch h a ) ;marathi letter CHA
( [ � � � ] = j a ) ;marathi letter JA
( [ � � � ] = j a ) ;marathi letter JA U+095B DEVANAGARI LETTER ZA ( U+091C DEVANAGARI LETTER JA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ] = j h a ) ;marathi letter JHA
( [ � � � ] = eh n eh a ) ;marathi letter NYA
( [ � � � ] = T a ) ;marathi letter TTA
( [ � � � ] = T h a ) ;marathi letter TTHA
( [ � � � ] = D a ) ;marathi letter DDA 
( [ � � � ] = D a ) ;marathi letter DDA U+095C DEVANAGARI LETTER DDDHA (U+0921 DEVANAGARI LETTER DDA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ] = D h a ) ;marathi letter DDHA
( [ � � � ] = D h a ) ; marathi letter DDHA U+095D DEVANAGARI LETTER RHA (U+0922 DEVANAGARI LETTER DDHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ] = N a ) ;marathi letter NNA
( [ � � � ] = th a ) ;marathi letter TA
( [ � � � ] = tth a ) ;marathi letter THA
( [ � � � ] = dh a ) ;marathi letter D
( [ � � � ] = ddh a ) ;marathi letter DHA
( [ � � � ] = n a ) ;marathi letter NA
( [ � � � ] = n a ) ;indi letter NA U+0928 DEVANAGARI LETTER NA + U+093C DEVANAGARI SIGN NUKTA
( [ � � � ] = p a ) ;marathi letter PA
( [ � � � ] = f a ) ;marathi letter PHA
( [ � � � ] = f a ) ;marathi letter PHA U+095E DEVANAGARI LETTER FA (U+092B DEVANAGARI LETTER PHA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ] = b a ) ;marathi letter BA
( [ � � � ] = bh a ) ;marathi letter BHA
( [ � � � ] = m a ) ;marathi letter MA
( [ � � � ] = y a ) ;marathi letter YA
( [ � � � ] = y a ) ;marathi letter YA U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ � � � ] = r a ) ;marathi letter RA
( [ � � � ] = r a ) ;marathi letter RRA
( [ � � � ] = l a ) ;marathi letter LA
( [ � � � ] = L a ) ;marathi letter LLA
( [ � � � ] = L a ) ;marathi letter LLA U+0934 DEVANAGARI LETTER LLLA (U+0933 DEVANAGARI LETTER LLA + U+093C DEVANAGARI SIGN NUKTA) for transcribing Dravidian l
( [ � � � ] = v a ) ;marathi letter VA
( [ � � � ] = sh a ) ;marathi letter SHA
( [ � � � ] = sh h a ) ;marathi letter SSA
( [ � � � ] = s a ) ;marathi letter SA
( [ � � � ] = h a ) ;marathi letter HA
( [ � � � ] = oh m) ;U+0950 DEVANAGARI OM 
;;dependent vowels
( [ � � � ] = ay ) ;marathi vowel sign AI 0C46 (E)+ 0C56(AI Length Mark)
( [ � � � ] =  aa )  ;marathi vowel sign AA
( [ � � � ] =  ih ) ;marathi vowel sign I
( [ � � � ] = iy ) ;marathi vowel sign II
( [ � � � ] = uh ) ;marathi vowel sign U
( [ � � � ] = uw ) ;marathi vowel sign UU
( [ � � � ] = r eh )  ;marathi vowel sign vocalic R
( [ � � � ] = r ee )  ;marathi vowel sign vocalic RR
( [ � � � ] = ee ) ;marathi vowel sign chandra E
( [ � � � ] = n ) ;marathi U+0901 DEVANAGARI SIGN CANDRABINDU
( [ � � � ] = eh ) ;marathi vowel sign short E (for transcribing Dravidian vowels)
( [ � � � ] = eh ) ;marathi vowel sign E
( [ � � � ] = ay ) ;marathi vowel sign AI
( [ � � � ] = oo ) ;marathi vowel sign chandra O
( [ � � � ] = oh ) ;U+094A DEVANAGARI VOWEL SIGN SHORT O (for transcribing Dravidian vowels)
( [ � � � ] = oh ) ;marathi vowel sign O
( [ � � � ] = aw ) ;marathi vowel sign AU
;( [ � � � ]= )  ;ignoring nukta sign U+093C
;( [ � � � ] = ) ;ignoring U+093D DEVANAGARI SIGN AVAGRAHA
( [ � � � ] = ) ;ignoring U+094D DEVANAGARI SIGN VIRAMA, halant (the preferred Marathi name)

   )
)

;;; Lexicon definition
(lex.create "marathi")
(lex.set.phoneset "marathi")

(define (marathi_lts_function word features)
  "(marathi_lts_function WORD FEATURES)
 Using letter to sound rules to bulid a marathi pronunciation of WORD."
   (list word
	 nil
          (lex.syllabify.phstress (lts.apply (downcase word) 'marathi))))
(lex.set.lts.method 'marathi_lts_function)
(marathi_addenda)

(provide 'marathi_lex)


