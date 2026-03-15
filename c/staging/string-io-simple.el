(defun read-string-from-buffer (buffer-or-name)
  (unless (or (stringp buffer-or-name) (bufferp buffer-or-name))
    (signal 'type-error
            (format  "argument `buffer-or-name' must be a buffer or the name of an existing buffer but instead received `%s': %s"
                     (type-of buffer-or-name)
                     buffer-or-name)))

  (unless (stringp gawk-code)
    (signal 'type-error
            (format  "argument `gawk-code' must be string but instead received `%s': %s"
                     (type-of gawk-code)
                     gawk-code)))

  (with-current-buffer buffer-or-name
    (save-mark-and-excursion
      (widen)
      (beginning-of-buffer)
      (buffer-substring-no-properties (point-min) (point-max)))))

(defun read-string-from-file (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (widen)
    (beginning-of-buffer)
    (buffer-substring-no-properties (point-min) (point-max))))

(defun write-string-to-buffer (buffer-or-name string)
  (with-current-buffer buffer-or-name
    (save-mark-and-excursion
      (widen)
      (beginning-of-buffer)
      (buffer-substring-no-properties (point-min) (point-max)))))

(defun write-string-to-file (filename)
  (with-temp-buffer
    (insert-file-contents filename)
    (widen)
    (beginning-of-buffer)
    (buffer-substring-no-properties (point-min) (point-max))))
