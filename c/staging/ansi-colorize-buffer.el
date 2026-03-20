(defconst colorize-ansi-truecolor-string-regexp
  "\\([\\]\\(x1b\\|033\\|[ee]\\)\\([[]\\([01];\\)?\\(38\\|48\\);2;\\([0]\\|[1-9][0-9]\\{0,2\\}\\);\\([0]\\|[1-9][0-9]\\{0,2\\}\\);\\([0]\\|[1-9][0-9]\\{0,2\\}\\)m\\)\\)"
  )

(defun colorize-ansi-truecolor-strings-buffer ()
  (interactive)
  (let* (
         (min-pos-restricted (point-min))
         (max-pos-restricted (point-max))
         (cur-pos-restricted (point))

         (min-pos-unrestricted nil)
         (max-pos-unrestricted nil)
         (cur-pos-unrestricted nil)

         (start-point (point))
         (end-point       nil)
         )


    (save-mark-and-excursion
      (save-restriction
	(widen)
	(setq min-pos-unrestricted (point-min))
	(setq max-pos-unrestricted (point-max))
	(setq cur-pos-unrestricted (point))
	(beginning-of-buffer)

	(while (re-search-forward colorize-ansi-truecolor-string-regexp nil t)
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
