(defun c-message-debug-frame (item-frame)
  (let* ( ;
         (params (get-frame-params item-frame))
         ;;
         )
    (c-message "frame %S params: %S" item-frame
      (get-frame-params-plist item-frame))))
