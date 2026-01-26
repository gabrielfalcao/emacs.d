(defun workbench-root ()
  (mkdir-p (file-name-concat (expand-file-name "~") "workbench")))

(defun workbench-logs-safe-path ()
  (mkdir-p (file-name-concat (workbench-root) "logs" (today-string))))

(defun workbench-path ()
  (mkdir-p (file-name-concat (workbench-root) (today-string))))

(defun workbench-logs () (workbench-logs-safe-path))

(defun workbench/path (&optional time zone)
  "returns the date-bound workbench path for today, unless the optional
argument TIME is provided.

The argument TIME is forwarded to `format-time-string', so if its value
is `nil' then the current date is assumed.

Likewise, the argument ZONE is forwarded to `format-time-string', so if its value
is `nil' then the current timezone is assumed.

This function automatically creates the workbench before returning its path.
"
  (let ((workbench-path
         (file-name-concat "~/workbench/"
                           (format-time-string "%Y-%m-%d" time zone))))
    (unless (file-directory-p workbench-path)
      (make-directory workbench-path t))
    workbench-path))


(defun workbench/save-session-info(&optional dir-path)
  (interactive)
  (when (null dir-path) (setq-local dir-path (workbench-path)))


  (let* ((date-fs (format-time-string "%Y-%m-%d-%z"))
         (timestamp-fs (slugify-string (now)))
         (target-dir (file-name-concat (format "emacs-%s" date-fs)))
         (target-file-buffers-content-backup-dir
          (file-name-concat target-dir
                            (format "open-files-%s" timestamp-fs)))
         (target-open-buffers-list-filename
          (format "emacs-open-buffers-%s" timestamp-fs))
         (target-open-files-list-filename
          (format "emacs-open-files-%s" timestamp-fs))
         (target-filename-buffer-list
          (format "emacs-open-buffers-%s" human-ts))
         (buffers (get-all-buffers-info))
         (lock-filename (file-name-concat target-dir "write.lock")))
    (make-directory target-file-buffers-content-backup-dir t)
    ;; :read-start start
    ;; :read-end end
    ;; :contents contents
    ;; :name (buffer-name buffer)
    ;; :slug (shell-script-gen-safe-variable-name-from-string (buffer-name buffer))
    ;; :filename (buffer-file-name buffer)
    ;; :filename-relatice (buffer-file-name buffer)
    ;; :cwd (getcwd)
    ;; :read-start-sec-and-nanos start-cons
    ;; :read-end-sec-and-nanos end-cons
    ;; :buffer buffer
    (mapc
     #'(lambda (info)
         (let-alist
             (seq-partition info 2)
           (let* ((target-filename
                   (file-name-concat
                    target-file-buffers-content-backup-dir
                    (string-trim-left .filename "^/+")))
                  (target-dir (file-name-directory target-filename)))
             (make-directory target-dir t)
             (with-temp-buffer
	       (insert .contents)
	       (widen)
	       (beginning-of-buffer)
	       (write-region
                (point-min)
                (point-max)
                .filename nil nil lock-filename))
             (with-temp-buffer
	       (insert (json-encode-plist info))
	       (widen)
	       (write-region
                (point-min)
                (point-max)
                (format "%s.info.json" .filename)
                nil nil lock-filename)))))
     buffers) ;;end mapc #'(lambda (info))
    (with-temp-buffer
      (insert (json-encode buffers))
      (widen)
      (beginning-of-buffer)
      (write-region
       (point-min)
       (point-max)
       (file-name-concat target-dir
                         (format "all-buffers-%s.json" timestamp-fs)
                         nil nil lock-filename)))); end let of defun
  );defun workbench/save-session-info

(defun Ox33b4O/find-file/~/workbench/today(filename)
  "bound to `C-x' 'M-f'"
  (interactive
   (find-file-open-minibuffer-at-directory-interactive
    (workbench/path)))
  (find-file-open-minibuffer-at-directory-body filename))


(defun Ox33b4O/open-boot-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/boot.el"))

(defun Ox33b4O/open-ui-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/ui.el"))

(defun Ox33b4O/open-e02491d9-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/e02491d9.el"))

(defun Ox33b4O/open-modes-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/modes.el"))

(defun Ox33b4O/open-debug-et-diagnostics-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/debug-et-diagnostics.el"))

(defun Ox33b4O/open-keys-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/keys.el"))

(defun Ox33b4O/open-hooks-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/hooks.el"))

(defun Ox33b4O/open-advices-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/advices.el"))

(defun Ox33b4O/open-functions-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/functions.el"))

(defun Ox33b4O/open-flatten-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/flatten.el"))

(defun Ox33b4O/open-g-modeline-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/g-modeline.el"))

(defun Ox33b4O/open-other-functions-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/other-functions.el"))

(defun Ox33b4O/open-elpamelpa-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/elpamelpa.el"))

(defun Ox33b4O/open-rgb-parser-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/rgb-parser.el"))

(defun Ox33b4O/open-write-refactor-tool-instead-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/write-refactor-tool-instead.el"))

(defun Ox33b4O/open-macros-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/macros.el"))

(defun find-file-open-minibuffer-at-directory-interactive(initial-directory)
  (let* ((~/opt/libexec/path (expand-file-name initial-directory))
         (result
          (list
           (read-file-name "Find file: " ~/opt/libexec/path "confirm-after-completion" nil nil ))))
    (with-minibuffer-selected-window
      (minibuffer-complete)
      (minibuffer-complete))
    result));; end defun closure

(defun find-file-open-minibuffer-at-directory-body (filename)
  (let* ((value (find-file-noselect filename nil nil t))
         (result
          (if (listp value)
	      (mapcar 'pop-to-buffer-same-window (nreverse value))
	    (pop-to-buffer-same-window value))))
    (with-minibuffer-selected-window
      (minibuffer-complete)
      (minibuffer-complete))
    result))

(defun Ox33b4O/find-file/~/opt/libexec(filename)
  "bound to `C-x' 'M-f'"
  (interactive
   (find-file-open-minibuffer-at-directory-interactive "~/opt/libexec/"))
  (find-file-open-minibuffer-at-directory-body filename))


(defun Ox33b4O/find-file/~/.shell.d(filename)
  "bound to `C-x' 'M-s'"
  (interactive
   (find-file-open-minibuffer-at-directory-interactive "~/.shell.d/"))
  (find-file-open-minibuffer-at-directory-body filename))

(defun Ox33b4O/find-file/~/.emacs.d(filename)
  "bound to `C-x' 'M-s'"
  (interactive
   (find-file-open-minibuffer-at-directory-interactive "~/.emacs.d/"))
  (find-file-open-minibuffer-at-directory-body filename))
