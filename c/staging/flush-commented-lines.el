(defun flush-commented-lines()
  (interactive)
  (let* (
         (comm-start (substring-no-properties (format "%s" (or comment-start ""))))
         (comm-start-skip (substring-no-properties (format "%s" (or comment-start-skip ""))))
         (comm-end (substring-no-properties (format "%s" (or comment-end ""))))
         (comm-end-skip (substring-no-properties (format "%s" (or comment-end-skip ""))))
         (comm-start-nonwspc (string-trim-right comm-start))
         (comm-end-nonwspc (string-trim-right comm-end))
         (comm-char (if (length= comm-end 0) comm-start-nonwspc nil))
         (comm-regex-start-only (format "^\\([[:space:]]*\\)\\(%s\\)\\([[:space:]]*\\)\\([^\n]*\\)"
                                        (regexp-quote comm-start-nonwspc)))
         (comm-regex-start-end (format "^\\([[:space:]]*\\)\\(%s\\)\\([[:space:]]*\\)\\(\\([^\n]*\\|[\n]+[^\n]+\\)*\\)\\(%s\\)"
                                       (regexp-quote comm-start-nonwspc)
                                       (regexp-quote comm-end-nonwspc)
                                       ))
         (comm-regex (if (length> comm-end-nonwspc 0)
                         comm-regex-start-end
                       comm-regex-start-only))
         )
    (flush-lines comm-regex nil nil t)
    )
  )
