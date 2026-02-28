(progn
  (erase-c-messages)
  (c-message-open "")
  (condition-case waterr
      (let* ((teens (mapcar (lambda (n) (* 10 n)) (number-sequence 1 9)))
             (caught
              (catch 'numba
                (mapc
                 (lambda (lownu)
                   (mapc
                    (lambda (factor)
                      (let (
                            (value (+ lownu factor))
                            (return)
                            )
                        (setq return
                              (list :lownu lownu :factor factor :val
                                    (* lownu factor)))
                        (when (or
                               (= value 37)
                               (= value 30))
                          (throw 'numba return))
                        )
                      )
                    teens)
                   )
                 (number-sequence 2 25))
                ))
             (c-message "caught: (%S) %S" (type-of caught) caught))
        )
    )
  )
