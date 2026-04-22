(defun get-indent-format-object (depth &optional indentation-string)
  (unless (stringp indentation-string)
    (setq indentation-string "    "))

  (unless (integerp depth) (setq depth 0))
  (or
    (and (> depth 0) (string-join (make-list depth "    ") ""))
    ""))

(defun get-length-noerror (value)
  (condition-case length-err
    (length value)
    (error
      (c-message
        "(get-length-noerror %S (%s)) ignoring error %s"
        value
        (type-of value)
        length-err)
      -1)))

(defun get-string-lines (value &optional noerror split-sep join-sep)
  (unless (and (stringp join-sep) (length> join-sep 0))
    (setq join-sep "\n"))
  (unless (and (stringp split-sep) (length> split-sep 0))
    (setq split-sep "\n"))

  (let ((value-length (get-length-noerror value)))
    (cond
      ((stringp value)
        (split-string value "\n"))
      ((or (listp value) (consp value))
        (let ((lines-string
                (string-join
                  (seq-map-indexed
                    (lambda (item index)
                      (unless (or noerror (stringp item))
                        (signal 'type-error
                          (format "sequence in %s arg `value' index %d should be a string but is %s: %S"
                            (type-of value)
                            index
                            (type-of item)
                            item)))
                      (substring-no-properties (format "%s" item)))
                    value)
                  join-sep)))

          (get-string-lines lines-string noerror split-sep join-sep)))
      (noerror (list (format "%S" value)))

      ((not noerror)
        (signal 'type-error
          (format "invalid type of `value' arg should be string or list of strings, but is %s: %s"
            (type-of value)
            (format "%S" value))))))) ;; end (let ((value-length ...))) ;; end (defun get-string-lines ...)

(defun indent-string-lines (string-or-list-of-strings &optional depth noerror)
  (string-join
    (mapcar
      (lambda (line)
        (format "%s%s" (get-indent-format-object (+ depth 1)) line))
      (get-string-lines string-or-list-of-strings noerror))
    "\n"))

(defun format-backtrace-object (obj obj-name &optional depth noerror)
  (unless (integerp depth) (setq depth 0))

  (unless (stringp obj-name)
    (signal 'type-error
      (format "`obj-name' should be a string not %s: %s"
        (type-of obj-name)
        obj-name)))

  (let* ((backtrace-object obj)
         (backtrace-object-ty (type-of backtrace-object))
         (backtrace-object-len (get-length-noerror backtrace-object))
         (output-lines
           (append
             (list "")
             (list
               (format "<backtrace-object name=\"%s\" type=\"%s\" length=\"%s\">"
                 obj-name
                 backtrace-object-ty
                 backtrace-object-len))
             (cond
               ((stringp backtrace-object)
                 (format "%s %s" obj-name
                   (substring-no-properties backtrace-object)))

               (t (format "%S %S: %S" obj-name obj backtrace-object-ty))
               ((sequencep backtrace-object)
                 (let ((items
                         (seq-map-indexed
                           (lambda (item index)
                             (format "%s[%s]: %S" obj-name index item))
                           backtrace-object)))
                   (indent-string-lines items (+ depth 1) noerror)))

               ((not noerror)
                 (signal 'type-error
                   (format "invalid type of `backtrace-object' arg should be string or sequence of strings, but is %s: %s"
                     (type-of value)
                     (format "%S" value))))
               (t
                 (indent-string-lines
                   (list (format "%S" value))

                   (+ depth 1)
                   noerror)))
             (list "</backtrace-object>")))) ;; end (append ...) ;; end (let* (.... (output-lines ...))) ;; end (let* (... varlist ...)
    (indent-string-lines output-lines (+ depth 1) noerror))) ;; end (let* ...) ;; end (defun format-backtrace-object ...)

(defun backtrace-to-plist (backtrace-object backtrace-label &optional depth)
  (unless (numberp depth) (setq depth 0))

  (when (< depth 0)
    (c-message "[backtrace-to-plist warning] depth below zero: %S" depth)
    (setq depth 0))

  (unless (stringp backtrace-label)
    (signal 'type-error
      (format "backtrace-to-plist arg `backtrace-label'  should be a string but is %s: %S"
        (type-of backtrace-label)
        backtrace-label)))
  (setq backtrace-label (string-trim backtrace-label))
  (unless (length> backtrace-label 0)
    (signal 'type-error
      "backtrace-to-plist invalid arg empty string `backtrace-label'"))

  (let* ( ;;
         (backtrace-obj backtrace-object)
         (backtrace-ty (type-of backtrace-obj))
         (backtrace-len (get-length-noerror backtrace-obj))
         ;; (backtrace-elements
         ;;  (if (>= backtrace-len 0)
         ;;      (seq-map-indexed
         ;;       (lambda (element index)
         ;;         (backtrace-to-plist element
         ;;                             (format "%s[%s]" backtrace-label index)
         ;;                             (+ 1 depth)))
         ;;       backtrace-obj)
         ;;    (list)))
         )
    (list
      :backtrace
      backtrace-obj
      :label
      backtrace-label
      :type
      backtrace-ty
      :depth
      depth
      :length
      backtrace-len
      ;; :items backtrace-len
      )))

(progn
  (enable-debug-on-error)
  (let* ((depth 0)
         (backtrace-tree
           (format-backtrace-object
             (backtrace-frame 5)
             "backtrace-frame-5"
             (+ 1 depth)
             t)))
    (erase-c-messages)
    (c-message-open "backtrace-tree\n")
    (c-message "backtrace-tree: %S" backtrace-tree)))
