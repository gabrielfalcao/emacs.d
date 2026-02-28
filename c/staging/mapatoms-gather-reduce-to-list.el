(defun gather-atoms ()
  (let (
	(all-atoms-list (list))
	(all-strings-list (list))
	(all-symbols-list (list))
	(all-functions-list (list))
	(all-vectors-list (list))
	(all-hash-tables-list (list))
	(all-lists-list (list))
	(all-sequences-list (list))
	(all-uncategorized-list (list))
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
                      (cond ((functionp val)      (push info all-functions-list))
                            ((symbolp val)        (push info  all-symbols-list))
                            ((stringp val)        (push info  all-strings-list))
                            ((vectorp val)        (push info  all-vectors-list))
                            ((hash-table-p val)   (push info  all-hash-tables-list))
                            ((listp val)          (push info  all-lists-list))
                            ((sequencep val)      (push info  all-sequences-list))
                            (t (push info all-uncategorized-list))
			    )
		      )
                    )
		  )
	      ); end mapatoms
    (erase-c-messages)
    (c-message-open)

    (seq-do-indexed
     (lambda (container index)
       (let* ((name (symbol-name container))
              (value (symbol-value container))
              (kind (save-match-data
                      (string-match "^\\(all-\\([a-z-]+\\)-list\\)$" name)
                      (match-string 2)))
              ); end (let* (...)) varlist
         (c-message "<%s count=\"%d\">" kind (length value))
         (c-message "%s" (string-join
                          (seq-map-indexed (lambda (item index)
                                             (format "    %d: %S" index item))
                                           value)
                          "\n"))
         (c-message "<%s>" kind)))
     (list 'all-atoms-list 'all-strings-list 'all-symbols-list 'all-functions-list 'all-vectors-list 'all-hash-tables-list 'all-lists-list 'all-sequences-list 'all-uncategorized-list)
     )
    );; end (let ...)  "defun body"
  );end defun gather-atoms
