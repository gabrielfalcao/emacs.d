(defun debug-sym-indexed (sym index)
  (let* (
         (idx-display (or (and (integerp index)
                               (format "%4d " index))
                          "     "))
         (name   (symbol-name sym))
         (value  (symbol-value sym))
         (ty    (cl-type-of value))
         (line (format "%s%s (%S): %S" idx-display name ty value))
         )
    ;; (c-message "\n(debug-sym-indexed '%s %d)\n\t%s\n" sym index (string-join (list )
    line
    )
  )

(defun map-callback-debug-maybe-indexed (elt &optional index)
  (let* (
         (elt-type (cl-type-of elt))
         (index-type (cl-type-of index))
         )

    (pcase index

      ((and (pred integerp)
            (pred (>= _ 0)))
       (format "%4d %S: %S" index (cl-type-of elt) elt))

      ((pred null)
       (format "%S: %S" (cl-type-of elt) elt))

      (_ (signal 'type-error
                 (format  "`map-callback-debug-maybe-indexed' argument `index' must be either `nil' or a non-negative integer, but instead received `%s': %S"
			  (cl-type-of index)
			  index)))
      )
    )
  )

(defun debug-mode-name (&optional noerror)
  (if noerror
      (disable-debug-on-error)
    (enable-debug-on-error))

  (let* (
         (flattened         (flatten-tree mode-name))
         (flattened-len     (length flattened))
         (mode-name-len     (length mode-name))
         (items             (seq-map-indexed #'map-callback-debug-maybe-indexed mode-name))
         (flattened-items   (seq-map-indexed #'map-callback-debug-maybe-indexed flattened))
         (meta-result (list))
         (result "")
         )

    (setq meta-result
          (seq-map-indexed #'debug-sym-indexed
                           (list
                            'mode-name
	                    'mode-name-len
	                    'items
                            )
                           )
          ); end (setq meta-result)
    (setq result (string-join meta-result "\n")) ;end (setq result)

    (erase-c-messages)
    (c-message-open)
    (c-message "\nresult:\n%s\n" result)

    (let* (
           (total-pairs (/ flattened-len 2))
           (flattened-key-values (mapcar (lambda (n)
                                           (let* (
                                                  (key   (nth (+ n 0) flattened))
                                                  (value (nth (+ n 1) flattened))
                                                  )
                                             (list key value)))
                                         (number-sequence 0 total-pairs 2)))
           (flattened-string-lines (string-join (seq-map-indexed (lambda (item index)
                                                                   (let* (
                                                                          (key (car item))
                                                                          (value (cadr item))
                                                                          )
                                                                     (format "[%4d]  key: %S\nvalue: %S" index key value)
                                                                     )
                                                                   )
                                                                 flattened-key-values)
                                                "\n"))
           )

      (seq-map-indexed #'debug-sym-indexed
                       (list 'flattened
                             'flattened-len
                             'flattened-items
                             'flattened-key-values
                             ))
      ) ;end (let* )
    ) ;end (let* )


  ) ;end (defun debug-mode-name ())
