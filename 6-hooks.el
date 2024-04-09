(setq initial-scratch-message nil)
(setq-default message-log-max 0)
(setq-default warning-log-max 0)

;;(setq initial-buffer-choice "~/projects/personal")


(defun remove-warnings-buffer ()
  (if (get-buffer "*Warnings*")
      (kill-buffer "*Warnings*")))
(add-hook 'after-change-major-mode-hook 'remove-warnings-buffer)


(defun remove-scratch-buffer ()
  (if (get-buffer "*scratch*")
      (kill-buffer "*scratch*")))
(add-hook 'after-change-major-mode-hook 'remove-scratch-buffer)

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(kill-buffer "*Messages*")


(add-hook 'minibuffer-exit-hook
          '(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))

(setq inhibit-startup-buffer-menu t)
