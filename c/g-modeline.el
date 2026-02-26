;; TODO:
;;
;; when mark is active, begin modeline with (line number and line
;; length of shortest and widest selected line)

(defun Ox33b4O/$/bfan ()
  "."
  (or
   (when (equal (buffer-file-name-relative) (buffer-name))
     (Ox33b4O/$/paint-buffer-name))
   (format "%s %s"
           (Ox33b4O/$/paint-buffer-name)
           (Ox33b4O/$/colorize-face-fg
            (format "[%s]" (buffer-file-name-relative))
            "#FF4018" ))))

(defun Ox33b4O/$/paint-buffer-name ()
  "."
  (Ox33b4O/$/colorize-face-fg (buffer-name) "#C6DBDC"))


(defun Ox33b4O/$/mark-indicator()
  "."
  (list
   '(:eval
     (list
      (or
       (when mark-active
         (format "%s%s %s%s"
                 (propertize
                  (Ox33b4O/$/mode-line-arrow-right)
                  'face
                  (list :background
                        (Ox33b4O/$/mode-line-background)
                        :foreground "#F5BF08")
                  )
                 (propertize
                  (format "%s" (marker-begin))
                  'face
                  (list :background
                        (Ox33b4O/$/mode-line-background)
                        :foreground (Ox33b4O/$/mark-indicator-color)))

                 (propertize
                  (let ((line-count
                         (count-lines
                          (marker-position (mark-marker))
                          (point))))
                    (format "[%s line%s]"
                            line-count
                            (or (and (= line-count 1) "") "s")))
                  'face
                  (list :background
                        (Ox33b4O/$/mark-indicator-color)
                        :foreground (Ox33b4O/$/mode-line-background)
                        ))
                 (propertize
                  (Ox33b4O/$/mode-line-arrow-left)
                  'face
                  (list :background
                        (Ox33b4O/$/mode-line-background)
                        :foreground "#F5BF08")
                  )
                 )

         )
       "")))))

(defun Ox33b4O/$/paint-mode-line-colorize (c contents)
  (let* ((foreground
          (format "#%s" (Ox33b4O/$/hash-take-first-n-chars 'sha512 6 c)))
         (background
          (compute-bright-dark-from-color-value foreground
                                                (Ox33b4O/$/mode-line-foreground)
                                                (Ox33b4O/$/mode-line-background))))
    ;; (message (format "mode-name color %s" foreground))
    ;;(debug "(Ox33b4O/$/paint-mode-line-colorize %S %S) => %s %s" c contents foreground background)
    (propertize
     (format "%s" contents)
     'face
     (list :foreground foreground :background background))))


(defun Ox33b4O/$/paint-mode-line-color (contents)
  (Ox33b4O/$/paint-mode-line-colorize contents contents))

(defun Ox33b4O/$/paint-non-file-buffer()
  "."
  (list
   (Ox33b4O/$/paint-mode-name)
   " "
   (Ox33b4O/$/paint-buffer-name)
   " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t" ;; row column kbytes bytes
   '(:eval (Ox33b4O/$/mark-indicator))))



(defun Ox33b4O/$/paint-mode-name-string()
  (format "%s-mode"
          (replace-regexp-in-string
           "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$" "\\1"
           (downcase
            (cond
             ((listp mode-name)
              (car mode-name))
             ((stringp mode-name)
              mode-name)
             ((t (format "%S" mode-name))))))))

(defun Ox33b4O/$/display-mode-name()
  (interactive "*")
  (message (Ox33b4O/$/paint-mode-name))
  )
(defun Ox33b4O/$/paint-mode-name()
  (Ox33b4O/$/paint-mode-line-color (Ox33b4O/$/paint-mode-name-string)))


(defun Ox33b4O/$/paint-file-buffer()
  "."
  (if (null (file-attribute-modes (file-attributes (buffer-file-name))))
      (Ox33b4O/$/paint-file-buffer-nil)
    (Ox33b4O/$/paint-file-buffer-existing-file)))

(defun Ox33b4O/$/paint-file-buffer-existing-file()
  "."
  (list
   '(:eval (Ox33b4O/$/mark-indicator))
   " "
   '(:eval (Ox33b4O/$/bfan))
   " "
   (propertize
    (Ox33b4O/$/mode-line-arrow-right)
    'face
    (list :foreground (Ox33b4O/$/mark-indicator-color)))
   " "
   '(:eval (format "W:%s H:%s" (frame-width) (frame-height) ))
   " "
   '(:eval (Ox33b4O/$/paint-mode-name))
   ;; " "
   ;; '(:eval (Ox33b4O/$/fm))
   " "
   '(:eval (Ox33b4O/$/bchs))
   " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t"))

(defun Ox33b4O/$/paint-file-buffer-nil
    ()
  "."
  (list
   '(:eval (Ox33b4O/$/mark-indicator))
   " "
   '(:eval (Ox33b4O/$/bfan))
   " "
   (propertize
    (Ox33b4O/$/mode-line-arrow-right)
    'face
    (list :foreground (Ox33b4O/$/mark-indicator-color)))
   " "
   '(:eval (Ox33b4O/$/paint-mode-name))
   " "
   '(:eval (Ox33b4O/$/fm))
   " "
   '(:eval (Ox33b4O/$/bchs))
   " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t"))


(defun Ox33b4O/$/paint-mode-line ()
  "."
  (interactive)
  (let* ((narrow
          (if (buffer-file-name)
              (Ox33b4O/$/paint-file-buffer)
            (Ox33b4O/$/paint-non-file-buffer)))
         (wide
          (list mode-line-front-space narrow mode-line-end-spaces)))
    (setq mode-line-format wide)
    (force-mode-line-update)
    wide))

(defun Ox33b4O/$/mode-name()
  (format "%s-mode"
          (replace-regexp-in-string
           "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$" "\\1"
           (downcase
            (cond
             ((listp mode-name)
              (car mode-name))
             ((stringp mode-name)
              (substring-no-properties mode-name))
             ((t (format "%S" mode-name))))))))


(defun Ox33b4O/$/mode-name()
  (format "%s-mode"
          (replace-regexp-in-string
           "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$" "\\1"
           (downcase
            (cond
             ((listp mode-name)
              (car mode-name))
             ((stringp mode-name)
              mode-name)
             ((t (format "%S" mode-name))))))))

(defun Ox33b4O/$/mark-indicator/active()
  "."
  (format "%s%s %s%s"
          (propertize
           (Ox33b4O/$/mode-line-arrow-right)
           'face
           (list :background
                 (Ox33b4O/$/mode-line-background)
                 :foreground "#F5BF08")
           )
          (propertize
           (format "%s" (marker-begin))
           'face
           (list :background
                 (Ox33b4O/$/mode-line-background)
                 :foreground (Ox33b4O/$/mark-indicator-color)))

          (propertize
           (let ((line-count
                  (count-lines
                   (marker-position (mark-marker))
                   (point))))
             (format "[%s line%s]"
                     line-count
                     (if (= line-count 1) "" "s")))
           'face
           (list :background
                 (Ox33b4O/$/mark-indicator-color)
                 :foreground (Ox33b4O/$/mode-line-background)
                 ))
          (propertize
           (Ox33b4O/$/mode-line-arrow-left)
           'face
           (list :background
                 (Ox33b4O/$/mode-line-background)
                 :foreground "#F5BF08")
           ))
  )

(defun Ox33b4O/$/mark-indicator/inactive()
  "."
  (string-join (list " ") ""))
