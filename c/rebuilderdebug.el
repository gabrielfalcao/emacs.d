(defconst c-messages-buffer "*C-Messages*"
  "Buffer to use for `c-messages'.")

(defun re-builder-debug-state()
  (interactive)
  (if (not (string= reb-buffer "*RE-Builder*"))
      (user-error "reb-buffer does not match name: `%s'" reb-buffer))

  (let* ((re-builder-buffer (get-buffer reb-buffer))
         ((re-builder-buffer-local-vars
           (if (bufferp re-builder-buffer)
               (with-current-buffer re-builder-buffer
                 (list
                  (format "reb-regexp [buffer-local] =`%S'" reb-regexp)
                  (format "reb-regexp-src [buffer-local] =`%S'" reb-regexp-src)
                  (format "reb-overlays [buffer-local] =`%S'" reb-overlays)
                  )
                 )
             (list (format "no buffer-local vars in %s buffer: %S" reb-buffer re-builder-buffer))))))
    (c-messages "re-builder vars:\n%s\nre-builder buffer-local vars:\n%s"
            (string-join (list
                          (format "reb-mode =`%S'" reb-mode)
                          (format "reb-target-buffer =`%S'" reb-target-buffer)
                          (format "reb-target-window =`%S'" reb-target-window)
                          (format "reb-window-config =`%S'" reb-window-config)
                          (format "reb-subexp-mode =`%S'" reb-subexp-mode)
                          (format "reb-subexp-displayed =`%S'" reb-subexp-displayed)
                          (format "reb-mode-string =`%S'" reb-mode-string)
                          (format "reb-valid-string =`%S'" reb-valid-string)
                          ) "\n")
            (string-join re-builder-buffer-local-vars "\n"))
    )
  )

(defun re-builder-clean-and-reset()
  (interactive)
  (if (not (string= reb-buffer "*RE-Builder*"))
      (user-error "reb-buffer does not match name: `%s'" reb-buffer))


  (let ((re-builder-buffer (get-buffer reb-buffer)))
    (if (bufferp re-builder-buffer)
        (with-current-buffer re-builder-buffer
          (setq-local  reb-regexp nil
                       reb-regexp-src nil
                       reb-overlays nil)
          )))

  (setq reb-mode nil
        reb-target-buffer nil
        reb-target-window nil
        reb-window-config nil
        reb-subexp-mode nil
        reb-subexp-displayed nil
        reb-mode-string ""
        reb-valid-string ""
        )
  )
