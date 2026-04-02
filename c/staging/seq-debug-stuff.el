(defun repr-value (item) (format "%S" item))

;; ...TK: defmacro
;; (defun make-indent-function (&optional level indentation-string)
;;   (let* ((default-level                4)
;;          (default-indentation-string " ")
;;          (level (or (and (natnump level) level) default-level))
;;          (indentation-string
;;           (or
;;            (and
;;             (stringp indentation-string)
;;             (length> indentation-string 0))
;;            default-indentation-string)))
;;     (lambda (value)
;;       (let* ((indentation
;;               (string-join (make-list level indentation-string) "")))
;;         (format "%s%s" indentation value)))))

(defun indent-value (value)
  (format "%s%s" (string-join (make-list 4 " ") "") value))


(defun list-items-to-string-values (items)
  (unless (or (listp items) (consp items))
    (signal 'type-error
            (format "argument ITEMS is not a list `%s': %S"
                    (cl-type-of items)
                    items)))
  (mapcar #'repr-value items))


(defun indented-list-items (items)
  (string-join
   (mapcar
    #'indent-value
    (list-items-to-string-values items))
   "\n"))
