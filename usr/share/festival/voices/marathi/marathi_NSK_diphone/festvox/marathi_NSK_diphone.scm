;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                             ;;
;;;        A diphone voice for Marathi language                                  ;;
;;;                                                                             ;;
;;;  Copyright (c) 2005, DONLab, Dept. of CS&E,                                 ;; 
;;;                      IIT Madras <speech@lantana.tenet.res.in>               ;; 
;;;  Copyright (c) 2005, Chaitanya Kamisetty <chaitanya@atc.tcs.co.in>          ;;
;;;                                                                             ;;
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


;;; Try to find out where we are
(if (assoc 'marathi_NSK_diphone voice-locations)
    (defvar marathi_dir 
      (cdr (assoc 'marathi_NSK_diphone voice-locations)))
    ;;; Not installed in Festival yet so assume running in place
    (defvar marathi_dir (pwd)))

(if (not (probe_file (path-append marathi_dir "festvox/")))
    (begin
     (format stderr "marathi_NSK_diphone Can't find voice scm files they are not in\n")
     (format stderr "   %s\n" (path-append marathi_dir "festvox/"))
     (format stderr "   Either the voice isn't linked into Festival\n")
     (format stderr "   or you are starting festival in the wrong directory\n")
     (error)))

;;;  Add the directory contains general voice stuff to load-path
(set! load-path (cons (path-append marathi_dir "festvox/") load-path))
;;;  Path for common marathi modules
;;; Debian distribution defines datadir, others use libdir
(if (symbol-bound? 'datadir)
	(set! load-path (cons (path-append datadir "marathi_scm/") load-path)))
(set! load-path (cons (path-append libdir "marathi_scm/") load-path))

;;; other files we need
(require 'marathi_phones)
(require 'marathi_lex)
(require 'marathi_token)
(require 'marathi_NSK_int)
(require 'marathi_NSK_dur)
(require 'marathi_NSK_ene)

;;;  Ensure we have a festival with the right diphone support compiled in
(require_module 'UniSyn)

(set! marathi_lpc_sep 
     (list
      '(name "marathi_lpc_sep")
      (list 'index_file (path-append marathi_dir "dic/NSKdiph.est"))
      '(grouped "false")
      (list 'coef_dir (path-append marathi_dir "lpc"))
      (list 'sig_dir  (path-append marathi_dir "lpc"))
      '(coef_ext ".lpc")
      '(sig_ext ".res")
      (list 'default_diphone 
	     (string-append
	      (car (cadr (car (PhoneSet.description '(silences)))))
	      "-"
	      (car (cadr (car (PhoneSet.description '(silences)))))))))

(set! marathi_lpc_group 
     (list
      '(name "NSK_lpc_group")
      (list 'index_file 
	     (path-append marathi_dir "group/NSKlpc.group"))
      '(grouped "true")
      (list 'default_diphone 
	     (string-append
	      (car (cadr (car (PhoneSet.description '(silences)))))
	      "-"
	      (car (cadr (car (PhoneSet.description '(silences)))))))))

;;Go ahead and set up the diphone db
;(set! marathi_db_name (us_diphone_init marathi_lpc_sep))
;;Once you've built the group file you can comment out the above and
;;uncomment the following.
(set! marathi_db_name (us_diphone_init marathi_lpc_group))


(define (marathi_NSK_diphone_fix utt)
"(marathi_NSK_diphone_fix UTT)
Map phones to phonological variants if the diphone database supports
them."
  (mapcar
   (lambda (s)
     (let ((name (item.name s)))
       ;; Check and do something maybe 
       ))
   (utt.relation.items utt 'Segment))
  utt)

(define (marathi_voice_reset)
  "(marathi_voice_reset)
Reset global variables back to previous voice."
  ;; whatever
)


(define (marathi_NSK_diphone_fix_phone_name utt seg)
"(marathi_fix_phone_name UTT SEG)
Add the feature diphone_phone_name to given segment with the appropriate
name for constructing a diphone.  Basically adds _ if either side is part
of the same consonant cluster, adds $ either side if in different
syllable for preceding/succeeding vowel syllable."
  (let ((name (item.name seg)))
    (cond
     ((string-equal name "pau") t)
     ((string-equal "-" (item.feat seg 'ph_vc))
      (if (and (member_string name '(r w y l))
	       (member_string (item.feat seg "p.name") '(p t k b d g))
	       (item.relation.prev seg "SylStructure"))
	  (item.set_feat seg "us_diphone_right" (format nil "_%s" name)))
      (if (and (member_string name '(w y l m n p t k))
	       (string-equal (item.feat seg "p.name") 's)
	       (item.relation.prev seg "SylStructure"))
	  (item.set_feat seg "us_diphone_right" (format nil "_%s" name)))
      (if (and (string-equal name 's)
	       (member_string (item.feat seg "n.name") '(w y l m n p t k))
	       (item.relation.next seg "SylStructure"))
	  (item.set_feat seg "us_diphone_left" (format nil "%s_" name)))
      (if (and (string-equal name 'hh)
	       (string-equal (item.feat seg "n.name") 'y))
	  (item.set_feat seg "us_diphone_left" (format nil "%s_" name)))
      (if (and (string-equal name 'y)
	       (string-equal (item.feat seg "p.name") 'hh))
	  (item.set_feat seg "us_diphone_right" (format nil "_%s" name)))
      (if (and (member_string name '(p t k b d g))
	       (member_string (item.feat seg "n.name") '(r w y l))
	       (item.relation.next seg "SylStructure"))
	  (item.set_feat seg "us_diphone_left" (format nil "%s_" name)))
      )
     ((string-equal "ah" (item.name seg))
      (item.set_feat seg "us_diphone" "aa"))

   )))


;;;  Full voice definition 
(define (voice_marathi_NSK_diphone)
"(voice_marathi_NSK_diphone)
Set speaker to NSK in marathi from DON."
  (voice_reset)
  (Parameter.set 'Language 'marathi)
  ;; Phone set
  (Parameter.set 'PhoneSet 'marathi)
  (PhoneSet.select 'marathi)

  ;; token expansion (numbers, symbols, compounds etc)
  (Parameter.set 'Token_Method 'Token_Any)
  (set! token_to_words marathi_token_to_words)

  ;; No pos prediction (get it from lexicon)
  (set! pos_lex_name nil)
  (set! guess_pos marathi_guess_pos) 
  ;; Phrase break prediction by punctuation
  (set! pos_supported nil) ;; well not real pos anyhow
  ;; Phrasing
  (set! phrase_cart_tree marathi_phrase_cart_tree_2)
  (Parameter.set 'Phrase_Method 'cart_tree)
  ;; Lexicon selection
  (lex.select "marathi")

  ;; No postlexical rules
  (set! postlex_rules_hooks nil)

  ;; Accent and tone prediction 
  
  (set! int_accent_cart_tree marathi_accent_cart_tree)
  (Parameter.set 'Int_Target_Method 'Simple) 

  ;; Duration prediction
  (set! duration_cart_tree marathi_NSK::zdur_tree) 

  ;;(set! duration_ph_info marathi_NSK::phone_data)
  (set! duration_ph_info marathi_NSK::phone_durs)   
  (Parameter.set 'Duration_Method 'Tree_ZScores)
  (Parameter.set 'Duration_Stretch 1.4)

  
  ;; Energy prediction
  (set! energy_cart_tree marathi_NSK::zene_treeMAX2) 
  (set! energy_ph_info marathi_NSK::phone_enesMAX2)
  (Parameter.set 'Energy_Method 'Tree_ZScores)

  ;; Waveform synthesizer: diphones
  (set! UniSyn_module_hooks (list marathi_NSK_diphone_fix))
  (set! us_abs_offset 0.0)
  (set! window_factor 1.0)
  (set! us_rel_offset 0.0)
  (set! us_gain 0.9)

  (Parameter.set 'Synth_Method 'UniSyn)
  (Parameter.set 'us_sigpr 'lpc)
  (us_db_select marathi_db_name)


  ;; set callback to restore some original values changed by this voice
  (set! current_voice_reset marathi_voice_reset)

  (set! current-voice 'marathi_NSK_diphone)
)

(proclaim_voice

 'marathi_NSK_diphone
 '((language marathi)
   (gender male)
   (dialect COMMENT)
   (description
    "COMMENT"
    )
   (builtwith festvox-1.2)
   (coding UTF-8)
   ))
(provide 'marathi_NSK_diphone)
