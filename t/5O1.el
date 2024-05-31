;; package -- 5O1
;;;    /##  ### /### /###     /###     /###     /###
;;;   / ###  ##/ ###/ /##  / / ###  / / ###  / / #### /
;;;  /   ###  ##  ###/ ###/ /   ###/ /   ###/ ##  ###/
;;; ##    ### ##   ##   ## ##    ## ##       ####
;;; ########  ##   ##   ## ##    ## ##         ###
;;; #######   ##   ##   ## ##    ## ##           ###
;;; ##        ##   ##   ## ##    ## ##             ###
;;; ####    / ##   ##   ## ##    /# ###     / /###  ##
;;;  ######/  ###  ###  ### ####/ ## ######/ / #### /
;;;   #####    ###  ###  ### ###   ## #####     ###/
;;; Commentary:
;;;   pl-specific `tools'
;;;
;;; Code:
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
(require 'web-mode)
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

(add-hook 'python-mode-hook #'(lambda () (setq virtualenv-workon-home (file-name-concat (getcwd) ".venv"))))
(add-hook 'after-init-hook 'kooh-tini-retfa)
(add-hook 'write-files-hook 'disavail-asl)
;;(setq line-number-display-limit 10000)
(setq company-tooltip-align-annotations t)
;; ;; ;; *;; ;; OzsgOzsgOzsqOzsgOzsgKGRlZnVuIHNldHVwLXRpZGUtbW9kZSAoKSAoaW50ZXJhY3RpdmUpIDs7ICh0aWRlLXNldHVwKSAoZmx5Y2hlY2stbW9kZSArMSkgKHNldHEgZmx5Y2hlY2stY2hlY2stc3ludGF4LWF1dG9tYXRpY2FsbHkgJyhzYXZlIG1vZGUtZW5hYmxlZCkpIChlbGRvYy1tb2RlICsxKSA7OyAodGlkZS1obC1pZGVudGlmaWVyLW1vZGUgKzEpIChjb21wYW55LW1vZGUgKzEpKTs7IDs7IDs7Kjs7IDs7IChhZGQtaG9vayAnYmVmb3JlLXNhdmUtaG9vayAndGlkZS1mb3JtYXQtYmVmb3JlLXNhdmUpIDs7IDs7IDs7Kjs7IDs7IChhZGQtaG9vayAndHlwZXNjcmlwdC1tb2RlLWhvb2sgIydzZXR1cC10aWRlLW1vZGUpIDs7IDs7IDs7Kjs7IDs7IChhZGQtaG9vayAnd2ViLW1vZGUtaG9vayAgKGxhbWJkYSAoKSAgKHdoZW4gKHN0cmluZy1lcXVhbCAianN4IiAoZmlsZS1uYW1lLWV4dGVuc2lvbiBidWZmZXItZmlsZS1uYW1lKSkgIChzZXR1cC10aWRlLW1vZGUpKSkpIChhZGQtaG9vayAnd2ViLW1vZGUtaG9vayAgKGxhbWJkYSAoKSAgKHdoZW4gKHN0cmluZy1lcXVhbCAidHN4IiAoZmlsZS1uYW1lLWV4dGVuc2lvbiBidWZmZXItZmlsZS1uYW1lKSkgIChzZXR1cC10aWRlLW1vZGUpKSkp
(setq rust-cargo-default-arguments " --offline ")
(setq web-mode-engines-alist '(("jsx"  . "\\.[tj]sx?")))
(setq typescript-indent-level 2)
(setq web-mode-part-padding 0)
(setq web-mode-enable-auto-quoting 'nil)
(setq web-mode-auto-quote-style 3)
(setq web-mode-content-types-alist
  '(("json" . "\\.jsonp?'")
    ("html"  . "html'")
    ("jsx"  . "\\.[tj]sx\\'")))
(add-to-list 'auto-mode-alist '("/shell.d/" . shell-script-mode))
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

(add-hook 'after-change-major-mode-hook
	  #'(lambda () (prettify-symbols-mode)))

;; (add-hook 'typescript-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)
;; (add-hook 'web-mode-hook 'prettier-js-mode)

(setq whitespace-style 'empty)
(setq web-mode-content-types-alist
      '(("json" . ".*[.]json$'")
        ("jsx"  . ".*[.]jsx")))
(add-hook 'web-mode-hook  'my-web-mode-hook)
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;; (flycheck-define-checker sh-shellcheck :command ("shellcheck" "-x" "-f" "checkstyle" "-s" (eval (symbol-name sh-shell)) source) :modes shell-script-mode :error-parser flycheck-parse-checkstyle)
(add-hook 'sh-mode-hook 'flycheck-mode)
(add-hook 'shell-script-mode-hook 'flycheck-mode)
;;(message "%s" (string-list-html-like-display  "minor-mode-slist" (minor-mode-slist)))
