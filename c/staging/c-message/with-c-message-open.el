(defmacro with-c-message-open (&optional window-position &rest body)
  (let* ((orig-body (copy-sequence body))
         (window-location
          (pcase window-position
            ((or "right" :right 'right)
             #'split-window-right)
            ((or "left" :left 'left)
             #'split-window-horizontally)
            ((or "above" :above 'above)
             #'split-window-vertically)
            ((or "below" :below 'below)
             #'split-window-below)
            (_
             (c-message "window-position (%S): %S"
                        (cl-type-of window-position)
                        window-position)
             (c-message "body (%S): %S" (cl-type-of body) body)
             ;; (setq body (list (car window-position) (car body)))
             ))
          )
         (existing-buffer (get-buffer c-message-buffer))
         (existing-window
          (and  existing-buffer (get-buffer-window existing-buffer)))
         (current-windows (window-list nil :minibuf-never)))
    (when (eq (frame-first-window) existing-window)
      (delete-window existing-window))

    (delete-other-windows (frame-first-window))
    (set-window-buffer
     (funcall window-location)
     (get-buffer-create c-message-buffer))

    `(progn ,@body))

  )

(enable-debug-on-error)
(erase-c-messages)
(c-message "%S"
           (macroexpand-1
            '(with-c-message-open
              (erase-c-messages)
              (c-message "foo"))))
