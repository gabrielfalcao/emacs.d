(defun save-open-buffers-as-wip-in-workbench ()
  (let* (
         (json-false "false")
         (json-null "null")
         (json-object-type 'plist)
         (json-array-type 'vector)
         (json-key-type 'string)

         (workbench-root (file-name-canonicalize "~/workbench"))
         (today (format-time-string "%Y-%m-%d" nil t))
         (workbench-path (file-name-concat workbench-root today))
         (workbench-wip-buffers-path (file-name-concat workbench-root
                                                       (format "emacs-buffers-%s"
                                                               (format-time-string "%s" nil t))))
         (workbench-wip-buffers-index-file-path
          (progn
            (mkdir workbench-wip-buffers-path t)
            (file-name-concat workbench-wip-buffers-path
                              "index.txt")))
         (buffers (buffer-list))
         (buffer-count (length buffers))
         (index-file-json-array-items
          (seq-map-indexed
           (lambda (buf index)
             (with-current-buffer buf
               (let* (
                      (number (1+ index))
                      (pos (format "%d of %d" number buffer-count))
                      (buffer-name-raw (buffer-name buf))
                      (filename (buffer-file-name buf))
                      (is-file (not (null filename)))
                      (buffer-name-fallback (replace-regexp-in-string "[[:space:]]+" "-" (string-trim (replace-regexp-in-string "[^a-zA-Z0-9_./-]+" " " (buffer-name)))))
                      (wip-filename (format "%s.bkp" buffer-name-fallback))
                      (bufname (if is-file (file-name-nondirectory filename)  buffer-name-fallback))
                      (bufcontents
                       (save-match-data
                         (save-mark-and-excursion
                           (widen)
                           (buffer-substring-no-properties (point-min) (point-max))
                           )))
                      (index-file-vector-json-array (make-vector buffer-count nil))
                      ) ;; end (with-current-buffer (let* ...) varlist )
                 ;; <seq-map-indexed lambda body>
                 (list
                  :index      index
                  :number      number
                  :total      buffer-count
                  :name       bufname
                  :filename       filename
                  :wip_filename       wip-filename
                  :pos        pos
                  :name_raw   buffer-name-raw
                  :is_file    (if is-file "true" "false")
                  :contents   bufcontents
                  :size       (length bufcontents)
                  )
                 ;; </seq-map-indexed lambda body>
                 );; end (let* ...)
               );; end (with-current-buffer ...)
             ) ;; end (lambda (buf index)
           ) ;; end (seq-map-indexed
          )
         (index-file-contents (json-encode index-file-json-array-items))
         )
    ;; <defun body>

    (progn
      ;; <write index file>
      (let ((index-file-path workbench-wip-buffers-index-file-path))
        (write-region index-file-contents nil index-file-path t nil nil nil))
      ;; </write index file>
      )


    );; end (defun ... (let* ... ))
  );; end (defun save-open-buffers-as-wip-in-workbench)
