;C6DCFC
;CFC6A6
;1C1C1C
;F49101
;DCDC88
;C63367
;F80101
;F937B9
;F80101
;DB5045
;F682FF
;FC580C
;DEDEDE
;211F17
;312F27
;A66A00
;A6E22E
;36F6E9

(let ((init-point (point))
      (regexp "^\\s-*;+\\s-*\\([0-9a-f]\\{2\\}\\)\\{3\\}\\s-*$")
      tmp-mark-beg
      tmp-mark-end
      first-pos
      last-pos)
  (erase-c-messages)
  (c-message-open "debug pos in buffer `%s'" (auto-propertize-string (buffer-name)))
;;   (save-mark-and-excursion
  ;;     (save-match-data
  (setq tmp-mark-end (point))
  (c-message "tmp-mark-end: %s"  tmp-mark-end)
  (widen)

  (beginning-of-buffer)
  (setq tmp-mark-beg (point))
  (setq tmp-mark-end (point))
  (c-message "tmp-mark-beg: %s"  tmp-mark-beg)
  (push-mark)
  (while (re-search-forward regexp nil t)
    (when (null first-pos)
      (setq first-pos (match-beginning 0))
      (c-message "first-pos: %s"  first-pos)
      )
    (setq last-pos (match-end 0))
    (c-message "last-pos: %s"  last-pos)
    (goto-char last-pos)
    )
  )
