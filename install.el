(defun install-missing-packages()
  (interactive)
  (package-refresh-contents)
  (let* (
         (packages-to-install-if-not-already (list
                                              "ansi"
                                              "autothemer"
                                              "blacken"
                                              "cargo-mode"
                                              "company"
                                              "csharp-mode"
                                              "dockerfile-mode"
                                              "elixir-mode"
                                              "exec-path-from-shell"
                                              "expand-region"
                                              "flycheck-rust"
                                              "go-mode"
                                              "haml-mode"
                                              "highlight-indentation"
                                              "jinja2-mode"
                                              "jsonnet-mode"
                                              "lua-mode"
                                              "markdown-mode"
                                              "nginx-mode"
                                              "pcre2el"
                                              "peg"
                                              "php-mode"
                                              "protobuf-mode"
                                              "python-mode"
                                              "restclient"
                                              "rust-mode"
                                              "solidity-flycheck"
                                              "swift-mode"
                                              "systemd"
                                              "terraform-mode"
                                              "toml"
                                              "toml-mode"
                                              "typescript-mode"
                                              "web-mode"
                                              "yaml-mode"
                                              "yasnippet"
                                              "yasnippet-snippets"))
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
                 (push name (list 'package-name install-failed 'installation-error err))))))
      packages-to-install-if-not-already)
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
