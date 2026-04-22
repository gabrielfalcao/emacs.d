(defun get-frame-params-plist (item-frame)
  (apply #'append
    (mapcar
      (lambda (frame-each-param-plist)
        (let* ((key (plist-get frame-each-param-plist :key))
               (value (plist-get frame-each-param-plist :value)))
          (list key value)))
      (get-frame-params item-frame))))
