(defclass buffer-info ()
  ((name :initarg :name
	      :type (or integer marker)
	      :documentation "the `point' within the searched `buffer' (integer or marker) to the name of a successful search result"
	      :writer buffer-info-set-name
	      :reader buffer-info-get-name)
   (end :initarg :end
	:type (or integer marker)
	:documentation "the `point' within the searched `buffer' (integer or marker) to the end of a successful search result"
	:writer buffer-info-set-end
	:reader buffer-info-get-end)
   (filename :initarg :filename
	      :type (or null nil string)
	      :documentation "the filename of a successful search (either :forward or :backward)"
	      :writer buffer-info-set-filename
	      :reader buffer-info-get-filename)
   (query :initarg :query
	  :type string
	  :documentation "the \"string\" used in the search. if `:type' is `'regexp' then `:query' is a regular-expression written in the \"string\" syntax since that's the format used in `isearch-regexp-forward' and `isearch-regexp-forward'"
	  :writer buffer-info-set-query
	  :reader buffer-info-get-query)
   (type :initarg :type
	 :type (member :regexp :string 'regexp 'string)
	 :documentation "the type of a buffer-info (either `'regexp' or `'string'"
	 :writer buffer-info-set-type
	 :reader buffer-info-get-type))
  )


(defun make-buffer-info (beg end filename query type)
  "creates a new `buffer-info' object"
  (make-instance 'buffer-info
		 :name beg
		 :end end
		 :filename filename
		 :query query
		 :type type))
