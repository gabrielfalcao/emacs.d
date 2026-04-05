;;; (defvar color-rgb-mode nil
;;;   "Mode variable for color-rgb mode"
;;;   (make-variable-buffer-local 'color-rgb-mode))
;;;
;;;
;;; (defun color-rgb-mode (&optional arg)
;;;   "color-rgb minor mode."
;;;   (interactive "P")
;;;   (setq color-rgb-mode
;;;         (if (null arg)
;;;             (not color-rgb-mode)
;;;           (>= (prefix-numeric-value arg) 0)))
;;;
;;;   (if color-rgb-mode
;;;       (color-rgb-minor-mode-enable)
;;;     (color-rgb-minor-mode-disable)))
;;;
;;; (defun color-rgb-minor-mode-enable()
;;;   (add-hook 'after-change-functions #'color-rgb-colorize-buffer nil t))
;;;
;;; (defun color-rgb-minor-mode-disable()
;;;   (remove-hook 'after-change-functions #'color-rgb-colorize-buffer t))
;;;
;;;
;;; (defun color-rgb-colorize-buffer()
;;;
;;;   )
;;;
