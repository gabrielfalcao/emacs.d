(defclass buffer-info ()
  ((name :initarg :name
	      :type (or integer marker)
	      :documentation "the `point' within the searched `buffer' (integer or marker) to the name of a successful search result"
	      :writer buffer-info-name-set
	      :reader buffer-info-name)
   (path :initarg :path
	      :type (member :forward :backward)
	      :documentation "the path of a successful search (either :forward or :backward)"
	      :writer search-info-set-path
	      :reader search-info-get-path)
   (is-file :initarg :is-file
	  :type string
	  :documentation "the \"string\" used in the search. if `:type' is `'regexp' then `:is-file' is a regular-expression written in the \"string\" syntax since that's the format used in `isearch-regexp-forward' and `isearch-regexp-forward'"
	  :writer search-info-set-is-file
	  :reader search-info-get-is-file)
   (query :initarg :query
	  :type string
	  :documentation "the \"string\" used in the search. if `:type' is `'regexp' then `:query' is a regular-expression written in the \"string\" syntax since that's the format used in `isearch-regexp-forward' and `isearch-regexp-forward'"
	  :writer search-info-set-query
	  :reader search-info-get-query)
   (type :initarg :type
	 :type (member :regexp :string 'regexp 'string)
	 :documentation "the type of a search-info (either `'regexp' or `'string'"
	 :writer search-info-set-type
	 :reader search-info-get-type))
  )


(defun make-search-info (beg end path query type)
  "creates a new `search-info' object"
  (make-instance 'search-info
		 :name beg
		 :end end
		 :path path
		 :query query
		 :type type))
