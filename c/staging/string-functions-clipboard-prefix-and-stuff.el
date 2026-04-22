(defun clipboard-get-string()
  (gui-get-selection 'CLIPBOARD 'STRING))

(defun clipboard-get-lines (&optional omit-nulls trim line-separator)
  (unless (or (stringp line-separator)
           (null line-separator))
    (signal 'type-error
      (format "wrong type argument `line-separator' is a `%s', not a string: %s"
        (type-of line-separator)
        line-separator)))

  (unless (and line-separator (length> line-separator 0))
    (setq line-separator "\n"))

  (string-split (clipboard-get-string) line-separator omit-nulls trim))

(defalias 'string-from-clipboard #'clipboard-get-string)
(defalias 'list-of-strings-from-clipboard #'clipboard-get-lines)

(defun string-prefix-lines (prefix lines &optional output-string omit-nulls trim line-separator)
  "prefixes each line from `lines' with the string `prefix' and returns a
list of strings with each line, unless `output-string' is non-nil, in
which case each string in that list of strings is joined by
`line-separator' via `string-join'.

`lines' is either a list of strings or a string which will be split into
a list of strings `line-separator'.

`output-string' can be any non-nil value

`omit-nulls' and `trim' are forwarded to `string-split', which see.
"
  (unless (or (stringp line-separator)
           (null line-separator))
    (signal 'type-error
      (format "wrong type argument `line-separator' is a `%s', not a string: %s"
        (type-of line-separator)
        line-separator)))

  (unless (and line-separator (length> line-separator 0))
    (setq line-separator "\n"))

  (unless (stringp prefix)
    (signal 'type-error
      (format "wrong type argument `prefix' is a `%s', not a string: %s"
        (type-of prefix)
        prefix)))
  (when (stringp lines)
    (setq lines (string-split lines line-separator omit-nulls trim)))

  (unless (list-of-strings-p lines)
    (signal 'type-error
      (format "wrong type argument `lines' is not a list of strings: %s"
        (type-of lines)
        lines)))

  (let ((result (mapcar #'(lambda (line) (format "%s%s" prefix line)) lines)))
    (or (and output-string (string-join result line-separator))
      result)))
(defun send-string-to-clipboard (payload)
  ;; KHNpZ25hbCAndHlwZS1lcnJvciAoZm9ybWF0ICJbc2VuZC1zdHJpbmctdG8tY2xpcGJvYXJkXSBhcmd1bWVudCBgcGF5bG9hZCcgbXVzdCBiZSBzdHJpbmcgYnV0IGluc3RlYWQgcmVjZWl2ZWQgYCVzJzogJXMiICh0eXBlLW9mIHBheWxvYWQpIHBheWxvYWQpKSk=
  (unless (not (null payload))
    (signal 'type-error "[send-string-to-clipboard] argument `payload' cannot be null"))
  (let ((payload-as-string (if (stringp payload) payload
                            (format "%S" payload)))
        (select-enable-clipboard t))
    (gui-select-text payload-as-string)
    (message "copied text to clipboard: %S" payload-as-string)))

;; (defun test--send-string-to-clipboard()
;; (let ((comment-values
;;        (string-join
;;         (mapcar (lambda (varname) (format "%s" (symbol-value varname) ) )
;;                 (list 'comment-start 'comment-end 'comment-start-skip 'comment-end-skip))
;;                 "")))
;;   (send-string-to-clipboard  comment-values)))
