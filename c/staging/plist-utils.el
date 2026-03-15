(defun plist-items (props)
  "returns a list of key/value pairs of each member of the plist `props', signals error if `props' is not a `plist'."

  (unless (plistp props)
    (signal 'type-error
            (format  "argument `props' must be a but instead received `%s': %s"
                     (cl-type-of props)
                     props)))
  (mapcar
   (lambda (even odd)
     (list (nth even props) (nth odd props)))
   (number-sequence 0 (- (length props) 1))))


(defun plist-objects (props)
  "returns a list of obarrays containing details about each of the plist
props `props'. This function differs from `plist-items' in that it
returns an `obarray' with where the key and value of each prop is stored
under the symbols `'key' and `'value', and provides a few useful fields
such as key type, value type and index of prop in plist.
"
  (unless (plistp props)
    (signal 'type-error
            (format  "argument `props' must be a but instead received `%s': %s"
                     (cl-type-of props)
                     props)))
  (seq-map-indexed
   (lambda (even odd)
     (list (nth even props) (nth odd props)))
   props))




(defun plist-item-format (key value index key-type value-type)
  "default value of the `format-fn' argument of `plist-format-items' function"
  (format "[%d] key: %S, value: %S, type: %S" index key value type))

(defun plist-format-items (props &optional format-fn)
  "returns a list of strings describing each property in a plist, useful
for debugging plists"
  (unless format-fn (setq format-fn #'plist-item-format))

  (seq-map-indexed
   (lambda (key-value index)
     (let* ((key (car key-value))
            (value (cadr key-value))
            (key-type (cl-type-of key))
            (value-type (cl-type-of value)))
       (format-fn key value index key-type value-type))
     (plist-items props))))
