(defconst rgb-hex-to-ansi-truecolor-hex-6-regexp
  "^[#]?\\([a-fA-F0-9]\\{2\\}\\)\\([a-fA-F0-9]\\{2\\}\\)\\([a-fA-F0-9]\\{2\\}\\)$"

  "
regular expression used by `rgb-hex-to-ansi-truecolor' to match, well,
rgb hex string with 6 characters (3 bands, duh) NOTE: this regexp is
constrained by beginning of line and end of line, that is, `^' and `$',
respectively.

Example strings that this regexp matches:

- ``#F13976`` (`#F13976')
- ``#F49101`` (`#F49101')

")

(defconst rgb-hex-to-ansi-truecolor-hex-3-regexp
  "^[#]?\\([a-fA-F0-9]\\{1\\}\\)\\([a-fA-F0-9]\\{1\\}\\)\\([a-fA-F0-9]\\{1\\}\\)$"

  "same as `rgb-hex-to-ansi-truecolor-hex-6-regexp' but matches shortened
version of hex rgb patterns like `RGB' or `\#RGB' whose 6-char long
value is `RRGGBB' or `\#RRGGBB'.

Example strings that this regexp matches:

- ``#1CE``   (`#11CCEE`)
- ``#DEA``   (`#DDEEAA`)
- ``#FB1``   (`#FFBB11`)
- ``#C1A``   (`#CC11AA`)
- ``#FCC``   (`#FFCCCC`)
- ``#5EC``   (`#55EECC`)
- ``#D1A``   (`#DD11AA`)
- ``#555``   (`#555555`)
- ``#A7F``   (`#AA77FF`)
- ``#D0D``   (`#DD00DD`)
- ``#FDA``   (`#FFDDAA`)
- ``#5EC``   (`#55EECC`)
- ``#D85``   (`#DD8855`)
- ``#D0E``   (`#DD00EE`)
- ``#D07``   (`#DD0077`)
")

(defconst rgb-hex-regexp-variants
  (list
   :length6 rgb-hex-to-ansi-truecolor-hex-6-regexp
   :length3 rgb-hex-to-ansi-truecolor-hex-3-regexp))



(defun rgb-hex-to-ansi-truecolor(rgb-hex)
  ""
  (unless (stringp rgb-hex)
    (signal 'type-error
            (format  "[rgb-hex-to-ansi-truecolor] argument `rgb-hex' must be string but instead got `%s': %s"
                     (type-of rgb-hex)
                     rgb-hex)))
  (erase-c-messages)
  (c-message-open "")
  (save-match-data
    (let* ((orig-input rgb-hex)
           (rgb-hex
            (string-trim
             (format "%s" (substring-no-properties rgb-hex))))
           (found
            (save-match-data
              (cond
               (string-match
                (plist-get rgb-hex-regexp-variants :length6)
                rgb-hex)
               (string-match
                (plist-get rgb-hex-regexp-variants :length3)
                rgb-hex)
               (t nil))))
           ) ;; end (let* (...)) varlist
      ;; start (let* (..) body)
      (c-message "orig-input: %s = %S" orig-input
                 (type-of orig-input))
      (c-message "rgb-hex: %s = %S" rgb-hex (type-of rgb-hex))
      (c-message "found: %s = %S" found (type-of found))
      ;; end (let* (..) body)
      );; end (let* )
    ) ;; save-match-data
  ) ;; defun

;; (catch 'numba
;;   (mapc
;;    (lambda (lownu)
;;      (mapc
;;       (lambda (factor)
;;         (let (
;;               (value (+ lownu factor))
;;               (return)
;;               )
;;           (setq return
;;                 (list :lownu lownu :factor factor :val
;;                       (* lownu factor)))
;;           (when (or
;;                  (= value 37)
;;                  (= value 30))
;;             (throw 'numba return))
;;           )
;;         )
;;       teens)
;;      )
