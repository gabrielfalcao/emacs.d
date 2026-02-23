(setq-default force-load-messages t)
(setq-default debug-on-error t)

(progn ; font
  ;; (setq-default $font-family$ "JetBrains Mono")
  ;; (setq-default $font-size$ "14")
  ;; (setq-default $font-name$ (string-join (list $font-family$ $font-size$) "-"))
  (setq-default $font-name$ "JetBrains Mono-14"))

(setq-default warning-minimum-level
              (setq-default warning-minimum-log-level :debug))


(defalias 'describe #'describe-symbol)

(defun safe-load-file (file-name)
  (condition-case err
      (load-file file-name)
    (error
     (display-warning 'emacs
                      (format "failed to load-file `%s': %s" file-name err)
                      ;; :debug / :warning / :error / :emergency
                      :error)
     ); end (display-warning ...)
    ))

(defun safe-load-library (library-name)
  (condition-case err
      (load-library library-name)
    (error
     (display-warning 'emacs
                      (format "failed to load-library `%s':\n%s" library-name err)
                      ;; :debug / :warning / :error / :emergency
                      :error)
     ))
  )



(defun safe-load (file &rest load-optional-args)
  (condition-case err
      (apply #'load (append (list file) load-optional-args))
    (error (message "failed to load `%s':\n%s" file err))))

(safe-load "server")

(defun list-dir-path(path)
  (unless (stringp path)
    (user-error (format "`%s' is not a string" path)))
  (unless (file-exists-p path)
    (user-error (format "path `%s' does not exist" path)))
  (let* ((path (expand-file-name path)))
    (or
     (when (file-directory-p path) (directory-files path))
     (when (file-regular-p path) '(path)))))

(defun scan-dir(path &optional callback)
  (or
   (unless (stringp path)
     (user-error (format "`%s' is not a string" path)))
   (unless (file-exists-p path)
     (user-error (format "path `%s' does not exist" path))))
  (let* ((callback
          (or
           (when (functionp callback) callback)
           #'(lambda (path) t))))
    (mapcar callback (list-dir-path path))))


(setq-default server-name "server" server-socket-dir "~/.emacs.d/socket" server-log t)


(let ((foreground "#A79C83")
      (background "#333"))
  (set-face-attribute 'default nil :font $font-name$ :background "#1c1c1c")
  (set-face-attribute 'default nil :foreground foreground :background background :font $font-name$)
  (set-face-attribute 'mode-line nil :background background :foreground foreground)
  (set-face-attribute 'mode-line-inactive nil :background background :foreground foreground))

(progn
  (add-to-list 'load-path "~/.emacs.d/3pty")
  (add-to-list 'load-path "~/.emacs.d/c")
  (safe-load-library "boot")
  (safe-load-library "elfmt"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(delete-minibuffer-contents)
(kill-buffer "*Messages*")
(line-number-mode #x594553)
(set-frame-parameter nil 'fullscreen 'maximized)
(setq-default debug-on-error nil)
(put 'downcase-region 'disabled nil)

(disable-bars)
