(defun luafmt ()
  "."
  (interactive)
  (enable-debug-on-error)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-stdout-buffer-name
           (format "*luafmt:stdout:%s*" current-filename))
         (tmp-stderr-file (make-temp-file "luafmt-stderr"))
         (tmp-stdout-buffer (get-buffer-create tmp-stdout-buffer-name))
         (exit-code
           (call-process "stylua" current-filename
             (list tmp-stdout-buffer tmp-stderr-file)
             nil
             "--syntax"
             "Lua54"
             "--column-width"
             "100"
             "--indent-width"
             "4"
             "--indent-type"
             "Tabs"
             "--call-parentheses"
             "Always"
             "--preserve-block-newline-gaps"
             "Preserve"
             "--quote-style"
             "AutoPreferSingle"
             "--space-after-function-names"
             "Never"
             "--color"
             "Never"))
         (stderr
           (with-temp-buffer
             (insert-file-contents tmp-stderr-file)
             (widen)
             (beginning-of-buffer)
             (buffer-substring-no-properties (point-min) (point-max))))

         (stdout
           (with-current-buffer tmp-stdout-buffer
             (widen)
             (beginning-of-buffer)
             (buffer-substring-no-properties (point-min) (point-max)))))

    (message
      (format "luafmt %s exitted with code: %s" current-filename exit-code))
    (cond
      ((eq exit-code 0)
        (let* ((previous-buffer-contents
                 (save-mark-and-excursion
                   (widen)
                   (beginning-of-buffer)
                   (buffer-substring-no-properties
                     (point-min)
                     (point-max)))))
          (widen)
          (beginning-of-buffer)
          (kill-region (point-min) (point-max))
          (beginning-of-buffer)
          (insert stdout)

          (kill-buffer tmp-stdout-buffer)
          (delete-file tmp-stderr-file)
          (message
            "%s formatted with luafmt"
            (abbreviate-file-name current-filename))))
      (t
        (kill-buffer tmp-stdout-buffer)
        (message
          (format "luafmt %s failed with code: %s"
            (abbreviate-file-name current-filename)
            exit-code))

        (pop-to-buffer-same-window tmp-buffer-stderr nil)))))
