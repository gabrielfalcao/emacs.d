(defcustom c-message-buffer
  "*C-Messages*"

  "
Name of buffer to use for `c-message'.

By default, calls to `c-message' write messages to a buffer named
`\"C-Messages\"'. This setting allows customization of the buffer name.
"
  :type 'string
  :group 'c-message
  :tag "Name of buffer where all \"C-Messages\" are written to."

  )

(defcustom c-message-write-to-minibuffer
  t
  "`c-message' will always write to minibuffer unless this var is set to `nil'"
  :type 'boolean
  :group 'c-message
  :tag "always write to minibuffer strings originating from calls to `c-message'"

  )

(defun c-message (fmt &rest args)
  "drop-in replacement for `message' that output colorized messages to a buffer named \"*C-Messages*\""
  (interactive (interactive-read-fmt-and-args))

  (let* ((output (format "%s\n" (apply #'format fmt args)))
         (trimmed-output (string-trim output))
         ;; (output (concat (apply #'format (append (list fmt) args)) "\n"))
         (buffer (get-buffer-create c-message-buffer)))
    (with-current-buffer buffer
      (read-only-mode -1)
      (widen)
      (end-of-buffer)
      (insert output)
      (end-of-buffer)
      (goto-char (point-max)))

    (unless (null c-message-write-to-minibuffer)
      (write-to-minibuffer trimmed-output))
    trimmed-output))

(defun erase-c-messages (&optional dont-erase-minibuffer)
  "."
  (interactive)
  (erase-buffer-by-name  "*C-Messages*")
  (unless (not (null dont-erase-minibuffer)) (erase-minibuffer)))

(defun c-message-open (&optional fmt &rest args)
  "drop-in replacement for `c-message' opens the `*C-Messages*' buffer after outputing the message"
  (interactive "*s")
  (when (null fmt) (setq fmt ""))

  (delete-other-windows (frame-first-window))
  ;;(erase-c-messages)
  (let ((output (funcall #'c-message fmt args)))
    (or
     (when ;; c-message-buffer is open and is the first active buffer in current frame...
         (and
          (not (null (get-buffer-window c-message-buffer)))
	  (eq
           (frame-first-window)
           (get-buffer-window c-message-buffer)))
       (message "... then split frame horizontally with the c-message-buffer at the right side")
       ;; ... then split frame horizontally with the c-message-buffer at the right side
       (set-window-buffer
        (split-window-right)
        (get-buffer c-message-buffer))
       ;; ... and set the previously active buffer (if any) to the left
       (debug-active-buffers
        ;; TODO: first lets figure out the most recent buffer before c-message-buffer
        )) ;; `end' `when' c-message-buffer is open and is the first active buffer in current frame
     (progn ;; currently active buffer is not c-message-buffer
       ;; so let's split right and set c-message-buffer to the right
       (let* ((right-side (split-window-right))
	      (cmbuffer (get-buffer-create c-message-buffer)))

         (message "(set-window-buffer %S %S)" right-side cmbuffer)
         (set-window-buffer right-side cmbuffer))));; `end' `or' clause
    output))

(defun delete-c-messages() (interactive) (erase-c-messages))


;;;
;;;(defun c-message-force-minibuffer (fmt &rest args)
;;;  (interactive (interactive-read-fmt-and-args))
;;;  (setq c-message-write-to-minibuffer t)
;;;  (funcall #'c-message fmt args))
;;;
;;;(defun c-message-no-minibuffer (fmt &rest args)
;;;  (interactive (interactive-read-fmt-and-args))
;;;  (setq c-message-write-to-minibuffer nil)
;;;  (funcall #'c-message fmt args))
;;;
;;;
;;;(defun c-message-eval-expression (expression)
;;;  (interactive "X")
;;;  (c-message-open "%s" expression))
;;;
