(defun blackpy ()
  "TODO: use `call-process-get-status-and-info' instead of duplicating most of the code of `blackpy'."
  (interactive)
  (erase-messages)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-buffer-name (format "*blackpy:%s*" current-filename))
         (tmp-buffer (create-fresh-buffer tmp-buffer-name))
         (blackpy-args (list tmp-buffer nil "-w" current-filename ))
         (exit-code
          (apply #'call-process (append (list "black" nil) blackpy-args))))
    (message
     (format "black %s exitted with code: %s" current-filename exit-code))

    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)
         ))
     (let* ((error-string (with-current-buffer tmp-buffer
			    (widen)
			    (goto-char (point-min))
			    (buffer-substring-no-properties (point-min) (point-max))
			    ))
	    (error-details
	     (with-current-buffer tmp-buffer
	       (widen)
	       (goto-char (point-min))
	       (let ((regex-point-beg (point))
		     (regex-point-end
		      (save-excursion (end-of-line) (point))))
                 ;;^ ;; [error] index.ts: SyntaxError: Function type notation must be parenthesized when used in a union type. (96:46)
                 ;;  ;; [error] utils.ts: SyntaxError: Expression expected. (183:21)
                 (goto-char (point-min))

                 (if (re-search-forward
		      "^\\(error:\\s-*\\)?\\(cannot\\s-*format\\s-*\\(\\s-*\\([^:[:space:]]+\\)\\(:?\\)\\(\\s-*\\)\\)\\)\\(\\s-*\\([^:]+\\)\\(:\\)?\\(\\s-*\\)\\)\\(\\s-*\\([^:]+\\)\\(:\\)?\\(\\s-*\\)\\)\\(\\s-*\\([^:]+\\)\\(:\\)?\\(\\s-*\\)\\)\\(\\s-*\\(.+\\)\\(\\s-*\\)\\)$"
		      regex-point-end
		      t 1)
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
                        error-column
                        )
		       )
		   )
                 )
	       )
	     ))
       (if (and (listp error-details)
                (not (null (nth 4 error-details))))
	   (let* (
                  (message-type (nth 0 error-details))
                  (error-filename (nth 1 error-details))
                  (error-type (nth 2 error-details))
                  (error-message (nth 3 error-details))
                  (error-lineno (nth 4 error-details))
                  (error-column (nth 5 error-details))
                  )
	     (goto-line error-lineno)
	     (goto-char (+ (point) error-column))
	     (message
	      "%s in %s line %d column %d => %s: %s"
	      (propertize (format "%s" message-type) 'face
                          (list :background "#3d3d3d"
                                :foreground "#FF3232"))

	      error-filename
	      error-lineno
	      error-column
	      (propertize (format "%s" error-type) 'face
                          (list :background "#3d3d3d"
                                :foreground "#FF3232"))
	      (propertize (format "%s" error-message) 'face
                          (list :background "#FF3232"
                                :foreground "#3d3d3d"))

	      ))
         ;; else
         (pop-to-buffer-same-window tmp-buffer)
         (user-error
          (format "prettier -w %s failed with code: %s"
                  (abbreviate-file-name current-filename)
                  exit-code)))
       ))
    (ignore-errors (kill-buffer tmp-buffer))
    ))
