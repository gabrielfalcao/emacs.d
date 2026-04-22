(defvar call-process-get-status-and-info-tmp-stdout-buffer-suffix
  "stdout"
  "function called within call-process-get-status-and-info to ensure each *element* in `arguments' is a string")

(defvar call-process-get-status-and-info-tmp-stderr-buffer-suffix
  "stderr"
  "function called within call-process-get-status-and-info to ensure each *element* in `arguments' is a string")

(defvar call-process-get-status-and-info-conversion-function
  #'call-process-get-status-and-info-default-conversion-function
  "function called within call-process-get-status-and-info to ensure each *element* in `arguments' is a string")

(defun call-process-get-status-and-info (executable &optional mix-output display-buffer buffer-prefix tmp-stdout-buffer-name &rest arguments)
  "calls process via `call-process' capturing the output in a temporary buffer.

The first argument `executable' is the name of an executable in the PATH
environment variable or a full path to an executable file (.e.g.: \"/bin/ls\")

Any other positional `arguments' are forwarded to `call-process'.

Returns a cons like '(exit-status . output) where the `car' is an
integer with the exit code of the process and the `cdr' is a string
containing both the stdout and stderr of that process.
"
  (if (not (stringp executable))
    (error "`executable' must be a string, instead got: %S" executable))
  (if (null buffer-prefix)
    (setq buffer-prefix "call-process"))
  (unless (stringp buffer-prefix)
    (setq tmp-stdout-buffer-name (format "*%s:%s%s" buffer-prefix executable (string-join arguments "*"))))

  (let ((error-args (seq-reduce #'(lambda (ok next)
                                   (if (not (stringp next))
                                    (list "nonstring argument %S" next))
                                   ok)
                     arguments
                     nil)))
    (when (and (listp error-args)
           (length> error-args 0))
      (apply #'error (append (list "error: %S") error-args))))

  (let* ((tmp-buffer-name (format "*call-process:%s%s" executable (string-join arguments "*")))
         (tmp-buffer (create-fresh-buffer tmp-buffer-name))
         ;; TODO: use (slugify-string (format "%s %s" executable (string-join arguments " ")))
         (stderr-file (when (null mix-output)
                       (make-temp-file (file-name-nondirectory executable)))) ;; TODO: use (slugify-string (format "%s %s" executable (string-join arguments " ")))
         ;; TODO: use (slugify-string (format "%s %s" executable (string-join arguments " ")))

         (call-process-destination
           (or (when (null mix-output)
                ;; mix-output is nil meaning stderr ought to go to a file and read later
                (list tmp-buffer stderr-file))
             tmp-buffer))
         (call-process-args (append
                             (list executable ;;PROGRAM
                               nil ;; INFILE
                               call-process-destination ;; DESTINATION
                               nil) ;; DISPLAY
                             arguments))
         (full-process-call-string (mapcar #'call-process-get-status-and-info-string-conversion-function
                                    call-process-args))
         (exit-code
           (apply #'call-process call-process-args))
         (process-stdout-string (with-current-buffer tmp-buffer
                                 (widen)
                                 (goto-char (point-min))
                                 (buffer-substring-no-properties (point-min) (point-max))))
         (process-stderr-string (read-file-to-string stderr-file))) ; end let* varlist
    (let ((return-value
            (flat-assoc-list
              :exit-code
              exit-code
              :stdout
              process-stdout-string
              :stderr
              process-stderr-string
              :call-process-args
              call-process-args
              :shell-command
              full-process-call-string)))

      (or (when (null display-buffer)
           (condition-case err
             (kill-buffer tmp-stdout-buffer
               (error (let ((error-label
                              (propertize
                                (format "[error killing buffer `%s']" (auto-propertize-string tmp-stdout-buffer-name))
                                'face
                                (list :foreground "#F13976" :background "#211F17")))
                            (error-message
                              (propertize
                                (format "%s" err)
                                'face
                                (list :foreground "#F6A3D7" :background "#3d3d3d")))) ;; #C63367 ;; end let varlist
                       (c-message "%s %s" error-label error-message))))))
        (when (and (numberp display-buffer) (= display-buffer 2))
          (let* ((bottom (split-window-below)))
            (set-window-buffer tmp-stdout-buffer
              (with-current-buffer-window bottom
                (with-current-buffer tmp-stdout-buffer(widen)
                  (goto-char (point-max))
                  (end-of-buffer))))))

        (when (and (numberp display-buffer) (= display-buffer 1))
          (let* ((bottom (split-window-below)))
            (set-window-buffer tmp-stderr-buffer
              (with-current-buffer-window bottom
                (with-current-buffer tmp-stderr-buffer(widen)
                  (goto-char (point-max))
                  (end-of-buffer)))))))))) ;; end (or ... when ...when ;; end (let return-value ;; end (defun ... (let* ;; end defun
