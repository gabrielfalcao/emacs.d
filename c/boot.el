(progn
  (require 'package)
  (require 'flycheck)
  (line-number-mode t)
  (setq global-package-online nil) ;; set to non-nil to enable
  (setq global-flycheck-mode t)
  (setq debug-on-error nil)
  (setq initial-scratch-message nil)
  (setq auto-save-interval 137)
  ;; (setq case-fold-search t)
  (defalias 'yes-or-no-p 'y-or-n-p)
  (defalias 'describe 'describe-symbol)
  )
(add-to-list 'custom-safe-themes "5bd001a0f95d54174370e9275b1f594829930a1a95ed82741a5492facb7415e7")
(set-face-attribute 'default nil :font "JetBrains Mono-13")

;;
;; given the region:
;;
;; ```emacs-lisp
;; (kernel-name ;; Linux
;;  (shell-command-to-string "uname -s"))
;; (operating-system-name ;; GNU/Linux
;;  (shell-command-to-string "uname -o"))
;; (hardware-platform-name ;; x86_64
;;  (shell-command-to-string "uname -m"))
;; ;;```
;;
;; run `replace-regexp-in-region' with regexp input and replacement
;;
;; ```replace-regexp input
;; ^(\(\([a-z-]+\)-name\)[;[:space:]]+\([^[:space:]]+\)[[:space:]]*\n+[[:space:]]*\((shell-command-to-string\s-+"\([^"]+\)")\))$
;; ```
;;
;; ```replace-regexp replacement
;; (defconst '\1 ;; \\1 => \1\n        \4 ;; init value \\4 => \4\n        "string with \2 name obtained via \\"\5\\" during emacs initialization"\n        ;; example value: \\"\2\\"\n)\n
;; ```
;;
(defconst 'kernel-name ;; \1 => kernel-name
        (shell-command-to-string "uname -s") ;; init value \4 => (shell-command-to-string "uname -s")
        "string with kernel name obtained via \"uname -s\" during emacs initialization"
        ;; example value: \"kernel\"
)
(defconst 'operating-system-name ;; \1 => operating-system-name
        (shell-command-to-string "uname -o") ;; init value \4 => (shell-command-to-string "uname -o")
        "string with operating-system name obtained via \"uname -o\" during emacs initialization"
        ;; example value: \"operating-system\"
)
(defconst 'hardware-platform-name ;; \1 => hardware-platform-name
        (shell-command-to-string "uname -m") ;; init value \4 => (shell-command-to-string "uname -m")
        "string with hardware-platform name obtained via \"uname -m\" during emacs initialization"
        ;; example value: \"hardware-platform\"
)

(defun font-name-for-system()
  (let (
        (default-font-name "JetBrains Mono")
        (linux-font-size "13")
        (osx-font-size "21")
        (os-name-emacs-sysconf (format "%s" system-configuration))
        (kernel-name ;; Linux
         (shell-command-to-string "uname -s"))
        (operating-system-name ;; GNU/Linux
         (shell-command-to-string "uname -o"))
        (hardware-platform-name ;; x86_64
         (shell-command-to-string "uname -m"))
        ) ;; end let variables
    (cond
     ((string= "Linux" kernel-name) ;; linux
      (format "%s-%s" default-font-name linux-font-size))
     ((string= "Darwin" kernel-name) ;; osx
      (format "%s-%s" default-font-name osx-font-size))
     (t ;; fallback when neither linux or darwin
      (let ((full-font-spec (format "%s-21" )))
        (message "(font-name-for-system) detected neither Linux nor MacOS but rather: kernel-name=%s and operating-system-name=%s"
                 kernel-name operating-system-name)
          full-font-spec))
     );;end cond
    );; end let
    );; end defun


(load-library "ui")
(load-library "functions")
(load-library "advices")
(load-library "debug-et-diagnostics")
(load-library "g-modeline")
(load-library "keys")
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
(defun Ox33b4O/$/load-library () "." (interactive) (load-library "k"))
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
(line-number-mode)

(setq debug-on-error nil)

(setq history-length 1000)
(setq history-delete-duplicates t)

;; (set-window-buffer (split-window-right) "*Messages*")
;; (erase-messages)
;; (enable-debug-on-error)
