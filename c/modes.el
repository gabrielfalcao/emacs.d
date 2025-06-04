(benchmark-progn
  (require 'package)
  (require 'flycheck)
  (line-number-mode t)
  (setq package-archives nil)
  (setq global-flycheck-mode t)
  (with-eval-after-load 'flycheck
    (require 'flycheck-pest)
    (flycheck-pest-setup))

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
  (require 'make-mode)
  (require 'ibuffer)
  (require 'calendar)
  (require 'rect)
  (require 'compile)
  (require 'ert)

  (setq python-indent-offset 6)
  (setq company-idle-delay 0)
  (setq company-show-quick-access t)
  (ignore-errors (server-reboot))

  (setq large-file-warning-threshold 9000000 make-backup-files nil)
  (setq rust-format-on-save nil rust-rustfmt-bin "~/.cargo/bin/rustfmt" rust-rustfmt-switches '("--edition" "2021" "--color" "always" "--unstable-features"))

  (setq replace-regexp-lax-whitespace t case-fold-search nil)


  (setq inhibit-local-variables-regexps (append '("\\[.]sh" "\\[.]json\w?" "\\[.][tj]sx?") inhibit-local-variables-regexps ))
  ;;(setq line-number-display-limit 10000)
  ;; ;; ;; *;; ;; OzsgOzsgOzsqOzsgOzsgKGRlZnVuIHNldHVwLXRpZGUtbW9kZSAoKSAoaW50ZXJhY3RpdmUpIDs7ICh0aWRlLXNldHVwKSAoZmx5Y2hlY2stbW9kZSArMSkgKHNldHEgZmx5Y2hlY2stY2hlY2stc3ludGF4LWF1dG9tYXRpY2FsbHkgJyhzYXZlIG1vZGUtZW5hYmxlZCkpIChlbGRvYy1tb2RlICsxKSA7OyAodGlkZS1obC1pZGVudGlmaWVyLW1vZGUgKzEpIChjb21wYW55LW1vZGUgKzEpKTs7IDs7IDs7Kjs7IDs7IChhZGQtaG9vayAnYmVmb3JlLXNhdmUtaG9vayAndGlkZS1mb3JtYXQtYmVmb3JlLXNhdmUpIDs7IDs7IDs7Kjs7IDs7IChhZGQtaG9vayAndHlwZXNjcmlwdC1tb2RlLWhvb2sgIydzZXR1cC10aWRlLW1vZGUpIDs7IDs7IDs7Kjs7IDs7IChhZGQtaG9vayAnd2ViLW1vZGUtaG9vayAgKGxhbWJkYSAoKSAgKHdoZW4gKHN0cmluZy1lcXVhbCAianN4IiAoZmlsZS1uYW1lLWV4dGVuc2lvbiBidWZmZXItZmlsZS1uYW1lKSkgIChzZXR1cC10aWRlLW1vZGUpKSkpIChhZGQtaG9vayAnd2ViLW1vZGUtaG9vayAgKGxhbWJkYSAoKSAgKHdoZW4gKHN0cmluZy1lcXVhbCAidHN4IiAoZmlsZS1uYW1lLWV4dGVuc2lvbiBidWZmZXItZmlsZS1uYW1lKSkgIChzZXR1cC10aWRlLW1vZGUpKSkp
  (setq vc-handled-backends nil)
  (eval-after-load "vc" '(remove-hook 'find-file-hook 'vc-find-file-hook))


  (setq kill-ring-max #xffffff
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
  (add-to-list 'auto-mode-alist '("pyproject.toml" . toml-mode))
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
  (add-to-list 'auto-mode-alist '("\\.noon$" . rust-mode))
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
  (add-to-list 'auto-mode-alist '("\\.lua$" . lua-mode))
  (add-to-list 'auto-mode-alist '("\\.frm$" . visual-basic-mode))
  (add-to-list 'auto-mode-alist '("\\.vbp$" . visual-basic-mode))
  (add-to-list 'auto-mode-alist '("\\.pest$" . pest-mode))

  (setq whitespace-style 'empty)
  (setq web-mode-content-types-alist
        '(("json" . ".*[.]json$'")
          ("jsx"  . ".*[.]jsx")))


  (setq sh-mode-map (make-sparse-keymap))



  (add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
  (add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
  ;; (flycheck-define-checker sh-shellcheck :command ("shellcheck" "-x" "-f" "checkstyle" "-s" (eval (symbol-name sh-shell)) source) :modes shell-script-mode :error-parser flycheck-parse-checkstyle)

  )



(add-to-list 'auto-mode-alist '("\\.c?js\\.tera$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erl\\.tera$" . erlang-mode))
(add-to-list 'auto-mode-alist '("\\.j2\\.tera$" . jinja2-mode))
(add-to-list 'auto-mode-alist '("\\.json\\.tera$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.json-*\\.tera$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsonnet\\.tera$" . jsonnet-mode))
(add-to-list 'auto-mode-alist '("\\.m?jsx?\\.tera$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.libsonnet\\.tera$" . jsonnet-mode))
(add-to-list 'auto-mode-alist '("\\.php\\.tera$" . php-mode))
(add-to-list 'auto-mode-alist '("\\.plist\\.tera$" . xml-mode))
(add-to-list 'auto-mode-alist '("\\.proto\\.tera$" . protobuf-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\.tera$" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.noon\\.tera$" . rust-mode))
(add-to-list 'auto-mode-alist '("\\.sh\\.tera$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.shell\\.tera$" . shell-script-mode))
(add-to-list 'auto-mode-alist '("\\.swift\\.tera$" . swift-mode))
(add-to-list 'auto-mode-alist '("\\.tf\\.tera$" . terraform-mode))
(add-to-list 'auto-mode-alist '("\\.toml\\.tera$" . toml-mode))
(add-to-list 'auto-mode-alist '("\\.ts\\.tera$" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.tsx\\.tera$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.typ?\\.tera$" . typst-mode))
(add-to-list 'auto-mode-alist '("\\.ya?ml\\.tera$" . yaml-mode))
