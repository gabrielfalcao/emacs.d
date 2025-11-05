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
  (defalias 'yes-or-no-p #'y-or-n-p)
  (defalias 'describe #'describe-symbol)
  )
(add-to-list 'custom-safe-themes "5bd001a0f95d54174370e9275b1f594829930a1a95ed82741a5492facb7415e7")
(setq find-function-C-source-directory (expand-file-name "~/projects/third_party/emacs/src"))
(set-face-attribute 'default nil :font "JetBrains Mono-13")

;; from commit d1deee94c7099cd0c79bd7c9d5716397e847a325: OzsKOzsgZ2l2ZW4gdGhlIHJlZ2lvbjoKOzsKOzsgYGBgZW1hY3MtbGlzcAo7OyAoa2VybmVsLW5hbWUgOzsgTGludXgKOzsgIChzaGVsbC1jb21tYW5kLXRvLXN0cmluZyAidW5hbWUgLXMiKSkKOzsgKG9wZXJhdGluZy1zeXN0ZW0tbmFtZSA7OyBHTlUvTGludXgKOzsgIChzaGVsbC1jb21tYW5kLXRvLXN0cmluZyAidW5hbWUgLW8iKSkKOzsgKGhhcmR3YXJlLXBsYXRmb3JtLW5hbWUgOzsgeDg2XzY0Cjs7ICAoc2hlbGwtY29tbWFuZC10by1zdHJpbmcgInVuYW1lIC1tIikpCjs7IDs7YGBgCjs7Cjs7IHJ1biBgcmVwbGFjZS1yZWdleHAtaW4tcmVnaW9uJyB3aXRoIHJlZ2V4cCBpbnB1dCBhbmQgcmVwbGFjZW1lbnQKOzsKOzsgYGBgcmVwbGFjZS1yZWdleHAgaW5wdXQKOzsgXihcKFwoW2Etei1dK1wpLW5hbWVcKVs7WzpzcGFjZTpdXStcKFteWzpzcGFjZTpdXStcKVtbOnNwYWNlOl1dKlxuK1tbOnNwYWNlOl1dKlwoKHNoZWxsLWNvbW1hbmQtdG8tc3RyaW5nXHMtKyJcKFteIl0rXCkiKVwpKSQKOzsgYGBgCjs7Cjs7IGBgYHJlcGxhY2UtcmVnZXhwIHJlcGxhY2VtZW50Cjs7IChkZWZjb25zdCAnXDEgOzsgXFwxID0+IFwxXG4gICAgICAgIFw0IDs7IGluaXQgdmFsdWUgXFw0ID0+IFw0XG4gICAgICAgICJzdHJpbmcgd2l0aCBcMiBuYW1lIG9idGFpbmVkIHZpYSBcXCJcNVxcIiBkdXJpbmcgZW1hY3MgaW5pdGlhbGl6YXRpb24iXG4gICAgICAgIDs7IGV4YW1wbGUgdmFsdWU6IFxcIlwyXFwiXG4pXG4KOzsgYGBgCjs7Cg==
(defconst kernel-name
  (string-trim (shell-command-to-string "uname -s"))
  "string with kernel name obtained via \"uname -s\" during emacs initialization"
  )
(defconst operating-system-name
  (string-trim (shell-command-to-string "uname -o"))
  "string with operating-system name obtained via \"uname -o\" during emacs initialization"
  )
(defconst hardware-platform-name
  (string-trim (shell-command-to-string "uname -m"))
  "string with hardware-platform name obtained via \"uname -m\" during emacs initialization"
  )

(defun runtime-is-linux()
  "returns `t' if emacs is currently running in GNU/Linux"
  (if (string= kernel-name "Linux")
      t
    nil))

(defun runtime-is-darwin()
  "returns `t' if emacs is currently running in Apple/Darwin"
  (if (string= kernel-name "Darwin")
      t
    nil))

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
     ((string= kernel-name "Darwin") 21)
     ((string= kernel-name "Linux")  13)
     (t ;; fallback
      (message "fallback warning (font-size-for-system) size %S because kernel-name is %S" fallback-font-size kernel-name)
      fallback-font-size))))

(defun font-name-for-system()
  "retrieve font-name based on `kernel-name' via `font-size-for-system'"
  (format "JetBrains Mono-%d" (font-size-for-system)))


(defun cursor-type-for-system()
  "retrieve `cursor-type' based on `kernel-name'"
  (let (
        (cursor-type-macos '( bar . 3))
        (cursor-type-linux '( bar . 4))
        )
    (cond
     ((string= kernel-name "Darwin") cursor-type-macos)
     ((string= kernel-name "Linux")  cursor-type-linux)
     (t cursor-type-macos))))


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
(linum-mode 1)       ;; enable display of numbers in the left margin
(line-number-mode 1) ;; enable display of line number in the mode line

(setq debug-on-error nil)

(setq history-length 1000)
(setq history-delete-duplicates t)

;; (set-window-buffer (split-window-right) "*Messages*")
;; (erase-messages)
;; (enable-debug-on-error)
