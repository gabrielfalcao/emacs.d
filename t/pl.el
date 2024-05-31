;; OO^^^^^^^^^G  -*- lexical-binding: t; -*-
;; OO  OOOOOOOG
;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-
;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-
;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg
;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg
;; OOOOOOOOOOOG


(defun g/pl/map/comments(ext)
  "EXT."
  (cond (
         ((member ext '("js" "jsx" "ts" "tsx")) '('("/*" "*/") '("//" nil)))
         ((member ext '("rs")) '('("//" nil)))
         ((member ext '("sh", "py")) '('("#" nil)))
         )))

(defun g/pl/map/comment/beg(ext)
  "EXT."
  (let ((commtpair (g/pl/map/comments ext)))
    (car commtpair)))

(defun g/pl/map/comment/beg/regex(ext)
  "EXT."
  (string-trim (replace-regexp-in-string "\\(.\\)" "[\1]" (format "%s" (g/pl/map/comment/beg ext)))))


(defun g/pl/comment/regex(ext)
  "EXT."
  (g/pl/map/comment/beg/regex ext))


(defun g/pl/fmt (fmtexect &optional major-mode)
  (if (buffer-modified-p (current-buffer))
      (error "%s ought to be saved"  (buffer-name))
    (let* (
           (target (expand-file-name (buffer-file-name (current-buffer))))
           (buffer (current-buffer))
           (pebu (format "*%s %s *" fmtexect target))
           (err (make-temp-file fmtexect nil (sha1 (buffer-file-name)))) ;; (secure-hash "sha256" (buffer-file-name))))
           )
      (if (and (file-readable-p target)
               (file-regular-p target))
          (let* (
                 (eco (format "%d" (call-process fmtexect nil (list buffer err) t target)))
                 (ets (format "%d" (file-attribute-size (file-attributes err)))))
            (if (and (not( equal "0" eco))
                     (not(equal "0" ets)))
                (progn
                  (set-buffer (get-buffer-create pebu t))
                  (insert-file-contents err nil nil nil t)
                  ;; (if (wmmd major-mode)
                  ;;     (set-buffer-major-mode major-mode)
                  ;;   (error "not a mode: %s" major-mode))

                  (read-only-mode nil)
                  (pop-to-buffer (get-buffer-create pebu t) 'display-buffer-same-window nil)
                  (display-buffer (current-buffer)))))))))

(defun g/pl/fmt/prettier/ts ()
  "."
  (interactive)
  (g/pl/fmt "prettier" "typescript-mode"))

(defun g/pl/fmt/prettier/js ()
  "."
  (interactive)
  (g/pl/fmt "prettier" "javascript-mode"))


(defun g/pl/extension-major-mode-mapping()
  "."

  (let ((emmo (make-hash-table)))
    (progn
      (puthash 'javascript-mode '("js", "json") emmo)
      (puthash 'typescript-mode '("ts")         emmo)
      (puthash 'web-mode        '("jsx" "tsx" "html") emmo)
      )))


(defun g/pl/map/major-mode(filename)
  "EXT."
  (let ((ext (file-name-extension filename)))
    ((member ext '("js")
             '("javascript-mode"))
     (member ext '("jsx" "tsx" "html")
             '("web-mode"))
     (member ext '("ts")
             '("typescript-mode"))


(add-hook
 'after-save-hook  #'(lambda ()
                       (let ((x (file-name-extension (buffer-file-name (current-buffer)))))
                         (cond (
                                ((member x (list "ts" "tsx" )) (g/pl/fmt/prettier/ts))
                                ((member x (list "js" "jsx" )) (g/pl/fmt/prettier/js)))
                               ))))
