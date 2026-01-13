(setq debug-on-error nil)
(setq $font-name$ "JetBrains Mono-16")
(set-face-attribute 'default nil :font $font-name$ :background "#1c1c1c")

(defun list-dir-path(path)
  (unless (stringp path)
    (user-error (format "`%s' is not a string" path)))
  (unless (file-exists-p path)
    (user-error (format "path `%s' does not exist" path)))
  (let* ((path (expand-file-name path)))
    (or
     (when (file-directory-p path) (directory-files path))
     (when (file-regular-p path) '(path)))))

(defun scan-dir(path &optional callback)
  (or
   (unless (stringp path)
     (user-error (format "`%s' is not a string" path)))
   (unless (file-exists-p path)
     (user-error (format "path `%s' does not exist" path))))
  (let* ((callback
          (or
           (when (functionp callback) callback)
           #'(lambda (path) t))))
    (mapcar callback (list-dir-path path))))


(setq server-socket-dir "~/.emacs.d/socket" server-log t)
(let ((foreground "#A79C83")
      (background "#333"))
  (set-face-attribute 'default nil :foreground foreground :background background :font $font-name$)
  (set-face-attribute 'mode-line nil :background background :foreground foreground)
  (set-face-attribute 'mode-line-inactive nil :background background :foreground foreground))
(progn
  (add-to-list 'load-path "~/.emacs.d/3pty")
  (add-to-list 'load-path "~/.emacs.d/c")
  (load-library "boot")
  (load-library "elfmt"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(expand-region-guess-python-mode nil)
 '(ignored-local-variable-values '((sh-indent-comment . t)))
 '(package-selected-packages
   '(ansi autothemer blacken brightscript-mode cargo-mode company
          company-box csharp-mode dockerfile-mode elixir-mode
          exec-path-from-shell expand-region flycheck-rust
          flymake-shellcheck gdscript-mode go-mode haml-mode
          highlight-indentation jinja2-mode jsonnet-mode kotlin-mode
          lua-mode markdown-mode nginx-mode pcre2el peg php-mode
          protobuf-mode python-mode pythonic restclient rust-mode
          sed-mode solidity-flycheck swift-mode terraform-mode toml
          toml-mode typescript-mode web-mode yaml-mode))
 '(py-electric-colon-greedy-p t)
 '(py-electric-colon-newline-and-indent-p t)
 '(py-indent-honors-inline-comment t)
 '(py-indent-no-completion-p t)
 '(py-ipython-command "~/.shell.d/.venv/bin/ipython3")
 '(py-known-shells '("~/.shell.d/.venv/bin/python3"))
 '(py-known-shells-extended-commands '("~/.shell.d/.venv/bin/python3"))
 '(py-max-specpdl-size 1337)
 '(py-python-command "~/.shell.d/.venv/bin/python")
 '(py-python3-command "~/.shell.d/.venv/bin/python3")
 '(py-pythonpath "~/.shell.d/.venv/lib/python3.12/site-packages")
 '(py-tab-indent nil)
 '(py-tab-indents-region-p t)
 '(py-tab-shifts-region-p t)
 '(python-indent-offset 4 t)
 '(python-interpreter "~/.shell.d/.venv/bin/python3")
 '(python-mode-hook
   '(#[nil
       ((define-key python-mode-map (kbd "C-c C-f")
                    #'g/format/prettify))
       nil nil nil nil]))
 '(ruby-deep-indent-paren '(40 91 93 t 58))
 '(ruby-indent-level 0)
 '(ruby-method-call-indent nil)
 '(ruby-method-params-indent 4))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(delete-minibuffer-contents)
(kill-buffer "*Messages*")
(line-number-mode)
(disable-bars)
(set-frame-parameter nil 'fullscreen 'maximized)
(setq debug-on-error nil)
