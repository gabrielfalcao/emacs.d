(enable-debug-on-error)
(let ((final-result
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
                  (number-sequence 1 40))
                 )
               )
              )
         caught
         )
       )
      )

  (erase-c-messages)
  (c-message-open "")
  (c-message
   "final-result: (%S) %S"
   (type-of final-result)
   final-result)
)
