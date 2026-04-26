;;;(defun schematfmt-string (schemat-code)
;;;  (unless (stringp schemat-code)
;;;    (signal 'type-error
;;;      (format "argument `schemat-code' must be string but instead received `%s': %s"
;;;        (type-of schemat-code)
;;;        schemat-code)))
;;;
;;;  (let* ((tmp-stdout-buffer-name
;;;           (format "*schematfmt:stdout:%s*" current-filename))
;;;         (tmp-stderr-file (make-temp-file "schematfmt-stderr"))
;;;         (tmp-stdout-buffer (get-buffer-create tmp-stdout-buffer-name))
;;;         (exit-code
;;;           (call-process "schemat" current-filename
;;;             (list tmp-stdout-buffer tmp-stderr-file)
;;;             nil
;;;             "-f"
;;;             "-"
;;;             "-o-"))
;;;         (stderr
;;;           (with-temp-buffer
;;;             (insert-file-contents tmp-stderr-file)
;;;             (widen)
;;;             (beginning-of-buffer)
;;;             (buffer-substring-no-properties (point-min) (point-max))))
;;;
;;;         (stdout
;;;           (with-current-buffer tmp-stdout-buffer
;;;             (widen)
;;;             (beginning-of-buffer)
;;;             (buffer-substring-no-properties (point-min) (point-max)))))
;;;
;;;    (message
;;;      (format "schematfmt %s exitted with code: %s" current-filename exit-code))
;;;    (cond
;;;      ((eq exit-code 0)
;;;        (let* ((previous-buffer-contents
;;;                 (save-mark-and-excursion
;;;                   (widen)
;;;                   (beginning-of-buffer)
;;;                   (buffer-substring-no-properties
;;;                     (point-min)
;;;                     (point-max)))))
;;;          (widen)
;;;          (beginning-of-buffer)
;;;          (kill-region (point-min) (point-max))
;;;          (beginning-of-buffer)
;;;          (insert stdout)
;;;
;;;          (kill-buffer tmp-stdout-buffer)
;;;          (delete-file tmp-stderr-file)
;;;          (message
;;;            "%s formatted with schematfmt"
;;;            (abbreviate-file-name current-filename))))
;;;      (t
;;;        (kill-buffer tmp-stdout-buffer)
;;;        (message
;;;          (format "schematfmt %s failed with code: %s"
;;;            (abbreviate-file-name current-filename)
;;;            exit-code))
;;;
;;;        (pop-to-buffer-same-window tmp-buffer-stderr nil)))))
;;;
(defun schematfmt ()
  "."
  (interactive)
  (enable-debug-on-error)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-stdout-buffer-name (format "*schematfmt:stdout:%s*" current-filename))
         (tmp-stderr-buffer-name (format "*schematfmt:stderr:%s*" current-filename))
         (tmp-stderr-file (make-temp-file "schematfmt-stderr"))
         (tmp-stdout-buffer (get-buffer-create tmp-stdout-buffer-name))
         (tmp-stderr-buffer (get-buffer-create tmp-stderr-buffer-name))
         (exit-code
           (call-process "schemat" nil
             (list tmp-stdout-buffer tmp-stderr-file)
             nil
             current-filename))
         (stderr
           (with-temp-buffer
             (insert-file-contents tmp-stderr-file)
             (widen)
             (beginning-of-buffer)
             (buffer-substring-no-properties (point-min) (point-max))))

         (stdout
           (with-current-buffer tmp-stdout-buffer
             (widen)
             (beginning-of-buffer)
             (buffer-substring-no-properties (point-min) (point-max)))))

    (message
      (format "schemat %s exitted with code: %s" current-filename exit-code))
    (cond
      ((eq exit-code 0)
        (revert-buffer t t t))
      (t
        (kill-buffer tmp-stdout-buffer)
        (message
          (format "schemat %s failed with code: %s"
            (abbreviate-file-name current-filename)
            exit-code))

        (with-current-buffer tmp-stderr-buffer
          (widen)
          (beginning-of-buffer)
          (insert stderr)
          (pop-to-buffer-same-window tmp-stderr-buffer nil))))))
