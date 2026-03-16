(mapcar (lambda (sym)
          (let* (
                 (name (symbol-name sym))
                 )
            (condition-case error
                (funcall sym)
              (error (throw 'funcall-error (
                      (list #'split-window-vertically
                            #'split-window-right
                            #'split-window-horizontally
                            #'split-window-below)
                      )
                                                                                                  )

                     ; wat
                     ;; 2026/03/20 07:14:19 (1773990859)
