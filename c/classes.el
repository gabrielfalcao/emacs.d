(defclass path ()
  (
   (string :initarg :string
	      :type string
	      :documentation "`string' of absolute file-system path"
	      :writer path-set-string
	      :reader path-get-string)
   )

  )


(defun make-path (string &optional cwd-or-prefix)
  "creates a new instance of `path' trying to resolve absolute file-system path from `string' if file exists.

`cwd-or-prefix' is either a `path' or `string' used in the absolute resolution attempt when file exists, or prepend to `string' denoting a relative path, resolution is not done if path is not absolute."
  (make-instance 'path
		 :absolute string
		 :cwd-or-prefix cwd-or-prefix))
