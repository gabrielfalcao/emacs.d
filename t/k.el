;; OO^^^^^^^^^G
;; OO  OOOOOOOG
;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-
;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-
;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg
;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg
;; OOOOOOOOOOOG



(defalias 'yes-or-no-p 'y-or-n-p)
(require 'package)
(require 'flycheck)
(setq package-archives nil)
(setq global-flycheck-mode t)
(add-to-list 'custom-safe-themes "5bd001a0f95d54174370e9275b1f594829930a1a95ed82741a5492facb7415e7")
(add-to-list 'custom-theme-load-path "~/.emacs.d/Ꭶ")
(load-library "ori")

(load-library "f")
(load-library "8O1")
(load-library "5O1")

(setq vc-handled-backends ())
(setq vc-handled-backends nil)
(eval-after-load "vc" '(remove-hook 'find-file-hook 'vc-find-file-hook))

(message "%s loaded" (buffer-name))
