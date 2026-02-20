(defun get-indent-for-depth (depth &optional indentation-string)
  (unless (stringp indentation-string)
    (setq indentation-string "    "))

  (unless (integerp depth) (setq depth 0))
  (or
   (and (> depth 0) (string-join (make-list depth "    ") ""))
   ""))

(defun ensure-server--step-function-return-value()
  (list :value nil :error nil))



(defun require-nonempty-string-value (value arg-name)
  (let (
        (orig-value value)
        (trimmed (substring-no-properties (string-trim (format "%s" value))))
        )
  (unless (stringp value)
    (signal 'type-error
            (format "arg `%s' should be a string but is %s: %S"
                    arg-name
                  (type-of value)
                  value)))

  (unless (length> value 0)
    (signal 'type-error
          (format "arg `%s' should not be an empty string" arg-name)))))

(defun format-string-or-list(elt &optional depth)
  (unless (and (integerp depth)
               (>= depth 0))
    (setq depth 0))
  (let ((padding-left (get-indent-for-depth depth)))

  (cond ((stringp elt)
         (format "%s%s" padding-left elt))

        ((and (or (listp elt)
                  (consp elt)))
         (seq-map-indexed (lambda (elt index)
                            (format-obj elt (format "%s" index) (+ 1 depth)))))

        (t (format "%s%s(type %s)"  padding-left elt (type-of elt)))
        )
  ))

(defun format-obj (obj label &optional depth)
  (require-nonempty-string-value label "label")
  (unless (and (integerp depth)
               (>= depth 0))
    (setq depth 0))

  (let* (
         (pair (list label obj))
         (items-to-join (mapcar
                         (lambda (elt)
                           (format-string-or-list elt (+ 1 depth)))
                         pair))
         (filtered-items  (seq-filter
                           (lambda (elt) (length> elt 0))
                           items-to-join))
         )
    (string-join filtered-items "")))

(defun c-message-print-obj(obj label)
  (require-nonempty-string-value label "label")
  (c-message "%s" (format-obj obj label)))


(defun ensure-server--configure-var-settings(pid timestamp tty)
  (let ((result (ensure-server--step-function-return-value))
        (settings '('(server-socket-dir "~/.emacs.d/socket"))))
    (mapc
     (lambda (symbol-and-value)
       (c-message "%S" symbol-and-value)
       (c-message "%S" (type-of symbol-and-value))
       (c-message "%S" (car symbol-and-value))
       ;; (let* (
       ;;       (sym-quoted (car symbol-and-value))
       ;;       (value (cadr symbol-and-value))
       ;;       (sym (symbol-value sym-quoted))
       ;;       )
       ;;   )
       )
     settings)))



(defun ensure-server--force-reboot(pid timestamp tty)
  (let ((result (ensure-server--step-function-return-value)))
    (condition-case server-reboot-error
        (put result :value (server-reboot))
      (error (put result :error server-reboot-error)))
    result))


(defconst ensure-server-ready-step-functions
  (list
   #'ensure-server--configure-var-settings
   ;; #'ensure-server--force-reboot)
   ))

(defun ensure-server-ready()
  (let ((pid (emacs-pid))
        (now (string-to-number (format-time-string "%s")))
        (tty (get-device-terminal nil)))
    (mapcar
     (lambda (step-fn) (funcall step-fn pid now tty))
     ensure-server-ready-step-functions)))

;; (progn
;;   (erase-c-messages)
;;   (c-message-open "")
;;   (ensure-server-ready))
