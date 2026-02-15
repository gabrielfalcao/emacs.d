;; ADVICES
;; =======
;;
;; create new lisp types (structs or classes)
;; ------------------------------------------
;;
;; buffer-info
;; +++++++++++
;;
;; -[ ] buffer-name,
;; -[ ] point-min,
;; -[ ] point-max,
;; -[ ] widen-point-min,
;; -[ ] widen-point-max,
;; -[ ] buffer-length,
;; -[ ] buffer-mode-name
;; -[ ] created-at (timestamp)
;; -[ ] last-modified-at (timestamp)
;; -[ ] modified-at-list (list of timestamps of each time the buffer was modified)
;; -[ ] last-switched-to-at (timestamp)
;; -[ ] switched-to-at-list (list of timestamps of each time the buffer was switched-to via #'switch-to-buffer and so on)
;; -[ ] last-saved-at (timestamp)
;; -[ ] saved-at-list (list of timestamps of each time the buffer was saved via #'save-buffer)
;;
;;
;; buffer-local vars
;; =================
;;
;; - buffer-info
;;
;; GLOBAL VARS
;; ===========
;;
;; - list of 'buffer-info list of references to each buffer's `buffer-info'
;;
;;
;; ADVICE FUNCTION LIST
;; ====================
;;
;; file/buffer  ;; context-switching
;; -----------
;;
;; - [ ] #'switch-to-buffer [buffer-info: buffer-name, point-min, point-max, widen-point-min, widen-point-max, buffer-length, buffer-mode-name
;;
;; - [ ] #'find-file (filename, buffer-length
;;
;;
;;
;; keylogger:
;;
;; - [ ] #'self-insert-command


;;;;; ;;;;; ;;;;; ;;;;; ;;;;; ;;;;; TODO ;;;;; ;;;;; ;;;;;  ;;;;; ;;;;;
;;;;;
;;;;; (progn ;; isearch-printing-char
;;;;;   ;; (isearch-printing-char &optional CHAR COUNT)
;;;;;
;;;;;   (defun log-isearch-printing-char (&optional char count)
;;;;;     ;; log-char
;;;;;     )
;;;;;   (advice-add 'isearch-printing-char :filter-return #'log-isearch-printing-char))
;;;;;
;;;;;
;;;;; (progn ;; isearch-delete-char
;;;;;   ;; (isearch-delete-char)
;;;;;
;;;;;   (defun log-isearch-delete-char ()
;;;;;     ;; log-char
;;;;;     )
;;;;;   (advice-add 'isearch-delete-char :filter-return #'log-isearch-delete-char))
;;;;;
;;;;;
;;;;; (progn ;; isearch-repeat-forward
;;;;;   ;; (isearch-repeat-forward &optional arg)
;;;;;
;;;;;   (defun log-isearch-repeat-forward ( &optional arg)
;;;;;     ;; log-char
;;;;;     )
;;;;;   (advice-add 'isearch-repeat-forward :filter-return #'log-isearch-repeat-forward))
;;;;;
;;;;; (progn ;; isearch-repeat-backward
;;;;;   ;; (isearch-repeat-backward &optional arg)
;;;;;
;;;;;   (defun log-isearch-repeat-backward ( &optional arg)
;;;;;     ;; log-char
;;;;;     )
;;;;;   (advice-add 'isearch-repeat-backward :filter-return #'log-isearch-repeat-backward))
;;;;;
;;;;;
;;;;;
;;;;; ;; isearch--state is a type (of kind ‘cl-structure-class’) in ‘isearch.el’.
;;;;; ;;  Inherits from ‘cl-structure-object’.
;;;;; ;; Instance Allocated Slots:
;;;;;
;;;;; ;; 	Name	Type	Default
;;;;; ;; 	————	————	———————
;;;;; ;; 	string		nil
;;;;; ;; 	message		nil
;;;;; ;; 	point		nil
;;;;; ;; 	success		nil
;;;;; ;; 	forward		nil
;;;;; ;; 	other-end		nil
;;;;; ;; 	word		nil
;;;;; ;; 	error		nil
;;;;; ;; 	wrapped		nil
;;;;; ;; 	barrier		nil
;;;;; ;; 	case-fold-search		nil
;;;;; ;; 	pop-fun		nil
;;;;; ;; 	match-data		nil
;;;;;
;;;;; ;; Specialized Methods:
;;;;;
;;;;; ;; ‘cl-print-object-contents’ ((object cl-structure-object) start stream)
;;;;;
;;;;;
;;;;; ;; ‘cl-print-object’ ((object cl-structure-object) stream)
;;;;;
;;;;; ;; [back]
;;;;;
