(defun gawkfmt ()
  "."
  (interactive)
  (enable-debug-on-error)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-stdout-buffer-name
          (format "*gawkfmt:stdout:%s*" current-filename))
         (tmp-stderr-buffer-name
          (format "*gawkfmt:stderr:%s*" current-filename))
         (tmp-buffer-stdout (get-buffer-create tmp-stdout-buffer-name))
         (tmp-buffer-stderr (get-buffer-create tmp-stderr-buffer-name))
         (exit-code
          (call-process "gawk" current-filename
                        '(tmp-buffer-stdout tmp-buffer-stderr)
                        nil "-f" "-" "-o-" ))
         (stderr
          (with-current-buffer tmp-buffer-stderr
	    (widen)
            (beginning-of-buffer)
            (buffer-substring-no-properties (point-min) (point-max))))
         (stdout
          (with-current-buffer tmp-buffer-stdout
	    (widen)
            (beginning-of-buffer)
            (buffer-substring-no-properties (point-min) (point-max)))))

    (message
     (format "gawkfmt %s exitted with code: %s" current-filename exit-code))
    (cond
     ((eq exit-code 0)
      (let* ((previous-buffer-contents
              (save-mark-and-excursion
                (widen)
                (beginning-of-buffer)
                (buffer-substring-no-properties
                 (point-min)
                 (point-max))))
             )
        (widen)
        (beginning-of-buffer)
        (kill-region (point-min) (point-max))
        (beginning-of-buffer)
        (insert stdout)

        (kill-buffer tmp-buffer-stdout)
        (kill-buffer tmp-buffer-stderr)
        (message
	 "%s formatted with gawkfmt"
         (abbreviate-file-name current-filename)))
      )
     (t
      (kill-buffer tmp-buffer-stdout)
      (message
       (format "gawkfmt %s failed with code: %s"
               (abbreviate-file-name current-filename)
               exit-code))

      (pop-to-buffer-same-window tmp-buffer-stderr nil))))
  )
