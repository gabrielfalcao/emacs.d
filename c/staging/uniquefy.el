(defun uniquify-all-lines-buffer ()
  "."
  (interactive "*")
  (save-restriction
    (widen)
    (uniquify-all-lines-region (point-min) (point-max))))

(defun uniquify-all-lines-region (start end)
  "."
  (interactive "*r")
  (let ((input-start (copy-marker start))
        (input-end   (copy-marker end))
        (initial-line (line-number-at-pos (point) t))
        (initial-pos (point))
        (current-line (line-number-at-pos (point) t))
        (current-pos (point))
        (last-line   (save-restriction
                       (widen) (line-number-at-pos (point-max) t)))
        (current-pos (point))
        (lines       (list))
        )
    (save-mark-and-excursion
      
      (while (and (< (point) input-end)
                  (not (eobp)))
        (let (
              (line-start-pos (save-mark-and-excursion (beginning-of-line) (point)))
              (line-end-pos (save-mark-and-excursion (end-of-line) (point)))
              
      
      (let ((end (copy-marker end)))
        (while (progn
                 (goto-char start)
                 (re-search-forward
                  "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
          (replace-match "\\1\n\\2")))))

