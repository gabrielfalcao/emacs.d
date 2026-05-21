;;;;;; (defadvice switch-to-buffer (before existing-file activate compile)
;;;;;;   "when interactive, try to auto-complete to existing file first."
;;;;;;   (interactive
;;;;;;    (list
;;;;;;     (find-file-read-args "Find file: "
;;;;;;                          (read-buffer "Find file: "
;;;;;;                                       (existing-file-current-buffer)
;;;;;;                                       (null current-prefix-arg))))))
;;;;(defun advise-replace-regexp-before-call (regexp to-string &rest args)
;;;;  (c-message "isearch-forward-regexp called with args: `%S'" args))
;;;;
;;;;(advice-add #'replace-regexp :before #'advise-replace-regexp-before-call)
;;;;
;;;;(defun advise-isearch-forward-regexp-before-call (&rest args)
;;;;  (c-message "isearch-forward-regexp called with args: `%S'" args))
;;;;
;;;;(advice-add #'isearch-forward-regexp :before #'advise-isearch-forward-regexp-before-call)
;;;;
