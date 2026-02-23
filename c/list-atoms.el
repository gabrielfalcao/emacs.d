(unless (functionp 'c-message)
  (defun c-message (fmt &rest args)
    (interactive "M")
    (apply #'message (append (list fmt) args))))

(unless (functionp 'erase-c-messages)
  (defun erase-c-messages (&optional dont-erase-minibuffer)
    "."
    (interactive)
    (erase-buffer-by-name  "*C-Messages*")
    (unless (not (null dont-erase-minibuffer)) (erase-minibuffer)))

  (defun erase-c-messages ()
    (apply #'message (append (list fmt) args))))



(defun formwat (sym)
  (format "type of %s: %s (type of type %s)" sym
          (type-of sym)
          (type-of (type-of sym))))
(defun wat (sym) (message "<wat>\n%s\n</wat>\n" (formwat sym)))


(defun list-atoms ()
  (let ((atoms-list (list)))
    (mapatoms (lambda (sym) (push sym atoms-list)))
    atoms-list))

(defvar list-atoms-cache (list-atoms))

(wat (car list-atoms-cache))


;;; (defun atoms-list ()
;;;   (let ((atoms-list (list)))
;;;     (mapatoms
;;;      (lambda (sym)
;;;        (let* (
;;;               (item (list :symbol sym))
;;;               (name "")
;;;               (ty "")
;;;               (name (condition-case symbol-name-err
;;;                         (setq item (append item (list :name (symbol-name sym) :symbol sym)
;;;                       (error
;;;                        (list :error symbol-name-err))
;;;        (push sym atoms-list)))
;;;     atoms-list))
;;;


;;; ;; (defun atoms-list ())
;;;
;;; ;; (let* ((atoms-index 0)
;;; ;;        (atoms-count 0)
;;; ;;        (atoms-list (list))
;;; ;;        (atoms-plist (list)) ;; same as (symbol-plist) ?
;;; ;;        )
;;; ;;   (mapatoms
;;; ;;    (lambda (sym)
;;; ;;      ;; (c-message "sym[%d of %d][type %S]" atoms-index atoms-count (type-of sym))
;;; ;;      (push sym atoms-list)
;;; ;;      (setq atoms-count (length atoms-list)))))
;;;
