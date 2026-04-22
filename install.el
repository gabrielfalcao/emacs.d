(require 'package)
(package-initialize)

(setq package-archives
  '(
    ("gnu" . "https://elpa.gnu.org/packages/")
    ("nongnu" . "https://elpa.nongnu.org/nongnu/")
    ("melpa" . "https://melpa.org/packages/")
    ("melpa-stable" . "https://stable.melpa.org/packages/")))

(defun install-missing-packages()
  (interactive)
  (package-refresh-contents)
  (let* (
         (packages-to-install-if-not-already (list
                                              "ansi"
                                              "autothemer"
                                              "blacken"
                                              "brightscript-mode"
                                              "cargo-mode"
                                              "company"
                                              "company-box"
                                              "csharp-mode"
                                              "dash"
                                              "dockerfile-mode"
                                              "elixir-mode"
                                              ;; epl
                                              "exec-path-from-shell"
                                              "expand-region"
                                              ;; f
                                              "flycheck"
                                              "flycheck-rust"
                                              "flymake-shellcheck"
                                              "frame-local"
                                              "fringe-helper"
                                              "gdscript-mode"
                                              "go-mode"
                                              "haml-mode"
                                              "hcl-mode"
                                              "highlight-indentation"
                                              ;; ht
                                              "jinja2-mode"
                                              "jsonnet-mode"
                                              "kotlin-mode"
                                              "line-reminder"
                                              "lua-mode"
                                              "markdown-mode"
                                              "nginx-mode"
                                              ;; ov
                                              "pcre2el"
                                              ;; peg
                                              "php-mode"
                                              "pkg-info"
                                              "protobuf-mode"
                                              "python-mode"
                                              "pythonic"
                                              "restclient"
                                              "rust-mode"
                                              ;; s
                                              "sed-mode"
                                              "solidity-flycheck"
                                              "solidity-mode"
                                              "swift-mode"
                                              "terraform-mode"
                                              "toml"
                                              "toml-mode"
                                              "typescript-mode"
                                              "web-mode"
                                              "yaml-mode"))
         (already-installed (list))
         (install-succeeded (list))
         (install-failed (list)))
    (mapc (lambda (name)
           (if (package-installed-p name)
             (push name already-installed)
             (condition-case err
               (progn
                 (package-install name)
                 (push name install-succeeded))
               (error
                 (put name 'installation-error err)
                 (push name install-failed)))))
      (mapcar #'intern packages-to-install-if-not-already))
    (message "<package-installation-result>\n\n%s\n\n<package-installation-result>"
      (string-join (list
                    (format "<failed>\n%s\n</failed>\n" (string-join (mapcar (lambda (props)
                                                                              (let* (
                                                                                     (package-name (plist-get 'package-name props))
                                                                                     (error-object (plist-get 'installation-error props)))
                                                                                (format "    %S: %s" package-name (error-message-string error-object))))
                                                                      install-failed)
                                                         "\n"))
                    (format "<succeeded>\n%s\n</succeeded>\n" (string-join install-succeeded "\n"))
                    (format "<already-installed-previously>\n%s\n</already-installed-previously>\n" (string-join install-succeeded "\n")))
        "\n"))))
