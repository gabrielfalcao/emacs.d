;; (enable-debug-on-error)
;;

;; USAGE
;;
;; (replace-regexp
;;     "TANGO_PALETTE_\\([A-Za-z_]+\\)[[]\"\\([a-z_[:space:]-]+\\)\"[]]=\"\\(\\([0-9]\\{1,3\\}\\)[;]\\([0-9]\\{1,3\\}\\)[;]\\([0-9]\\{1,3\\}\\)\\)\""
;;     \,(showcase-tango-palette-from-python-dicts))
;;
;;
(progn (erase-c-messages) (c-message-open ""))
(defun showcase-tango-palette-from-python-dicts ()
  ;; 0=`TANGO_PALETTE_DARK["aluminum dark"]="46;52;54"`
  ;; 1=`DARK`
  ;; 2=`aluminum dark`
  ;; 3=`46;52;54`
  ;; 4=`46`
  ;; 5=`52`
  ;; 6=`54`

  (save-match-data
    (let* ((color-tone
            (downcase
             (substring-no-properties (format "%s" (match-string 1)))))
           (color-name
            (downcase
             (substring-no-properties (format "%s" (match-string 2)))))
           (full-color-name
            (string-join (list color-name color-tone) " "))
           (color-varname (string-to-snake full-color-name))
           (red (string-to-number (match-string 4)))
           (green (string-to-number (match-string 5)))
           (blue (string-to-number (match-string 6)))
           (ansi-rgb-triple-short (format "%d;%d;%dm" red green blue))
           (ansi-rgb-triple
            (let* ((short-len (length ansi-rgb-triple-short))
                   (delta (- 12 short-len))
                   (padding (string-join (make-list delta " " )))
                   (triple-from-subexpr-3
                    (format "%sm"
                            (substring-no-properties (match-string 3))))
                   (with-padding
                    (string-join (list ansi-rgb-triple-short padding))))
              ;; (progn
              ;;   (c-message "ansi-rgb-triple-short (%s): %S"
              ;;              (type-of ansi-rgb-triple-short)
              ;;              ansi-rgb-triple-short)
              ;;   (c-message "short-len (%s): %S"
              ;;              (type-of short-len)
              ;;              short-len)
              ;;   (c-message "delta (%s): %S" (type-of delta) delta)
              ;;   (c-message "padding (%s): %S"
              ;;              (type-of padding)
              ;;              padding)
              ;;   (c-message "triple-from-subexpr-3 (%s): %S"
              ;;              (type-of triple-from-subexpr-3)
              ;;              triple-from-subexpr-3)
              ;;   (c-message "with-padding (%s): %S"
              ;;              (type-of with-padding)
              ;;              with-padding))

              triple-from-subexpr-3))
           (hex-rgb (format "#%02X%02X%02X" red green blue))
           (ansi-reset      "\\x1b[0m")
           (ansi-rgb-fg (format "\\x1b[1;38;2;%s" ansi-rgb-triple))
           (ansi-rgb-bg (format "\\x1b[1;48;2;%s" ansi-rgb-triple))
           (ansi-contrast-rgb-fg
            (cond
             ((string= "light" color-tone)
              (format "\\x1b[1;38;2;22;22;22m"))

             ((string= "medium" color-tone)
              (format "\\x1b[1;38;2;66;66;66m"))

             ((string= "dark" color-tone)
              (format "\\x1b[1;38;2;255;255;255m"))

             ((format "\\x1b[1;38;2;99;99;99m"))))) ;; end (let* (...)) varlist

      (let* ((first-line
              (string-join
               (list
                ""
                (format "palettes['tango']['%s']['%s']='%s' # %s %s\n"
                        color-name
                        color-tone
                        ansi-rgb-fg
                        hex-rgb
                        full-color-name
                        )
                ""
                "\\x0a")
               " ")) ;; end (first-line ...)
             );; end (let* ((first-line ...))) varlist
        (string-join (list first-line) "\n")) ;; end (let* ((first-line ...)))
      )  ;; end (let* ((color-tone ...)))
    ) ;; end (save-match-data ...)
  ) ;; end (defun ... (let* ...))

;;(defun test--showcase-tango-palette-from-python-dicts()
;;  (let* ((input-string "TANGO_PALETTE_LIGHT[\"butter\"]=\"252;233;79\"")
;;         (regexp
;;          "TANGO_PALETTE_\\([A-Za-z_]+\\)[[]\"\\([a-z_[:space:]-]+\\)\"[]]=\"\\(\\([0-9]\\{1,3\\}\\)[;]\\([0-9]\\{1,3\\}\\)[;]\\([0-9]\\{1,3\\}\\)\\)\"")
;;         (result ""))
;;    (save-match-data
;;      (string-match regexp input-string)
;;      (setq result
;;            (replace-match
;;             (showcase-tango-palette-from-python-dicts)
;;             nil t input-string)))
;;
;;    (unless (string= result "")
;;      (erase-c-messages)
;;      (c-message-open "")
;;      (c-message "assert error %S != %S" result input-string))))
;;
;;
;;
;;(condition-case err
;;    (test--showcase-tango-palette-from-python-dicts)
;;  (error
;;   (erase-c-messages)
;;   (c-message-open "")
;;   (c-message "test-error: %S" err)))
;;
;;
;;
;;
