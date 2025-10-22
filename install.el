(defun install-missing-packages()
  (interactive)
  (erase-messages)
  (package-refresh-contents)
  (let* ((installed-packages (mapcar #'(lambda (item)
                                         (format "%s" (car item)))
                              (package--alist)    ))
        (packages-ensure-presence (list
                              "yasnippet-snippets"
                              "yasnippet"
                              "systemd"
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
                              "terraform-mode"
                              "toml"
                              "toml-mode"
                              "typescript-mode"
                              "web-mode"
                              "yaml-mode"
                              ))
        (packages-to-install (seq-filter #'(lambda (name)
                                             (not (seq-contains-p installed-packages name))) packages-ensure-presence))
        )

      (message (format "<install-results>\n%S\n</install-results>" (mapcar #'(lambda (package-name)
            (list package-name (ignore-errors
                                 (if (package-install package-name)
                                     (message (format "Installed %s\n" package-name))
                                   (message (format "failed to install %s\n" package-name))))
            ))
                                   packages-ensure-presence
                                   )))

    )
  )
