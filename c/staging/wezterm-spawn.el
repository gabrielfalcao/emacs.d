(defun wezterm-spawn (&optional working-dir)
  "."
  (interactive)
  (enable-debug-on-error)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-stdout-buffer-name
          (format "*wezterm_cli_spawn:stdout:%s*" current-filename))
         (tmp-stderr-file (make-temp-file "wezterm_cli_spawn-stderr"))
         (tmp-stdout-buffer (get-buffer-create tmp-stdout-buffer-name))
         (exit-code
          (call-process "wezterm" nil
                        (list tmp-stdout-buffer tmp-stderr-file)
                        nil "cli" "spawn" (format "--pane-id=%d" wezterm-pane-id) (format "--cwd '%s'" working-dir) ))
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
     (format "wezterm_cli_spawn %s exitted with code: %s" current-filename exit-code))
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
	 "%s formatted with wezterm_cli_spawn"
         (abbreviate-file-name current-filename))))
     (t
      (kill-buffer tmp-stdout-buffer)
      (message
       (format "wezterm_cli_spawn %s failed with code: %s"
               (abbreviate-file-name current-filename)
               exit-code))

      (pop-to-buffer-same-window tmp-buffer-stderr nil)))))
