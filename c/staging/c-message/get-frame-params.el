(defun get-frame-params (item-frame)
  (let* (;
         (params-list (frame-parameters item-frame))
         (params-count (length params-list))
         (params-plists
          (seq-map-indexed
           (lambda (item-param-cons param-index)
             (let* (;
                    (item-no (1+  param-index))
                    (key (car item-param-cons))
                    (value (cdr item-param-cons))
                    ;;
                    )
               (list :key key
                     :value value
                     :type (cl-type-of value)
                     :index param-index
                     :num   item-no
                     :total params-count)))
           params-list)))
    params-plists))
