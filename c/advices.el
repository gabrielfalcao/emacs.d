;; (defadvice switch-to-buffer (before existing-file activate compile)
;;   "when interactive, try to auto-complete to existing file first."
;;   (interactive
;;    (list
;;     (find-file-read-args "Find file: "
;;                          (read-buffer "Find file: "
;;                                       (existing-file-current-buffer)
;;                                       (null current-prefix-arg))))))
