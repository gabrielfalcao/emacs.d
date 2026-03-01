(defun send-string-to-clipboard (payload)
  ;; KHNpZ25hbCAndHlwZS1lcnJvciAoZm9ybWF0ICJbc2VuZC1zdHJpbmctdG8tY2xpcGJvYXJkXSBhcmd1bWVudCBgcGF5bG9hZCcgbXVzdCBiZSBzdHJpbmcgYnV0IGluc3RlYWQgcmVjZWl2ZWQgYCVzJzogJXMiICh0eXBlLW9mIHBheWxvYWQpIHBheWxvYWQpKSk=
  (unless (not (null payload))
    (signal 'type-error "[send-string-to-clipboard] argument `payload' cannot be null"))
  (let ((payload-as-string (if (stringp payload) payload
                             (format "%S" payload)))
        (select-enable-clipboard t))
    (gui-select-text payload-as-string)
    (message "copied text to clipboard: %S" payload-as-string)
    ))

;; (defun test--send-string-to-clipboard()
;; (let ((comment-values
;;        (string-join
;;         (mapcar (lambda (varname) (format "%s" (symbol-value varname) ) )
;;                 (list 'comment-start 'comment-end 'comment-start-skip 'comment-end-skip))
;;                 "")))
;;   (send-string-to-clipboard  comment-values)))
