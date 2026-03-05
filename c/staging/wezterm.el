;; ;;WEZTERM_CONFIG_DIR="/Users/gabrielfalcao"
;; ;;WEZTERM_CONFIG_FILE="/Users/gabrielfalcao/.wezterm.lua"
;; ;;WEZTERM_EXECUTABLE="/Applications/WezTerm.app/Contents/MacOS/wezterm-gui"
;; ;;WEZTERM_EXECUTABLE_DIR="/Applications/WezTerm.app/Contents/MacOS"
;; ;;WEZTERM_PANE="190"
;; ;;WEZTERM_UNIX_SOCKET="/Users/gabrielfalcao/.local/share/wezterm/gui-sock-530"

(defun validate-arg-type-nil-or-string (function-name arg-name arg-value)
  ((or (stringp arg-value) (null arg-value))
   (signal 'type-error
           (format  "function `%s' argument `%s' must be either nil or string but instead received `%s': %S"
                    function-name
                    arg-name
                    (type-of arg-value)
                    arg-value))))

(defun validate-value-type-string (var-name var-value &optional at-)
  (unless (stringp var-value)
    (signal 'type-error
            (format  "variable `%s' should be string but instead is `%s': %S"
                    var-name
                    (type-of var-value)
                    var-value))))

(defun validate-env-var-type-string (env-var-name env-var-value)
  (unless (stringp env-var-value)
    (signal 'type-error
            (format  "environment variable `%s' should be string but instead is `%s': %S"
                    env-var-name
                    (type-of env-var-value)
                    env-var-value))))

(defun validate-value-type-string-existing-readable-and-writable-file (var-name var-value)
  (validate-value-type-string "var-name" var-value)
  (validate-value-type-string var-name var-value)
  (validate-value-type-string var-name var-value)
  (validate-arg-type-nil-or-string var-name)

  (unless (and (stringp var-value)
             (file-exists-p var-value)
             (file-readable-p var-value)
             (file-writable-p var-value))
    (signal 'type-error
            (format  "variable `%s' should be existing, readable and writable path but instead is `%s': %S"
                    var-name
                    (type-of var-value)
                    var-value))))



(defun wezterm-spawn(&optional working-dir &rest args)
  (validate-argument-is-of-expected-type-or-nil "wezterm-spawn" "working-dir" working-dir)

  (let* (
         (env-wezterm-pane (getenv "WEZTERM_PANE"))
         (env-wezterm-unix-socket (getenv "WEZTERM_UNIX_SOCKET"))
         (wezterm-pane (and (stringp env-wezterm-pane) (string-to-number env-wezterm-pane)))
         (wezterm-unix-socket (and (stringp env-wezterm-unix-socket) (expand-file-name env-wezterm-unix-socket)))
         (wezterm-unix-socket (if
                                  (and (stringp wezterm-unix-socket)
                                          (file-exists-p wezterm-unix-socket)
                                          (file-readable-p wezterm-unix-socket)
                                          (file-writable-p wezterm-unix-socket))
                                  wezterm-unix-socket
                                ;; else
                                    (
                                     (and (or (not (stringp wezterm-unix-socket))
                                              (not (file-exists-p wezterm-unix-socket))))


                                      )
                                     )
                                    )
                              )


         (working-dir (cond
                       ((stringp working-dir)
                        (expand-file-name working-dir))

                       ((null working-dir)
                        default-directory))
                      ); end let* working-dir
         (wezterm-spawn-cwd (substring-no-properties (format "%s" working-dir)))

         (call-process-args
          (append (list "cli" "spawn" "--new-window" "--cwd" wezterm-spawn-cwd  "--") args))
         (tmp-buffer-prefix (secure-hash "sha512" (string-join))
         (stdout-buffer (create-fresh-buffer (format "")))
         )
    (condition-case err
        (call-process "/opt/homebrew/bin/wezterm" nil nil nil call-process-args)
      )

    )); end (defun wezterm-spawn ...)


;; (defun wezterm-cli-run-command (command :string args :list<string> &optional pane-id :integer unix-socket :path)

;;   )
;; (defun wezterm-spawn-command-in-new-window-and-get-text (program args &optional cwd pane-id


;; Usage: wezterm cli spawn [OPTIONS] [PROG]...

;; Arguments:
;;   [PROG]...  Instead of executing your shell, run PROG. For example: `wezterm cli spawn -- bash -l` will spawn bash as if it were a login shell

;; Options:
;;       --pane-id <PANE_ID>          Specify the current pane. The default is to use the current pane based on the environment variable WEZTERM_PANE. The pane is used to determine the current domain and window
;;       --domain-name <DOMAIN_NAME>
;;       --window-id <WINDOW_ID>      Specify the window into which to spawn a tab. If omitted, the window associated with the current pane is used. Cannot be used with `--workspace` or `--new-window`
;;       --new-window                 Spawn into a new window, rather than a new tab
;;       --cwd <CWD>                  Specify the current working directory for the initially spawned program
;;       --workspace <WORKSPACE>      When creating a new window, override the default workspace name with the provided name.  The default name is "default". Requires `--new-window`
;;   -h, --help                       Print help
