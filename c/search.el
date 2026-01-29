;; MP""""""`MM                                     dP
;; M  mmmmm..M                                     88
;; M.      `YM .d8888b. .d8888b. 88d888b. .d8888b. 88d888b.
;; MMMMMMM.  M 88ooood8 88'  `88 88'  `88 88'  `"" 88'  `88
;; M. .MMM'  M 88.  ... 88.  .88 88       88.  ... 88    88
;; Mb.     .dM `88888P' `88888P8 dP       `88888P' dP    dP
;; MMMMMMMMMMM

(defclass search-info ()
  ((beginning :initarg :beginning
	      :type (or integer marker)
	      :documentation "the `point' within the searched `buffer' (integer or marker) to the beginning of a successful search result"
	      :writer search-info-set-beginning
	      :reader search-info-get-beginning)
   (end :initarg :end
	:type (or integer marker)
	:documentation "the `point' within the searched `buffer' (integer or marker) to the end of a successful search result"
	:writer search-info-set-end
	:reader search-info-get-end)
   (direction :initarg :direction
	      :type (member :forward :backward)
	      :documentation "the direction of a successful search (either :forward or :backward)"
	      :writer search-info-set-direction
	      :reader search-info-get-direction)
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


(defun make-search-info (beg end direction query type)
  "creates a new `search-info' object"
  (make-instance 'search-info
		 :beginning beg
		 :end end
		 :direction direction
		 :query query
		 :type type))

(defun get-recent-regexp-search-string-if-results()
  (let (beg end direction
	    (latest-regexp-search (car regexp-search-ring)))
    (when (stringp latest-regexp-search)
      (or
       (save-mark-and-excursion
	 (widen)
	 (and
	  (setq end (re-search-forward latest-regexp-search nil t))
	  (setq beg (match-beginning 0))
	  (setq direction :forward)
	  (search-info :beginning beg
		       :end end
		       :direction direction
		       :query latest-regexp-search
		       :type 'regexp)))
       (save-mark-and-excursion
	 (widen)
	 (and
	  (setq end (re-search-backward latest-regexp-search nil t))
	  (setq beg (match-beginning 0))
	  (setq direction :backward)
	  (search-info :beginning beg
		       :end end
		       :direction direction
		       :query latest-regexp-search
		       :type 'regexp)))))))

(defun get-recent-literal-search-string-if-results()
  (let (beg end direction (latest-literal-search (car search-ring)))
    (when (stringp latest-literal-search)
      (or
       (save-mark-and-excursion
	 (widen)
	 (and
	  (setq end (search-forward latest-literal-search nil t))
	  (setq beg (match-beginning 0))
	  (setq direction :forward)
	  (search-info :beginning beg
		       :end end
		       :direction direction
		       :query latest-literal-search
		       :type 'literal)))
       (save-mark-and-excursion
	 (widen)
	 (and
	  (setq end (search-backward latest-literal-search nil t))
	  (setq beg (match-beginning 0))
	  (setq direction :backward)
	  (search-info :beginning beg
		       :end end
		       :direction direction
		       :query latest-literal-search
		       :type 'literal)))))))

(defun get-search-info-from-isearch-rings()
  "returns a `search-info' if the latest query in either `regexp-search-ring' or `search-ring' provided at least one of the rings are non-empty"
  (or
   (get-recent-regexp-search-string-if-results)
   (get-recent-regexp-search-string-if-results)))


(defun g/search()
  "searches the current buffer like a G.
  if region is active, places string within region in `regexp-search-ring' otherwise invokes `isearch-edit-string';
  then performs search with `isearch-forward-regexp', if nothing is found then performs `isearch-backward-regexp'.
  if neither search yields result then tries to search using `isearch-forward' and `isearch-backward' instead.
"
  (interactive)
  (let* ((info nil)
	 (search-input
	  (or
	   (when (region-active-p)
	     (save-mark-and-excursion
	       (buffer-substring-no-properties
		(region-beginning)
		(region-end)))
	     ;; end when region-active-p
	     )
	   (when (setq info (get-search-info-from-isearch-rings))
	     (search-info-get-query info))
	   (progn
	     (isearch-edit-string)

	     ;; try to forward search: option 1
	     (if isearch-other-end (goto-char isearch-other-end))
	     (isearch-search)
	     (isearch-push-state)
	     (isearch-update)

	     ;; try to forward search: option 2
	     (isearch-search-and-update)
	     (isearch-repeat-forward)
	     (setq info (get-search-info-from-isearch-rings))
	     (search-info-get-query info))))); end let* varlist
    (if (search-info-p search-input)
	(message "g/searching %s with %S"
		 (search-info-get-direction info)
		 search-input))); end (let*
  ); end defun g/search
