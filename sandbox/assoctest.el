(let ((items (list :code 1 :display "One")))
  (c-message-open "
items = %S
(alist-get :code) = %S

%S
"
                  items
                  (alist-get :code items)
                  (mapcar #'(lambda (item) (format "%S" item)) items)
                  );; c-message-open


  );; let
