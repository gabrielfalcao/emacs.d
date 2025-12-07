(defun dbg(a)
  (let (
        (value (propertize (format "%s" a) 'face (list :foreground "#A6E22E")))
        (tag (propertize "debugging" 'face (list :foreground "#F49101"))))
    (message (format "<%s>\n\n%s\n\n</%s>" tag value (propertize "debugging" 'face (list :foreground "#F49101"))))))

(dbg '("a" . a))
(dbg (cons 'a 'a nil))
