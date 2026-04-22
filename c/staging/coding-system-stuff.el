(defun dbg-coding-system ()
  (let* ((coding-system-tmp-varnames (list
                                      'default-file-name-coding-system
                                      'default-keyboard-coding-system
                                      'default-process-coding-system
                                      'default-sendmail-coding-system
                                      'default-terminal-coding-system))
         (cs-plist-keywords (list :symbol :index :value))
         (coding-system-tmp-plist (seq-map-indexed (lambda (varname index)
                                                    (let ((value (intern-soft varname)))
                                                      (list :symbol varname :index index :value value)))))
         (cs-plist-length (length coding-system-tmp-plist)))
    ;; (erase-c-messages)
    ;; (c-message-open "")
    (seq-map-indexed (lambda (cs-plist idx)
                      (let* (
                             (fmt-str-list (mapcar (lambda (sym)
                                                    (let (
                                                          (name (substring-no-properties (symbol-name sym) 1))
                                                          (val (plist-get cs-plist sym)))

                                                      (format "%s: %s" name val)))
                                            cs-plist))
                             (cs-plist-length (length cs-plist))
                             (current (1+ index)))
                        (append cs-plist (list :display
                                          (format "[item %d of %d]:\n%s"
                                            current
                                            cs-plist-length
                                            (string-join (mapcar (lambda (line) (format "%s%s"
                                                                                 (make-string 4 " ")
                                                                                 fmt-str-list))
                                                          cs-plist)
                                              "\n")))))) ; end (append) ; end (let* )
      coding-system-tmp-plist)))
