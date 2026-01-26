(defun uncollapse-repeated-open-or-close-parenthesis(string)
  (let* (
         (regexp "\\([()]\\)\\(\\1\\)+")
         (result string)
         (rounds -1)
         (states nil)
         (state-count 0)
         );; end let* varlist
    (erase-c-messages)
    (c-message-open "(uncollapse-repeated-open-or-close-parenthesis %S)" string)
    (save-match-data
      (string-match regexp result)
      (while (string-match regexp result)
        (setq rounds (+ 1 rounds))
        (save-match-data
          (let* (
                (parens-char (match-string 1 result))
                (extra-occurrences (match-string 2 result))
                (whole-match (match-string 0 result))
                (new-text (uncollapse-repeated-open-or-close-parenthesis--explode-levels parens-char extra-occurrences))
                ) ;; end let varlist
            (c-message-debug-symbols (list 'result 'new-text 'whole-match)  'state-count 'string 'parens-char 'extra-occurrences)
            (setq result (replace-match new-text nil nil result))
            (setq states (append states (list result)))
            (setq state-count (length states))
            ) ;; end let
          )  ;; end save-match-data
        )  ;; end while
      )  ;; end save-match-data
    )  ;; end let*
  ) ;; end defun



(defun uncollapse-repeated-open-or-close-parenthesis--explode-levels(parens-char extra-occurrences)
  (unless (stringp parens-char)
    (signal 'type-error
            (format "`parens-char' should be a string not %s: %s"
                    (type-of parens-char)
                    parens-char)))
  (unless (= (length parens-char) 1)
    (signal 'type-error
            (format "`parens-char' should be a string of length 1 but length is: %d"
                    (length parens-char))))
  (unless (stringp extra-occurrences)
    (signal 'type-error
            (format "`extra-occurrences' should be a string not %s: %s"
                    (type-of extra-occurrences)
                    extra-occurrences)))

  (let* (
         (total-levels (length extra-occurrences))
         (len (+ 1 total-levels))
         (levels (number-sequence 0 total-levels))
         )
    (string-join
     (mapcar
      (lambda (n)
        (let ((padding-left "") (sol ""))
          (when (> n 0)
            (setq sol "#")
            (when (string= "(" parens-char)
              (setq padding-left (make-string (* n 2) (ash 1 5)))))
          (format "%s%s%s\n" sol padding-left parens-char)))
        levels))))

(uncollapse-repeated-open-or-close-parenthesis "()((())())")
