(let (
      (history-vars (list
                      'regexp-history
                      'occur-collect-regexp-history
                      'query-replace-history))
      )
  (insert "\n")
  (erase-c-messages)
  (c-message-open "")
  ;; (c-message "history-vars (%s): %S" (type-of history-vars) history-vars)

  (seq-map-indexed
   (lambda (hist-var-sym hist-var-index)
     (let* (
            (history-var (symbol-name hist-var-sym))
            (history-list (symbol-value hist-var-sym))
            (parent-dir (mkdir-p (expand-file-name (format "~/.emacs.d/vardumps" history-var))))
            (filename (file-name-concat parent-dir
                                        (format "%s.%s.el" history-var
                                                (format-time-string "%Y-%m-%d_%H-%M-%S_%Z" nil t))))
            (dump (string-join
                      (seq-map-indexed
                       (lambda (item index)
                         (format "%S:    %S\n" index item))
                       history-list
                       )
                      "\n"))
            )
       (write-region dump nil filename t nil nil nil)
       )
     )
   history-vars
   )
  )
