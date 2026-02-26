(defun save-open-buffers-as-wip-in-workbench ()
  (let* ((workbench-root (file-name-canonicalize "~/workbench"))
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
         (index-file-lines (list))
         (buffers (buffer-list))
         (buffer-count (length buffers))
         ) ;; end (let* ...( varlist
    ;; <defun body>
    (seq-do-indexed
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
                (index-file-data (string-join (list
                                               (format "[buffer %s]{" pos)
                                               (format "    \"index\": %S," index)
                                               (format "    \"total\": %S," buffer-count)
                                               (format "    \"name\": %S," bufname)
                                               (format "    \"pos\": %S," pos)
                                               (format "    \"name_raw\": %S," buffer-name-raw)
                                               (format "    \"is_file\": %s," (if is-file "true" "false"))
                                               (format "    \"contents\": %S," bufcontents)
                                               (format "}")
                                               )
                                              "\n"))
                ) ;; end (with-current-buffer (let* ...) varlist )
           ;; <seq-do-index lambda body>
           (push index-file-data  index-file-lines)

           ;; </seq-do-index lambda body>

           );; end (let* ...)
         );; end (with-current-buffer ...)
       ) ;; end (lambda (buf index)
     ) ;; end (seq-do-indexed
    ;; </defun body>
    (let (
          (index-file-contents (format "\n%s\n" (string-join index-file-lines "\n")))
          (index-file-path workbench-wip-buffers-index-file-path)
          )
      (write-region index-file-contents nil index-file-path t nil nil nil))


    );; end (defun ... (let* ... ))
  );; end (defun save-open-buffers-as-wip-in-workbench)
