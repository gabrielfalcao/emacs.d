;; Setup package sources as described in MELPA’s Getting Started Guide.

(require 'package)

(let* ((no-ssl (and (memq system-type '(windows-nt ms-dos))
                    (not (gnutls-available-p))))
       (proto (if no-ssl "http" "https")))
  ;; Comment/uncomment these two lines to enable/disable MELPA and MELPA Stable as desired
  (add-to-list 'package-archives (cons "melpa" (concat proto "://melpa.org/packages/")) t)
  ;;(add-to-list 'package-archives (cons "melpa-stable" (concat proto "://stable.melpa.org/packages/")) t)
  (when (< emacs-major-version 24)
    ;; For important compatibility libraries like cl-lib
    (add-to-list 'package-archives '("gnu" . (concat proto "://elpa.gnu.org/packages/")))))


(when (require 'use-package nil 'noerror)
  (eval-when-compile
    ;; Following line is not needed if use-package.el is in ~/.emacs.d
    (package-refresh-contents)
    (package-install 'use-package)
    (require 'use-package)))


;; ;; I prefer installing packages with use-package since it makes easier
;; ;; to organize code by grouping a package’s installation with it’s
;; ;; configuration.
;; (unless (package-installed-p 'use-package)
;;   )


(setq use-package-always-ensure t)
