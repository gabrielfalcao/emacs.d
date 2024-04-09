(use-package editorconfig
  :ensure t
  :config
  (editorconfig-mode 1))

(use-package company)
(use-package go-mode)
(use-package coffee-mode)
(use-package jinja2-mode)
(use-package jira-markup-mode)
(use-package js2-mode
  :config
  (setq js2-basic-offset 2)
  (setq js2-strict-trailing-comma-warning nil)
  (setq js2-strict-missing-semi-warning nil))
(use-package tide
               :hook ((web-mode . tide-setup)))
(use-package json-mode)
(use-package toml)
(use-package lua-mode)
(use-package markdown-mode)
(use-package nginx-mode)
(use-package php-mode)
(use-package protobuf-mode)
(use-package python-mode)
(use-package elixir-mode)
(use-package elixir-yasnippets)
(use-package ruby-test-mode)
(use-package sass-mode)
(use-package terraform-mode)
(use-package toml-mode)
(use-package web-mode)
(use-package rust-mode)
(use-package yaml-mode)
(use-package cask)
(use-package elpy)
(use-package cask-package-toolset)
(use-package dockerfile-mode)
(use-package jsonnet-mode)
(custom-set-faces
 '(org-level-1 ((t (:inherit outline-1 :height 1.50 :weight extra-bold))))
 '(org-level-2 ((t (:inherit outline-2 :height 1.30 :weight extra-bold))))
 '(org-level-3 ((t (:inherit outline-3 :height 1.20 :weight extra-bold))))
 '(org-level-4 ((t (:inherit outline-4 :height 1.15 :weight bold))))
 '(org-level-5 ((t (:inherit outline-5 :height 1.10 :weight bold))))
 '(org-level-6 ((t (:inherit outline-6 :height 1.05 :weight semi-bold)))))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

;; formats the buffer before saving
(add-hook 'before-save-hook 'tide-format-before-save)
(add-hook 'typescript-mode-hook #'setup-tide-mode)


(add-to-list 'auto-mode-alist '("/bin/py/[^/.]*" . python-mode))
(add-to-list 'auto-mode-alist '("^---$" . yaml-mode))
(add-to-list 'auto-mode-alist '("/bin/[^/.]*" . shell-script-mode))
(add-to-list 'auto-mode-alist '("/bin/sh/[^/.]*" . shell-script-mode))
(add-to-list 'auto-mode-alist '("/.flkwnlib/" . python-mode))
(add-to-list 'auto-mode-alist '("/bashrc.d/" . shell-script-mode))
(add-to-list 'auto-mode-alist '("Dockerfile.*" . dockefile-mode))
(add-to-list 'auto-mode-alist '("\\.sh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.shell$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.bash$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.bashrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.j2$" . jinja2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.json-*$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.jsonnet$" . jsonnet-mode))
(add-to-list 'auto-mode-alist '("\\.libsonnet$" . jsonnet-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.toml$" . toml-mode))
(add-to-list 'auto-mode-alist '("\\.haya$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.sls$" . yaml-mode)) ; salt stack

;;; Map file extensions to modes
(add-to-list 'auto-mode-alist '("Pipfile" . toml-mode))           ;; pipenv
(add-to-list 'auto-mode-alist '("Pipfile.lock" . toml-mode))      ;; pipenv
(add-to-list 'auto-mode-alist '("Vagrantfile$" . ruby-mode))      ;; Vagrant
(add-to-list 'auto-mode-alist '(".urls" . ruby-mode))      ;; Vagrant
(add-to-list 'auto-mode-alist '("Makefile[.].*" . makefile-mode)) ;; Makefile-alikes
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))            ;; PHP
(add-to-list 'auto-mode-alist '("\\.c?js$" . web-mode))             ;; Javascript and ES6
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))             ;; Rust
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))            ;; Javascript and ES6
(add-to-list 'auto-mode-alist '("\\.swift$" . swift-mode))            ;; Javascript and ES6
(add-to-list 'auto-mode-alist '("\\.tsx?$" . web-mode))     ;; Javascript and ES6
(add-to-list 'auto-mode-alist '("\\.scpt?$" . applescript-mode))     ;; Applescript
(add-to-list 'auto-mode-alist '("\\.typ?$" . typst-mode))     ;; Typst-Mode
(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))     ;; Protobuf (GRPC)
(add-hook 'web-mode-hook 'prettier-web-mode)
(add-hook 'typescript-mode-hook 'prettier-js-mode)


(add-to-list 'auto-mode-alist '("\\.tf$" . terraform-mode))       ;; Terraform

