(defmacro with-c-message-open (&optional window-position &rest body)
  (let* ((orig-body (copy-sequence body))
         (default-window-location #'split-window-right)
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
             (setq body `(,window-position ,@body))

             ;; (c-message "<body type=%S>\n%S\n</body>"
             ;;            (format "%S" (cl-type-of body))
             ;;            body)
             default-window-location
             ))
          )
         (existing-buffer (get-buffer c-message-buffer))
         (existing-window
          (and  existing-buffer (get-buffer-window existing-buffer)))
         (current-windows (window-list nil :minibuf-never)))

    `(progn ,@body)))

;; TESTING:
;; ;;
;; ;; (progn
;; ;;   (disable-debug-on-error)
;; ;;   ;; (enable-debug-on-error)
;; ;;   (let* (
;; ;;          (sexpr `(with-c-message-open :left
;; ;;                 (erase-c-messages)
;; ;;                 (c-message "bar")))
;; ;;          (expanded (macroexpand sexpr))
;; ;;          )
;; ;;     (c-message-open)
;; ;;     (erase-c-messages)
;; ;;     (c-message "s-expression:\n\n%S\n\n\nexpands to:\n\n%S\n" sexpr expanded)
;; ;;
;; ;;     )
;; ;;   )
;; ;;
;; ;;
;; ;;
;; ;; ;; (when (eq (frame-first-window) existing-window)
;; ;; ;;       (delete-window existing-window))
;; ;;
;; ;; ;;     (delete-other-windows (frame-first-window))
;; ;; ;;     (set-window-buffer
;; ;; ;;      (funcall window-location)
;; ;; ;;      (get-buffer-create c-message-buffer))
