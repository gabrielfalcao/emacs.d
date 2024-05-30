;; OO^^^^^^^^^G
;; OO  OOOOOOOG
;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-
;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-
;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg
;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg
;; OOOOOOOOOOOG


(defun file-name-collapse (path)
  "PATH."

  )
(progn
  (global-unset-key (kbd "C-x C-x"))
  (global-set-key (kbd "C-x C-x")
                  #'(lambda (beg end) (interactive "r")
                      (eval-region beg end)))

  (global-unset-key (kbd "C-x C-z"))
  (global-set-key (kbd "C-x C-z") #'(lambda () (interactive)
                                      (if (equal "el" (file-name-extension (buffer-file-name)))
                                          (progn (eval-buffer)
                                                 (message "%s eval'd" (buffer-file-name)))
                                        (message "\"%s\" aint no el" (buffer-name)))
                                      )))
(global-set-key (kbd "C-c C-d C-c")
                #'(lambda () (interactive)
                    (save-excursion
                      (let (begb hwmb cbeg cend faber)
                        (setq begb (point-min))
                        (setq hwmb (point-max))
                        (goto-char begb)
                        (while (and (re-search-forward "\\([#][a-f0-9]\\{3\,6\\}\\)" hwmb t)
                                    (<= (point) hwmb)
                                    (setq cbeg (match-beginning 1))
                                    (setq cend (match-end 1))
                                    (setq faber (buffer-substring cbeg cend))
                                    (put-text-property cbeg cend 'face (list :background faber :foreground (web-mode-colorize-foreground "#9acd32"))))plist)
                        (progn

                          (message "%s" (propertize faber 'face (list :foreground faber)))
                          )))))



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


(message "%s loaded" (buffer-name))
