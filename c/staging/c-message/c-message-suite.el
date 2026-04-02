(safe-load-file "~/.emacs.d/c/staging/c-message/c-message-visible-p.el")
(safe-load-file "~/.emacs.d/c/staging/c-message/with-c-message-open.el")

(defcustom c-messages-buffer-name
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

(defun c-message-get-logging-path-to-workbench ()
  (let* ((log-file-path
	  (expand-file-name (format "~/workbench/%s/logs/pid.%d.tty.%s.log"
				    (format-time-string "%Y-%m-%d")
				    (emacs-pid)
				    (process-tty-name server-process))))
         (log-dir-path (file-name-directory log-file-path))
         )
    (make-directory log-dir-path)
    log-file-path))

(defcustom c-message-logging-path
  #'c-message-get-logging-path-to-workbench

  "function which dynamically returns a valid path to which logging messages sent via `c-message-log' are written to."

  :type 'function
  :group 'c-message
  )

(defun c-message-log (level fmt &rest args)
  "logging facility writes to `c-message-logging-path'

arg LEVEL is one of:  `:trace', `:debug', `:info', `:warn', `:error', `:critical', `:emergency'

args FMT and ARGS are the same form as `c-message'
"
  (let* (
         (prefix (format "%s %s" (string-trim-left (symbol-name level) "^[:]+") (format-time-string "%Y/%m/%d %H:%M:%S %Z")))
         (message (funcall #'format fmt args))
         )
    (c-message-open)
    (c-message "[%s] %s" prefix message)
    )
  )


(defun c-message (fmt &rest args)
  "drop-in replacement for `message' that output colorized messages to a buffer named \"*C-Messages*\""
  (interactive (interactive-read-fmt-and-args))

  (let* ((output (format "%s\n" (apply #'format fmt args)))
         (trimmed-output (string-trim output))
         ;; (output (concat (apply #'format (append (list fmt) args)) "\n"))
         (buffer (get-buffer-create c-messages-buffer-name)))
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
     (when ;;  c-messages-buffer-name  is open and is the first active buffer in current frame...
         (and
          (not (null (get-buffer-window c-messages-buffer-name)))
	  (eq
           (frame-first-window)
           (get-buffer-window c-messages-buffer-name)))
       (message "... then split frame horizontally with the  c-messages-buffer-name  at the right side")
       ;; ... then split frame horizontally with the  c-messages-buffer-name  at the right side
       (set-window-buffer
        (split-window-right)
        (get-buffer  c-messages-buffer-name ))
       ;; ... and set the previously active buffer (if any) to the left
       (debug-active-buffers
        ;; TODO: first lets figure out the most recent buffer before  c-messages-buffer-name
        )) ;; `end' `when'  c-messages-buffer-name  is open and is the first active buffer in current frame
     (progn ;; currently active buffer is not  c-messages-buffer-name
       ;; so let's split right and set  c-messages-buffer-name  to the right
       (let* ((right-side (split-window-right))
	      (cmbuffer (get-buffer-create  c-messages-buffer-name )))

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
