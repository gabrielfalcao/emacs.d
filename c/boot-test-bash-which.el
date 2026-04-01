(defun repr-value (value) (format "%S" item))

(defun make-indent-function (&optional level indentation-string)
  (let* ((default-level                4)
         (default-indentation-string " ")
         (level (or (and (natnump level) level) default-level))
         (indentation-string
          (or
           (and
            (stringp indentation-string)
            (length> indentation-string 0))
           default-indentation-string)))
    (lambda (value)
      (let* ((indentation
              (string-join (make-list level indentation-string) "")))
        (format "%s%s" indentation value)))))


(defun list-items-to-string-values (items)
  (unless (or (listp items) (consp items))
    (signal 'type-error
            (format "argument ITEMS is not a list `%s': %S"
                    (cl-type-of items)
                    items)))
  (mapcar #'repr-value items))


(defun indented-list-items (items)
  (string-join
   (mapcar
    (make-indent-function 4 " ")
    (list-items-to-string-values items))
   "\n"))



(defun which-bin (name)
  "Returns a list of all executable files and symlinks in all of the paths returned by `exec-path' matching NAME.

   Every symbolic link, if any, is resolved to the canonical path of its
   source and added to the beginning of the list returned by this
   function, but is *NOT* replaced.

   The return value is a `list' of valid filesystem paths.
"
  (let* ((trim-regexp "[ \t\n\r[:space:]]+")
         (which-a-bash (shell-command-to-string "which -a bash"))
         (which-a-lines
          (save-match-data
            (split-string which-a-bash "\n" t trim-regexp)))
         (canonical-paths
          (mapcar
           (lambda (path)
             (string-trim
              (shell-command-to-string
               (format "path canon %S" (string-trim path)))))
           which-a-lines))
         (result (list)))
    (seq-do-indexed
     (lambda (item idx)
       (unless (member item result)
         (when (and (stringp item) (file-exists-p item))
           (push item result))))
     (append  which-a-lines canonical-paths))

    (unless (c-message-visible-p)
      (c-message-open)
      (erase-c-messages))
    (erase-c-messages)
    (erase-all-non-file-buffers)
    ;; (c-message "which-a-bash: %S" which-a-bash)
    (c-message "which-a-lines:\n%s"
               (indented-list-items which-a-lines))
    (c-message "canonical-paths:\n%s"
               (indented-list-items canonical-paths))
    (c-message "result:\n%s" (indented-list-items result)))
  )


(which-bin "bash")
