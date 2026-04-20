;;; -*- lexical-binding: t -*-

(defmacro with-file-buffer (buffer-or-file &rest body)
  "executes BODY in file buffer of filename BUFFER-OR-FILE, returns
the value of last form. If buffer is modified during the execution of
BODY, write changes to filesystem before returning.

BUFFER-OR-FILE is either an existing file `buffer' or a string with the
name of an existing file, in which case the file is loaded into a new
buffer in which to execute BODY.
"
  (declare (indent 1) (debug t))
  (unless (or (stringp buffer-or-file)
              (bufferp buffer-or-file))
    (signal 'type-error (format  "argument `buffer-or-file' must be either a buffer or filename string of existing file but %S is a %s" buffer-or-file (cl-type-of buffer-or-file))
            )
    )

 (unless (or (bufferp buffer-or-file) (file-exists-p buffer-or-file))
   (signal 'type-error (format  "argument `buffer-or-file' points to a non-existing-file %S" buffer-or-file)))

 (let* (
        (buffer              (get-buffer buffer-or-file))
        (must-create         (not buffer))
        (file-name            (and (stringp buffer-or-file) buffer-or-file))
        (file-name-absolute   (and file-name (expand-file-name file-name)))
        )

   (when must-create
     (setq buffer (get-buffer-create file-name-absolute t))
     (with-current-buffer buffer
       (insert-file-contents-literally file-name-absolute)
       ))

  (let ((temp-file (make-symbol "temp-file"))
	(temp-buffer (make-symbol "temp-buffer"))
	(return-value (make-symbol "return-value"))

        )

    `(let* (
           (,temp-file ,file-name-absolute)
           (,temp-buffer ,buffer)
           ,return-value
           )

       (unwind-protect
           (setq ,return-value (progn
                                 (with-current-buffer ,temp-buffer
                                   (save-restriction
                                     (widen)
                                     (beginning-of-buffer)
	                             ,@body))))

	 (with-current-buffer ,temp-buffer
	   (write-region nil nil ,temp-file nil 0))
         (and (buffer-name ,temp-buffer)
	      (kill-buffer ,temp-buffer)))
       )
    )
  )
 )
