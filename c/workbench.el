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


(defun save-session-info-get-each-buffer-info-callback (buffer)
  (unless (bufferp buffer)
    (error "`buffer' is not a `bufferp' but rather `%s': %S"
           (type-of buffer)
           buffer))

  (let* ((start-cons (now-sexp))
         (contents
          (save-mark-and-excursion
            (widen)
            (buffer-substring-no-properties (point-min) (point-max))))
         (end-cons (now-sexp))
         (start (car start-cons))
         (end (car end-cons))
         (elapsed-seconds (- end start)));;let
    ;; <body>
    (list
     :read-start start
     :read-end end
     :contents contents
     :name (buffer-name buffer)
     :slug (shell-script-gen-safe-variable-name-from-string
            (buffer-name buffer))
     :filename (buffer-file-name buffer)
     :filename-relatice (buffer-file-name buffer)
     :cwd (getcwd)
     :read-start-sec-and-nanos start-cons
     :read-end-sec-and-nanos end-cons
     ;;      :buffer buffer
     )
    ;; </body>
    );; let* (after body)
  ); defun save-session-info-get-buffer-contents-timed
(defun get-all-buffers-info()
  "returns list with information of each open buffer"
  (and
   (unless (or (null dir-path) (stringp dir-path))
     (signal 'type-error
             (format "dir-path is not a string but rather %s: %S"
                     (type-of dir-path)
                     dir-path)));; end unless
   (unless (file-directory-p dir-path)
     (signal 'type-error
             (format "dir-path is not a directory: %S" dir-path)));; end unless
   (unless (file-exists-p dir-path) (make-directory dir-path t) t);; end unless
   );; end and
  (mapcar #'save-session-info-get-each-buffer-info-callback
          (buffer-list))) ;; end defun get-all-buffers-info

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
