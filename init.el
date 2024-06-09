;; OO^^^^^^^^^G
;; OO  OOOOOOOG
;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-
;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-
;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg
;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg
;; OOOOOOOOOOOG
(setq mode-line-format (list (base64-decode-string "SGkgbWFzdGVyIGdhYnJpZWxmYWxjYW8gcGxlYXNlIHdhaXQuLi4=")))
(setq server-socket-dir "~/.emacs.d/socket" server-log t)
(let ((foreground "#A79C83")
      (background "#333"))
  (set-face-attribute 'default nil :foreground foreground :background background :font "JetBrains Mono-20")
  (set-face-attribute 'mode-line nil :background background :foreground foreground)
  (set-face-attribute 'mode-line-inactive nil :background background :foreground foreground
                      :box '(:line-width (0 . 0))))
(progn (add-to-list 'load-path "~/.emacs.d/t") (load-library "k"))
