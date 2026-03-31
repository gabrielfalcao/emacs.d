(defun shfmt-break-onliner-region (beg end)
  "."
  (interactive "*r")
  (let ((break-up-oneliner-regex
         "\\([;]\\s-\\|\\bdo\\b\\|\\bthen\\b\\|\\bthen\\b\\|\\belse\\b\\|\\bfi\\b\\|\\besac\\b\\|[;][;]\\)"))
    (save-mark-and-excursion
      (goto-char beg)
      (replace-regexp break-up-oneliner-regex "\n\\1\n" nil
		      (point-min)
		      (point-max)))))

(defun shfmt ()
  ".
;; https://github.com/mvdan/sh
;; go install mvdan.cc/sh/v3/cmd/shfmt@latest

shfmt -bn -ci -i 4 -ln=bash -w %s
"
  (interactive)
  ;; (shfmt-break-onliner)
  (let* ((current-shell-buffer (current-buffer))
         (current-filename (expand-file-name (buffer-file-name)))
         (tmp-buffer-name (format "*shfmt:%s*" current-filename))
         (tmp-buffer
          (progn
            (ignore-errors (kill-buffer tmp-buffer-name))
            (get-buffer-create tmp-buffer-name)))
         (exit-code
          (call-process "shfmt"
                        nil
                        tmp-buffer
                        nil "-bn" "-ci" "-i" "4" "-ln=bash" "-w" current-filename )))
    (message
     (format "shfmt -bn -ci -i 4 -ln=bash -w %s exitted with code: %s" current-filename exit-code))
    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)
         (ignore-errors (kill-buffer tmp-buffer))))
     (progn
       (let ((result
	      ;; t
	      (with-current-buffer tmp-buffer
	        (widen)

                (goto-char (point-min))
	        (re-search-forward
                 "^\\([^:]+\\)[:]\\([0-9]+\\)[:]\\([0-9]+\\)[:]\s-*\\(.+\\)$"
                 ;; "^\s-*\\([^:]+\\):\\([0-9]+\\):\\([0-9]+\\)\s-*\\(.+\\)$"
                 (point-max)
                 t)
	        (let* ((error-filename (match-string 1))
		       (error-lineno (match-string 2))
		       (error-column (match-string 3))
		       (error-message (match-string 4))
		       (result-list
                        (list error-filename error-lineno error-column error-message)))
                  result-list))

	      ))
         (if (listp result)
             (let ((error-filename (nth 0 result))
                   (error-lineno (string-to-number (nth 1 result)))
                   (error-column (string-to-number (nth 2 result)))
                   (error-message (nth 3 result)))
	       (goto-line error-lineno current-shell-buffer)
	       (beginning-of-line)
	       (let ((error-point (+ (point) (- error-column 1)))
                     (eol
		      (save-mark-and-excursion
                        (end-of-line 1)
                        (point))))
                 (goto-char error-point)
                 (push-mark error-point t t)
                 ;; (goto-char eol)
                 )
	       (message
                (format "line %d: %s" error-lineno
			(propertize error-message 'face
                                    (list :foreground "#F13976"))))
	       (kill-buffer tmp-buffer))
	   (switch-to-buffer tmp-buffer t t)
	   (user-error
            (format "shfmt -bn -ci -i 4 -ln=bash -w %s failed with code: %s"
                    (abbreviate-file-name current-filename)
                    exit-code))))))))

(defun elfmt ()
  "."
  (interactive)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-buffer-name (format "*elfmt:%s*" current-filename))
         (tmp-buffer (get-buffer-create tmp-buffer-name))
         (exit-code
          (call-process "elfmt" nil tmp-buffer nil current-filename )))
    (message
     (format "elfmt %s exitted with code: %s" current-filename exit-code))
    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)))
     (user-error
      (format "elfmt %s failed with code: %s"
	      (abbreviate-file-name current-filename)
	      exit-code)))))
