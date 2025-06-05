(erase-messages)
(message (format "%s" (list "a" "b" '("c" "d"))))

(message (format "%s" (cons "a" '("c" "d"))))


(defun myfun()
  (message "1")
  (message "2")
  (defun testicle()
    (message "3"))
  (testicle)
  )

(myfun)
