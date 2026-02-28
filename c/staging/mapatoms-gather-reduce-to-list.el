(defvar all-atoms-list (list))
(defun atom-hash-cmp (obj1 obj2)
  (let* (
         (obj1-ty (type-of obj1))
         (obj2-ty (type-of obj2))
         (
(defvar all-atoms-hash (make-hash-table ))

(defvar gathering-count 0)
(defvar gathering-index 0)

(defun for-each-atom (val)
  (let* (
         (ty             (type-of val))
         (index          (+ gathering-index 0))
         (pos            (+ gathering-index 1))
         (id             (format "atom@%d" pos))
         (name           (cond ((symbolp val) (symbol-name val))
                               (            t (format "atom@%d#%s" pos ty))
                               ))
         )
    (setq gathering-index (1+ gathering-index))
    )
  )
(mapatoms #'for-each-atom)
