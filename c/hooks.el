(add-hook 'after-init-hook 'c$dg$)
(add-hook 'after-revert-hook 'c$dg$)
(add-hook 'after-save-hook 'c$dg$)
(add-hook 'after-change-functions 'c$dg$)
;; (add-hook 'after-insert-file-functions 'c$dg$)
(add-hook 'write-files-hook 'c$dg$)
(add-hook 'after-find-file 'c$dg$)
(add-hook 'after-change-major-mode-hook 'c$dg$)
(add-hook 'after-set-visited-file-name-hook 'c$dg$)
;; (add-hook 'after-save-hook 'git-autocommit-opt-libexec)
;; (add-hook 'after-save-hook 'git-autocommit-emacs-d-c-sources)
(add-hook 'after-change-major-mode-hook
          #'(lambda () (prettify-symbols-mode)))
;; (add-hook 'web-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)
(add-hook 'python-mode-hook
          #'(lambda ()
              (interactive)
              (define-key python-mode-map
                          (kbd "C-c C-f")
                          'blacken-buffer)))
(add-hook 'rust-mode-hook
          #'(lambda ()
              (interactive)
              (define-key rust-mode-map
                          (kbd "C-x C-e i")
                          'rust-insert-members-from-file)
              (define-key rust-mode-map
                          (kbd "C-x C-e C-i")
                          'rust-insert-members-from-file
)
              ))
(add-hook 'typescript-mode-hook
          #'(lambda ()
              (interactive)
              (define-key typescript-mode-map
                          (kbd "C-c C-f")
                          'prettierjs)))
(add-hook 'elisp-mode-hook
          #'(lambda ()
              (interactive)
              (define-key elisp-mode-map (kbd "C-c C-f") 'elfmt)))
(add-hook 'emacs-lisp-mode-hook
          #'(lambda ()
              (interactive)
              (define-key emacs-lisp-mode-map (kbd "C-c C-f") 'elfmt)))

(add-hook 'lua-mode-hook
          #'(lambda ()
              (interactive)
              (define-key lua-mode-map (kbd "C-c C-f") 'stylua)))
(add-hook 'javascript-mode-hook
          #'(lambda ()
              (interactive)
              (define-key typescript-mode-map
                          (kbd "C-c C-f")
                          'prettierjs)))

;; (add-hook 'sh-mode-hook 'flycheck-mode)
;; (add-hook 'shell-script-mode-hook 'flycheck-mode)

(add-hook 'sh-mode-hook 'flymake-shellcheck-load)
(add-hook 'shell-script-mode-hook 'flymake-shellcheck-load)

(add-hook 'shell-script-mode-hook
          #'(lambda ()
              (interactive)

              (setq 'sh-basic-offset 4)
              (local-unset-key (kbd "C-c C-f"))
              (local-set-key (kbd "C-c C-f") #'shfmt)))

(add-hook 'web-mode-hook
          #'(lambda ()
              (interactive)
              (setq web-mode-markup-indent-offset 2 web-mode-css-indent-offset 2 web-mode-code-indent-offset 2 web-mode-enable-current-element-highlight t web-mode-enable-current-column-highlight t )
              (set-face-attribute 'web-mode-doctype-face nil :foreground
                                  (face-foreground font-lock-function-name-face))
              (set-face-attribute 'web-mode-html-attr-name-face nil :foreground
                                  (face-foreground font-lock-variable-name-face))
              (set-face-attribute 'web-mode-html-attr-value-face nil :foreground
                                  (face-foreground font-lock-type-face))))
(add-hook 'pest-mode-hook 'flycheck-mode)

(add-hook  'after-make-frame-functions
           #'(lambda (frame)
               (set-frame-parameter frame 'fullscreen 'maximized)
               (Ox33b4O/$/paint-mode-line nil "new buffer")))
(add-hook 'toml-mode-hook #'(lambda ()
                              (setq fill-column 120)))
;; (add-hook 'toml-mode-hook #'(lambda () ( (local-set-key (kbd '("C-c C-f") 'toml-prettify-buffer)))))
;; (add-hook 'local-write-file-hooks 'git-add-opt-libexec)

(add-hook 'after-set-visited-file-name-hook
          #'(lambda ()
              (interactive)
              (let* ((full-path (expand-file-name (buffer-file-name)))
                     (parent-path (file-name-directory full-path))
                     (filename (file-name-nondirectory full-path))
                     (auto-save-filename
                      (file-name-concat parent-path
                                        (format ".%s.emacs-auto-save" filename))))
                (progn
                  (setq buffer-auto-save-file-name auto-save-filename)))))

;; (defvar shell-script-mode-map
;;   (let ((keymap (make-sparse-keymap)))
;;     (define-key keymap (kbd "C-c C-f") #'shfmt)
;;     keymap)
;;   "Keymap for `shell-script-mode'.")
;; (defalias 'sh-mode-map 'shell-script-mode-map)
