; 0=`declare -- debug_prefix_color_rgb="138;226;52"`
; 1=`debug`
; 2=`_prefix`
; 3=`prefix`
; 4=`_color`
; 5=`color`
; 6=`_rgb`
; 7=`"138;226;52"`
; 8=`138;226;52`
; 9=`138`
; 10=`226`
; 11=`52`
;
;"declare\s-+[-][-]\s-+\([a-z]+\)\([_]\(prefix\)\)?\([_]\(color\)\)\([_]rgb\)=\(\(['"]\)\(\([0-9]\{1,3\}\);\([0-9]\{1,3\}\);\([0-9]\{1,3\}\)[m;]?\)\8\)\s-*"

(defvar shebang-template-color-declarations-string
  "
declare -- error_prefix_color_rgb='239;41;41'
declare -- error_color_rgb='204;0;0'

declare -- achtung_prefix_color_rgb='245;121;0'
declare -- achtung_color_rgb='206;92;0'

declare -- warn_prefix_color_rgb='252;233;79'
declare -- warn_color_rgb='237;212;00'

declare -- info_prefix_color_rgb='52;101;164'
declare -- info_color_rgb='114;159;207;'

declare -- msg_prefix_color_rgb='186;189;182'
declare -- msg_color_rgb='136;138;133'

declare -- display_prefix_color_rgb='238;238;236'
declare -- display_color_rgb='211;215;207'

declare -- debug_prefix_color_rgb='138;226;52'
declare -- debug_color_rgb='115;210;22'
"
  )

(defun shebang-template-color-declarations-replace-regexp-to-string-function()
  "non-interactive function to use in interactive call to `replace-regexp' where that function's `regexp' argument looks like `shebang-template-color-declarations-string'"
  (let* (
         (regexp "^declare\\s-+[-][-]\\s-+\\([a-z]+\\)\\([_]\\(prefix\\)\\)?\\([_]\\(color\\)\\)\\([_]rgb\\)=\\(\\(['\"]\\)\\(\\([0-9]\\{1,3\\}\\);\\([0-9]\\{1,3\\}\\);\\([0-9]\\{1,3\\}\\)[m;]?\\)\\8\\)\\s-*$")
         (md (match-data))
         (md-len (length md))
         (pairs (/ md-len 2))
         (subexps (- pairs 1))
         (pairs-list (number-sequence 0 pairs))
         (subexps-list (number-sequence 0 subexps))
         ); end varlist
    (replace-match-data
     (string-join
      (seq-map-indexed
       (lambda (value index)
         ) ; end (lambda (value index)...)
       "\n")
      )
    )
  )


;; (defun shebang-template-color-declarations-replace-regexp-to-string-function()
;;   "non-interactive function to use in interactive call to `replace-regexp' where that function's `regexp' argument looks like `shebang-template-color-declarations-string'"
;;   (save-match-data
;;     (let* (
;;            (regexp "^declare\\s-+[-][-]\\s-+\\([a-z]+\\)\\([_]\\(prefix\\)\\)?\\([_]\\(color\\)\\)\\([_]rgb\\)=\\(\\(['\"]\\)\\(\\([0-9]\\{1,3\\}\\);\\([0-9]\\{1,3\\}\\);\\([0-9]\\{1,3\\}\\)[m;]?\\)\\8\\)\\s-*$")
;;            (md (match-data))
;;            (md-len (length md))
;;            (pairs (/ md-len 2))
;;            (subexps (- pairs 1))
;;            (pairs-list (number-sequence 0 pairs))
;;            (subexps-list (number-sequence 0 subexps))
;;            ); end varlist
;;       (
;;        (seq-map-indexed ()
;;       )
;;     )
;;   )
