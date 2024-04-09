;; Keep emacs Custom-settings in separate file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(defun load-file-if-exists (file-name)
  (let ((file-path (expand-file-name file-name user-emacs-directory)))
    (load-file file-path)
    ))


(load-file-if-exists "typst-mode.el")
(load-file-if-exists "0-basics.el")
(load-file-if-exists "1-package-management.el")
(load-file-if-exists "2-shell.el")
(load-file-if-exists "3-autocomplete.el")
(load-file-if-exists "4-theme.el")
(load-file-if-exists "5-mode-bindings.el")
(load-file-if-exists "6-hooks.el")
(load-file-if-exists "7-programming-tools.el")
;;(load-file "custom.el")
