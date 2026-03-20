(defun colorize-hexadecimal-text ()
  (interactive)
  (save-excursion
    (let (begb hwmb cbeg cend faber)
      (setq begb (point-min))
      (setq hwmb (point-max))
      (goto-char begb)
      (while (and
              (re-search-forward "\\([#][a-f0-9]\\{3\,6\\}\\b\\)" hwmb t)
              (<= (point) hwmb))
        (let* ((cbeg (match-beginning 1))
               (cend (match-end 1))
               (faber (buffer-substring-no-properties cbeg cend))
               (x2133
                (progn
                  (Ox33b4O/$/delete-overlays-within cbeg cend)
                  (make-overlay cbeg cend))))
          (overlay-put x2133 'bcc t)
          (overlay-put x2133 'face
                       (list :foreground
                             (contrast-color faber)
                             :background faber)))))))
