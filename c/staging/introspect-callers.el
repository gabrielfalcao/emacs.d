(defun dbg-pairs (count)
  (unless (integerp count)
    (signal 'type-error
      (format "function `dbg-pairs' argument `count' must be an integer but instead received `%s': %S"
        (type-of count)
        count)))
  (unless (>= count 0)
    (signal 'type-error
      (format "function `dbg-pairs' argument `count' must be a non-negative number but instead received: %S"
        count)))

  (let* ((items
           (seq-map-indexed
             (lambda (elt index) index)
             (make-list count t))))
    (seq-map-indexed
      (lambda (elt index)
        (format "index %S %% 2 => %S" index (% index 2)))
      items)))

(defun debug-syms (list-of-syms)
  (unless (listp list-of-syms)
    (signal 'type-error
      (format "function `debug-syms' argument `list-of-syms' must be a list of symbol objects but instead received `%s': %S"
        (type-of list-of-syms)
        list-of-syms)))
  (let* ((list-sym-count (length list-of-syms))
         (list-of-syms
           (seq-map-indexed
             (lambda (elt index)
               (let* ((current (+ index 1))
                      (count (* list-sym-count 1))
                      (pos (format "%s of %s" current count))
                      (ty (type-of elt))
                      sym
                      sym-repr
                      sym-value
                      sym-value-repr)
                 (unless (symbolp elt)
                   (signal 'type-error
                     (format "function debug-syms argument `list-of-syms' must be a list of symbols but its element at pos `%s' is not a symbol but rather a `%s': %s"
                       pos
                       (type-of elt)
                       (format "%S" elt))))

                 (setq sym elt
                   sym-repr
                   (format "%S" sym)
                   sym-value
                   (symbol-value sym)
                   sym-value-repr
                   (format "%s (%s): %S" sym ty sym-value))
                 (list
                   :sym
                   sym
                   :index
                   index
                   :current
                   current
                   :pos
                   pos
                   :count
                   count
                   :ty
                   ty
                   :name
                   (symbol-name sym)
                   :repr
                   sym-repr
                   :value
                   sym-value
                   :value-repr
                   sym-value-repr))) ; end (lambda (elt index) ...)
             list-of-syms))) ; end (let* (... list-of-syms (seq-map-indexed (...)) ; end (let* (... list-of-syms)) ;; end (debug-syms (let* ... )) varlist

    ;; <debug-syms effective-body>

    ;; </debug-syms effective-body>
    )) ;; (defun debug-syms ...)

;;;
;;;
;;; (let* (
;;;        (frames (backtrace-frame 3))
;;;        (frames-ty (type-of frames))
;;;        (frame-count (length frames))
;;;        (local-sym-list (list 'frames 'frames-ty 'frames-count))
;;;        (dbg-lines (debug-syms local-sym-list))
;;;        (linecount-dbg (length dbg-lines))
;;;        (pairs (list))
;;;        (tmp-key nil)
;;;        (tmp-value nil)
;;;        )
;;;   (erase-c-messages)
;;;   (c-message-open)
;;;   (seq-do-indexed (lambda (prop index)
;;;                     (when (% index 2
;;;                     (
;;;
;;;
;;;   )
;;;
