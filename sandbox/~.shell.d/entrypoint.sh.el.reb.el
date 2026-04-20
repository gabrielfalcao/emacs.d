(defun collect-traps()
  (interactive)
  (let* (
         (regexp "^\\(\\s-*[#]\\s-*\\)?\\(\\s-*\\)\\(trap\\)\\s-+\\([a-zA-Z0-9_]+[^[:space:]\n]*\\)\\s-*\\([[:space:]\\n]+\\)\\([a-zA-Z0-9_]+\\)\\(\\s-*\\)$")
         (result (list))
         )
    (save-mark-and-excursion
      (widen)
      (beginning-of-buffer)
      (save-match-data
        (while (re-search-forward regexp nil t)
          (let* (
                 (md (match-data))
                 (md-len (length md))
                 (pairs (/ md-len 2))
                 (subexp-count (- pairs 1))
                 (subexps (mapcar (lambda (idx)
                                    (list :subexp idx
                                          :string (match-string idx)
                                          )
                                    ) ; end lambda
                                  (number-sequence 0 subexp-count))
                          )
                 )
            )
          )
        )
      )
    )
)
