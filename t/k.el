;; OO^^^^^^^^^G
;; OO  OOOOOOOG
;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-
;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-
;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg
;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg
;; OOOOOOOOOOOG

(progn
  (global-unset-key (kbd "C-x C-x"))
  (global-set-key (kbd "C-x C-x") 'eval-region)
  (global-unset-key (kbd "C-x C-z"))
  (global-set-key (kbd "C-x C-z") #'(lambda () (interactive) (eval-buffer))))
(defalias 'yes-or-no-p 'y-or-n-p)
(progn
  (require 'package)
  (setq package-archives nil)
  (progn (require 'flycheck)
         (global-flycheck-mode))
  (add-to-list 'custom-safe-themes "5bd001a0f95d54174370e9275b1f594829930a1a95ed82741a5492facb7415e7")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/Ꭶ")
  (load-library "ori")
  (progn
    (load-library "f")
    (load-library "8O1")
    (load-library "5O1")))

(ignore-errors
  (progn
    (setq vc-handled-backends ())
    (setq vc-handled-backends nil)
    (eval-after-load "vc" '(remove-hook 'find-file-hook 'vc-find-file-hook))))


;;;
