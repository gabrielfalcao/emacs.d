(defvar all-atoms-list (list))
;; (defvar all-atoms-hash (make-hash-table))
(defvar gathering-index 0)

(defun for-each-atom (val)
  (let* (
         (ty             (type-of val))
         (index          (+ gathering-index 0))
         (pos            (+ gathering-index 1))
         (id             (format "atom@%d" pos))
         (name           (cond ((symbolp val) (symbol-name val))
                               (            t (format "unnamed#%s@%d" ty pod))))
         (name-and-id    (string-join (list (format "%s-%d" ty index) name ) ":::"))
         (repr           (format "%S" val))
         )
    (setq gathering-index (1+ gathering-index))
    (let ((atom-info (list
                      :ty ty
                      :index index
                      :pos pos
                      :id id
                      :name name
                      :name-and-id name-and-id
                      :repr repr
                      )))
      (push atom-info all-atoms-list)

    )
    )
  )
(mapatoms #'for-each-atom)
