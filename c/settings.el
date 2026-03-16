(let* (
      (settings (list
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
                )
      (total-settings (length settings))
      (failed-settings (list))
      (total-failed 0)
      (cursor 0)
      )
  (while (< cursor (- total-settings
                      (length failed-settings)))
    (catch 'failure
    (push
    (setq total-failed (length failed-settings))

    )
  )
