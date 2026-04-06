(setq-default force-load-messages t)
(setq-default debug-on-error t)
(defcustom
  $font-family$
  "JetBrains Mono"
  "default font family used in `~/.emacs.d/c/ui.el'"

  :type 'string
  :group 'emacs.d.c
  :tag "default font-family used across `~/.emacs.d/c'"
  )
(defcustom
  $font-size$
  16
  "default font size used in `~/.emacs.d/c/ui.el'"

  :type 'natnum
  :group 'emacs.d.c
  :tag "default font-size used across `~/.emacs.d/c'"
  )

;;(setq-default $font-name$
;;	      (string-join (mapcar (lambda (item)
;;				     (format "%s" item))
;;						 (list $font-family$ $font-size$))
;;					 "-"))
;;
(setq-default $font-name$ "JetBrains Mono-16")


(setq-default warning-minimum-level :debug)
(setq-default warning-minimum-log-level :debug)


(defalias 'describe #'describe-symbol)

(defun unix-time-secs-nanos (&optional time zone)
  "Returns a list with 2 items, both natural numbers, respectively
`seconds' and `nanoseconds' relative to the `current-time' and universal
timezone (UTC) when called without arguments.

The optional arguments TIME and ZONE, follow the same logic and
semantics of the arguments of `format-time-string'.
"
  (let* (
         (time          (or time (current-time)))
         (unix-seconds  (format-time-string "%s"  time zone))
         (nano-seconds  (format-time-string "%N"  time zone))
         ;; (micro-seconds (format-time-string "%6N" time zone))
         ;; (milli-seconds (format-time-string "%3N" time zone))
         )
    (list unix-seconds nano-seconds)
    )
  )

(defun safe-load-file (file-name &optional default-directory)
  (unless (stringp file-name)
    (signal 'type-error (format "argument `file-name' should be a string but is `%s': %S"
                                (cl-type-of file-name)
                                file-name)))

  (let* (
         (resolved-file-name    (expand-file-name file-name default-directory))
         (started-at            nil)
         (finished-at           nil)
         (error-caught-at       nil)
         (error-caught-obj      nil)
         (error-caught-msg      nil)
         (result                nil)
         (makeprops             (lambda (&rest extra-props)
                                  (unless extra-props
                                    (setq extra-props (list)))
                                  (unless (or (null extra-props) (plistp extra-props))
                                    (signal 'type-error
                                            (format "`makeprops' argument `extra-props' must be a plist but instead got `%s': %S"
                                                    (cl-type-of extra-props)
                                                    extra-props)))

                                  (append extra-props
                                          (list :filename                  file-name
                                                :resolved-filename         resolved-file-name
                                                :started-at                started-at
                                                :finished-at               finished-at
                                                :result                    result
                                                )
                                          )))
         (loaded                (condition-case err
                                    (progn
                                      (setq started-at (unix-time-secs-nanos))
                                      (setq result (load-file resolved-file-name))
                                      (setq finished-at (unix-time-secs-nanos))
                                      t)
                                  (error
                                   (setq error-caught-at (unix-time-secs-nanos))
                                   (setq error-caught-obj err)
                                   (let* (
                                          (err-msg   (error-message-string err))
                                          (user-msg  (format "failed to load-file `%s': %S" resolved-file-name err-msg))

                                          (final-msg (apply #'propertize user-msg (funcall makeprops
                                                                                   :error-object    err
										   :error-caught-at error-caught-at)))
                                          )
                                     (display-warning 'emacs final-msg :error) ;; :debug / :warning / :error / :emergency
                                     (setq error-caught-msg final-msg)
                                     nil
                                     )
                                   )
                                  )
				)
         (dbg-display (format "(safe-load-file %s)" (string-join
                                                     (seq-filter #'stringp
                                                                 (list (format "%S" file-name)
                                                                       (and default-directory (format "%S" default-directory))))
                                                     " ")))
         ); end let* varlist
    result
    )
  )



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


(safe-load-file "~/.emacs.d/c/workbench.el")
(safe-load-file "~/.emacs.d/c/staging/debug-regexp-subexpressions.el")
(safe-load-file "~/.emacs.d/c/staging/gitfun.el")
(safe-load-file "~/.emacs.d/c/staging/c-message/c-message-suite.el")

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
  (load-file "~/.emacs.d/c/boot.el")
  (safe-load-library "elfmt"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;(delete-minibuffer-contents)
(line-number-mode #x594553)
(set-frame-parameter nil 'fullscreen 'maximized)
(setq-default debug-on-error t)
(setq-default kill-ring-max #xffff)

(put 'downcase-region 'disabled nil)

(safe-load-file "~/.emacs.d/c/staging/write-to-minibuffer.el")

;(erase-all-non-file-buffers)

(disable-bars)
