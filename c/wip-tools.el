(defconst atom-info-plist-keys
  (list
    :index
    :name
    :atom
    :atom-type
    :error
    :error-type
    :value
    :value-type
    :value-length))

(defun get-all-lists-from-mapatoms ()
  (interactive)
  (let ((only-list-atoms (seq-filter
                          (lambda (atom)
                            (let* (
                                   (name (plist-get atom :name))
                                   (value (plist-get atom :value))
                                   (value-type (plist-get atom :value-type))
                                   (value-error (plist-get atom :value-error))) ;; end (let* (...varlist...))
                              (and
                                (null value-error)
                                (listp value)))) ;; end  (let* ...) ;; end (lambda (atom) ...)
                          (internal-atoms-plist)))) ;; end seq-filter ;; end let ((only-list-atoms ...)) ;; end let (...varlist...)
    only-list-atoms)) ;; end (let ...) ;; end (defun debug-atoms-when-sym-name-includes-history-and-ty-alist() ...)

(defun main()
  (interactive)
  (print-all-hist-alist-variables))

(defun print-all-hist-alist-variables ()
  (interactive)
  (erase-c-messages)
  (let* (
         (callers (backtrace-frame 4))
         (total-callers (length callers))
         (debug-items (string-join
                       (append (list "")
                         (seq-map-indexed (lambda (caller index)
                                           (let* (
                                                  (caller-num (+ index 1))
                                                  (caller-type (type-of caller))
                                                  (position (format "%d of %d" caller-num total-callers)))

                                             (format "        <caller position=\"%s\" type=\"%s\">%S</caller>" position caller-type caller)))
                           callers)
                         (list "" "\n"))
                       "\n"))
         (atoms (get-all-lists-from-mapatoms)))
    (erase-c-messages)
    (c-message-open "")
    (c-message-debug-symbols (list 'callers 'debug-items 'atoms) 'total-callers)))

(main)

(defun print-atom (atom atom-index)
  (erase-c-messages)
  (let ((caller (backtrace-frame 1)))
    (c-message"\n%s\n" (string-join
                        (seq-map-indexed (lambda (atom index)
                                          (let (
                                                (name (plist-get atom :name))
                                                (value (plist-get atom :value))
                                                (value-ty (plist-get atom :value-type)))
                                            (format "<%s index=\"%d\">\n%S\n</%s>\n\n" name index value name)))
                          (debug-atoms-when-sym-name-includes-history-and-ty-alist))
                        "\n"))))

(defun variable-appears-to-be-history-alist(name value)
  (unless (stringp name)
    (signal 'type-error
      (format "`name' should be a string not %s: %s"
        (type-of name)
        name)))
  ;; (unless (listp value)
  ;;   (signal 'type-error
  ;;           (format "`value' should be a list not %s: %s"
  ;;                   (type-of value)
  ;;                   value)))
  (and
    (listp value)
    (or (string-search "-alist" name)
      (string-search "-history" name)
      (string-search "-hist" name))))
(defun debug-atoms-when-sym-name-includes-history-and-ty-alist ()
  (interactive)
  (let ((atoms
          (seq-filter
            (lambda (atom)
              (let* (
                     (name (plist-get atom :name))
                     (value (plist-get atom :value))
                     (value-type (plist-get atom :value-type))
                     (value-error (plist-get atom :value-error))) ;; end (let* (...varlist...))

                (and
                  ;; :index
                  ;; :name
                  ;; :atom
                  ;; :atom-type
                  ;; :error
                  ;; :error-type
                  ;; :value
                  ;; :value-type
                  ;; :value-length
                  (null value-error)
                  (listp value)))) ;; end  (let* ...) ;; end (lambda (atom) ...)

            (internal-atoms-plist)))))) ;; end seq-filter ;; end let ((atoms ...)) ;; end let (...varlist...) ;; end (let ...) ;; end (defun debug-atoms-when-sym-name-includes-history-and-ty-alist() ...)

(defun internal-atoms-plist ()
  (let (
        (internal-atoms-list-result (list))
        (atoms-by-index (list))
        (index -1))
    (mapatoms (lambda (sym)
               (let* (
                      (index (setq index (+ 1 index)))
                      (name (symbol-name sym))
                      (atom-result (let (
                                         (result (list)))
                                    (progn
                                      (push (cons :index index) atom-result)
                                      (push (cons :name name) atom-result)
                                      (push (cons :atom sym) atom-result)
                                      (push (cons :atom-type (type-of sym)) atom-result)
                                      (push (cons :symbol sym) atom-result)
                                      (push (cons :symbol-type (type-of sym)) atom-result)

                                      result)))
                      (value-and-error (condition-case symbol-value-err
                                        (cons (symbol-value sym) nil)
                                        (error
                                          (cons nil symbol-value-err))))
                      (value (car value-and-error))
                      (error-obj (cadr value-and-error))) ;; end (let* ...varlist...)

                 (if (null error-obj)
                   (progn ;; then
                     (push (cons :value value) atom-result)
                     (push (cons :value-type (type-of value)) atom-result)
                     (push (cons :value-length (condition-case value-length-err (length value) (error nil))) atom-result)
                     (push (cons :value-error nil) atom-result)
                     (push (cons :error nil) atom-result)
                     (push (cons :error-type nil) atom-result))
                   (progn ;; else
                     (push (cons :value nil) atom-result)
                     (push (cons :value-type nil) atom-result)
                     (push (cons :value-length nil) atom-result)
                     (push (cons :value-error error-obj) atom-result)
                     (push (cons :error error-obj) atom-result)
                     (push (cons :error-type (type-of error-obj)) atom-result))) ;; end if
                 (push atom-result internal-atoms-list-result)))) ;; end (let* ...) ;; end (mapatoms (lambda (sym) ...)) ;; end (mapatoms ...)
    ;; below, return the resulting list of plists with atom metadata
    internal-atoms-list-result)) ;; end (defun internal-atoms-plist() (let ...))

(defun debug-replace-regexp-history()
  (interactive)
  (let* (
         (query-replace-to-history-sym-value (symbol-value query-replace-from-history-variable))
         (query-replace-from-history-sym-value (symbol-value query-replace-from-history-variable)))
    (erase-c-messages)
    (c-message-open "")
    (c-message "query-replace-to-history-variable: %s %s"
      (type-of query-replace-to-history-list-value)
      (length query-replace-to-history-list-value))
    (c-message "query-replace-from-history-variable: %s %s"
      (type-of query-replace-from-history-list-value)
      (length query-replace-from-history-list-value))))

(defun debug-variable (variable-name variable-value)
  (unless (stringp variable-name)
    (signal 'type-error
      (format "`variable-name' should be a string not %s: %s"
        (type-of variable-name)
        variable-name)))
  (let* (
         (frame-max-width (- (frame-width) (- 5 (% (frame-width) 2))))
         (frame-max-height (- (frame-height) (- 5 (% (frame-height) 2))))
         (variable-value-type (type-of variable-value))
         (variable-value-string-prefix "   variable-value: ")
         (variable-value-string-prefix-len (length variable-value-string-prefix))
         (variable-value-available-width (- frame-max-height variable-value-string-prefix-len))
         (variable-value-to-string-raw (format "%S" variable-value))
         (variable-value-to-string-raw-len (length variable-value-to-string-raw))
         (variable-value-display-len (+ variable-value-string-prefix-len variable-value-to-string-raw-len))
         (variable-value-display-trucate-delta (/ variable-value-to-string-raw-len 2))
         (variable-value-half-available-width (/ variable-value-available-width 2))
         (variable-value-to-string (if (>= variable-value-to-string-raw-len variable-value-available-width)
                                    (format "%s..." (substring-no-properties
                                                     variable-value-to-string-raw
                                                     0
                                                     (- variable-value-half-available-width 3)))
                                    variable-value-to-string-raw))

         (is-symbol (symbolp variable-value))
         (symbol-name-and-val (or (and is-symbol
                                   (cons (symbol-name variable-value) (symbol-value variable-value)))
                               nil))
         (name (when is-symbol (car symbol-name-and-val)))
         (value (when is-symbol (cadr symbol-name-and-val)))
         (c-message-lines (list
                           "(debug-variable variable-name variable-value)"
                           "where"
                           (format "   variable-name: %S" variable-name)
                           (format "   variable-value: %s" variable-value-to-string)
                           (format "     ; type-of variable-value: %S" variable-value-type))))

    (c-message
      "%s"
      (string-join c-message-lines "\n"))))
