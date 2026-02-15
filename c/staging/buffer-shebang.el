(defun buffer-first-line ()
  (save-mark-and-excursion
    (widen)
    (beginning-of-buffer)
    (end-of-line)
    (buffer-substring-no-properties (point-min) (point))))

(defun buffer-shebang-firstline ()
  (save-mark-and-excursion
    (widen)
    (beginning-of-buffer)
    (re-search-forward "^([#][!]([a-zA-Z0-9,-/_]+))"
    (end-of-line)
    (buffer-substring-no-properties (point-min) (point))))

(defun shebang-file-executable()
  (when-let ((filename (buffer-file-name)))
    (let ((first-line (save-mark-and-excursion
                        (widen)
                        (beginning-of-buffer)
                        (end-of-line)
                        (buffer-substring-no-properties (point-min) (point)))))
      (string-

       )))
  )
