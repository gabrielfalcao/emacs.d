(defun call-fmt-tool (&optional save-upon-success)
  "."
  (interactive)
  (enable-debug-on-error)
  (let* ((result
          (catch 'fmt-failed
            (let* (
                   (required-mode-name "awk-mode")
                   (fmt-tool-prog-name "gawk")
                   (fmt-tool-args      "-f" "-" "-o-")
                   (fmt-tool-inputfile current-filename)

                   (buf-filename       (buffer-file-name)
                                       )
                   (current-filename (progn
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

                   (tmp-stdout-buffer-name (format "%s:%s" tmp-buffer-prefix "stdout")
                                           )
                   (tmp-stderr-buffer-name (format "%s:%s" tmp-buffer-prefix "stderr")
                                           )

                   (tmp-stdout-buffer      (get-buffer-create tmp-stdout-buffer-name)
                                           )
                   (fmt-tool-call-process-args (append fmt-tool-args (list fmt-tool-prog-name fmt-tool-inputfile (list tmp-stdout-buffer tmp-stderr-file) nil)
                                                       )
                                               )
                   (exit-code (apply #'call-process fmt-tool-call-process-args)
                              )
                   (fmt-succeeded   (equal exit-code )
                                    )
                   (stderr
                    (with-temp-buffer
                      (insert-file-contents tmp-stderr-file)
                      (widen)
                      (beginning-of-buffer)
                      (buffer-substring-no-properties (point-min) (point-max)
                                                      )
                      )
                    )

                   (stdout
                    (with-current-buffer tmp-stdout-buffer
	              (widen)
                      (beginning-of-buffer)
                      (buffer-substring-no-properties (point-min) (point-max)
                                                      )
                      )
                    )
                   )

              (c-message "gawkfmt %s exitted with code: %s" current-filename-display exit-code)
              (unwind-protect
                  (progn
                    (unless fmt-succeeded
                      (c-message "gawkfmt %s failed with code: %s"
                                 current-filename-display
                                 exit-code)
                      (throw 'fmt-failed (pop-to-buffer-same-window tmp-buffer-stderr nil)

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

                (kill-buffer tmp-stdout-buffer)

                )
              )
            )
          )
         )
    (kill-buffer tmp-stdout-buffer)
    (delete-file tmp-stderr-file)
    )
  )
)
