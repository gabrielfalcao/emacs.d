(defmacro with-c-message-open (&optional window-position &rest body)
  `(progn ,@body))


(progn
  (enable-debug-on-error)
  (erase-c-messages)
  (c-message-open)
  (c-message "%S"
             (macroexpand
              `(with-c-message-open
                (erase-c-messages)
                (c-message "foo")))))
