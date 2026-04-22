(defun sort-lines-by-last-field (reverse beg end last-field-regexp)
  "line `sort-lines' but uses the last `field' as key"
  (interactive "P\nr")
  (when (null last-field-regexp)
    (setq last-field-regexp "\\s-+\\([^\n[:space:]]+.*\\)$"))

  (save-excursion
    (save-restriction
      (narrow-to-region beg end)
      (goto-char (point-min))
      (let ;; To make `end-of-line' and etc. to ignore fields.
        ((inhibit-field-text-motion t))
        (sort-subr reverse 'forward-line 'end-of-line)))))
