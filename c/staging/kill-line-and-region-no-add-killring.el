(defun kill-region-no-kill-ring(beg end)
  (interactive "*r")
  (let ((cur-point (point))
        (point-min-narrow (point-min))
        (point-max-narrow (point-max))
        beg-buffer
        end-buffer)

    (save-restriction
      (widen)
      (setq beg-buffer (point-min))
      (setq end-buffer (point-max)))
    (save-mark-and-excursion
      (delete-region (point) (progn (end-of-line 1) (point)))
      (delete-char 1))))

;; (defun my-delete-line ()
;;   "Delete text from current position to end of line char.
;; This command does not push text to `kill-ring'."
;;   (interactive)
;;   (delete-region (point) (progn (end-of-line 1) (point)))
;;   (delete-char 1)) ;; Deletes the newline character

;; ;; Bind it to a key combination (e.g., C-S-k or C-k if you want to replace default behavior)
;; (global-set-key (kbd "C-S-k") 'my-delete-line)
