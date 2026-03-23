

;; (with-c-message-open
;;  (c-message "retval-of-insert => %S => %S"
;;             (cl-type-of retval-of-insert)
;;             retval-of-insert))

;; expands to

(progn
  (erase-c-messages)
  (c-message-open)
  (c-message "retval-of-insert => %S => %S"
             ": fooo" "BAR"))
