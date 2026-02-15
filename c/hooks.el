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



(defun buffer-first-line ()
  (save-mark-and-excursion
    (widen)
    (beginning-of-buffer)
    (end-of-line)
    (buffer-substring-no-properties (point-min) (point))))

(defun buffer-shebang-firstline ()
  (save-mark-and-excursion
    (widen)
    (beginning-of-buffer)

    (re-search-forward "^([#][!]([a-zA-Z0-9_,./-]))" [',', '-', '.', '/', '_']
    (end-of-line)
    (buffer-substring-no-properties (point-min) (point))))

(defun shebang-file-executable()
  (when-let ((filename (buffer-file-name)))
    (let ((first-line (save-mark-and-excursion
                        (widen)
                        (beginning-of-buffer)
                        (end-of-line)
                        (buffer-substring-no-properties (point-min) (point)))))
      (string-

       )))
  )

(defun clipboard-get-string()
  (gui-get-selection 'CLIPBOARD 'STRING))

(defun clipboard-get-lines()
  (string-split (clipboard-get-string) "\n"))

(defun prefix-lines (prefix lines &key :omit-nulls omit-nulls :trim trim :line-separator line-separator)
  (unless (or (stringp line-separator)
              (null line-separator))
    (signal 'type-error
            (format  "wrong type argument `line-separator' is a `%s', not a string: %s"
                     (type-of line-separator)
                     line-separator)))

  (unless (and line-separator (length> line-separator 0))
    (setq line-separator "\n"))

  (unless (stringp prefix)
    (signal 'type-error
            (format  "wrong type argument `prefix' is a `%s', not a string: %s"
                     (type-of prefix)
                     prefix)))
  (when (stringp lines)
    (setq lines (string-split lines "\n" omit-nulls trim)))

  (unless (list-of-strings-p lines)
    (signal 'type-error
            (format  "wrong type argument `lines' is not a list of strings: %s"
                     (type-of lines)
                     lines)))
  (string-join (mapcar (lambda (line) (format "%s%s" prefix line)) lines) "\n")
  )

;;   (gui-get-selection 'CLIPBOARD 'STRING))
;; (insert (string-join (mapcar (lambda (line) (format ";; %s" line )) (string-split (gui-get-selection) "\n" t t ) "\n")))


(require 'company-box)
(add-hook 'company-mode-hook 'company-box-mode)

(defun python-mode-hook-bind-custom-keys()
  (interactive)
  (define-key python-mode-map (kbd "C-c C-f") #'g/format/prettify)
  (define-key python-mode-map (kbd "TAB") #'indent-for-tab-command)
  (define-key python-mode-map
              (kbd "C-x C-e i")
              'python-insert-members-from-file)
  (define-key python-mode-map
              (kbd "C-x C-e C-i")
              'python-insert-members-from-file)

  )
(add-hook 'python-mode-hook
          #'python-mode-hook-bind-custom-keys)

(add-hook 'py-shell-mode
          #'(lambda ()
              (interactive)
              (define-key py-shell-mode-map (kbd "C-c C-f") #'g/format/prettify)
              ;; (define-key py-shell-mode-map (kbd "Tab") #'indent-for-tab-command)
              ))
(add-hook 'rust-mode-hook
          #'(lambda ()
              (interactive)
              (define-key rust-mode-map
                          (kbd "C-x C-e i")
                          'rust-insert-members-from-file)
              (define-key rust-mode-map
                          (kbd "C-x C-e C-i")
                          'rust-insert-members-from-file)))
(add-hook 'typescript-mode-hook
          #'(lambda ()
              (interactive)
              (define-key typescript-mode-map
                          (kbd "C-c C-f")
                          #'g/format/prettify)))
(add-hook 'javascript-mode-hook
          #'(lambda ()
              (interactive)
              (define-key javascript-mode-map
                          (kbd "C-c C-f")
                          #'g/format/prettify)))
(add-hook 'web-mode-hook
          #'(lambda ()
              (interactive)
              ;;(keymap-set web-mode-map KEY DEFINITION)

              (define-key web-mode-map (kbd "C-c C-f") #'g/format/prettify)))

(add-hook 'elisp-mode-hook
          #'(lambda ()
              (interactive)
              (define-key elisp-mode-map (kbd "C-c C-f") #'g/format/prettify)))
(add-hook 'emacs-lisp-mode-hook
          #'(lambda ()
              (interactive)
              (define-key emacs-lisp-mode-map
                          (kbd "C-c C-f")
                          #'g/format/prettify)))

(add-hook 'lua-mode-hook
          #'(lambda ()
              (interactive)
              (define-key lua-mode-map (kbd "C-c C-f") #'g/format/prettify)))

;; (add-hook 'sh-mode-hook 'flycheck-mode)
;; (add-hook 'shell-script-mode-hook 'flycheck-mode)


(defun remap-hook-local-map-to-g-format-prettify ()
  (interactive "*")
  (cond ((runtime-is-darwin)
         (progn
           (keymap-unset (current-local-map) "C-c C-f")
           (keymap-set (current-local-map) "C-c C-f" #'g/format/prettify)))
        (or (not (functionp (symbol-value 'keymap-unset)))
            (not (functionp (symbol-value 'keymap-set))))
        (c-message "shfmt not available in C-c C-f")
        )
  )


(add-hook 'sh-mode-hook #'flymake-shellcheck-load)
(add-hook 'shell-script-mode-hook #'flymake-shellcheck-load)


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
(add-hook 'toml-mode-hook #'(lambda () (setq fill-column 120)))
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

(add-hook 'web-mode-hook #'remap-hook-local-map-to-g-format-prettify)
(add-hook 'sh-mode-hook #'remap-hook-local-map-to-g-format-prettify)
(add-hook 'shell-script-mode-hook #'remap-hook-local-map-to-g-format-prettify)
