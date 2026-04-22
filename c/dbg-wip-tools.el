(c-message-open "%s" (let* (
                            (value "foo")
                            (value-type (type-of value))
                            (type-of-value-type (type-of value-type)))
                      (format "value: %s\nvalue-type: %s\nvalue-of-value-type: %s\n(symbol-value value-type): %s\n" value value-type type-of-value-type (intern (symbol-name value-type)))))
