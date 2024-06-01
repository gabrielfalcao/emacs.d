;; OO^^^^^^^^^G
;; OO  OOOOOOOG
;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-
;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-
;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg
;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg
;; OOOOOOOOOOOG

(utf8ftu)

(g/purge-key
 '(
   "C-c C-x"
   "M-o M-g"
   "C-g"
   "C-S"
   "C-q"
   "C-s"
   "C-x 5 2"
   "C-c C-x"
   "C-c C-u"
   "C-x C-d"
   "C-x C-e"
   "M-j"
   "M-k"
   "M-,"
   ))

(g/set-key (μεταψομμα ",") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3Qvay5lbA==")))
(g/set-key (μεταψομμα "f") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3QvZi5lbA==")))
(g/set-key (μεταψομμα "8") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3QvOE8xLmVs")))
(g/set-key (μεταψομμα "5") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3QvNU8xLmVs")))
(g/set-key (μεταψομμα "t") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3Qvb3JpLmVs")))
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-save-hook 'disavail-asl)
(add-hook 'after-save-hook 'kooh-tini-retfa)
(add-hook 'after-init-hook #'(lambda () (interactive) (message "present instance started in %s" (emacs-init-time))))
(g/set-key '("C-x C-x" "C-x C-z") 'elevate)
;; (g/set-key (μεταψομμα ",")#'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3Qvay5lbA==")))
;; (g/set-key (μεταψομμα "f")#'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3QvZi5lbA==")))
;; (g/set-key (μεταψομμα "8")#'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3QvOE8xLmVs")))
;; (g/set-key (μεταψομμα "5")#'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3QvNU8xLmVs")))
;; (g/set-key (μεταψομμα "t")#'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3Qvb3JpLmVs")))
(g/set-key '("C-c C-l") 'collapse-lines-region)
(g/set-key '("C-c C-t C-m C-l") 'kooh-tini-retfa)
(g/set-key '("C-c C-x C-f") 'show-face-at-point)
(g/set-key '("C-c C-w" "C-c M-w") 'clipboard-kill-ring-save)
(g/set-key '("C-c C-y" "C-c M-y") 'clipboard-yank)
(g/set-key '("C-x C-q" "C-c M-y") 'keyboard-quit)
(g/set-key '("C-x C-d C-h") 'info)
(g/set-key "C-c C-u C-d C-a" #'(lambda () (interactive) (when (read-only-mode -8) (message "%s unlocked" (buffer-name)))))
(global-set-key (kbd "C-c C-c C-r") 'collapse-lines-region)
;; (g/set-key '("M-, M-8" "M-, 8")#'(lambda () (interactive) (rot13(fpuervo) "OE8x"))) ;; https://deezer.page.link/HUJ1z8CfsudS2he96
;; (g/set-key '("M-, M-5" "M-, 5")#'(lambda () (interactive) (schreib "NU8x")))
;; (g/set-key '("M-, M-t" "M-, t")#'(lambda () (interactive) (schreib "b3Jp")))

(g/set-key "C-x C-d C-s" 'describe-symbol)
(g/set-key "C-x C-d C-g" 'shortdoc-display-group)
(g/set-key "C-x C-d C-X"
           #'(lambda (beg end) (interactive "r")
               (save-buffer
                (let ((tgtcode (replace-regexp-in-string "\\(\\s-\\|\\)+" " " (buffer-substring beg end))))
                  (with-current-buffer "*Messages*"
                    (read-only-mode -1)
                    (erase-buffer)
                    (read-only-mode 4))
                  (if (eval-region beg end)
                      (message "(%s) eval'd: \n```%s``` " (secure-hash 'sha256 tgtcode) tgtcode)
                    (warn "(%s) nil in evalin': \n```%s``` " (secure-hash 'sha256 tgtcode) tgtcode))
                  ))))

(g/set-key '("C-p" "M-p") #'(lambda () (interactive) (scroll-up 1)))
(g/set-key '("C-n" "M-n") #'(lambda () (interactive) (scroll-down 1)))
(g/set-key '("C-n" "M-n") #'(lambda () (interactive) (scroll-down 1)))
(g/set-key '("<backtab>") #'(lambda () (interactive) (other-frame 1)))



(g/set-key '("C-x C-SPC" "C-c C-SPC") 'rectangle-mark-mode)
(g/set-key "C-x C-e e" 'g/ep)
(g/set-key "C-x C-e b" 'g/wkzg)
(g/set-key "M-s" 'save-buffer)
(g/set-key "C-c C-p" #'(lambda () (interactive) (message "cur %d" (point))))
(g/set-key '("M-f") 'forward-word)
(g/set-key '("M-b") 'backward-word)
(g/set-key '("C-Ꮎ" "C-n") 'next-line)
(g/set-key '("C-p" "C-Ꮑ") 'previous-line)
(g/set-key '("C-a" "C-Ꭰ") 'move-beginning-of-line)
(g/set-key '("C-e" "C-Ꭱ") 'move-end-of-line)
(g/set-key '("C-k" "C-Ꮈ") 'kill-line)
(g/set-key '("C-<" "C-Ꮲ") 'decrease-left-margin)
(g/set-key '("C-Ꮄ" "C->") 'increase-left-margin)

(g/set-key "C-c C-r" 'ruskify-region)
(g/set-key '("C-x C-2" "C-x C-e C-g") 'make-frame-command)
(g/set-key '("C-x C-e C-o") 'other-frame)
(g/set-key "<f12>" 'g/build)
(g/set-key '("C-c C-n" "C-x C-n") 'uncomment-region)
(g/set-key '("C-c c" "C-#") 'comment-region)
(g/set-key '("C-c C-x C-e" "C-c C-d C-e"
             "C-c C-e C-b" "C-x C-d C-e")
           'base64-encode-region)
(g/set-key '("C-c C-x C-e" "C-c C-d C-d"
             "C-x C-d C-d")
           'base64-decode-region)

(g/set-key "C-c C-e C-3" 'rot13-region)
(progn
  (put 'upcase-region 'disabled nil)
  (g/set-key "C-x C-u" #'(lambda () (interactive) (error "C-x C-k")))
  (g/set-key '("C-x C-k" "C-c C-k") #'upcase-region))

(progn
  (put 'downcase-region 'disabled nil)
  (g/set-key "C-x C-l" #'downcase-region)
  (g/set-key "C-c C-l" #'downcase-region))


(g/set-key   '("C-z" "M-z" "C-_") 'undo     )
(g/set-key   '("M-r") 'replace-regexp       )
(g/set-key   '("C-g" "C-q") 'keyboard-quit  )
(g/set-key   '("M-u" "M-l" "M-ESC") 'ah     )
(g/set-key   "C-s"   'isearch-forward-regexp )
(g/set-key   "C-S-s" 'isearch-backward-regexp)

(g/set-key "M-G" #'(lambda () (interactive) (insert "Ꭶ")))
(g/set-key "M-g g" 'goto-line)
(g/set-key "M-g M-g" 'goto-line)
(g/set-key "M-O" #'(lambda () (interactive) (insert "ॐ")))
(setq ns-allow-anti-aliasing t)
(setq ns-function-modifier 'control)
(setq ns-option-modifier 'meta)
(setq ns-command-modifier 'meta)
(global-set-key [kp-delete] 'delete-char)


(column-number-mode)
(setq select-enable-clipboard nil)
(setq ring-bell-function 'ignore)
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq show-paren-delay 0 show-paren-style 'parenthesis)
(setq scroll-conservatively 101)
(setq show-trailing-whitespace t)
(setq backup-by-copying t backup-directory-alist '(("." . "~/.emacs.backups")) delete-old-versions t kept-new-versions 0 kept-old-versions 0 version-control t)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq completion-ignored-extensions '(".lock" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".dfsl" ".pfsl" ".d64fsl" ".p64fsl" ".lx64fsl" ".lx32fsl" ".dx64fsl" ".dx32fsl" ".fx64fsl" ".fx32fsl" ".sx64fsl" ".sx32fsl" ".wx64fsl" ".wx32fsl" ".fasl" ".ufsl" ".fsl" ".dxl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo"))
;;; nichts
(setq read-file-name-completion-ignore-case t)

;;;
