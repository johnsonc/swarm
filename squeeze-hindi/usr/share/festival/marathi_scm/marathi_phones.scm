;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;                                                                             ;;
;;;                       Phoneset definition                                   ;;
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

(defPhoneSet
  marathi
  ;;;  Phone Features
  (;; vowel or consonant
   (vc + -)  
   ;; vowel length: short long dipthong schwa gemenite
   (vlng s l d a g 0)
   ;; vowel height: high mid low
   (vheight 1 2 3 0)
   ;; vowel frontness: front mid back
   (vfront 1 2 3 0)
   ;; lip rounding
   (vrnd + - 0)
   ;; consonant type: stop fricative affricative nasal liquid
   (ctype s f a n l 0)
   ;; place of articulation: labial alveolar palatal labio-dental
   ;;                         dental velar glottal
   (cplace l a p b d v g  0)
   ;; consonant voicing
   (cvox + - 0)
   )
  (
     (a  + s 3 3 - 0 0 0 ) 
     (aa  + l 3 3 - 0 0 0 ) 
     (ih  + s 1 1 - 0 0 0 ) 
     (iy  + l 1 1 - 0 0 0 ) 
     (uh  + s 2 3 + 0 0 0 ) 
     (uw  + l 1 3 + 0 0 0 ) 
     (eh  + a 2 2 - 0 0 0 ) 
     (ee  + d 2 1 - 0 0 0 )
     (ay + d 3 2 - 0 0 0 )
     (oh + s 2 2 - 0 0 0 )
     (oo + d 2 2 + 0 0 0 )
     (aw + d 3 2 + 0 0 0 )
     (f - 0 0 0 0 f b - )
     (k - 0 0 0 0 s v - )
     (g - 0 0 0 0 s v + )
     (ch - 0 0 0 0 a p - )
     (T - 0 0 0 0 s a - )
     (D - 0 0 0 0 s a + )               
     (N - 0 0 0 0 n p + )
     (th - 0 0 0 0 f d - )
     (dh - 0 0 0 0 f d + )
     (n - 0 0 0 0 n a + )
     (p - 0 0 0 0 s l - )
     (b - 0 0 0 0 s l + )
     (m - 0 0 0 0 n l + )
     (y - 0 0 0 0 a p + )
     (r - 0 0 0 0 a a + )
     (l - 0 0 0 0 l a + )
     (v - 0 0 0 0 f b + )
     (L - 0 0 0 0 l a + )
     (R - 0 0 0 0 a a + )
     (s - 0 0 0 0 f a - )
     (sh - 0 0 0 0 f p - )
     (j - 0 0 0 0 a p + )
     (h - 0 0 0 0 f g - )    
     (ksh - g 0 0 0 s p - )
     (sri - g 0 0 0 f a - )  
     (x - 0 0 0 0 0 0 - )    
     (kh - 0 0 0 0 s v - )    
     (gh - 0 0 0 0 s v + )    
     (td - 0 0 0 0 s a - )     
     (tth - 0 0 0 0 f d - )  
     (ddh - 0 0 0 0 f d + )      
     (bh - 0 0 0 0 s l + )    
     (zh - 0 0 0 0 f p + )     
     (@  + l 3 3 - 0 0 0 )   
     (pau - 0 0 0 0 0 0 - )
     (w  + s 2 3 + 0 0 0 ) 
  )
)
(PhoneSet.silences '(pau))

(provide 'marathi_phones)


