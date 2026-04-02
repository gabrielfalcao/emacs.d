(defun c-message-buffer-local-variables (&optional buffer-or-name)
  "prints out each key/value `cons' from the return value of `buffer-local-variables'"
  (unless (or
           (null buffer-or-name)
           (bufferp buffer-or-name)
           (stringp buffer-or-name))
    (signal 'type-error
            (format "argument BUFFER-OR-NAME, if provided, should be either a `buffer' or `string' but got `%s': %S"
                    (cl-type-of buffer-or-name)
                    buffer-or-name)))
  (let* ((buffer
          (and
           (or (bufferp buffer-or-name) (stringp buffer-or-name))
           (get-buffer buffer-or-name)))
         (var-list (buffer-local-variables buffer))
         (total (length var-list))
         (indexfmt (format "%%%ds" (length (format "%s" total))))
         (result                    nil))

    (unless (c-message-visible-p)
      (c-message-open)
      (erase-c-messages))
    (condition-case err
        (progn
          (erase-c-messages)
          (erase-messages)
          (erase-minibuffer))
      (error
       (let* (
              (msg (format "caught error when erasing read-only buffers: %S" (error-message-string err)))
              )
         (warn "%s" msg))))

    (setq result
          (seq-map-indexed
           (lambda (pair idx)
             (let* ((current (1+ idx))
                    (pos
                     (format "%s of %d"
                             (format indexfmt current)
                             total))
                    (head (car pair))
                    (tail (cdr pair))
                    (tail-head (car tail))
                    (repr-tail  (format "%S" tail))
                    (repr-lines (string-split repr-tail "\n"))
                    (repr-size  (length repr-lines))
                    (key                 head)
                    (values
                     (or
                      (and (or (listp tail) (consp tail)) tail)
                      (list tail)))
                    (value (car values))
                    (item-start
                     (format "<%s pos={%s} of={%d}>" key
                             (format indexfmt current)
                             total))
                    (item-end (format "</%s>"                 key))

                    ;; (item-tail
                    ;;  (format "<tail type={%s}>%S</tail>"
                    ;;          (cl-type-of tail)
                    ;;          tail))
                    (item-tail
                     (format "<tail-size>%S</tail-size>" repr-size))

                    (item-tail-head
                     (format "<tail-head type={%s}>%S</tail-head>"
                             (cl-type-of tail-head)
                             tail-head))
                    (item-value
                     (format "<value type={%s}>%S</value>"
                             (cl-type-of value)
                             value))
                    (item-values
                     (format "<values type={%s}>%S</values>"
                             (cl-type-of values)
                             values))
                    (item
                     (list
                      :start     item-start
                      :end       item-end
                      :tail      item-tail
                      :tail-head item-tail-head
                      :value     item-value
                      :values    item-values))
                    (parts
                     (append
                      (list item-start)
                      (mapcar
                       (lambda (item) (format "    %s" item))
                       (list item-tail
                             item-tail-head
                             item-values
                             item-value))
                      (list item-end))))
               (c-message "%s" (string-join parts "\n"))
               (list
                :current current
                :pos pos
                :head head
                :tail tail
                :tail-head tail-head
                :key key
                :values values
                :value value
                :item item
                :parts parts))
             )
           var-list)
          ))
  )
