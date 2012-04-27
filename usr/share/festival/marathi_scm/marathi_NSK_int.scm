;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                             ;;
;;; 		       Accent and F0 prediction				        ;;
;;;									        ;;
;;;                Phrase breaks use punctuation			        ;;
;;;                                                                             ;;
;;;  Copyright (c) 2005, DONLab, Dept. of CS&E,                                 ;; 
;;;                      IIT Madras <speech@lantana.tenet.res.in>               ;; 
;;;                                                                             ;;
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

(set! marathi_phrase_cart_tree
'
((lisp_token_end_punc in ("." ":" "?" "!" " "))
 ((BB))
  ((lisp_token_end_punc in ("'" "\"" "," ";"))
   ((B))
   ((n.name is 0) ;; end of utterance
    ((BB))
    ((NB))))))

(set! marathi_accent_cart_tree
  '
  (
   (R:SylStructure.gpos is content)
    ( (stress is 1)
       ((Accented))
       ((NONE))
    )
  )
)
;;------------- Morph tagger Start -------------------------------------------

(define (since_punctuation word)
     "(since_punctuation word)
    Number of words since last punctuation or beginning of utterance."
     (cond
       ((null word) 0) ;; beginning or utterance
       ((not (string-equal "1" (item.feat word 'p.word_break))) 0)
       (t
        (+ 1 (since_punctuation (item.prev word))))))

    (define (until_punctuation word)
     "(until_punctuation word)
    Number of words until next punctuation or end of utterance."
     (cond
       ((null word) 0) ;; beginning or utterance
       ((not (string-equal "1" (item.feat word 'word_break))) 0)
       (t
        (+ 1 (until_punctuation (item.next word))))))

  (set! marathi_phrase_cart_tree_2
    '
    ((lisp_token_end_punc in ("?" "." ":"))
      ((B))
      ((lisp_token_end_punc in ("'" "\"" "," ";"))
       ((B))
       ((n.name is 0)  ;; end of utterance
        ((BB))
        ((lisp_since_punctuation > 5)
         ((lisp_until_punctuation > 5)
          ((gpos is content)
           ((n.gpos content)
            ((NB))
            ((B)))   ;; not content so a function word
           ((NB)))   ;; this is a function word
          ((NB)))    ;; to close to punctuation
          ((NB)))     ;; to soon after punctuation
        ((NB))))))

  (set! marathi_guess_pos
          '((in of for in on that with by at from as if that against about 
        before because if under after over into while without
        through new between among until per up down)
    (to to)
    (det the a an no some this that each another those every all any 
         these both neither no many)
    (md will may would can could should must ought might)
    (cc and but or plus yet nor)
    (wp who what where how when)
    (pps her his their its our their its mine)
    (aux is am are was were has have had be)
  ;  (punc "." "," ":" ";" "\"" "'" "(" "?" ")" "!")
    ))

(define (morph_tag word)
     "(morph_tag word)
    Return the appropriate morph tag for the word."
(cond
((string-matches (item.name word) ".*lO") 'lO)
((string-matches (item.name word) ".*tO") 'tO)
((string-matches (item.name word) ".*Aru") 'Aru)
((string-matches (item.name word) ".*ndi") 'ndi)
((string-matches (item.name word) ".*ani") 'ani)
((string-matches (item.name word) ".*lu") 'lu)
((string-matches (item.name word) ".*nni") 'nni)
((string-matches (item.name word) ".*Oni") 'Oni)
((string-matches (item.name word) ".*chi") 'chi)
((string-matches (item.name word) ".*nna") 'nna)
((string-matches (item.name word) ".*na") 'na)
((string-matches (item.name word) ".*ki") 'ki)
((string-matches (item.name word) ".*ini") 'ini)
((string-matches (item.name word) ".*gA") 'gA)
((string-matches (item.name word) ".*ku") 'ku)
((string-matches (item.name word) ".*nu") 'nu)
((string-matches (item.name word) ".*pai") 'pai)
((string-matches (item.name word) ".*la") 'la)
((string-matches (item.name word) ".*.n") '.n)
(t
 'fn)
))



;;---------------- Morph tagger End ------------------------------------------

;;---------------- Power contour targets --------------------------------------

(define (find_power_targets utt)
"(find_power_targets utt)
gives the power targets for the utt ."
 ;(set! SEG (utt.relation.first utt 'Segment))
(set! seg (utt.relation.first utt 'Segment)) 

;(let ((tmpfile (make_tmp_filename))
	;(ofd))
    (set! ofd (fopen "tmpfile" "w"))
;(let (ofd (fopen "TMP_POWER_TARGETS" "w"))
;(format ofd "#\n")
  (while seg
; (set! dur (item.feat seg 'segment_duration))
(if (string-equal (item.feat seg 'ph_vc) "+")
(begin
 (set! dur (item.feat seg 'segment_end))
 (set! pred_ene (wagon_predict seg marathi_NSK::zene_treeMAX2))
 (set! mean_ene (wagon_predict seg marathi_NSK::phone_enesMAX2))
;(format t "%s %f %f %f\n" (item.name seg) dur mean_ene pred_ene)
;(format ofd "%s %f %f %f\n" (item.name seg) dur mean_ene pred_ene)
(format ofd "%f 123 %f\n" dur (/ pred_ene mean_ene))
;(format ofd "%s %f 123 %f\n" (item.name seg) dur (/ pred_ene mean_ene))
(format t "%s %f 123 %f\n" (item.name seg) dur (/ pred_ene mean_ene))
))
(set! seg (item.next seg))
)
(fclose ofd)
)


;;---------------- Power contour targets --------------------------------------

;; ADDED BY NSK


(set! marathi_el_int_simple_params
    '(
  ;; These number may be modified the speakers range.
        ;; Even though we offer an automatic way to do this
        ;; hand tuning often allows a better voice
        (target_f0_mean 120)   ;; speaker's mean F0
        (target_f0_std 14)     ;; speaker's range
        ;; These number should remain as they are
	(f0_mean 180) (f0_std 50)))

(define (After_Each_Word_Pauses utt)
  "(Pauses UTT)
Predict pause insertion."
  (let ((words (utt.relation.items utt 'Word)) lastword tpname)
    (if words
        (begin
          (insert_initial_pause utt)   ;; always have a start pause
          (set! lastword (car (last words)))
          (mapcar
           (lambda (w)
             (let ((pbreak (item.feat w "pbreak"))
                   (emph (item.feat w "R:Token.parent.EMPH")))
               (cond
                ((equal? w lastword)
                 (insert_pause utt w))                                
		
                (t
                 (set! s (insert_pause utt w))
                 ;; but make it a little pause
                 (item.set_feat s "emph_sil" "+")))))
           words)
          ;; The embarassing bit.  Remove any words labelled as punc or fpunc
          (mapcar
           (lambda (w)
             (let ((pos (item.feat w "pos")))
               (if (or (string-equal "punc" pos)
                       (string-equal "fpunc" pos))
                   (let ((pbreak (item.feat w "pbreak"))
                         (wp (item.relation w 'Phrase)))
                     (if (and (string-matches pbreak "BB?")
                              (item.relation.prev w 'Word))
                         (item.set_feat
                          (item.relation.prev w 'Word) "pbreak" pbreak))
                     (item.relation.remove w 'Word)
                     ;; can't refer to w as we've just deleted it
                     (item.relation.remove wp 'Phrase)))))
           words)))                                          
  utt))


;;;;;;;;;;;;; ADDED BY NSK ;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(define (marathi_NSK_targ_func1 utt syl)
 "(marathi_NSK_targ_func1 utt syl)
Simple hat accents."
  (let ((start (item.feat syl 'syllable_start))
        (end (item.feat syl 'syllable_end))
        (ulen (item.feat (utt.relation.last utt 'Segment ) 'segment_end))
        nstart nend fustart fuend fuend fstart fend)
        (set! nstart (/ start ulen))
        (set! nend (/ end ulen))
        (set! fustart '125)
        (set! fuend   '120)
       (set! fstart  (+ (* (- fuend fustart) nstart) fustart))
       (set! fend    (+ (* (- fuend fustart) nend) fustart))
       ;; (set! fstart '130)
       ;; (set! fend   '130)
        (set! tstart (* (- end start) 0.333))
        (set! tend (* (- end start) 0.333))
    (cond
    ;;  ((equal? (item.feat syl "R:Intonation.daughter1.name") "Accented")
     (t
       (list
        (list start fstart)
 ;;  (list (+ start 0.030) (+ fstart 25 ))
   ;;   (list (- end   0.030) (+ fstart 20 )) 
       (list (+ start tstart) (+ fstart 15 ))
      (list (- end tend) (+ fstart 12 ))
       ;; (list (/ (+ fstart fend) 2.0) 150)    ;;;;;   ADDED on 18-02-02
       ;; (list (/ (+ fstart fend) 2.0) 150)     ;;;;;  ADDED on 18-02-02
        (list end   fend) 
	))
      ((not (item.next syl))
       (list
	(list end fuend)))
      ((not (item.prev syl))
       (list
	(list start fustart)))
      (t
       nil))))

(define (phrase_int_factor syl sylpos int_table)
  "(phrase_int_factor ITEM STREAMPOS)
       Returns the phrase intonation factor."

  (let 
      ((start (item.feat syl "syllable_start"))
       (end (item.feat syl "syllable_end"))
       (phrase_start (item.feat syl "R:SylStructure.parent.R:Phrase.first.word_start"))
       (phrase_end   (item.feat syl "R:SylStructure.parent.R:Phrase.last.word_end"))
       (dur)
       (ref)
       (last_pair))

       (set! dur (- phrase_end phrase_start))
    
       (set! target_pos (- (+ start (* (- end start) sylpos)) phrase_start))
       (set! ref (/ target_pos dur))
       (set! last_pair (car int_table))


  (mapcar
   (lambda (pair)
     (if (> ref (car last_pair))
	 (set! factor (interpolate last_pair pair ref ))
	 )
     (set! last_pair pair)
     )
   (cdr int_table))
  
  factor
))

(define (interpolate last_pair pair ref )
(set! m (/(- (cadr pair) (cadr last_pair)) (- (car pair) (car last_pair))))
(set! m (+ (cadr last_pair) (* m (- ref (car last_pair)))))
m
)


(set! normal_int_table
  '(	(0.00 0.98)
	(0.10 1.00)
	(0.20 1.01)
	(0.46 0.98)
	(0.65 1.01)
	(0.97 0.96)
	(0.98 0.97)
	(0.99 0.93)
	(1.00	0.82)))



(set! normal_int_table
  '(	(0.00 0.98)
	(0.10 1.02)
	(0.20 0.98)
	(0.30 1.02)
	(0.40 0.98)
	(0.50 1.01)
	(0.60 0.98)
	(0.70 1.02)
	(0.80 0.98)
	(0.90 1.01)
	(0.91 0.96)
	(0.94 0.97)
	(0.96 0.86)
	(1.00	0.82)))

(set! flat_int_table
  '(	(0.00 1.00)
	(0.50 1.00)
	(1.00	1.00)))

(set! exclam_int_table
  '(	(0.00 0.82)
	(0.10 0.86)
	(0.50 1.05)
	(0.98 0.90)
	(0.99 0.91)
	(1.00	0.80)))

(set! word_int_table
  '(	(0.00 0.90)
	(0.10 0.91)
	(0.90 0.91)
	(0.97 0.89)
	(1.00	0.83)))


(set! comma_int_table
  '(	(0.00 0.88)
	(0.10 0.97)
	(0.90 1.00)
	(0.98 1.10)
	(1.00	1.20)))

(set! question_int_table
  '(	(0.00 0.95)
	(0.10 1.03)
	(0.20 1.10)
	(0.30 1.06)
	(0.40 1.03)
	(0.50 1.00)
	(0.60 0.90)
	(0.70 0.86)
	(0.80 0.86)
	(0.90 0.88)
	(0.96 0.90)
	(0.98 1.10)
	(0.99 1.20)
	(1.00	1.50)))

;----------------------------------------------------------------------------


(provide 'marathi_NSK_int)

 
 
