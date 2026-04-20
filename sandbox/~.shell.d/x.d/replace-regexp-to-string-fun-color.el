(progn
  (enable-debug-on-error)
  (let* (
       (indexed-varnames '("PALETTE_NAME" "COLOR_NAME" "TONE" "RED" "GREEN" "BLUE" ))
       (varname-caps   (upcase (substring-no-properties (or (match-string 1) ""))))
       (varname-snake  (downcase (substring varname-caps)))
       (var-is-integer (member varname-caps '("RED" "GREEN" "BLUE")))
       (initial-value  "\x22\x22")
       (declare-flags  "\x2d\x2d")
       (pair           (progn
                         (erase-c-messages) (c-message-open "")
                         (plist-get indexed-varnames varname-caps
                                    (lambda (lhs rhs)
                                      (when (consp lhs)
                                        (setq lhs (car lhs)))
                                      (when (consp rhs)
                                        (setq lhs (car rhs)))
                                      (string= lhs rhs)
                                      ))))
       (pair-ty        (progn
                         (c-message "pair (%s) = %s" (type-of pair) (format "%S" pair))))
       (varname        (car pair))
       (position       (cadr pair))
       (fmt            (format "argv[%s]" (or (and var-is-integer "%d")
                                          "\x22%s\x22")))
       (assign-value  (format fmt pair-position))
       )

    (when (member varname-caps )
      (setq declare-flags "-i")
      )
    (format "local %s %s=%s\n" declare-flags varname-snake assign-value)))


;; (replace-regexp
;;    "^\(\s-\{7\}[(]\)\([a-z-]+[_][a-z0-9_]*\)\(\s-+\)"
;;    \,(string-join (list \1 (replace-regexp-in-string "[_]" "-" \2) \3))
;; )
