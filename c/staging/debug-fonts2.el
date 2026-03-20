(defun list-to-dbg-string (name items)
  (let* ((items (copy-sequence items))
         (len (length items))
         (lines
          (seq-map-indexed
           (lambda (item index)
             (let* ((current (1+ index)))
               (format "  %d of %d (%s): %S" current len
                       (cl-type-of item)
                       item)))
           items))
         (tag-open (format "<%s length=\x22%d\x22>\n" name len))
         (tag-close (format "\n</%s>" name))
         (tag-content (string-join lines "\n")))
    (string-join (list tag-open tag-content tag-close) "\n"))
  )




(defun test-list-side-effects ()
  "."
  (declare (not-side-effect-free t))
  (let* ((orig-container (number-sequence 1 22 2))
         (container (copy-sequence orig-container))
         (first-2 (ntake 2 container)))
    (erase-c-messages)
    (c-message-open "")
    (c-message "<test-list-side-effects>\n\n%s\n\n</test-list-side-effects>\n"
               (string-join
                (mapcar
                 (lambda (line) (format "  %s" line))
                 (list
                  (list-to-dbg-string 'container container)
                  (list-to-dbg-string 'first-2 first-2)
                  (list-to-dbg-string 'orig-container orig-container)))
                "\n"))
    ))
(test-list-side-effects)
