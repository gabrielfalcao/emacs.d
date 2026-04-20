(defun dbg-curline-insert-or-replace (contents)
  (interactive "*s")

  (save-mark-and-excursion
    (let* (
           (initial-lineno        (line-number-at-pos nil t))
           (expected-prev-lineno  (- initial-lineno 1))
           (actual-prev-lineno    nil)
           (initial-pos           (point))
           (initial-eol-pos       (save-mark-and-excursion (end-of-line) (point)))
           (initial-min-pos       (point-min))
           (initial-max-pos       (point-max))
           (absolute-min-pos      nil)
           (absolute-max-pos      nil)
           (initial-line-text     "")
           pos-bol
           pos-eol
           ;; (absolute-beg-pos       nil) ;; bob = beginning-of-buffer (widen)
           ;; (absolute-end-pos       nil) ;; eob = end-of-buffer       (widen)
           )
      (save-restriction
        (widen)
        (setq absolute-min-pos     (point-min))
        (setq absolute-max-pos     (point-max)))

      (save-mark-and-excursion
        (beginning-of-line)
        (setq pos-bol (point))
        (unless (>= bol eol)
          (user-error "beginning of line greater than end of line"))
        (setq cur-line-text (buffer-substring-no-properties bol eol))
        (unless (> initial-lineno 1)
          (save-restriction
            (widen)
            (beginning-of-buffer)
            (setq actual-prev-lineno (line-number-at-pos nil t))
            (unless (= actual-prev-lineno expected-prev-lineno)
              (user-error "expected previous line number to be `%s' but actual is `%s'"
                          expected-prev-lineno actual-prev-lineno))
            
            (insert "\n")
            ))
        ) ;; (save-mark-and-excursion)
      ) ;; (let* )
    ) ;; (save-mark-and-excursion (let* ))
  ) ;; (defun dbg-curline-insert-or-replace)
        
