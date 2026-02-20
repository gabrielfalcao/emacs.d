\,(let* ((class-name "buffer-info")
         (regexp "search-info-\([gs]et\)-\([a-z]+\|[a-z][A-Za-z0-9-]*[a-z]\)")
        (to-string (lambda()
                     (let* (
                            (action    (match-string-no-properties 1))
                            (slot (match-string-no-properties 2))
                            (action-matches #'(lambda (verb-name)
                                              (and (stringp action)
                                                   (string= verb action))))
                            )
                       (cond
                        ((action-matches "get")
                         (string-join (list class-name action slot) "-"))

                        ((action-matches "set")
                         (string-join (list class-name action slot) "-")))


              (replace-regexp   → buffer-info-\2\,(format "%s" (if (string= "set" \1) "-set" ""))
