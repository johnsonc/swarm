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
	( OCT340 ‡ ) 
	( OCT244 § )
	( OCT245 • )
	( MAT1 æ ø )
	( MAT2 Ä Å Ç É Ñ Ö Ü á à â ä ã å ç º Ω æ ø ¢ £ )
  )
  (
;; single vowels
( [ ‡ § Ö ] = a ) ;marathi letter A 
( [ ‡ § Ü ] = aa ) ;marathi letter AA
( [ ‡ § á ] = ih ) ;marathi letter I
( [ ‡ § à ] = iy ) ;marathi letter II
( [ ‡ § â ] = uh ) ;marathi letter U
( [ ‡ § ä ] = uw ) ;marathi letter UU 
( [ ‡ § ã ] = r uh ) ;marathi letter vocalic R 
( [ ‡ • † ]  = r uw ) ;marathi letter vocalic RR 
([ ‡ § å ] =  l uh ) ; marathi letter vocalic L (using 'lu' sound)
([ ‡ • ° ] = l uw ) ; marathi letter vocalic LL (uinsg 'luu' sound)
( [ ‡ § ç ] = eh ) ;U+090D marathi letter chandra E
( [ ‡ § é  ] = ay ) ;U+090E DEVANAGARI LETTER SHORT E (for transcribing Dravidian short e)
( [ ‡ § è ] = eh ) ;marathi letter E
;( [ ‡ ∞ è ] = ee ) ;no marathi letter EE
( [ ‡ § ê ] = ay ) ;marathi letter AI
( [ ‡ § ë ] = oo ) ;U+0911 DEVANAGARI LETTER CANDRA O
( [ ‡ § ì ] = oh )  ;marathi letter O 
( [ ‡ ∞ í ] = oh )  ;U+0912 DEVANAGARI LETTER SHORT O 
( [ ‡ § î ] = aw ) ;marathi letter AU
( [ ‡ § Ç ]  = m ) ;marathi sign anusvara (sunna) (using 'ma' sound)
([ ‡ § É ] = h a ) ;marathi sign visarga (using 'ha' sound)
;; consonants in half forms i.e. consonant + halant
( [ ‡ § ï ‡ • ç ]  = k ) ;marathi letter K
( [ ‡ • ò ‡ • ç ]  = k ) ;U+0958 DEVANAGARI LETTER QA ( U+0915 DEVANAGARI LETTER KA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ñ ‡ • ç ] = kh ) ;marathi letter KH
( [ ‡ • ô ‡ • ç ]  = kh ) ;U+0959 DEVANAGARI LETTER KHHA (U+0916 DEVANAGARI LETTER KHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ó ‡ • ç ] = g ) ;marathi letter G
( [ ‡ • ö ‡ • ç ]  = g ) ;U+095A DEVANAGARI LETTER GHHA (U+0917 DEVANAGARI LETTER GA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ò ‡ • ç ] = g h ) ;marathi letter GH
( [ ‡ § ô ‡ • ç ] = n y ) ;marathi letter NG
( [ ‡ § ö ‡ • ç ] = ch ) ;marathi letter C
( [ ‡ § õ ‡ • ç ] = ch h )	;marathi letter CH 
( [ ‡ § ú ‡ • ç ] = j ) ;marathi letter J
( [ ‡ • õ ‡ • ç ]  = j ) ;U+095B DEVANAGARI LETTER ZA ( U+091C DEVANAGARI LETTER JA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ù ‡ • ç ] = j h )	;marathi letter JH (missing in phoneset)
( [ ‡ § û ‡ • ç ] = eh n eh )	;marathi letter NY (missing in phoneset)
( [ ‡ § ü ‡ • ç ] = T ) ;marathi letter TT
( [ ‡ § † ‡ • ç ] = T h )	;marathi letter TTH (missing in phoneset)
( [ ‡ § ° ‡ • ç ] = D ) ;marathi letter DD
( [ ‡ • ú ‡ • ç ]  = D ) ;U+095C DEVANAGARI LETTER DDDHA (U+0921 DEVANAGARI LETTER DDA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ¢ ‡ • ç ] = D h ) ;marathi letter DDH (missing in phoneset)
( [ ‡ • ù ‡ • ç ]  = D h) ;U+095D DEVANAGARI LETTER RHA (U+0922 DEVANAGARI LETTER DDHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § £ ‡ • ç ] = N ) ;marathi letter NN (missing in phoneset)
( [ ‡ § § ‡ • ç ] = th )	;marathi letter T (missing in phoneset)
( [ ‡ § • ‡ • ç ] = tth ) ;marathi letter TH
( [ ‡ § ¶ ‡ • ç ] = dh )	;marathi letter D (missing in phoneset)
( [ ‡ § ß ‡ • ç ] = ddh )	;marathi letter DH
( [ ‡ § ® ‡ • ç ] = n ) ;marathi letter N
( [ ‡ § © ‡ • ç ] = n ) ;half marathi letter NNNA (U+0928 DEVANAGARI LETTER NA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ™ ‡ • ç ] = p ) ;marathi letter P
( [ ‡ § ´ ‡ • ç ] = f ) ;marathi letter PH
( [ ‡ • û ‡ • ç ]  = f ) ;U+095E DEVANAGARI LETTER FA (U+092B DEVANAGARI LETTER PHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ¨ ‡ • ç ] = b ) ;marathi letter B
( [ ‡ § ≠ ‡ • ç ] = bh ) ;marathi letter BH
( [ ‡ § Æ ‡ • ç ] = m ) ;marathi letter M
( [ ‡ § Ø ‡ • ç ] = y ) ;marathi letter Y
( [ ‡ • ü ‡ • ç ]  = y ) ;U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ∞ ‡ • ç ] = r ) ;marathi letter R
( [ ‡ § ± ‡ • ç ] = r ) ;half marathi letter U+0931 RRA ( U+0930 DEVANAGARI LETTER RA + U+093C DEVANAGARI SIGN NUKTA)  for transcribing Dravidian alveolar r and half form is represented as "Eyelash RA"
( [ ‡ § ≤ ‡ • ç ] = l ) ;marathi letter L 
( [ ‡ § ≥ ‡ • ç ] = L ) ;marathi letter LL
( [ ‡ § ¥ ‡ • ç ] = L ) ;half marathi letter LLLA, U+0934 DEVANAGARI LETTER LLLA (U+0933 DEVANAGARI LETTER LLA + U+093C DEVANAGARI SIGN NUKTA) for transcribing Dravidian l
( [ ‡ § µ ‡ • ç ] = v ) ;marathi letter V
( [ ‡ § ∂ ‡ • ç ] = sh ) ;marathi letter SH
( [ ‡ § ∑ ‡ • ç ] = sh h ) ;marathi letter SS
( [ ‡ § ∏ ‡ • ç ] = s ) ;marathi letter S (missing in phoneset)
( [ ‡ § π ‡ • ç ] = h ) ;marathi letter H
;;consonants occuring as vattulu
;; matches the regex [consonant]{consonant}
( [ ‡ § ï ]  OCT340 OCT244 MAT1  =  k ) ;marathi letter K
( [ ‡ • ò ]  OCT340 OCT244 MAT1  =  k ) ;marathi letter K U+0958 DEVANAGARI LETTER QA ( U+0915 DEVANAGARI LETTER KA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ñ ]  OCT340 OCT244 MAT1 = kh ) ;marathi letter KH
( [ ‡ • ô ]  OCT340 OCT244 MAT1 = kh ) ;marathi letter KH U+0959 DEVANAGARI LETTER KHHA (U+0916 DEVANAGARI LETTER KHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ó ]   OCT340 OCT244 MAT1 = g ) ;marathi letter G
( [ ‡ • ö ]   OCT340 OCT244 MAT1 = g ) ;marathi letter G U+095A DEVANAGARI LETTER GHHA (U+0917 DEVANAGARI LETTER GA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ò ]   OCT340 OCT244 MAT1 = g h ) ;marathi letter GH
( [ ‡ § ô ]  OCT340 OCT244 MAT1 = n y ) ;marathi letter NG
( [ ‡ § ö ]   OCT340 OCT244 MAT1 = ch ) ;marathi letter C
( [ ‡ § õ ]  OCT340 OCT244 MAT1  = ch h ) ;marathi letter CH
( [ ‡ § ú ]  OCT340 OCT244 MAT1  = j ) ;marathi letter J
( [ ‡ • õ ]  OCT340 OCT244 MAT1  = j ) ;marathi letter J U+095B DEVANAGARI LETTER ZA ( U+091C DEVANAGARI LETTER JA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ù ]   OCT340 OCT244 MAT1 = j h ) ;marathi letter JH
( [ ‡ § û ]   OCT340 OCT244 MAT1 = eh n eh ) ;marathi letter NY
( [ ‡ § ü ]   OCT340 OCT244 MAT1 = T ) ;marathi letter TT
( [ ‡ § † ]   OCT340 OCT244 MAT1 = T h ) ;marathi letter TTH
( [ ‡ § ° ]   OCT340 OCT244 MAT1 = D ) ;marathi letter DD 
( [ ‡ • ú ]   OCT340 OCT244 MAT1 = D ) ;marathi letter DD U+095C DEVANAGARI LETTER DDDHA (U+0921 DEVANAGARI LETTER DDA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ¢ ]   OCT340 OCT244 MAT1 = D h ) ;marathi letter DDH 
( [ ‡ • ù ]   OCT340 OCT244 MAT1 = D h ) ;marathi letter DDH U+095D DEVANAGARI LETTER RHA (U+0922 DEVANAGARI LETTER DDHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § £ ]   OCT340 OCT244 MAT1 = N ) ;marathi letter NN
( [ ‡ § § ]   OCT340 OCT244 MAT1 = th ) ;marathi letter T
( [ ‡ § • ]  OCT340 OCT244 MAT1  = tth ) ;marathi letter TH
( [ ‡ § ¶ ]   OCT340 OCT244 MAT1 = dh ) ;marathi letter D
( [ ‡ § ß ]   OCT340 OCT244 MAT1 = ddh ) ;marathi letter DH
( [ ‡ § ® ]   OCT340 OCT244 MAT1 = n ) ;marathi letter N
( [ ‡ § © ]   OCT340 OCT244 MAT1 = n ) ;marathi letter N
( [ ‡ § ™ ]   OCT340 OCT244 MAT1 = p ) ;marathi letter P
( [ ‡ § ´ ]   OCT340 OCT244 MAT1 = f ) ;marathi letter PH 
( [ ‡ • û ]   OCT340 OCT244 MAT1 = f ) ;marathi letter PH U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ¨ ]   OCT340 OCT244 MAT1 = b ) ;marathi letter B
( [ ‡ § ≠ ]   OCT340 OCT244 MAT1 = bh ) ;marathi letter BH
( [ ‡ § Æ ]   OCT340 OCT244 MAT1 = m ) ;marathi letter M
( [ ‡ § Ø ]   OCT340 OCT244 MAT1 = y ) ;marathi letter Y 
( [ ‡ • ü ]   OCT340 OCT244 MAT1 = y ) ;marathi letter Y U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ∞ ]   OCT340 OCT244 MAT1 = r ) ;marathi letter R
( [ ‡ § ± ] OCT340 OCT244 MAT1 = r ) ;marathi letter RR
( [ ‡ § ≤ ]  OCT340 OCT244 MAT1  = l) ;marathi letter L
( [ ‡ § ≥ ]   OCT340 OCT244 MAT1 = L ) ;marathi letter LL
( [ ‡ § ≥ ]   OCT340 OCT244 MAT1 = L ) ;marathi letter LLLA, U+0934 DEVANAGARI LETTER LLLA (U+0933 DEVANAGARI LETTER LLA + U+093C DEVANAGARI SIGN NUKTA) for transcribing Dravidian l
( [ ‡ § µ ]   OCT340 OCT244 MAT1 = v ) ;marathi letter V
( [ ‡ § ∂ ]   OCT340 OCT244 MAT1 = sh ) ;marathi letter SH
( [ ‡ § ∑ ]   OCT340 OCT244 MAT1 = sh h ) ;marathi letter SS
( [ ‡ § ∏ ]   OCT340 OCT244 MAT1 = s ) ;marathi letter S
( [ ‡ § π ]   OCT340 OCT244 MAT1 = h ) ;marathi letter H
( [ ‡ § ï ]   OCT340 OCT245 MAT2  =  k ) ;marathi letter K
( [ ‡ • ò ]  OCT340 OCT245 MAT2  =  k ) ;marathi letter K U+0958 DEVANAGARI LETTER QA ( U+0915 DEVANAGARI LETTER KA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ñ ]  OCT340 OCT245 MAT2   = kh ) ;marathi letter KH
( [ ‡ • ô ]  OCT340 OCT245 MAT2 = kh ) ;marathi letter KH U+0959 DEVANAGARI LETTER KHHA (U+0916 DEVANAGARI LETTER KHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ó ]  OCT340 OCT245 MAT2   = g ) ;marathi letter G
( [ ‡ • ö ]   OCT340 OCT245 MAT2 = g ) ;marathi letter G U+095A DEVANAGARI LETTER GHHA (U+0917 DEVANAGARI LETTER GA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ò ]   OCT340 OCT245 MAT2  = g h ) ;marathi letter GH
( [ ‡ § ô ]   OCT340 OCT245 MAT2  = n y ) ;marathi letter NG
( [ ‡ § ö ]   OCT340 OCT245 MAT2  = ch ) ;marathi letter C
( [ ‡ § õ ]  OCT340 OCT245 MAT2  = ch h ) ;marathi letter CH
( [ ‡ § ú ]  OCT340 OCT245 MAT2  = j ) ;marathi letter J
( [ ‡ • õ ]  OCT340 OCT245 MAT2  = j ) ;marathi letter J U+095B DEVANAGARI LETTER ZA ( U+091C DEVANAGARI LETTER JA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ù ]   OCT340 OCT245 MAT2  = j h ) ;marathi letter JH
( [ ‡ § û ]   OCT340 OCT245 MAT2  = eh n eh ) ;marathi letter NY
( [ ‡ § ü ]  OCT340 OCT245 MAT2   = T ) ;marathi letter TT
( [ ‡ § † ]   OCT340 OCT245 MAT2  = T h ) ;marathi letter TTH
( [ ‡ § ° ]   OCT340 OCT245 MAT2  = D ) ;marathi letter DD
( [ ‡ • ú ]   OCT340 OCT245 MAT2 = D ) ;marathi letter DD U+095C DEVANAGARI LETTER DDDHA (U+0921 DEVANAGARI LETTER DDA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ¢ ]   OCT340 OCT245 MAT2  = D h ) ;marathi letter DDH
( [ ‡ • ù ]   OCT340 OCT245 MAT2 = D h ) ;marathi letter DDH U+095D DEVANAGARI LETTER RHA (U+0922 DEVANAGARI LETTER DDHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § £ ]  OCT340 OCT245 MAT2   = N ) ;marathi letter NN
( [ ‡ § § ]   OCT340 OCT245 MAT2  = th ) ;marathi letter T
( [ ‡ § • ]  OCT340 OCT245 MAT2   = tth ) ;marathi letter TH
( [ ‡ § ¶ ]   OCT340 OCT245 MAT2  = dh ) ;marathi letter D
( [ ‡ § ß ]   OCT340 OCT245 MAT2  = ddh ) ;marathi letter DH
( [ ‡ § ® ]   OCT340 OCT245 MAT2  = n ) ;marathi letter N
( [ ‡ § © ]   OCT340 OCT245 MAT2  = n ) ;marathi letter N
( [ ‡ § ™ ]   OCT340 OCT245 MAT2  = p ) ;marathi letter P
( [ ‡ § ´ ]   OCT340 OCT245 MAT2  = f ) ;marathi letter PH
( [ ‡ • û ]   OCT340 OCT244 MAT2 = f ) ;marathi letter PH U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ¨ ]   OCT340 OCT245 MAT2  = b ) ;marathi letter B
( [ ‡ § ≠ ]   OCT340 OCT245 MAT2  = bh ) ;marathi letter BH
( [ ‡ § Æ ]   OCT340 OCT245 MAT2  = m ) ;marathi letter M
( [ ‡ § Ø ]   OCT340 OCT245 MAT2  = y ) ;marathi letter Y
( [ ‡ • ü ]   OCT340 OCT245 MAT2 = y ) ;marathi letter Y U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ∞ ]  OCT340 OCT245 MAT2   = r ) ;marathi letter R
([ ‡ § ± ] OCT340 OCT245 MAT2  = r ) ;marathi letter RR
( [ ‡ § ≤ ]   OCT340 OCT245 MAT2  = l) ;marathi letter L
( [ ‡ § ≥ ]  OCT340 OCT245 MAT2   = L ) ;marathi letter LL
( [ ‡ § ≥ ]   OCT340 OCT245 MAT2 = L ) ;marathi letter LLLA, U+0934 DEVANAGARI LETTER LLLA (U+0933 DEVANAGARI LETTER LLA + U+093C DEVANAGARI SIGN NUKTA) for transcribing Dravidian l
( [ ‡ § µ ]   OCT340 OCT245 MAT2  = v ) ;marathi letter V
( [ ‡ § ∂ ]   OCT340 OCT245 MAT2  = sh ) ;marathi letter SH
( [ ‡ § ∑ ]   OCT340 OCT245 MAT2  = sh h ) ;marathi letter SS
( [ ‡ § ∏ ]  OCT340 OCT245 MAT2   = s ) ;marathi letter S
( [ ‡ § π ]   OCT340 OCT245 MAT2  = h ) ;marathi letter H
;consonants
( [ ‡ § ï ]   =  k a ) ;marathi letter KA
( [ ‡ • ò ]  =  k a ) ;marathi letter KA U+0958 DEVANAGARI LETTER QA ( U+0915 DEVANAGARI LETTER KA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ñ ] = kh a ) ;marathi letter KHA
( [ ‡ • ô ] = kh a ) ;marathi letter KHA +0959 DEVANAGARI LETTER KHHA (U+0916 DEVANAGARI LETTER KHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ó ] = g a ) ;marathi letter GA
( [ ‡ • ö ] = g a ) ;marathi letter GA U+095A DEVANAGARI LETTER GHHA (U+0917 DEVANAGARI LETTER GA + U+093C DEVANAGARI SIGN NUKTA) 
( [ ‡ § ò ] = g h a ) ;marathi letter GHA
( [ ‡ § ô ] = n y a ) ;marathi letter NGA
( [ ‡ § ö ] = ch a ) ;marathi letter CA
( [ ‡ § õ ] = ch h a ) ;marathi letter CHA
( [ ‡ § ú ] = j a ) ;marathi letter JA
( [ ‡ • õ ] = j a ) ;marathi letter JA U+095B DEVANAGARI LETTER ZA ( U+091C DEVANAGARI LETTER JA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ù ] = j h a ) ;marathi letter JHA
( [ ‡ § û ] = eh n eh a ) ;marathi letter NYA
( [ ‡ § ü ] = T a ) ;marathi letter TTA
( [ ‡ § † ] = T h a ) ;marathi letter TTHA
( [ ‡ § ° ] = D a ) ;marathi letter DDA 
( [ ‡ • ú ] = D a ) ;marathi letter DDA U+095C DEVANAGARI LETTER DDDHA (U+0921 DEVANAGARI LETTER DDA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ¢ ] = D h a ) ;marathi letter DDHA
( [ ‡ • ù ] = D h a ) ; marathi letter DDHA U+095D DEVANAGARI LETTER RHA (U+0922 DEVANAGARI LETTER DDHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § £ ] = N a ) ;marathi letter NNA
( [ ‡ § § ] = th a ) ;marathi letter TA
( [ ‡ § • ] = tth a ) ;marathi letter THA
( [ ‡ § ¶ ] = dh a ) ;marathi letter D
( [ ‡ § ß ] = ddh a ) ;marathi letter DHA
( [ ‡ § ® ] = n a ) ;marathi letter NA
( [ ‡ § © ] = n a ) ;indi letter NA U+0928 DEVANAGARI LETTER NA + U+093C DEVANAGARI SIGN NUKTA
( [ ‡ § ™ ] = p a ) ;marathi letter PA
( [ ‡ § ´ ] = f a ) ;marathi letter PHA
( [ ‡ • û ] = f a ) ;marathi letter PHA U+095E DEVANAGARI LETTER FA (U+092B DEVANAGARI LETTER PHA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ¨ ] = b a ) ;marathi letter BA
( [ ‡ § ≠ ] = bh a ) ;marathi letter BHA
( [ ‡ § Æ ] = m a ) ;marathi letter MA
( [ ‡ § Ø ] = y a ) ;marathi letter YA
( [ ‡ • ü ] = y a ) ;marathi letter YA U+095F DEVANAGARI LETTER YYA (U+092F DEVANAGARI LETTER YA + U+093C DEVANAGARI SIGN NUKTA)
( [ ‡ § ∞ ] = r a ) ;marathi letter RA
( [ ‡ § ± ] = r a ) ;marathi letter RRA
( [ ‡ § ≤ ] = l a ) ;marathi letter LA
( [ ‡ § ≥ ] = L a ) ;marathi letter LLA
( [ ‡ § ¥ ] = L a ) ;marathi letter LLA U+0934 DEVANAGARI LETTER LLLA (U+0933 DEVANAGARI LETTER LLA + U+093C DEVANAGARI SIGN NUKTA) for transcribing Dravidian l
( [ ‡ § µ ] = v a ) ;marathi letter VA
( [ ‡ § ∂ ] = sh a ) ;marathi letter SHA
( [ ‡ § ∑ ] = sh h a ) ;marathi letter SSA
( [ ‡ § ∏ ] = s a ) ;marathi letter SA
( [ ‡ § π ] = h a ) ;marathi letter HA
( [ ‡ • ê ] = oh m) ;U+0950 DEVANAGARI OM 
;;dependent vowels
( [ ‡ • à ] = ay ) ;marathi vowel sign AI 0C46 (E)+ 0C56(AI Length Mark)
( [ ‡ § æ ] =  aa )  ;marathi vowel sign AA
( [ ‡ § ø ] =  ih ) ;marathi vowel sign I
( [ ‡ • Ä ] = iy ) ;marathi vowel sign II
( [ ‡ • Å ] = uh ) ;marathi vowel sign U
( [ ‡ • Ç ] = uw ) ;marathi vowel sign UU
( [ ‡ • É ] = r eh )  ;marathi vowel sign vocalic R
( [ ‡ • Ñ ] = r ee )  ;marathi vowel sign vocalic RR
( [ ‡ • Ö ] = ee ) ;marathi vowel sign chandra E
( [ ‡ § Å ] = n ) ;marathi U+0901 DEVANAGARI SIGN CANDRABINDU
( [ ‡ • Ü ] = eh ) ;marathi vowel sign short E (for transcribing Dravidian vowels)
( [ ‡ • á ] = eh ) ;marathi vowel sign E
( [ ‡ • à ] = ay ) ;marathi vowel sign AI
( [ ‡ • â ] = oo ) ;marathi vowel sign chandra O
( [ ‡ • ä ] = oh ) ;U+094A DEVANAGARI VOWEL SIGN SHORT O (for transcribing Dravidian vowels)
( [ ‡ • ã ] = oh ) ;marathi vowel sign O
( [ ‡ • å ] = aw ) ;marathi vowel sign AU
;( [ ‡ § º ]= )  ;ignoring nukta sign U+093C
;( [ ‡ § Ω ] = ) ;ignoring U+093D DEVANAGARI SIGN AVAGRAHA
( [ ‡ • ç ] = ) ;ignoring U+094D DEVANAGARI SIGN VIRAMA, halant (the preferred Marathi name)

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


