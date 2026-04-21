(defun ack-text-region-in-path (path)
  "."
  (interactive)
  (unless mark-active (user-error "mark is not active"))

  (unless (region-active-p) (user-error "region not active"))

  (save-mark-excursion-and-match-data
    (let* ((region (region-bounds))
           (beg (car  region))
           (end (cdr region))
           ;; (input  (buffer-substring-no-properties beg end))
           ;; (tmp-buffer-name (format "*ack:%s*" (downcase (replace-regexp-in-string "[^a-zA-Z0-9-]+" "-" input))))
           ;; (tmp-buffer (get-buffer-create tmp-buffer-name))
           ;; (exit-code (call-process "ack" nil tmp-buffer nil input path))
           )
      (c-message-ensure-visible)
      (erase-c-messages)
      (c-message "region: %S" region)
      (c-message "beg: %S" beg)
      (c-message "end: %S" end)
      ;; (pop-to-buffer tmp-buffer)
      ))
  )

;; (progn
;;   (unless (and  mark-active (region-active-p))
;;     (beginning-of-buffer)
;;     (set-mark (point))
;;     (forward-sexp))
;;
;;   (ack-text-region-in-path (expand-file-name ".")))
