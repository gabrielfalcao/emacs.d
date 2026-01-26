;; (defun describe (symbol-s)
;;   "makes a \"popup\" frame and calls `describe-symbol' in that popup window's buffer."
;;   (interactive
;;    (let* ((v-or-f (symbol-at-point))
;;           (found (if v-or-f (cl-some (lambda (x) (funcall (nth 1 x) v-or-f))
;;                                      describe-symbol-backends)))
;;           (v-or-f (if found v-or-f (function-called-at-point)))
;;           (found (or found v-or-f))
;;           (enable-recursive-minibuffers t)
;;           (val (completing-read (format-prompt "Describe symbol"
;;                                                (and found v-or-f))
;; 				#'help--symbol-completion-table
;; 				(lambda (vv)
;;                                   (cl-some (lambda (x) (funcall (nth 1 x) vv))
;;                                            describe-symbol-backends))
;; 				t nil nil
;; 				(if found (symbol-name v-or-f)))))
;;      (list (if (equal val "")
;; 	       (or v-or-f "") (intern val)))))
;;   (let* ((frm (let ((frm (make-frame)))
;;                 (select-frame frm)
;;                 frm))
;;          (wnd (frame-root-window frm))
;;          (buf (window-buffer wnd)))
;;     (describe-symbol symbol-s buf frm)))
