(defun $/bfan ()
  "."
  (or
   (when (equal (buffer-file-name-relative) (buffer-name))
     ($/paint-buffer-name))
   (format "%s %s"
           ($/paint-buffer-name)
           ($/colorize-face-fg
            (format "[%s]" (buffer-file-name-relative))
            "#FF4018" ))))

(defun $/paint-buffer-name ()
  "."
  ($/colorize-face-fg (buffer-name) "#C6DBDC"))


(defun $/mark-indicator()
  "."
  (list
   '(:eval
     (list
      (or
       (when mark-active
         (format "%s%s %s %s%s"
                 (propertize ($/mode-line-arrow-right) 'face
                             (list :background ($/mode-line-background)
                                   :foreground "#F5BF08"
                                   )
                             )
                 (propertize
                  (format "%s" (marker-begin))
                  'face (list :background ($/mode-line-background)
                              :foreground ($/mark-indicator-color)))
                 (propertize
                  (format "%s" (marker-end))
                  'face (list :background ($/mode-line-background)
                              :foreground ($/mark-indicator-color)))

                 (propertize
                  (format "[%s lines]"
                          (count-lines (marker-position (mark-marker)) (point)))
                          'face (list :background ($/mark-indicator-color)
                                      :foreground ($/mode-line-background)
                                      ))
                 (propertize ($/mode-line-arrow-left) 'face
                             (list :background ($/mode-line-background)
                                   :foreground "#F5BF08"
                                   )
                             ))

         )
       " ")))))

(defun $/paint-mode-line-colorize (c contents)
  (let* ((foreground
          (format "#%s" ($/hash-take-last-n-chars 'md5 6 c)))
         (background
          (compute-bright-dark-from-color-value foreground
                                                ($/mode-line-foreground)
                                                ($/mode-line-background))))
    ;; (message (format "mode-name color %s" foreground))
    ;;(debug "($/paint-mode-line-colorize %S %S) => %s %s" c contents foreground background)
    (propertize
     (format "%s" contents)
     'face
     (list :foreground foreground :background background))))


(defun $/paint-mode-line-color (contents)
  ($/paint-mode-line-colorize contents contents))

(defun $/paint-non-file-buffer()
  "."
  (list
   ($/paint-mode-name)
   " "
   ($/paint-buffer-name)
   " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t" ;; row column kbytes bytes
   '(:eval ($/mark-indicator))))



(defun $/paint-mode-name-string()
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

(defun $/paint-mode-name()
  ($/paint-mode-line-color ($/paint-mode-name-string)))


(defun $/paint-file-buffer()
  "."
  (list
   '(:eval ($/mark-indicator))
   " "
   '(:eval ($/bfan))
   " "
   (propertize ($/mode-line-arrow-right) 'face
               (list :foreground ($/mark-indicator-color)))
   " "
   '(:eval ($/paint-mode-name))
   " "
   '(:eval ($/fm))
   " "
   '(:eval ($/bchs))
   " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t"))

(defun $/paint-mode-line ()
  "."
  (interactive)
  (let* ((narrow
          (if (buffer-file-name)
              ($/paint-file-buffer)
            ($/paint-non-file-buffer)))
         (wide
          (list mode-line-front-space narrow mode-line-end-spaces)))
    (setq mode-line-format wide)
    (force-mode-line-update)
    wide))

(defun $/mode-name()
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


(defun $/mode-name()
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
