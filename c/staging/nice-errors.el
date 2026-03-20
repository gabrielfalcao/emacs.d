(define-error 'type-error "Type Error" 'error)
(define-error 'type-error-internal "Type Error " 'error)

(defun type-error (message &optional expected-types actual-type value)
  (unless (stringp message)
    (signal 'type-error
            (format  "argument `message' must be string but instead received `%s': %s"
                     (type-of message)
                     message)))

  (let* ((props (list)))
    (cl-typecase expected-types
      (cl-type symbol (push props


  (signal 'type-error message))


(defun indefinite-article-from-noun (noun-or-displayable)
  (let* ((noun (cl-typecase noun-or-displayable
                 (string (substring-no-properties noun-or-displayable))
                 (symbol (symbol-name noun-or-displayable))
                 (t (signal

                 ((stringp noun-or-displayable) noun-or-displayable)
                     ((symbolp noun-or-displayable) (symbol-name noun-or-displayable))
                     ((functionp noun-or-displayable) (symbol-function noun-or-displayable)
  (cond
    (

    )
(defmacro require-arg-type (arg type)
  (let* (
         (arg-name (symbol-name arg))
         (type-name (symbol-name type))
         )
  `(unless (cl-typep ,arg ,type)
     (list 'signal 'type-error
             (format  "argument `%s' must be a `%s' but instead received a `%s': %s"
                      ,arg-name
                      ,type-name
                      (type-of ,arg)
                      ,arg)))))


(let* (
       ;; (arg "foo")
       (arg 222)
       (type 'string)
       )
  (erase-c-messages)
  (c-message-open "(require-arg-type arg type)\n\n%s\n"
                  (macroexpand-all (require-arg-type arg type))))
