(defun align-backslash-eol-widest-region-internal(beg end)
  (unless (number-or-marker-p beg)
    (signal 'type-error
      (format "argument `beg' must be either a number or marker but instead received `%s': %s"
        (type-of beg)
        beg)))
  (unless (number-or-marker-p end)
    (signal 'type-error
      (format "argument `end' must be either a number or marker but instead received `%s': %s"
        (type-of end)
        end)))

  (erase-c-messages)
  (c-message-open)
  (let ((furthest-backslash-col 0))
    (save-match-data
      (save-mark-and-excursion
        (goto-char beg)
        (beginning-of-line)
        (while (re-search-forward "^.*?[^\\]+\\s-+\\([\\]\\)\\s-*$" end t)
          (let* (
                 (pos-line-beg (progn (beginning-of-line) (point)))
                 (pos-beg (progn (match-beginning 1) (point)))
                 (pos-end (progn (end-of-line) (point)))
                 (lineno (line-number-at-pos pos-beg))
                 (text (buffer-substring-no-properties pos-beg pos-end))
                 (width (length text)))
            (c-message "pos-beg: %S" pos-beg)
            (c-message "pos-end: %S" pos-end)
            (c-message "width: %S" width)
            (c-message "text: %S" text)
            (c-message "action: %S" action)
            (c-message "")

            (forward-line)
            (beginning-of-line))))))) ; end (while ...) ;; ends (save-mark-and-excursion ...) ;; ends (save-match-data ...)

(defun align-backslash-eol-widest-region(beg end)
  (interactive "*r")
  (align-backslash-eol-widest-region beg end))

(defun align-backslash-eol-widest-buffer ()
  (interactive)
  (save-mark-and-excursion
    (widen)
    (beginning-of-buffer)
    (align-backslash-eol-widest-region (point-min) (point-max))))
