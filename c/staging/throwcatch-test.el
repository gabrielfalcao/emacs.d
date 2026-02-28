(let* ((backtrace-global (backtrace)))
  (erase-c-messages)
  (c-message-open "")
  (condition-case waterr
      (let* ((teens
              (mapcar
               (lambda (n) (* 10 n))
               (number-sequence 1 10)))
             (caught
              (catch 'numba
                (mapc
                 (lambda (lownu)
                   (setq backtrace-global (backtrace))
                   (mapc
                    (lambda (factor)
                      (setq backtrace-global (backtrace))
                      (let* ((value (+ lownu factor))
                             (return
                              (list :lownu lownu :factor factor :val
                                    (* lownu factor))))
                        (when (= value 37) (throw 'numba return)))
                      )
                    (number-sequence teens))
                   )
                 (number-sequence 2 25))
                ))
             )
        (c-message "caught: (%S) %S" (type-of caught) caught))
    (error
     (let* (
            (ty (type-of waterr))
            (msg (format "%S" waterr))
            (backtrace-global-string
             (string-join
              (mapcar (lambda (item) (format "    (%s): %S" (type-of item) item))
                      backtrace-global
                      )
              "\n"))
            )
       (c-message "%s Error: %s\nBacktrace: \n%s" ty msg backtrace-global-string)
       )
     )
    )
  )
