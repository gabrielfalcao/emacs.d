(defun gawkfmt (&optional save-upon-success)
  "."
  (interactive)
  (enable-debug-on-error)
  (catch 'fmt-failed
    (let* (
           (required-mode-name "awk-mode")
           (fmt-tool-prog-name "gawk")
           (fmt-tool-args      "-f" "-" "-o-")
           (fmt-tool-inputfile current-filename)

           (orig-buffer        (current-buffer))
           (buf-filename       (buffer-file-name orig-buffer))
           (current-filename (with-current-buffer orig-buffer
                               (unless (string= required-mode-name (get-mode-name)
                                                )
                                 (throw  'fmt-failed (c-message "%S is not in `%s'" (buffer-name) required-mode-name)
                                         )
                                 )
                               (unless buf-filename
                                 (throw  'fmt-failed (c-message "%S is not a file buffer" (buffer-name)
                                                                )
                                         )
                                 )

                               (expand-file-name buf-filename)
                               )
                             )
           (current-filename-display (abbreviate-file-name current-filename)
                                     )
           (current-buffer-contents (save-mark-and-excursion
                                      (widen)
                                      (beginning-of-buffer)
                                      (buffer-substring-no-properties
                                       (point-min)
                                       (point-max)
                                       )
                                      )
                                    )
           (tmp-buffer-prefix (format "*%s*:%s" (c-defun-name) current-filename)
                              )

           (tmp-stderr-buffer-name (format "%s:%s" tmp-buffer-prefix "stderr"))
           (tmp-stderr-file (let* (
                                   (name      (format "%s.stderr.log" current-filename))
                                   (buf-name  tmp-stderr-buffer-name)
                                   (call-args (mapcar (lambda (arg) (format "# %s" arg) ) fmt-tool-call-process-args))
                                   (call-proc  (string-join call-args " "))
                                   (timestamp (format-time-string "%Y-%m-%d %H:%M:%S (%s . %N)"))
                                   (lines     (list (format "filename: %s" name)
                                                    (format "buffer-name: %s" buf-name)
                                                    (format "call-args: %s" call-proc)
                                                    (format "timestamp: %s" timestamp)))
                                   (contents (format "%s" (string-join lines) "\n"))
                                   )
                              (with-temp-file name
                                (insert contents))
                              name))
           (tmp-stderr-buffer      (get-buffer-create tmp-stderr-buffer-name))


           (tmp-stdout-buffer-name (format "%s:%s" tmp-buffer-prefix "stdout"))
           (tmp-stdout-file (let* (
                                   (name      (format "%s.stdout.log" current-filename))
                                   (buf-name  tmp-stdout-buffer-name)
                                   (call-args (mapcar (lambda (arg) (format "# %s" arg) ) fmt-tool-call-process-args))
                                   (call-proc  (string-join call-args " "))
                                   (timestamp (format-time-string "%Y-%m-%d %H:%M:%S (%s . %N)"))
                                   (lines     (list (format "filename: %s" name)
                                                    (format "buffer-name: %s" buf-name)
                                                    (format "call-args: %s" call-proc)
                                                    (format "timestamp: %s" timestamp)))
                                   (contents (format "%s" (string-join lines) "\n"))
                                   )
                              (with-temp-file name
                                (insert contents))
                              name))
           (tmp-stdout-buffer      (get-buffer-create tmp-stdout-buffer-name))


           (fmt-tool-call-process-args (append fmt-tool-args (list fmt-tool-prog-name fmt-tool-inputfile (list tmp-stdout-buffer tmp-stderr-file) nil)
                                               )
                                       )
           (exit-code (apply #'call-process fmt-tool-call-process-args))
           (stderr
            (with-current-buffer tmp-stderr-buffer
              (erase-buffer)
              (insert-file-contents tmp-stderr-file)
              (widen)
              (beginning-of-buffer)
              (buffer-substring-no-properties (point-min) (point-max))
              )
            )

           (stdout
            (with-current-buffer tmp-stdout-buffer
	      (widen)
              (beginning-of-buffer)
              (buffer-substring-no-properties (point-min) (point-max)                                              )
              )
            )

           (tmp-stdout-file (with-temp-file tmp-stdout-file
                              (erase-buffer)
                              (widen)
                              (beginning-of-buffer)
                              (insert stdout)
                              tmp-stdout-file))

           (tmp-stderr-file (with-temp-file tmp-stderr-file
                              (erase-buffer)
                              (widen)
                              (beginning-of-buffer)
                              (insert stderr)
                              tmp-stderr-file))

           (fmt-succeeded   (equal exit-code ))
           )

      (c-message "gawkfmt %s exitted with code: %s" current-filename-display exit-code)
      (unwind-protect
          (progn
            (unless fmt-succeeded
              (c-message "gawkfmt %s failed with code: %s"
                         current-filename-display
                         exit-code)
              (throw 'fmt-failed (let* (
                                        (rawfile  t)
                                        (nowarn   t)
                                        (buf      (progn
                                                    (ignore-errors
                                                      (kill-buffer tmp-stderr-file))
                                                    (find-file-noselect tmp-stderr-file nowarn rawfile)))
                                        (filename tmp-stderr-buffer)
                                        )

                                   (pop-to-buffer-same-window buf t)
                                   (with-current-buffer orig-buffer



                                   (save-mark-and-excursion
                                     (erase-buffer)
                                     (insert stdout)
                                     (and save-upon-success (basic-save-buffer nil)
                                          )
                                     )
                                   (c-message "%s formatted with gawkfmt"current-filename-display)
                                   )
                     )
              )
            )

        (kill-buffer tmp-stdout-buffer)
        (kill-buffer tmp-stderr-buffer)
        )
      )
    )
  )
