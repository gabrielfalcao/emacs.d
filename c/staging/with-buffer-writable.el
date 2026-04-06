(defmacro with-buffer-writable (buffer-or-name &rest body)
  "Execute the forms in BODY with BUFFER-OR-NAME temporarily current and
writable. This is morally equivalent to using `with-current-buffer',
setting `buffer-read-only' to nil, executing the forms in BODY then
restoring `buffer-read-only' to whatever value it had before."
  (declare (indent 1) (debug t))
  (let* (
         (buffer-to-erase (make-symbol (format "buffer-to-erase" )))
         (buffer-to-erase-readonly-state (make-symbol (format "buffer-to-erase-readonly-state" )))
         (with-current-buffer-result (make-symbol (format "with-current-buffer-result" )))
         )
    `(let* (
            (,buffer-to-erase (get-buffer ,buffer-or-name))
            (,buffer-to-erase-readonly-state (buffer-local-value 'buffer-read-only ,buffer-to-erase))
            (,with-current-buffer-result ,with-current-buffer-result
                                         (with-current-buffer ,buffer-to-erase
                                           ,@body))
            )
       (with-current-buffer ,buffer-to-erase (setq 'buffer-read-only ,buffer-to-erase-readonly-state))
       ,with-current-buffer-result
       )
    )
  )


;;;(defmacro with-current-buffer (buffer-or-name &rest body)
;;;  "Execute the forms in BODY with BUFFER-OR-NAME temporarily current.
;;;BUFFER-OR-NAME must be a buffer or the name of an existing buffer.
;;;The value returned is the value of the last form in BODY.  See
;;;also `with-temp-buffer'."
;;;  (declare (indent 1) (debug t))
;;;  `(save-current-buffer
;;;     (set-buffer ,buffer-or-name)
;;;     ,@body))
;;;
