;; ;;WEZTERM_CONFIG_DIR="/Users/gabrielfalcao"
;; ;;WEZTERM_CONFIG_FILE="/Users/gabrielfalcao/.wezterm.lua"
;; ;;WEZTERM_EXECUTABLE="/Applications/WezTerm.app/Contents/MacOS/wezterm-gui"
;; ;;WEZTERM_EXECUTABLE_DIR="/Applications/WezTerm.app/Contents/MacOS"
;; ;;WEZTERM_PANE="190"
;; ;;WEZTERM_UNIX_SOCKET="/Users/gabrielfalcao/.local/share/wezterm/gui-sock-530"
(defun wezterm-spawn(&rest args)
  (call-process "/opt/homebrew/bin/wezterm" nil nil nil (append (list "cli" "spawn" "--new-window" "--") args
                                                                )))
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
