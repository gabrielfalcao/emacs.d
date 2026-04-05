(defmacro with-buffer-writable (buffer-or-name &rest body)
 "Execute the forms in BODY with BUFFER-OR-NAME temporarily current and
writable. This is morally equivalent to using `with-current-buffer',
setting `buffer-read-only' to nil, executing the forms in BODY then
restoring `buffer-read-only' to whatever value it had before."
 (declare (indent 1) (debug t))
 (let* (
        (buffer-to-erase (make-symbol (format "buffer-to-erase" )))
        (buffer-to-erase-readonly-state (make-symbol (format "buffer-to-erase-readonly-state" )))
        )
 `(let* ((buffer (get-buffer ,buffer-or-name))
         (buffer-read-only-state (make-symbol "buffer-read-only-state


(with-current-buffer ,
    (set-buffer ,buffer-or-name)

    ,@body))
