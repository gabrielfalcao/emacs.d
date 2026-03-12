(defconst rgb-hex-to-ansi-truecolor-hex-6-regexp
  "^[#]?\\([a-fA-F0-9]\\{2\\}\\)\\([a-fA-F0-9]\\{2\\}\\)\\([a-fA-F0-9]\\{2\\}\\)$"

  "
regular expression used by `rgb-hex-to-ansi-truecolor' to match, well,
rgb hex string with 6 characters (3 bands, duh) NOTE: this regexp is
constrained by beginning of line and end of line, that is, `^' and `$',
respectively.

Example strings that this regexp matches:

- ``#F13976`` (`#F13976')
- ``F49101``  (`#F49101')

")

(defconst rgb-hex-to-ansi-truecolor-hex-3-regexp
  "^[#]?\\([a-fA-F0-9]\\{1\\}\\)\\([a-fA-F0-9]\\{1\\}\\)\\([a-fA-F0-9]\\{1\\}\\)$"

  "same as `rgb-hex-to-ansi-truecolor-hex-6-regexp' but matches shortened
version of hex rgb patterns like `RGB' or `\#RGB' whose 6-char long
value is `RRGGBB' or `\#RRGGBB'.

Example strings that this regexp matches:

- ``#1CE``   (`#11CCEE')
- ``#C1A``   (`#CC11AA')
- ``#FB1``   (`#FFBB11')

#1CE
#DEA
#FB1
#C1A
#FCC
#5EC
#D1A
#555
#A7F
#D0D
#FDA
#5EC
#D85
#D0E
#D07
")





(defun rgb-hex-to-ansi-truecolor(rgb-hex)
  ""
  (unless (stringp rgb-hex) (signal 'type-error (format  "[rgb-hex-to-ansi-truecolor] argument `rgb-hex' must be string but instead got `%s': %s" (type-of rgb-hex) rgb-hex)))

  (save-match-data
    (let* (
           (orig-input rgb-hex)
           (rgb-hex (string-trim (format "%s" (substring-no-properties rgb-hex))))
           (smd (string-match  rgb-hex nil t))




    ) ;; save-match-data
  ) ;; defun
