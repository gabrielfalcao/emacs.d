;; (defmacro switch (value &optional body &rest :test #'eq)
;;   (let ((tempvar (make-symbol "max")))



;; (defalias 'fix-node-info
;;   (kmacro "C-s N o d e I n f o SPC { M-b C-SPC C-n C-n C-a C-s s t r i n g : SPC \" C-b C-w s t u b _ i n <backspace> <backspace> n o d e _ i n t <backspace> f o ( & i n p u t , SPC C-e C-b C-SPC C-n C-a C-s l i n e C-f C-w , SPC ( C-s c o l u m n M-b C-SPC M-f C-f C-f C-w M-f C-k ) , C-SPC C-n C-a C-s l i n e C-f C-w ( C-s c o l M-f C-f C-SPC M-b C-w M-f C-k ) ) ) , C-n C-a C-SPC C-n C-s } , ) , C-f C-w"))


;; TODO: learn what is `macroexp
;; (defmacro push (newelt place)
;;   "Add NEWELT to the list stored in the generalized variable PLACE.
;; This is morally equivalent to (setf PLACE (cons NEWELT PLACE)),
;; except that PLACE is evaluated only once (after NEWELT)."
;;   (declare (debug (form gv-place)))
;;   (if (symbolp place)
;;       ;; Important special case, to avoid triggering GV too early in
;;       ;; the bootstrap.
;;       (list 'setq place
;;             (list 'cons newelt place))
;;     (require 'macroexp)
;;     (macroexp-let2 macroexp-copyable-p x newelt
;;       (gv-letplace (getter setter) place
;;         (funcall setter `(cons ,x ,getter))))))
