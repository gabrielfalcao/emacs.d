(defun c-message-visible-p ()
  (let* (
         ;;
         (vis-frames                (visible-frame-list))
         (total-items               (length vis-frames))
         (item-frame                 (nth 0 vis-frames))
         ;;
         )
    (c-message-open)
    (erase-c-messages)

    (c-message "frame: %S" item-frame)
    ;; (seq-do-indexed (lambda (item-frame item-index)
    ;;                   (let* (
    ;;                          ;;
    ;;                          (item-no (1+ item-index))
    ;;                          (pos     (format "%-4s of %s" item-no total-items))
    ;;                          ;;
    ;;                          )
    ;;                     (c-message "[%s] title => %s" pos (get item-frame 'title))
    ;;                     )
    ;;                   )
    ;;                 vis-frames
    ;;                 )
    )
  )
