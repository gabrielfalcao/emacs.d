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


(defun get-frame-params-plist (item-frame)
  (apply #'append
         (mapcar
          (lambda (frame-each-param-plist)
            (let* ((key (plist-get frame-each-param-plist :key))
                   (value (plist-get frame-each-param-plist :value)))
              (list key value)))
          (get-frame-params item-frame))))

(defun c-message-debug-frame (item-frame)
  (let* (;
         (params (get-frame-params item-frame))
         ;;
         )
    (c-message "frame %S params: %S" item-frame
               (get-frame-params-plist item-frame))))

(defun c-message-buffer-in-frame (frame)
  (unless (framep frame)
    (signal 'type-error
            (format "argument FRAME must be a `frame' but is `%s': %S"
                    (cl-type-of frame)
                    frame)))
  (let* (;
         (frame-params (get-frame-params-plist frame))
         (frame-buffers (plist-get frame-params 'buffer-list))
         (buf-candidates
          (seq-map (lambda (buf) (buffer-name buf)) frame-buffers))

         ;; (response
         ;;  (seq-reduce
         ;;   (lambda (acc buf)
         ;;     (or
         ;;      (and
         ;;       (or
         ;;        (eq acc t)
         ;;        (and (stringp acc) (string= acc "*C-Messages*"))
         ;;        (string= (buffer-name buf) "*C-Messages*"))
         ;;       t)
         ;;      (buffer-name buf)))
         ;;   frame-buffers
         ;;   ""))

         ;;
         )
    (mapcar
     (lambda (name)
       (and (stringp name) (string= "*C-Messages*" name)))
     buf-candidates))
  )



(defun c-message-visible-p ()
  (let* (;;
         (vis-frames (visible-frame-list))
         (total-items (length vis-frames))
         ;; (item-frame (nth 0 vis-frames))
         ;;
         (result
          (mapcar
           (lambda (item-frame) (c-message-buffer-in-frame item-frame))

           vis-frames)))
    (c-message-open)
    (erase-c-messages)
    ;; (c-message-debug-frame item-frame)
    (erase-messages)
    (c-message "message: %S" result)
    ;; (c-message-buffer-in-frame item-frame)
    ))
;(c-message-visible-p)
