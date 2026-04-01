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
    result)
  )
