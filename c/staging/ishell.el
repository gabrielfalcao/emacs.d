(defun ishell (&optional socket-file &rest spawn-command-args)
  (interactive)

  ;; WEZTERM_UNIX_SOCKET="/Users/gabrielfalcao/.local/share/wezterm/gui-sock-530"
  (let* ((wezterm-unix-socket-env (getenv "WEZTERM_UNIX_SOCKET"))
         (unix-socket-path
           (or
             (and
               (length> (string-trim socket-file) 0)
               (file-exists-p socket-file)
               socket-file)
             nil))
         (wezterm-unix-socket-path
           (or
             (and
               (length> (string-trim wezterm-unix-socket-env) 0)
               (file-exists-p wezterm-unix-socket-env)
               wezterm-unix-socket-env)
             nil))
         (unix-socket
           (let ((socket (or unix-socket-path wezterm-unix-socket-path)))
             (unless (and (length> socket 0) (file-exists-p socket))
               (signal 'type-error
                 (format "[ishell] unix socket file exists neither in `%s' nor in `%s'"
                   unix-socket-path

                   wezterm-unix-socket-path))) ; end unless
             socket))
         (cwd (getcwd))
         (now (format-time-string "%Y-%m-%d.%H-%M-%S.%s"))
         (bufname-prefix (format "wezterm-cli-spawn.%s" now))
         (stdout-bufname (format "%s.stdout.log" bufname-prefix))
         (stderr-bufname (format "%s.stderr.log" bufname-prefix))
         (stdout-buf (get-buffer-create stdout-bufname))
         (stderr-buf (get-buffer-create stderr-bufname))
         (destination (cons stdout-buf . stderr-buf))
         (program-name "wezterm")
         (program-args
           (append
             (list "cli" "--no-auto-start" "--pane-id=${WEZTERM_PANE}" "--cwd" cwd "spawn")
             (cond
               ((and
                   (length> spawn-command-args 0)
                   (list-of-strings-p spawn-command-args))
                 spawn-command-args)
               ((length= spawn-command-args 0)
                 (list))
               (t
                 ;;(not (list-of-strings-p spawn-command-args))
                 (signal 'type-error
                   (format "[ishell] extra arguments `spawn-command-args' should be a list of strings: %S"
                     spawn-command-args))
                 (list))))) ; end (cond ... ) ; end (append (list "cli" ...)) ;end (let* (... (program-args ...)))
         (call-process-apply-list
           (append (list program-name) program-args))
         (call-process-apply-string
           (string-join call-process-apply-list " "))
         (wezterm-cli-exit-code
           (apply #'call-process call-process-apply-list))
         (stdout
           (with-current-buffer stdout-buf
             (save-mark-and-excursion (widen) (buffer-string))))
         (stderr
           (with-current-buffer stderr-buf
             (save-mark-and-excursion (widen) (buffer-string))))) ;end let* ( ... ) varlist

    (if (= wezterm-cli-exit-code 0)
      (message "command `%s' succeeded:\n<stdout>\n%s\n</stdout>\n\n<stderr>\n%s\n</stderr>\n"
        call-process-apply-string
        stderr
        stdout)
      (message "success: %s" call-process-apply-string)
      (user-error "command `%s' failed with status %d:\n<stderr>\n%s\n</stderr>\n\n<stdout>\n%s\n</stdout>\n"
        call-process-apply-string ;; end (let* ...)
        wezterm-cli-exit-code
        stderr
        stdout)))) ; end (defun ishell ...)
