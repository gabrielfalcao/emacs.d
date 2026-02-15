(defun shell-script-isearch-variable-names (&rest variable-names)
  (interactive)
  ;; (let* ((regexp  "\(^\|[^a-zA-Z0-9_{}()]\)\(argument\|script_name\|field\|key\|name\|path\|value\)\($\|[^a-zA-Z0-9_{}()]\)")))
  (with-isearch-suspended
   (let* ((message-log-max nil)
	  ;; Don't add a new search string to the search ring here
	  ;; in `read-from-minibuffer'. It should be added only
	  ;; by `isearch-update-ring' called from `isearch-done'.
	  (history-add-new-input nil)
	  ;; Binding minibuffer-history-symbol to nil is a work-around
	  ;; for some incompatibility with gmhist.
	  (minibuffer-history-symbol)
	  ;; Search string might have meta information on text properties.
	  (minibuffer-allow-text-properties t))
     (setq isearch-new-string
	   (minibuffer-with-setup-hook
               (minibuffer-lazy-highlight-setup)
             (read-from-minibuffer
	      (isearch-message-prefix nil isearch-nonincremental)
	      (cons isearch-string (1+ (or (isearch-fail-pos)
					   (length isearch-string))))
	      minibuffer-local-isearch-map nil
	      (if isearch-regexp
		  (cons 'regexp-search-ring
		        (1+ (or regexp-search-ring-yank-pointer -1)))
	        (cons 'search-ring
		      (1+ (or search-ring-yank-pointer -1))))
	      nil t))
	   isearch-new-message
	   (mapconcat 'isearch-text-char-description
		      isearch-new-string "")))))
