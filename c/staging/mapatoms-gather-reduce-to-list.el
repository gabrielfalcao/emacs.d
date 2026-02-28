(defun getslots (obj1 obj2)
  (let (
        (getslots-result nil)
        (getslots-error  nil)
        )
    (condition-case no-slots-err
        (let (
              (slots1 (object-public-slots obj1))
              (slots2 (object-public-slots obj2))
              count1 count2
              )
          (setq
           count1 (length slots1)
           count2 (length slots2)
           )
          (setq getslots-result
                (list
                 :slots1 slots1
                 :slots2 slots2
                 :count1 count1
                 :count2 count2
                 ))
          )
      (error
       (setq getslots-error no-slots-err))
      )

    (list
     :result getslots-result
     :error getslots-error)
    )
  )

(defvar all-atoms-list (list))
(defun atom-hash-cmp (obj1 obj2)
  (catch 'not-equal
    (let* (
           (ty1 (type-of obj1))
           (ty2 (type-of obj2))
           )
      (unless (equal ty1 ty2)
        (throw 'not-equal t))
      )

    (when (stringp obj1)
      (unless (string= obj1 obj2)
        (throw 'not-equal t)))

    (when (or (number-or-marker-p obj1)
              (floatp obj1))
      (unless (eql obj1 obj2)
        (throw 'not-equal t)))

    (progn ; check slots of object defined with defclass
      (let (
            (slots (getslots obj1 obj2))
            )
        )
      ) ;; end progn
    )
  )


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
