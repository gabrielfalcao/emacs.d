(erase-messages)
(setq debug-on-error t)

(defun debug-et-diagnostics-forward-search-macro()
  (interactive)
  (let ((regexp
         "\\(admonition\\|dbg\\([a-z_]+\\)?\\|filename\\|format_\\([a-z_]+\\)?\\|function_name\\|indent\\([a-z_]+\\)\\|info\\|location\\|step\\|tag\\|warn\\)!"))
    (with-isearch-suspended
     (setq isearch-new-string regexp)
     (setq isearch-string regexp)
     (isearch-update-ring regexp)
     (isearch-mode t t nil t))))
