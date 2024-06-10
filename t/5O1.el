;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;                                                     ;;;;;;
;;;;;; OO^^^^^^^^^G                                        ;;;;;;
;;;;;; OO  OOOOOOOG                                        ;;;;;;
;;;;;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-  ;;;;;;
;;;;;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-  ;;;;;;
;;;;;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg  ;;;;;;
;;;;;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg  ;;;;;;
;;;;;; OOOOOOOOOOOG                                        ;;;;;;
;;;;;;                                                     ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(benchmark-progn
(require 'package)
(require 'flycheck)
(setq package-archives nil)
(setq global-flycheck-mode t)

(require 'web-mode)
(require 'company)
(require 'go-mode)
(require 'jinja2-mode)
(require 'toml)
(require 'protobuf-mode)
(require 'python-mode)
(require 'elixir-mode)
(require 'terraform-mode)
(require 'toml-mode)
(require 'rust-mode)
(require 'yaml-mode)
(require 'dockerfile-mode)
(require 'jsonnet-mode)
(require 'typescript-mode)
(require 'whitespace)
(require 'blacken)
(require 'linum)
(require 'make-mode)
(require 'ibuffer)
(require 'calendar)
(require 'rect)
(require 'compile)
(require 'ert)

(setq python-indent-offset 6)
(setq company-idle-delay 0)
(setq company-show-quick-access t)
(ignore-errors
  (server-mode 9))

(setq large-file-warning-threshold 9000000 make-backup-files nil)
(setq rust-format-on-save t rust-rustfmt-bin "~/.cargo/bin/rustfmt" rust-rustfmt-switches '("--edition" "2021" "--color" "always" "--unstable-features" "--check"))

(add-hook 'after-init-hook 'cgdᎦ)
;; (add-hook 'after-revert-hook 'cgdᎦ)
;; (add-hook 'after-save-hook 'cgdᎦ)
;; (add-hook 'after-change-functions 'cgdᎦ)
;; (add-hook 'after-insert-file-functions 'cgdᎦ)
(add-hook 'write-files-hook 'cgdᎦ)
(add-hook 'after-find-file 'cgdᎦ)
(add-hook 'after-change-major-mode-hook 'cgdᎦ)
(add-hook 'after-set-visited-file-name-hook 'cgdᎦ)
(setq inhibit-local-variables-regexps (append '("\\[.]sh" "\\[.]json\w?" "\\[.][tj]sx?") inhibit-local-variables-regexps ))
;;(setq line-number-display-limit 10000)
;; ;; ;; *;; ;; OzsgOzsgOzsqOzsgOzsgKGRlZnVuIHNldHVwLXRpZGUtbW9kZSAoKSAoaW50ZXJhY3RpdmUpIDs7ICh0aWRlLXNldHVwKSAoZmx5Y2hlY2stbW9kZSArMSkgKHNldHEgZmx5Y2hlY2stY2hlY2stc3ludGF4LWF1dG9tYXRpY2FsbHkgJyhzYXZlIG1vZGUtZW5hYmxlZCkpIChlbGRvYy1tb2RlICsxKSA7OyAodGlkZS1obC1pZGVudGlmaWVyLW1vZGUgKzEpIChjb21wYW55LW1vZGUgKzEpKTs7IDs7IDs7Kjs7IDs7IChhZGQtaG9vayAnYmVmb3JlLXNhdmUtaG9vayAndGlkZS1mb3JtYXQtYmVmb3JlLXNhdmUpIDs7IDs7IDs7Kjs7IDs7IChhZGQtaG9vayAndHlwZXNjcmlwdC1tb2RlLWhvb2sgIydzZXR1cC10aWRlLW1vZGUpIDs7IDs7IDs7Kjs7IDs7IChhZGQtaG9vayAnd2ViLW1vZGUtaG9vayAgKGxhbWJkYSAoKSAgKHdoZW4gKHN0cmluZy1lcXVhbCAianN4IiAoZmlsZS1uYW1lLWV4dGVuc2lvbiBidWZmZXItZmlsZS1uYW1lKSkgIChzZXR1cC10aWRlLW1vZGUpKSkpIChhZGQtaG9vayAnd2ViLW1vZGUtaG9vayAgKGxhbWJkYSAoKSAgKHdoZW4gKHN0cmluZy1lcXVhbCAidHN4IiAoZmlsZS1uYW1lLWV4dGVuc2lvbiBidWZmZXItZmlsZS1uYW1lKSkgIChzZXR1cC10aWRlLW1vZGUpKSkp
(setq vc-handled-backends nil)
(eval-after-load "vc" '(remove-hook 'find-file-hook 'vc-find-file-hook))


(setq kill-ring-max (logxor #x10d3 #o2176)
      company-tooltip-align-annotations t
      rust-cargo-default-arguments " --offline "
      web-mode-engines-alist '(("jsx"  . "\\.[tj]sx?"))
      typescript-indent-level 2
      web-mode-part-padding 0
      web-mode-enable-auto-quoting 'nil
      web-mode-auto-quote-style 3
      web-mode-content-types-alist
      '(("json" . "\\.jsonp?'")
        ("html"  . "html'")
        ("jsx"  . "\\.[tj]sx\\'"))
      )
(add-to-list 'auto-mode-alist '("/shell.d/" . shell-script-mode))
(add-to-list 'auto-mode-alist '("/opt[\/]libexec/" . shell-script-mode))
(add-to-list 'auto-mode-alist '("/bin/[^/.]*" . shell-script-mode))
(add-to-list 'auto-mode-alist '("/bin/py/[^/.]*" . python-mode))
(add-to-list 'auto-mode-alist '("/bin/sh/[^/.]*" . shell-script-mode))
(add-to-list 'auto-mode-alist '("Dockerfile.*" . dockefile-mode))
(add-to-list 'auto-mode-alist '("Makefile[.].*" . makefile-mode))
(add-to-list 'auto-mode-alist '("Pipfile" . toml-mode))
(add-to-list 'auto-mode-alist '("Pipfile.lock" . toml-mode))
(add-to-list 'auto-mode-alist '("\\.babelrc" . web-mode))
(add-to-list 'auto-mode-alist '("\\.bash$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.bashrc$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.c?js$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erl$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.j2$" . jinja2-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json-*$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsonnet$" . jsonnet-mode))
(add-to-list 'auto-mode-alist '("\\.m?jsx?$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.libsonnet$" . jsonnet-mode))
(add-to-list 'auto-mode-alist '("\\.php$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.plist$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.proto$" . protobuf-mode))
(add-to-list 'auto-mode-alist '("\\.rs$" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.sh$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.shell$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.swift$" . swift-mode))
(add-to-list 'auto-mode-alist '("\\.tf$" . terraform-mode))
(add-to-list 'auto-mode-alist '("\\.toml$" . toml-mode))
(add-to-list 'auto-mode-alist '("\\.ts$" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.typ?$" . typst-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("^---$" . yaml-mode))
(add-to-list 'auto-mode-alist '("nginx.conf$" . nginx-mode))
(add-hook 'after-change-major-mode-hook #'(lambda () (prettify-symbols-mode)))

;; (add-hook 'typescript-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)

(setq whitespace-style 'empty)
(setq web-mode-content-types-alist
      '(("json" . ".*[.]json$'")
        ("jsx"  . ".*[.]jsx")))


(setq sh-mode-map (make-sparse-keymap))
(add-hook 'emacs-lisp-mode-hook 'elisp-format-buffer)
(add-hook 'shell-script-mode-hook
          #'(lambda () (interactive)
              (setq sh-mode-map (make-sparse-keymap))
              (setq 'sh-basic-offset 6)
              ))


(add-hook 'web-mode-hook
          #'(lambda () (interactive)
           (setq web-mode-markup-indent-offset 2
                 web-mode-css-indent-offset 2
                 web-mode-code-indent-offset 2
                 web-mode-enable-current-element-highlight t
                 web-mode-enable-current-column-highlight t
                 )
           (set-face-attribute 'web-mode-doctype-face nil
                               :foreground (face-foreground font-lock-function-name-face))
           (set-face-attribute 'web-mode-html-attr-name-face nil
                               :foreground (face-foreground font-lock-variable-name-face))
           (set-face-attribute 'web-mode-html-attr-value-face nil
                               :foreground (face-foreground font-lock-type-face))
           ))

(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;; (flycheck-define-checker sh-shellcheck :command ("shellcheck" "-x" "-f" "checkstyle" "-s" (eval (symbol-name sh-shell)) source) :modes shell-script-mode :error-parser flycheck-parse-checkstyle)
(add-hook 'sh-mode-hook 'flycheck-mode)
(add-hook 'shell-script-mode-hook 'flycheck-mode)
;;(message "%s" (string-list-html-like-display  "minor-mode-slist" (minor-mode-slist)))
(add-hook 'python-mode-hook #'(lambda () (interactive) (setq virtualenv-workon-home (file-name-concat (getcwd) ".venv"))))
)
