(require 'package)
(require 'flycheck)
(require 'seq)
(require 'server)
;(load "subr")
(require 'subr-x)
(require 'help-fns)
(safe-load-file "~/.emacs.d/c/staging/write-to-minibuffer.el")
(safe-load-file "~/.emacs.d/c/staging/save-match-data-excursion-and-restriction.el")

(define-error 'c-el-internal-error
  (format "Internal Error in elisp files under `default-directory'/`c/*.el'"))
(define-error 'c-el-server-error "Server Error")
(define-error 'server-reboot-error "Server Reboot Error" 'c-el-server-error)

(define-error 'load-error "Type Error" 'c-el-internal-error)
(define-error 'format-string-error "Format Error" 'c-el-internal-error)
(define-error 'type-error "Type Error" 'c-el-internal-error)
(define-error 'eval-sexp-string-error "Eval Expression Error" 'c-el-internal-error)
(define-error 'filesystem-error "File-System Error" 'c-el-internal-error)
(define-error 'io-error "I/O Error" 'c-el-internal-error)

(defconst set-bar-modes-mode-names
  (list 'menu-bar-mode ;
    'tool-bar-mode ;
    'scroll-bar-mode)) ;

(defun set-bar-modes (&optional orig-arg)
  "."
  (interactive "P")
  (let* ((arg
           (pcase orig-arg

             ('enable 1)
             (:enable 1)

             ('disable -1)
             (:disable -1)

             ((or
                 (pred integerp)
                 (pred null)
                 (pred (eq t)))
               arg)

             (_
               (display-warning :warning
                 (format "defaulting to disable bar modes %S due to unexpected raw argument of type %S: %S "
                   (format
                     "(%s)"
                     (string-join
                       (mapcar #'symbol-name set-bar-modes-mode-names)
                       ", "))
                   (cl-type-of orig-arg)
                   orig-arg)
                 :warning
                 "*Messages*")
               -1)))) ; disable mode by default

    (mapcar
      (lambda (minor-mode-sym)
        (let* ((current-value (symbol-value minor-mode-sym))
               (result (list)))

          (plist-put result :func-name (symbol-name minor-mode-sym))

          (condition-case err
            (plist-put result :func-call-return
              (funcall minor-mode-sym arg))
            (error (plist-put result :func-call-error err)))
          (setq-default minor-mode-sym arg)))

      set-bar-modes-mode-names)))

(defun disable-bars () (interactive) (set-bar-modes :disable))

;; TODO: defadvice for auto-complete of `find-file' to:
;;   - exclude from empty files from completion
;;   - exclude the same file as the (buffer-file-name) from which find-file was called
;;   - sort filenames by their modified-at timestamp

(defconst user-emacs-d-c-directory
  "path to ~/.emacs.d/c/"
  (file-name-concat user-emacs-directory "./c/"))

(defun eval-buffer-goto-failure()
  (interactive)
  (condition-case err
    (eval-buffer)
    (error
      (if (string-match
           "\\([Ii]nvalid.*syntax\\|syntax.*error\\).*\\s-*,\\s-*\\([0-9]+\\)\\s-*,\\s-*\\([0-9]+\\)"
           (format "%s" err)
           nil
           t)
        (let* ((position (string-to-number (match-string 2)))
               (wat (string-to-number (match-string 3))))
          (message "going to position %d" position)
          (goto-char position))
        (c-message "ERROR: %s" err)))))

(defconst workbench-root-path
  (expand-file-name "~/workbench")
  "root path of workbench, this var will be DEPRECATED by the future emacs/rust extension `workbench-el' with RPC calls to the **workbench-server**")

(defun workbench-today-string (&optional time zone)
  "returns a datetime with the correct format for daily workbench paths.
  See variable `workbench-path' which uses this function."
  (format-time-string "%Y-%m-%d" time zone))

(defvar workbench-path
  (file-name-concat workbench-root-path (workbench-today-string))
  "path to the current day's workbench path within the `workbench-root-path' constant.")

;; ;; ..TK
;; (setq-default default-directory           (wezterm-get-newest-cwd))
;; (setq-default shell-file-name                    (car (which-bin "bash")))
;; ;;

(setq-default shell-command-dont-erase-buffer t)
(setq-default shell-command-dont-erase-buffer 'save-point)
(setq-default shell-command-default-error-buffer "*shell-command-stderr*")
(setq-default shell-command-buffer-name "*shell-command-stdout*")
(setq-default shell-file-name "/opt/homebrew/Cellar/bash/5.2.26/bin/bash")

(setq-default kill-ring-max #xfffff)
(setq-default current-time-list nil)
(setq-default line-number-mode t)
(setq-default indent-tabs-mode nil)
(setq-default global-package-online nil) ;; set to non-nil to enable
(setq-default global-flycheck-mode t)
(setq-default debug-on-error nil)
(setq-default initial-scratch-message nil)
(setq-default auto-save-interval 137)
(setq-default save-interprogram-paste-before-kill t)
;; (setq-default case-fold-search nil)
(defalias 'yes-or-no-p #'y-or-n-p)
(defalias '~libexec #'Ox33b4O/find-file/~/opt/libexec)
(defalias '~opt/libexec #'Ox33b4O/find-file/~/opt/libexec)
(defalias '~/opt/libexec #'Ox33b4O/find-file/~/opt/libexec)
(defalias '~/opt #'Ox33b4O/find-file/~/opt/libexec)
(defalias '~opt #'Ox33b4O/find-file/~/opt/libexec)
(defalias 'opt #'Ox33b4O/find-file/~/opt/libexec)

(defalias '~workbench #'Ox33b4O/find-file/~/workbench/today)

(defalias '~shell.d #'Ox33b4O/find-file/~/.shell.d)
(defalias '~/shell.d #'Ox33b4O/find-file/~/.shell.d)

(defalias '~emacs.d #'Ox33b4O/find-file/~/.emacs.d)
(defalias '~/emacs.d #'Ox33b4O/find-file/~/.emacs.d)

(setq-default gdscript-use-tab-indents nil)
(setq-default binary-as-unsigned t)
(defalias 'file-name-canonicalize #'expand-file-name)
(defalias 'file-name-full-path #'expand-file-name)
(add-to-list 'custom-safe-themes "5bd001a0f95d54174370e9275b1f594829930a1a95ed82741a5492facb7415e7")
(setq-default find-function-C-source-directory
  (expand-file-name "~/projects/third_party/emacs/src"))
(set-face-attribute 'default nil :font "JetBrains Mono-16")

;; from commit d1deee94c7099cd0c79bd7c9d5716397e847a325: OzsKOzsgZ2l2ZW4gdGhlIHJlZ2lvbjoKOzsKOzsgYGBgZW1hY3MtbGlzcAo7OyAoa2VybmVsLW5hbWUgOzsgTGludXgKOzsgIChzaGVsbC1jb21tYW5kLXRvLXN0cmluZyAidW5hbWUgLXMiKSkKOzsgKG9wZXJhdGluZy1zeXN0ZW0tbmFtZSA7OyBHTlUvTGludXgKOzsgIChzaGVsbC1jb21tYW5kLXRvLXN0cmluZyAidW5hbWUgLW8iKSkKOzsgKGhhcmR3YXJlLXBsYXRmb3JtLW5hbWUgOzsgeDg2XzY0Cjs7ICAoc2hlbGwtY29tbWFuZC10by1zdHJpbmcgInVuYW1lIC1tIikpCjs7IDs7YGBgCjs7Cjs7IHJ1biBgcmVwbGFjZS1yZWdleHAtaW4tcmVnaW9uJyB3aXRoIHJlZ2V4cCBpbnB1dCBhbmQgcmVwbGFjZW1lbnQKOzsKOzsgYGBgcmVwbGFjZS1yZWdleHAgaW5wdXQKOzsgXihcKFwoW2Etei1dK1wpLW5hbWVcKVs7WzpzcGFjZTpdXStcKFteWzpzcGFjZTpdXStcKVtbOnNwYWNlOl1dKlxuK1tbOnNwYWNlOl1dKlwoKHNoZWxsLWNvbW1hbmQtdG8tc3RyaW5nXHMtKyJcKFteIl0rXCkiKVwpKSQKOzsgYGBgCjs7Cjs7IGBgYHJlcGxhY2UtcmVnZXhwIHJlcGxhY2VtZW50Cjs7IChkZWZjb25zdCAnXDEgOzsgXFwxID0+IFwxXG4gICAgICAgIFw0IDs7IGluaXQgdmFsdWUgXFw0ID0+IFw0XG4gICAgICAgICJzdHJpbmcgd2l0aCBcMiBuYW1lIG9idGFpbmVkIHZpYSBcXCJcNVxcIiBkdXJpbmcgZW1hY3MgaW5pdGlhbGl6YXRpb24iXG4gICAgICAgIDs7IGV4YW1wbGUgdmFsdWU6IFxcIlwyXFwiXG4pXG4KOzsgYGBgCjs7Cg==
(defconst kernel-name
  (string-trim (shell-command-to-string "uname -s"))
  "string with kernel name obtained via \"uname -s\" during emacs initialization")
(defconst operating-system-name
  (string-trim (shell-command-to-string "uname -o"))
  "string with operating-system name obtained via \"uname -o\" during emacs initialization")
(defconst hardware-platform-name
  (string-trim (shell-command-to-string "uname -m"))
  "string with hardware-platform name obtained via \"uname -m\" during emacs initialization")

(defun runtime-is-linux()
  "returns `t' if emacs is currently running in GNU/Linux"
  (if (string= kernel-name "Linux") t nil))

(defun runtime-is-darwin()
  "returns `t' if emacs is currently running in Apple/Darwin"
  (if (string= kernel-name "Darwin") t nil))

(defconst kernel-is-linux
  (runtime-is-linux)
  "constant that is `t' when emacs is running on GNU/Linux kernel or `nil' otherwise")
(defconst kernel-is-darwin
  (runtime-is-darwin)
  "constant that is `t' when emacs is running on Apple/Darwin kernel or `nil' otherwise")

(defalias 'runtime-is-gnu #'runtime-is-linux)
(defalias 'runtime-is-osx #'runtime-is-darwin)
(defalias 'runtime-is-macos #'runtime-is-darwin)

(defun font-size-for-system()
  "retrieve font-size based on `kernel-name'"
  (let ((fallback-font-size 16))
    (cond
      ((string= kernel-name "Darwin")
        16)
      ((string= kernel-name "Linux")
        14)
      (t ;; fallback
        (message "fallback warning (font-size-for-system) size %S because kernel-name is %S" fallback-font-size kernel-name)
        fallback-font-size))))

(defun font-name-for-system()
  "retrieve font-name based on `kernel-name' via `font-size-for-system'"
  (format "JetBrains Mono-%d" (font-size-for-system)))

(defun cursor-type-for-system()
  "retrieve `cursor-type' based on `kernel-name'"
  (let ((cursor-type-macos '(bar . 3))
        (cursor-type-linux '(bar . 4)))
    (cond
      ((string= kernel-name "Darwin")
        cursor-type-macos)
      ((string= kernel-name "Linux")
        cursor-type-linux)
      (t cursor-type-macos))))

(load-library "ui")
(load-library "functions")
(load-library "debug-et-diagnostics")
(load-library "g-modeline")
(load-library "keys")
(load-file "~/.emacs.d/c/advices.el")
;; (load-library "server-setup") ;; not ready
;; (ensure-server-ready)
(safe-load-file "~/.emacs.d/c/staging/wezterm-list-cwds.el")
(safe-load-file "~/.emacs.d/c/staging/which-bin.el")
;; (load-library "c-staging-after-save-hooks")
(safe-load-file "~/.emacs.d/c/staging/write-to-minibuffer.el")
(safe-load-file "~/.emacs.d/c/staging/save-buffer-list-wip.el")
(safe-load-file "~/.emacs.d/c/staging/string-io-simple.el")
(safe-load-file "~/.emacs.d/c/staging/fmtfun.el")
(safe-load-file "~/.emacs.d/c/staging/get-mode-name.el")
(safe-load-file "~/.emacs.d/c/staging/insert-escape-sexp-backslash-comma.el")
(safe-load-file "~/.emacs.d/c/staging/c-message/c-message-suite.el")
(safe-load-file "~/.emacs.d/c/staging/c-message/with-c-message-open.el")
(load-library "regexp")
(load-library "modes")
(load-library "hooks")
(load-library "macros")
(load-library "pest-mode")
(load-library "functions")
(load-library "elpamelpa")
;; (load-library "ninja-mode")
;; (load-library "cobol-mode")
;; (load-library "cmake-mode")
;; (load-library "visual-basic-mode")
(defun Ox33b4O/$/load-library ()
  "."
  (interactive)
  (load-library "k"))
(defun Ox33b4O/$/load-init ()
  "."
  (interactive)
  (load-file "~/.emacs.d/init.el"))
(defvar Ox33b4O/$/keymap (copy-keymap global-map))
(Ox33b4O/$/paint-mode-line)
(defalias 'plus #'+)
(defalias 'quotient #'/)
(defalias 'times #'*)
(defalias 'difference #'-)
(if kernel-is-linux
  ;; enable display of numbers in the left margin
  (linum-mode 1))

(line-number-mode 1) ;; enable display of line number in the mode line

(setq-default debug-on-error nil)

(setq-default history-length 1000)
(setq-default history-delete-duplicates t)
(setq-default display-line-numbers t)

;; (set-window-buffer (split-window-right) "*Messages*")
;; (erase-messages)
;; (enable-debug-on-error)
(ignore-errors (erase-messages) (erase-c-messages))
