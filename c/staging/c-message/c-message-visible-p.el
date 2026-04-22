(defun --c-message-list-to-debug-string (seq label &optional item-separator)
  (unless (or (null seq) (listp seq))
    (signal 'type-error
      (format "argument `seq' must a list but received `%s': %S"
        (cl-type-of seq)
        seq)))
  (unless (stringp label)
    (signal 'type-error
      (format "argument `label' must a string but received `%s': %S"
        (cl-type-of label)
        label)))

  (let* ((default-item-separator "\n")
         (items (or seq (list)))
         (total (length items))
         (item-separator
           (or
             (and (stringp item-separator) item-separator)
             default-item-separator))
         (index-fmt (format "%%%ds" (length (format "%s" total))))
         (indentation (string-join (make-list 4 " ") ""))
         (indent-part (lambda (part) (format "%s%s" indentation part)))
         (on-each-item-indexed
           (lambda (item idx)
             (let* ((current (1+ idx))
                    (item-start
                      (format "<%s item={%d} of={%d}>" label current total))
                    (item-end (format "</%s>" label))
                    (item-value (funcall indent-part (format "%S" item)))
                    (parts (list item-start item-value item-end))
                    (items (mapcar indent-part parts)))
               (string-join items item-separator)))))
    (string-join
      (seq-map-indexed on-each-item-indexed items)
      item-separator)))

(defun c-message-visible-p (&optional frame debug-internals)
  "returns non-nil if `c-message-buffer' is visible in current frame when called with no arguments.

The optional FRAME argument, if provided, must be of type `frame' and
must be *live* (.i.e.: must pass both predicates `framep' and
`frame-live-p'), in which case this function returns non-nil if
`c-message-buffer' is visible in that frame.
"
  (let* (
         (vis-windows (window-list frame))
         (vis-buffers (mapcar #'window-buffer vis-windows))
         (vis-buffer-names
           (seq-filter #'stringp (mapcar #'buffer-name vis-buffers)))
         (c-message-buf-membership
           (member c-messages-buffer-name vis-buffer-names))
         (result
           (and
             (listp c-message-buf-membership)
             (length> c-message-buf-membership 0))))

    (when debug-internals
      (let* ((vars-dbg
               (list
                 (--c-message-list-to-debug-string vis-windows "vis-windows")
                 (--c-message-list-to-debug-string vis-buffers "vis-buffers")
                 (--c-message-list-to-debug-string vis-buffer-names "vis-buffer-names")
                 (--c-message-list-to-debug-string c-message-buf-membership "c-message-buf-membership")
                 (format "<result type={%s}>\n%S\n</result>"
                   (cl-type-of result)
                   result)))
             (do-debug
               (lambda (&rest extra-dbg-items)
                 (c-message "%s"
                   (string-join
                     (append extra-dbg-items vars-dbg)
                     "\n")))))
        (apply do-debug
          (list :result result
            :c-message-buf-membership
            c-message-buf-membership))))
    result))

(defun --c-message-visible-p-debug(&optional frame)
  (let* ((result nil))
    (c-message-open)
    (erase-c-messages)
    (c-message "<c-message-visible-p>")
    (setq result (c-message-visible-p frame t))
    (c-message "</c-message-visible-p>")

    (c-message "<result type={%s}>" (cl-type-of result))
    (c-message "%S" result)
    (c-message "</result>")))
