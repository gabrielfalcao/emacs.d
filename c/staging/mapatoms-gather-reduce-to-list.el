(let (
      (all-atoms-list (list))
      (all-strings-list (list))
      (all-symbols-list (list))
      (all-functions-list (list))
      (all-vectors-list (list))
      (all-hash-tables-list (list))
      (all-lists-list (list))
      (all-sequences-list (list))
      (gathering-index 0)
      )

  (mapatoms #'(lambda (val)
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
		  (let ((info (list
			       :ty ty
			       :index index
			       :pos pos
			       :id id
			       :name name
			       :name-and-id name-and-id
			       :repr repr
			       )))
		    (push info all-atoms-list)
                    (cond nil
                          ((functionp val)      (push info all-functions-list))
                          ((symbolp val)        (push info  all-symbols-list))
                          ((stringp val)        (push info  all-strings-list))
                          ((vectorp val)        (push info  all-vectors-list))
                          ((hash-table-p val)   (push info  all-hash-tables-list))
                          ((listp val)          (push info  all-lists-list))
                          ((sequencep val)      (push info  all-sequences-list))
			  )
		    )
                  )
		)
	    )
  )
