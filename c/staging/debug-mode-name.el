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
    ;; (c-message "\n(debug-sym-indexed '%s %d)\n\t%s\n" sym index line)
    line
    )
  )

(defun map-indexed-callback-debug (elt &optional index)
  (let* (
         (elt-type (cl-type-of elt))
         )

    (pcase index

      ((and (pred integerp)
            (pred (>= _ 0)))
       (format "%4d %S: %S" index elt-type elt))

      ((pred null)
       (format "%S: %S" elt-type elt))

      (_ (signal 'type-error
                 (format  "`map-indexed-callback-debug' argument `index' must be either `nil' or a non-negative integer, but instead received `%s': %S"
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
         (items             (seq-map-indexed #'map-indexed-callback-debug mode-name))
         (flattened-items   (seq-map-indexed #'map-indexed-callback-debug flattened))
         (meta-result       (seq-map-indexed #'debug-sym-indexed
				             (list
					      'mode-name
					      'mode-name-len
					      'items
					      )
					     ))
         (result (string-join meta-result "\n"))
         (total-flattened-pairs (/ flattened-len 2))
         (flattened-key-values (mapcar (lambda (n)
                                         (let* (
                                                (key   (nth (+ n 0) flattened))
                                                (value (nth (+ n 1) flattened))
                                                )
                                           (list key value)))
                                       (number-sequence 0 total-flattened-pairs 2)))
         (flattened-string-lines (seq-map-indexed
                                  (lambda (item index)
                                    (let* (
                                           (key (car item))
                                           (value (cadr item))
                                           (line (format "%s [key (%S) => %S] value (%S) => %S"
                                                         (format "[%d]" index)
                                                         (cl-type-of key) key
                                                         (cl-type-of value) value
                                                         ))
                                           )
                                      ;; (c-message "%s" line)
                                      line
                                      )
                                    )
                                  flattened-key-values))
         (flattened-string-output (string-join flattened-string-lines "\n"))
         (flattened-sym-list (list 'flattened
                                   'flattened-len
                                   'flattened-items
                                   'flattened-key-values))
         (flattened-meta-result (seq-map-indexed #'debug-sym-indexed flattened-sym-list))
         ) ; end (let* varlist)

					; start (let* ) body
    (erase-c-messages)
    (c-message-open)
    (c-message "\n(list 'mode-name 'mode-name-len 'items)\n%s\n"
               (string-join
                (seq-map-indexed (lambda (line index) (format "%4s%s" " " (1+ index) line))
                                 meta-result)
                "\n"
                ))


    (c-message "\n(list 'flattened-len 'flattened-items 'flattened-key-values)\n%s\n"
               (string-join (seq-map-indexed (lambda (line index) (format "%4s%s" " " (1+ index) line))
                                             flattened-meta-result)
                            "\n")
               )
					; end (let* ) body
    ) ;end (let* )
  ) ;end (defun debug-mode-name ())
