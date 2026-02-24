;; (defadvice switch-to-buffer (before existing-file activate compile)
;;   "when interactive, try to auto-complete to existing file first."
;;   (interactive
;;    (list
;;     (find-file-read-args "Find file: "
;;                          (read-buffer "Find file: "
;;                                       (existing-file-current-buffer)
;;                                       (null current-prefix-arg))))))
(defun advise-replace-regexp-before-call (regexp to-string &rest args)
  ;; (ignore-errors
  ;;   (erase-c-messages)
  ;;   (c-message-open "" ))
  (setq case-fold-search nil)
  (setq-default case-fold-search nil)
  ;; (c-message "replace-regexp called with REGEXP `%S' and TO-STRING `%S'" regexp to-string)
  (message "isearch-forward-regexp called with args: `%S'" args)
  )

(advice-add #'replace-regexp :before #'advise-replace-regexp-before-call)


(defun advise-isearch-forward-regexp-before-call (&rest args)
  ;; (ignore-errors
  ;;   (erase-c-messages)
  ;;   (c-message-open "" ))
  ;; (c-message "isearch-forward-regexp called with REGEXP `%S' and TO-STRING `%S'" regexp to-string)
  (setq case-fold-search t)
  (setq-default case-fold-search t)
  (message "isearch-forward-regexp called with args: `%S'" args)
  )

(advice-add #'isearch-forward-regexp :before #'advise-isearch-forward-regexp-before-call)
