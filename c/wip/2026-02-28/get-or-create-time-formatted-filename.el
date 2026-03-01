(defun get-or-create-time-formatted-filename (filename &optional time zone)
  (let* (
         (time-formatted (format-time-string filename time zone))
         (expanded (expand-file-name time-formatted))
         (filename (file-name-nondirectory expanded))
         (parent-dir (file-name-directory expanded))
         )
    (when (and (file-exists-p parent-dir) (not (file-directory-p parent-dir)))
      (signal 'io-error (format  "target parent path of %S exists but is not a directory"
                                 (format "%s" parent-dir))))
    (condition-case err
        (make-directory parent-dir t)
      (error
       (signal 'io-error (format  "target parent path of %S exists but "
                                  (format "%s" parent-dir))))




     ((and (file-exists-p parent-dir)
                (not (file-directory-p parent-dir)))
           (signal 'io-error
                   (format  "target parent path of %S exists but is not a directory"
                            (format "%s" parent-dir))))


    )
  )
