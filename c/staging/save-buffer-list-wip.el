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
                (json-false "false")
                (json-null "null")
                (json-object-type 'plist)
                (json-array-type 'vector)
                (json-key-type 'string)
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
           ;; <seq-do-index lambda body>
           (push index-file-data  index-file-lines)

           (let (
                 (buffer-info-plist-json-object
                  (list
                   :index      index
                   :number      number
                   :total      buffer-count
                   :name       bufname
                   :filename       filename
                   :pos        pos
                   :name_raw   buffer-name-raw
                   :is_file    (if is-file "true" "false")
                   :contents   bufcontents
                   :size       (length bufcontents)
                   ))
                 )

             (mapc (lambda (item)
                     (let* ((key (string-to-snake (format "%s" (car item))))
                            (value (cadr item))
                            (value-as-string (substring-no-properties (format "%s" value)))
                            (ty (cond ((member value-as-string '("true" "false"))
                                       "boolean")
                                      ((or (null value)
                                           (string= value-as-string "null"))
                                       "null")
                                      ((numberp value)
                                       "number")
                                      ((stringp value)
                                       "string")



  (type-of value))
                            (item-obj (json-new-object))
                            )
                       (setq item-obj
                             (json-add-to-object
                              item-obj          ;; object
                              "key"             ;; key
                              (format "%s" key) ;; value
                              ))
                       (setq item-obj
                             (json-add-to-object
                              item-obj          ;; object
                              "value"           ;; key
                              value             ;; value
                              ))
                       (setq item-obj
                             (json-add-to-object
                              item-obj          ;; object
                              "type"            ;; key
                              ty                ;; value
                              ))

                       (setq index-file-vector-json-array
                             (json-add-to-object
                              index-file-vector-json-array
                              (format "%s" key)
                              item-obj))
                       )

           (setq total-file-json-object (json-add-to-object total-file-json-object "total" buffer-substring-no-properties))

                               (string-join (list
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
