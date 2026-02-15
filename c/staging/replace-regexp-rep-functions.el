(define-error 'syntax-error  "Syntax Error" 'error)
(define-error 'macro-syntax-error  "Macro Syntax Error" 'syntax-error)

(defmacro map-subexps (args &rest body)

(defun symbol-matches-any-of (sym &rest choices)
  (unless (symbolp sym)
    (signal 'type-error
            (format "`symbol-matches-any-of' argument `sym' should be a symbol but is a %s: %S"
                    (type-of sym)
                    sym)))

  (unless (length> choices 0)
    (signal 'type-error
            (format "`symbol-matches-any-of' requires at least one keyword or symbol in the `choices' list")
            ))

  (let ((symbol-names (list)) (idx 0))
    (mapc (lambda (elt)
            (setq idx (+ 1 idx)))
          choices))
  (unless (symbolp sym)
    (signal 'type-error
            (format "`symbol-matches-any-of' argument `sym' should be a symbol but is a %s: %S"
                    (type-of sym)
                    sym)))

    (signal 'type-error
            (format "`symbol-matches-any-of' argument `sym' should be a symbol but is a %s: %S"
                    (type-of sym)
                    sym)))

(defun replace-regexp-rgb-hex-6-to-ansi-rgb(&optional bg-color noreset nobold escape-style)
  (let* ((escape-code (cond
                       ((or (eq escape-style :octal)
                            (eq escape-style :oct)
                            (eq escape-style :prompt-string)
                            (eq escape-style :ps)
                            (eq escape-style :ps1)
                            (eq escape-style :ps2)
                            (eq escape-style :ps3)
                            (eq escape-style :ps4)

                        "\033
         (prefix (string-join
                  (append
                   (list )
                   (unless nobold (list "1"))

                  )
                        "\x1b[1;38"
(string-join (mapcar (lambda (num) (let ((val (match-string num))) (and val (downcase (format "%d%s" (string-to-number (downcase val) 16) (or (and (= num pairs) "m") ";")))))) (number-sequence 1 pairs)))
