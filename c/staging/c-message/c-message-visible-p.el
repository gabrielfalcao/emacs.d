(defun c-message-visible-p (&optional buffer)
  (unless buffer
    (setq buffer (current-buffer)))

  (unless (bufferp buffer)
    (signal 'type-error (format "argument BUFFER should be a `buffer' but instead is `%s': %S" (cl-type-of buffer) buffer)))

  (let* (
         ;;
         (buf buffer)
         (buf-frame (selected-frame))
         (buf-window (selected-window))
         ;;
         )
    (walk-windows (lambda (win)



                    ;; <lambda (win)>

                    ;; </lambda (win)>

                    )
                  nil
                  nil
                  )
    )
  )
