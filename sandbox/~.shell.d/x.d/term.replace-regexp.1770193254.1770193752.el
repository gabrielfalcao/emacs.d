;; 
;;\(\(\([[:space:]]*\)\([)]\)\([[:space:]]*\)\)+\)\)\([)]+\)\(\(\([[:space:]]*\)\([)]\)\([[:space:]]*\)\)+\)\) → \1\n;;\2\n;;\3\n;;
;;
;;→
;;
;; \(\(\([[:space:]]*\)\([)]\)\([[:space:]]*\)\)+\)\)\([)]+\)\(\(\([[:space:]]*\)\([)]\)\([[:space:]]*\)\)+\)\) → \1
\2
\3



(let* (
       (timestamp        (string-to-number (format-time-string "%s")))
       (ts-hex           (format "%x" timestamp))
       (first-pos        (point))
       (output-parts     (list ";;"
                               (format "%s" timestamp)
                               (format "[hex: %s (length %s)]" ts-hex (length ts-hex ))
                               )
                         )
       (output-count     (length output-parts))
       (pos-part-alist   (list))
       last-pos
       pos-bol
       pos-eol
       cur-line-substring
       )
  (save-mark-and-excursion
    (end-of-line)
    (setq pos-eol (point)))
  (save-mark-and-excursion
    (beginning-of-line)
    (setq pos-bol (point))
    (unless (> pos-eol pos-bol)
      (user-error "eol (%s) not greater than bol (%s)" pos-eol pos-bol))
    (setq cur-line-text (buffer-substring-no-properties pos-bol pos-eol))

    (when (> (point) 0)
      (previous-line)
      (end-of-line)
    
    )

  (seq-map-indexed (lambda (beg index)
                     (let* (
                            (current (+ 1 index))
                            (end (or (and (< current output-count) " ") ""))
                            (part (string-join (list beg end) ""))
                            (pos-before (point))
                            )
                       
                       (insert (format "\n%s\n" output))
                       

  (setq last-pos (point))
  (setq pos-part-alist (append pos-part-alist (cons (point
  
  (goto-char first-pos)
  )

(let* (
(tz "UTC")
(ts                         (format-time-string "%s" nil tz))
(timestamp                  (string-to-number ts))
(now                        timestamp)
(file-name-timestamp-hex    (format "%010x" now))

(file-name-day              (format-time-string "%Y-%m-%d" now tz))
(file-name-hour             (format-time-string "%H" now tz))
(file-name-minute           (format-time-string "%H-%M" now tz))
(file-name-second           (format-time-string "%H-%M-%S" now tz))

(subdir-day-parts-hour      (list file-name-day file-name-hour))
(subdir-day-parts-minute    (list file-name-day file-name-minute))
(subdir-day-parts-second    (list file-name-day file-name-second))

(file-name-subdir-formats   (list :day "%Y-%m-%d" now tz))

(workbench-root        (expand-file-name "~/workbench"))
(workbench-path        (file-name-concat workbench-root file-name-today))

(buf-path-absolute   (buffer-file-name))

(buf-path-abs-parent (file-name-directory buf-path-absolute))


(buf-path-filename   (file-name-nondirectory buf-path-absolute))
(buf-path-relative   (buffer-file-name-relative))

(buf-file-name-base  (file-name-base buf-path-filename))
(buf-file-extension  (file-name-extension buf-path-filename))

(file-name-concat (file-name-directory (buffer-file-name))
                  (format "%s" (string-join (list )
                                                  (format-time-string "%s") "el"  ) "." ))))


