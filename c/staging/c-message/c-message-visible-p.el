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
                     :total params-count)
               ))
           params-plists)
          )
         )
    params-plists
    )
  )


(defun get-frame-params-plist (item-frame)
  (apply #'append
  (mapcar (lambda (frame-each-param-plist)
            (let* (
                   (key   (plist-get frame-each-param-plist :key))
                   (value (plist-get frame-each-param-plist :value))
                   )
              (list key value)
              )
            )
          (get-frame-params item-frame))
  )
  )

(defun c-message-debug-frame (item-frame)
  (let* (
                                        ;
         (params (get-frame-params item-frame))
         ;
         )
    (c-message "frame %S params: %S" item-frame (get-frame-params-plist item-frame))
    )
  )

(defun c-message-visible-p ()
  (let* (;;
         (vis-frames (visible-frame-list))
         (total-items (length vis-frames))
         (item-frame (nth 0 vis-frames))
         ;;
         )
    (c-message-open)
    (erase-c-messages)
    (c-message-debug-frame item-frame)
    ;; (seq-do-indexed (lambda (item-frame item-index)
    ;;                   (let* (
    ;;                          ;;
    ;;                          (item-no (1+ item-index))
    ;;                          (pos     (format "%-4s of %s" item-no total-items))
    ;;                          ;;
    ;;                          )
    ;;                     (c-message "[%s] title => %s" pos (get item-frame 'title))
    ;;                     )
    ;;                   )
    ;;                 vis-frames
    ;;                 )
    ))
(c-message-visible-p)