(add-to-list 'auto-mode-alist '("nginx.conf$" . nginx-mode)) ;; nginx
(add-to-list 'auto-mode-alist '("\\.plist$" . xml-mode))     ;; Mac OS X .plist files
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))    ;; erlang
(add-to-list 'auto-mode-alist '("/mutt" . mail-mode))        ;; Files created under a /mutt dir
(add-hook 'html-mode-hook (lambda() (setq sgml-basic-offset 4)))  ;; html mode

;;; remove all sorts of trailing spaces

;;; (require 'pyimpsort)
;;; (eval-after-load 'python
;;;   '(define-key python-mode-map "\C-c\C-u" #'pyimpsort-buffer))

(require 'whitespace)
(setq whitespace-style 'empty)
(setq web-mode-content-types-alist
      '(("json" . ".*[.]json$'")
        ("jsx"  . ".*[.]js[x]?")))
;;; css config
(setq cssm-indent-function #'cssm-c-style-indenter)
(setq cssm-indent-level 4)

                                        ; Set CSS colors with themselves
(require 'jira-markup-mode)
(add-to-list 'auto-mode-alist '("\\.jira$" . jira-markup-mode))

(require 'sass-mode)
(add-to-list 'auto-mode-alist '("\\.sass$" . sass-mode))
(add-to-list 'auto-mode-alist '("\\.scss$" . sass-mode))
(setq sass-indent-offset 2)

;;; less mode
(require 'less-css-mode)
(add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode))
(setq less-compile-at-save nil)

;;; Web mode
(require 'web-mode)
(defun my-web-mode-hook ()
  "Hooks for Web mode."
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2)
  (setq web-mode-enable-current-element-highlight t)
  (setq web-mode-enable-current-column-highlight t)
  (set-face-attribute 'web-mode-doctype-face nil :foreground
                      (face-foreground font-lock-function-name-face))
  (set-face-attribute 'web-mode-html-attr-name-face nil :foreground
                      (face-foreground font-lock-variable-name-face))
  (set-face-attribute 'web-mode-html-attr-value-face nil :foreground
                      (face-foreground font-lock-type-face)))
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))

;;; Markdown mode
(require 'markdown-mode)
(autoload 'markdown-mode "markdown-mode.el"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
(add-hook 'markdown-mode-hook '(lambda() (flyspell-mode)))

;;; Vala mode
(autoload 'vala-mode "vala-mode" "Major mode for editing Vala code." t)
(add-to-list 'auto-mode-alist '("\\.vala$" . vala-mode))
(add-to-list 'auto-mode-alist '("\\.vapi$" . vala-mode))
(add-to-list 'file-coding-system-alist '("\\.vala$" . utf-8))
(add-to-list 'file-coding-system-alist '("\\.vapi$" . utf-8))

;;; CoffeScript mode
(require 'coffee-mode)
(add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
(add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode))
(defun coffee-custom () "coffee-mode-hook"
       (set (make-local-variable 'tab-width) 2))
(add-hook 'coffee-mode-hook '(lambda() (coffee-custom)))

;;; Earl gray mode
;;; (add-to-list 'load-path "~/.emacs.d/elisp/earl-grey-mode")
;;; (require 'earl-mode)
;;; (add-to-list 'auto-mode-alist '("\\.eg$" . earl-mode))

;; ;;; Auto complete
;; (require 'auto-complete)
;; (require 'auto-complete-config)
;; (global-auto-complete-mode t)
;; (setq ac-dwim 2)
;; (ac-config-default)
;; (define-key ac-complete-mode-map "\C-n" 'ac-next)
;; (define-key ac-complete-mode-map "\C-p" 'ac-previous)

;;; Loading YAS personal snippets

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(flymake-error ((t (:underline "tomato"))))
 '(flymake-warning ((t (:underline (:color "firebrick" :style wave))))))
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)
(defalias 'yes-or-no-p 'y-or-n-p)


;;; ensure that this has priority over `auto-mode-alist`
(add-to-list 'interpreter-mode-alist '("python" . python-mode))
(add-to-list 'interpreter-mode-alist '("python2.7" . python-mode))
(add-to-list 'interpreter-mode-alist '("osascript" . apples-mode))
(add-to-list 'interpreter-mode-alist '("bash" . shell-script-mode))
(add-to-list 'interpreter-mode-alist '("markdown" . shell-script-mode))

;;https://www.masteringemacs.org/article/removing-blank-lines-buffer
;;; _     _  _____   _____  _     _ _______
;;; |_____| |     | |     | |____/  |______
;;; |     | |_____| |_____| |    \_ ______|

;;; before safe
;;; ~~~~~~~~~~~
(add-hook 'before-save-hook 'delete-trailing-whitespace)

;;; python-mode

;; (require 'flycheck-virtualenv)
;;(require 'blacken)
;; (require 'pipenv)
;;(require 'py-isort)

;; (add-hook 'python-mode-hook 'pipenv-mode)
;; (defun python-find-module (name)
;;   "Open the file that declares the received python module"
;;   (interactive "MPython module to open: ")
;;   (find-file
;;    (let ((command (concat "python -c 'import sys, " name " as m; sys.stdout.write(m.__file__)'")))
;;      (replace-regexp-in-string ".py.$" ".py" (shell-command-to-string command)))))



;; (defun pipenv-switch-flake8-path ()
;;   "When a Pipenv project is found, activate the virtual environment, \
;; and open a Pipenv shell and a Python interpreter."
;;   ;; '(setq flycheck-python-pyflakes-executable )
;;   ;; Always clean up, in case we were in a Python project previously.
;;   (pipenv-deactivate)
;;   ;; Only activate if we can verify this is a Pipenv project.
;;   (when (pipenv-project?)
;;     (pipenv-activate)
;;     (pipenv-shell)
;;     ;; Tell blacken that the executable changed
;;     '(setq blacken-executable (concat (file-name-as-directory python-shell-virtualenv-root) "/bin/blacken"))
;;     ;; Tell flycheck that the flake8 executable changed
;;     (flycheck-set-checker-executable (quote python-flake8)
;;                                      (concat (file-name-as-directory python-shell-virtualenv-root) "/bin/flake8"))
;;     (message (concat (file-name-as-directory python-shell-virtualenv-root) "/bin/flake8"))

;;     ))

;; (setq pipenv-projectile-after-switch-function #'pipenv-switch-flake8-path)
;; (setq-default pipenv-projectile-after-switch-function #'pipenv-switch-flake8-path)


;; (defun set-flychecker-executables ()
;;   "Configure virtualenv for flake8 and lint."

;;     (setq blacken-executable (concat (file-name-as-directory python-shell-virtualenv-root) "/bin/blacken"))
;;     (flycheck-set-checker-executable (quote python-flake8)
;;                                      ;; (concat (file-name-as-directory python-shell-virtualenv-root) "/bin/flake8")))
;;                                      "/usr/local/bin/flake8"))


;; (add-hook 'flycheck-before-syntax-check-hook
;;           #'set-flychecker-executables 'local)


;; (add-hook 'python-mode-hook 'yas-minor-mode-on)
;; (add-hook 'python-mode-hook #'yas-minor-mode)
;; (add-hook 'python-mode-hook 'blacken-mode)
;; (add-hook 'before-save-hook 'py-isort-before-save)

(flycheck-define-checker sh-shellcheck
  "A shell script syntax and style checker using Shellcheck.

See URL `https://github.com/koalaman/shellcheck/'."
  :command ("shellcheck" "-x" "-f" "checkstyle"
            "-s" (eval (symbol-name sh-shell))
            source)
  :modes sh-mode
  :error-parser flycheck-parse-checkstyle)

(add-hook 'sh-mode-hook 'flycheck-mode)
(add-hook 'shell-script-mode-hook 'flycheck-mode)


;;; (package-refresh-contents)

(defun uniquify-all-lines-region (start end)
  "Find duplicate lines in region START to END keeping first occurrence."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
          (progn
            (goto-char start)
            (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
        (replace-match "\\1\n\\2")))))

(defun uniquify-all-lines-buffer ()
  "Delete duplicate lines in buffer and keep first occurrence."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))


(use-package golden-ratio
  :ensure t
  :config
  (golden-ratio-mode 0))


(use-package expand-region
  :ensure t
  :config
  (global-set-key (kbd "C-=") 'er/expand-region)
  )

;;; (use-package golden-ratio
;;;   :ensure t
;;;   :config
;;;   (golden-ratio-mode 1))

(use-package restclient
  :ensure t)

;;; ; buffer registry mgmt
;;; (use-package perspective
;;;   :ensure t
;;;   :config
;;;   (persp-mode)) ;; TODO came up with some better keybindings


(use-package rjsx-mode
  :ensure t
  :config
  ;; (add-to-list 'auto-mode-alist '("\\.js$" . rjsx-mode))
  ;; (define-key js2-mode-map (kbd "M-.") nil)
  (setq js2-mode-show-parse-errors nil)
  (setq js2-mode-show-strict-warnings nil)
  (add-hook 'js2
            (add-hook 'xref-backend-functions #'xref-js2-xref-backend nil t)
            (superword-mode 1)
            ))

;; (defun sort-lines-nocase ()
;;   (interactive)
;;   (let ((sort-fold-case t))
;;     (call-interactively 'sort-lines)))


;; (defun isortlines
;;     (interactive)
;;   (let ((sort-fold-case t))
;;     (call-interactively 'sort-lines)))

;; (setq gofmt-command "goimports")
;; ;;; (require 'go-mode-autoloads)
;; (add-hook 'before-save-hook 'gofmt-before-save)

;; (message "reminder: C-c t brings a file-tree")
;; (add-hook 'after-init-hook 'global-company-mode)

;; (load-file "~/.emacs.d/flow-for-emacs/flow.el")

;; ;(add-hook 'after-init-hook #'global-flycheck-mode)
;; ;; http://www.howardism.org/Technical/Emacs/capturing-content.html


;; ;; I have all the packages installed in subdirectories of ~/elisp
;; (dolist (lib '("font-utils" "unicode-fonts" "ucs-utils" "list-utils"))
;;   (add-to-list 'load-path
;; 	       (expand-file-name lib (concat (getenv "HOME") "/elisp"))))
;; ;; keep only the Emoticons block, change only the default fontset
;; (require 'unicode-fonts)
;; (setq unicode-fonts-block-font-mapping
;;       '(("Emoticons"
;; 	 ("Apple Color Emoji" "Symbola" "Quivira")))
;;       unicode-fonts-fontset-names '("fontset-default"))




;; (setq python-shell-interpreter "/usr/local/bin/python3")
;;(cask-initialize)
