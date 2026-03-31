(defun c-message-visible-p ()
  (let* (
         ;;
         (vis-frames                (visible-frame-list))
         (total-items               (length vis-frames))
         (tmp-frame                 (nth 0 vis-frames))
         ;;
         )
    (c-message-open)
    (erase-c-messages)

    (seq-do-indexed (lambda (item-frame item-index)
                      (let* (
                             ;;
                             (item-no (1+ item-index))
                             (pos     (format "%-4s of %s" item-no total-items))
                             ;;
                             )
                        (c-message "[%s] title => %s" pos (get tmp-frame 'title))
                        )
                      )
                    vis-frames
                    )
    )
  )


(defun get-window-list()
  (let* ((result-windows (list)))
    (walk-windows (lambda (win) (push win result-windows)))
    result-windows))
