(defun clipboard-get-string()
  (gui-get-selection 'CLIPBOARD 'STRING))

(defun clipboard-get-lines (&key :omit-nulls omit-nulls :trim trim :line-separator line-separator)
  (unless (or (stringp line-separator)
              (null line-separator))
    (signal 'type-error
            (format  "wrong type argument `line-separator' is a `%s', not a string: %s"
                     (type-of line-separator)
                     line-separator)))

  (unless (and line-separator (length> line-separator 0))
    (setq line-separator "\n"))

  (string-split (clipboard-get-string) line-separator omit-nulls trim))

(defun prefix-lines (prefix lines &key :omit-nulls omit-nulls :trim trim :line-separator line-separator)
  (unless (or (stringp line-separator)
              (null line-separator))
    (signal 'type-error
            (format  "wrong type argument `line-separator' is a `%s', not a string: %s"
                     (type-of line-separator)
                     line-separator)))

  (unless (and line-separator (length> line-separator 0))
    (setq line-separator "\n"))

  (unless (stringp prefix)
    (signal 'type-error
            (format  "wrong type argument `prefix' is a `%s', not a string: %s"
                     (type-of prefix)
                     prefix)))
  (when (stringp lines)
    (setq lines (string-split lines "\n" omit-nulls trim)))

  (unless (list-of-strings-p lines)
    (signal 'type-error
            (format  "wrong type argument `lines' is not a list of strings: %s"
                     (type-of lines)
                     lines)))
  (string-join (mapcar (lambda (line) (format "%s%s" prefix line)) lines) "\n")
  )
