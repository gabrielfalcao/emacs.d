(defun write-to-minibuffer (text)
  "writes to minibuffer"
  (let ((output
         (or (when (stringp text) text) (format "%S" text))))
    (ignore-errors
      (with-current-buffer (window-buffer (minibuffer-window))
	(read-only-mode -1)
	(widen)
	(erase-buffer)
	(end-of-buffer)
	(insert output)
	(read-only-mode 1)))))

(defun erase-minibuffer ()
  "erases the minibuffer in the current frame"
  (interactive)

  (ignore-errors
    (with-current-buffer (window-buffer (minibuffer-window))
      (read-only-mode -1)
      (widen)
      (erase-buffer)
      (read-only-mode 1))))

