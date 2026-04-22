(defmacro save-match-data-excursion-and-restriction (&rest body)
  `(save-match-data
    (save-mark-and-excursion
     (save-restriction
      ,@body))))
