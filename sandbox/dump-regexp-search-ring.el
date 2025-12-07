;; `query-replace-from-history-variable'
;; `query-replace-to-history-variable'

(let* ((items (append regexp-search-ring))
       qrv (symbol-value query-replace-from-history-variable))
  (erase-c-messages)
  (c-message-open "debugging regexp-search-ring")

  (mapc #'(lambda (item)
            (let* ((tag-attrs (string-join (list) " "))
                   (open (format "<%s%s>" (type-of item) tag-attrs))
                   (close (format "</%s>" (type-of item)))
                   (result (format "%s\n%S\n%s" open item close))
                   )
                   (c-message "%s" (auto-propertize-string result))))
        items)

  (c-message-debug-symbols (list ;;'query-replace-map
                                 'query-replace-history
                                 'query-replace-from-history-variable
                                 'query-replace-to-history-variable
                                 ))

  (c-message "<query-replace-to-history-variable type=\"%s\">\n\t%s</query-replace-to-history-variable>"
             (type-of qrv) qrv )

  )
