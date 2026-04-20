(defun taggy (name content &optional tag-attrs indent-or-prefix)
  (unless (or (null attrs) (stringp attrs) (list-of-strings-p attrs))
    (signal 'type-error
            (format  "[taggy] argument `tag-attrs' must be either nil, a string or a `list' of strings but instead received `%s': %s"
                     (type-of tag-attrs)
                     tag-attrs)))
  (unless (or (null indent-or-prefix) (stringp indent-or-prefix))
    (signal 'type-error
            (format  "[taggy] argument `indent-or-prefix' must be either nil or string but instead received `%s': %s"
                     (type-of indent-or-prefix)
                     indent-or-prefix)))

  (when (null indent-or-prefix) (setq indent-or-prefix ""))

  (let* ((attrs
          (cond
           ((list-of-strings-p tag-attrs)
            (string-join
             (mapcar (lambda (item) (string-trim item)) tag-attrs)
             " "))
           ((stringp tag-attrs)
            (string-trim tag-attrs))
           ((null tag-attrs)
            "")
           (t (format "%S" tag-attrs))))
         (trimmed-attrs (string-trim attrs))
         (attrs
          (if (length> trimmed-attrs 0)
              (format " %s" trimmed-attrs "")
            ""))
         (open (format "<%s%s>" name attrs))
         (close (format "</%s>" name))

         )
    (string-join
     (mapcar
      (item)
      (format "%s%s" indent-or-prefix item)
      (list open content close))
     "\n")))

(let ((bash-function-regexp
       "^\\(hist[a-z0-9_]+\\)\\([[:space:]\\n]*\\)[(]\\(\\s-*\\)[)]\\([\\n[:space:]]*\\)[{]" )
      (point-return-of-re-search-forward (point-min)))
  (erase-c-messages)
  (c-message-open "(let ... )")

  (save-mark-and-excursion
    (widen)
    (let* ((begbuf (point-min))
           (endbuf (point-max))
           (function-names (list))
           (current-point (point-min))
           (loop-count 0)
           (debug-symbol-names
            (list
             'name
             'content
             'tag-attrs
             'indent-or-prefix

             'begbuf
             'endbuf

             'function-names
             'current-point

             'attrs

             'bash-function-regexp
             'point-return-of-re-search-forward))
           (debug-enabled nil)

           (debug-items-string-list
            (seq-map-indexed
             (lambda (item idx) (format "%s: %s"
                                        item
                                        (condition-case error-seq-map-indexed-debug-items-string-list
                                        (intern-soft item)
                                        (error
                                         (progn
                                           (c-message "[debug-symbol-names %d/%d] error retrieving symbol value of %s %S: %s"
            (+ idx 1)                                       ;; 1
            (length debug-symbol-names)                     ;; 2
            (type-of item)                                  ;; 3
            item                                            ;; 4
            error-seq-map-indexed-debug-items-string-list   ;; 5
            )
                                       )
                                      ) ;;end (error ...)
                                        ) ;;end condition-case
                                        ) ;;end format
               ) ;; end (seq-map-indexed (lambda (item idx)) ...)
             debug-symbol-names ;;end  (seq-map-indexed ... sequence )
             ); end seq-map-indexed
                         ) ;; end (seq-map-indexed ...)

            ) ;end (let* (... debug-items-string-list) )
           ); end let* varlist


      (beginning-of-buffer)

      (while (re-search-forward bash-function-regexp  endbuf t)
        (replace-match
         (format "shell_d_%s() {" (match-string 1))
         t t)

        (goto-char match-end 0)

        (setq loop-count (+ loop-count 1))
        (setq debug-enabled t)


        (when (eq debug-enabled t)
          ;; (when (= loop-count 1)
          ;;   (erase-c-messages))
          (when (>= loop-count 1)
               (c-message "%s" (string-join debug-items-string-list "\n"))
            )
          );; end when eq debug-enabled t


        ) ;; while
      );; let*
    ); end save-mark-and-excursion
  ); end let
