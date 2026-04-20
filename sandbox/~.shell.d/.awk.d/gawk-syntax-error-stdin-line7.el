(defconst prettify-gawk-regex-error-details
  "^\\([[:space:]]*?\\(g?awk:[[:space:]]*\\)\\([a-zA-Z0-9_-]+[^:]*\\)[:]\\([0-9]+\\)[:]\\)[[:space:]]+\\([^\n]+\\)[\n]\1[[:space:]]\\([[:space:]]*\\)")

(defun prettify-gawk ()
  (interactive)
  (erase-messages)

  (let* ((buf-filename (buffer-file-name))
         (current-filename (progn
                             (unless (file-exists-p (buffer-file-name))
                               (signal 'type-error
                                       (format  "[prettify-gawk] current buffer is not a file: `%s'" (buffer-name))))

                             (expand-file-name (buffer-file-name))))
         (tmp-buffer-name (format "*prettify-gawk:%s*" current-filename))
         (tmp-buffer (create-fresh-buffer tmp-buffer-name))
         (prettify-gawk-args (list tmp-buffer nil current-filename ))
         (exit-code
          (apply #'call-process
                 (append (list "black" nil) prettify-gawk-args))))
    (message
     (format "black %s exitted with code: %s" current-filename exit-code))

    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)))
     (let* ((error-string
             (with-current-buffer tmp-buffer
	       (widen)
	       (goto-char (point-min))
	       (buffer-substring-no-properties (point-min) (point-max))))
	    (error-details
	     (with-current-buffer tmp-buffer
	       (widen)
	       (goto-char (point-min))
	       (let ((regex-point-beg (point))
		     (regex-point-end
		      (save-excursion (end-of-line) (point))))
                 (beginning-of-buffer)
                 (goto-char (point-min))

                 (if (re-search-forward
		      prettify-gawk-regex-error-details
		      regex-point-end
		      t 1)
                     (progn
		       (let ((message-type (match-string 1))
			     (error-filename (match-string 2))
			     (error-type (match-string 3))

			     (error-message (match-string 4))
			     (error-lineno
			      (string-to-number (match-string 5)))
			     (error-column
			      (string-to-number (match-string 6))))
		         (list
                          message-type
                          error-filename
                          error-type
                          error-message
                          error-lineno
                          error-column)))
                   )))))
       (if (and
            (listp error-details)
            (not (null (nth 4 error-details))))
	   (let* ((message-type (nth 0 error-details))
                  (error-filename (nth 1 error-details))
                  (error-type (nth 2 error-details))
                  (error-message (nth 3 error-details))
                  (error-lineno (nth 4 error-details))
                  (error-column (nth 5 error-details)))
	     (goto-line error-lineno)
	     (goto-char (+ (point) error-column))
	     (message
	      "%s in %s line %d column %d => %s: %s"
	      (propertize
               (format "%s" message-type)
               'face
               (list :background "#3d3d3d" :foreground "#FF3232"))

	      error-filename
	      error-lineno
	      error-column
	      (propertize
               (format "%s" error-type)
               'face
               (list :background "#3d3d3d" :foreground "#FF3232"))
	      (propertize
               (format "%s" error-message)
               'face
               (list :background "#FF3232" :foreground "#3d3d3d"))

	      ))
         (pop-to-buffer-same-window tmp-buffer)
         (user-error
          (format "black %s failed with code: %s"
                  (abbreviate-file-name current-filename)
                  exit-code)))))
    (ignore-errors (kill-buffer tmp-buffer))))
