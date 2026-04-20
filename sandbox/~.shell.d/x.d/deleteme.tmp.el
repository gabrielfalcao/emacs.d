(defun deleteme-tmp (string)
  (replace-regexp-in-string "[
[:space:]]+" " " string))
