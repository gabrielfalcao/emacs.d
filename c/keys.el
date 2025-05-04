(setup-utf8)

($/undefine-key
 '(
   "C-x C-z"
   "C-c C-d"
   "C-c C-r"
   "C-c C-x"
   ;; "M-o M-g"
   "C-g"
   "C-S"
   "C-q"
   "C-s"
   "C-c C-x"
   ;; "C-c C-u"
   "C-x C-e"
   "C-x C-d"
   ;; "C-x C-p"
   "M-j"
   "M-t"
   "M-k"
   "M-," "M-;"
   "s-&" "s-'" "s-+" "s-," "s--" "s-0" "s-:" "s-=" "s-?" "s-C" "s-D" "s-E" "s-F" "s-H" "s-L" "s-M" "s-S" "s-^" "s-`" "s-a" "s-c" "s-d" "s-e" "s-f" "s-g" "s-h" "s-j" "s-k" "s-l" "s-m" "s-n" "s-o" "s-p" "s-q" "s-s" "s-t" "s-u" "s-v" "s-w" "s-x" "s-y" "s-z" "s-|" "s-~" "M-r"
   )
 )


($/set-key (meta-comma ",") #'(lambda () (interactive) (find-file "~/.emacs.d/t/k.el")))
($/set-key (meta-comma "f") #'(lambda () (interactive) (find-file "~/.emacs.d/t/f.el")))
($/set-key (meta-comma "8") #'(lambda () (interactive) (find-file "~/.emacs.d/t/8O1.el")))
($/set-key (meta-comma "5") #'(lambda () (interactive) (find-file "~/.emacs.d/t/5O1.el")))
($/set-key (meta-comma "o") #'(lambda () (interactive) (find-file "~/.emacs.d/t/ori.el")))
($/set-key '("M-k") '$/flush-kill-ring)
($/set-key '("C-M-k") '$/kill-all-buffers-and-flush-kill-ring)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-save-hook '$$$$$)
(add-hook 'after-init-hook '$$$$$)
(add-hook 'after-init-hook #'(lambda () (interactive) (ignore-errors (delete-minibuffer-contents) (message "emacs init took %s to initialize" (emacs-init-time)))))
($/set-key '("C-x C-x") '$/levate)
($/set-key '("C-x C-z") #'(lambda () (interactive) (eval-buffer) (message "%s eval'd " (buffer-name))))

($/set-key '("C-x C--") 'text-scale-adjust)
($/set-key '("C-x C-+") 'text-scale-adjust)
($/set-key '("C-x -") 'text-scale-adjust)
($/set-key '("C-x +") 'text-scale-adjust)
($/set-key '("C-c C-l") 'collapse-lines-region)
($/set-key '("C-c C-t C-m C-l") '$$$$$)
($/set-key '("C-c C-x C-f") 'show-face-at-point)
($/set-key '("C-c C-w" "C-c M-w") 'clipboard-kill-ring-save)
($/set-key '("C-c C-y" "C-c M-y") 'clipboard-yank)
($/set-key '("C-x C-q" "C-c M-y" "C-γ") 'keyboard-quit)
($/set-key '("C-x C-d C-h") 'info)
;; ($/set-key "C-c C-u C-d C-a" #'(lambda () (interactive) (when (read-only-mode -8) (message "%s unlocked" (buffer-name)))))

($/set-key '("C-x M-k") '$/load-library)($/set-key '("C-x M-,") '$/load-init)

(global-set-key (kbd "C-c C-c C-r") 'collapse-lines-region)

;; ($/set-key '("M-, M-8" "M-, 8")#'(lambda () (interactive) (rot13(fpuervo) "OE8x"))) ;; https://deezer.page.link/HUJ1z8CfsudS2he96
;; ($/set-key '("M-, M-5" "M-, 5")#'(lambda () (interactive) (schreib "NU8x")))
;; ($/set-key '("M-, M-t" "M-, t")#'(lambda () (interactive) (schreib "b3Jp")))

($/set-key "C-x C-d C-s" 'describe-symbol)
($/set-key "C-x C-d C-g" 'shortdoc-display-group)
($/set-key "C-x C-d C-X"
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

($/set-key '("C-p" "M-p") #'(lambda () (interactive) (scroll-up 1)))
($/set-key '("C-n" "M-n") #'(lambda () (interactive) (scroll-down 1)))
($/set-key '("C-n" "M-n") #'(lambda () (interactive) (scroll-down 1)))
($/set-key '("<backtab>") #'(lambda () (interactive) (other-frame 1)))
($/set-key '("C-c C-d C-c") 'colorize-hexadecimal-text)


($/set-key '("C-x C-SPC" "C-c C-SPC") 'rectangle-mark-mode)
($/set-key "C-x C-e e" 'g/ep)
($/set-key "M-s" 'save-buffer)
($/set-key "C-c C-p" #'(lambda () (interactive) (message "cur %d" (point))))
($/set-key '("M-f") 'forward-word)
($/set-key '("M-b") 'backward-word)
($/set-key '("C-Ꮎ" "C-n") 'next-line)
($/set-key '("C-p" "C-Ꮑ") 'previous-line)
($/set-key '("C-a" "C-Ꭰ") 'move-beginning-of-line)
($/set-key '("C-e" "C-Ꭱ") 'move-end-of-line)
($/set-key '("C-k" "C-Ꮈ") 'kill-line)
($/set-key '("C-<" "C-Ꮲ") 'decrease-left-margin)
($/set-key '("C-Ꮄ" "C->") 'increase-left-margin)

($/set-key '("C-c C-r" "C-c r") 'reverse-string)
($/set-key '("C-x C-2" "C-x C-e C-g") 'make-frame-command)
($/set-key '("C-x C-e C-o") 'other-frame)
($/set-key "<f12>" 'g/build)
($/set-key '("M-<f10>" "M-<f11>" "M-<f12>" ) 'revert-buffer)
($/set-key '("C-c C-n" "C-x C-n" "C-c C-M-n") 'uncomment-region)
($/set-key '("C-c c" "C-#" "C-c C-M-c") 'comment-region)
($/set-key '("C-c C-x C-e" "C-c C-d C-e"
             "C-c C-e C-b" "C-x C-d C-e")
           '$/base64-encode-region)
($/set-key '("C-c C-x C-d" "C-c C-d C-d"
             "C-x C-d C-d")
           'base64-decode-region)

($/set-key '("C-c C-d C-3" "C-x C-d C-3" "C-c C-e C-3" "C-x C-e C-3") 'rot13-region)
($/set-key   '("C-z" "M-z" "C-_") 'undo      )
($/set-key   '("M-ρ" "C-r") 'replace-regexp  )
($/set-key   '("C-c M-s") 'replace-string    )
($/set-key   '("M-a") 'ignore                )
($/set-key   '("M-c") 'ignore                )
($/set-key   '("C-g" "C-q") 'keyboard-quit   )

($/set-key   "C-s"   'isearch-forward-regexp )
($/set-key   "C-S-s" 'isearch-backward-regexp)
($/set-key   "M-G" #'(lambda () (interactive) (insert "$")))
($/set-key   '("M-g g" "M-g M-g") 'goto-line)
($/set-key   "C-x C-z" #'(lambda () (interactive) (insert "\n")))

(setq        ring-bell-function               'ignore)
(global-set-key [kp-delete] 'delete-char)
(setq select-enable-clipboard nil)
(setq inhibit-splash-screen t)
(setq inhibit-startup-screen t)
(setq show-paren-delay 0 show-paren-style 'parenthesis)
(setq scroll-conservatively 101)
(setq show-trailing-whitespace t)
(setq backup-by-copying t backup-directory-alist '(("." . "~/.emacs.backups")) delete-old-versions t kept-new-versions 0 kept-old-versions 0 version-control t)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq completion-ignored-extensions '(".lock" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".dfsl" ".pfsl" ".d64fsl" ".p64fsl" ".lx64fsl" ".lx32fsl" ".dx64fsl" ".dx32fsl" ".fx64fsl" ".fx32fsl" ".sx64fsl" ".sx32fsl" ".wx64fsl" ".wx32fsl" ".fasl" ".ufsl" ".fsl" ".dxl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo"))
;;;
(setq read-file-name-completion-ignore-case nil)
(setq ns-allow-anti-aliasing t)
(setq ns-function-modifier 'control)
(setq ns-option-modifier 'meta)
(setq ns-command-modifier 'meta)


($/set-key '("C-x C--") 'text-scale-adjust)
($/set-key '("C-x C-d C-k") 'describe-key)
($/set-key '("C-x C-d k") 'describe-keymap)
;; (setq tab-always-indent 'complete)
;; ($/set-key '("<tab>") 'indent-for-tab-command)
($/set-key '("C-x j") #'(lambda () (interactive) (progn (auto-fill-mode -5) (insert "\n"))))


($/set-key   '(
               "C-f"
               )
             'forward-char)
($/set-key   '(
               "C-b"
               )
             'backward-char)

($/set-key   '(
               "C-n"
               )
             'next-line)
($/set-key   '(
               "C-p"
               )
             'previous-line)
($/set-key   '(
               "M-f"
               )
             'forward-word)
($/set-key   '(
               "M-b"
               )
             'backward-word)
($/set-key   '(
               "C-a"
               )
             'beginning-of-line)
($/set-key   '(
               "C-e"
               )
             'end-of-line)
($/set-key   '(
               "M-<"
               )
             'beginning-of-buffer)
($/set-key   '(
               "M->"
               )
             'end-of-buffer)
($/set-key   '(
               "C-k"
               )
             'kill-line)

(progn
  (put 'upcase-region 'disabled nil)
  ($/set-key '("C-x C-u" "C-c C-u") #'upcase-region))

(progn
  (put 'downcase-region 'disabled nil)
  ($/set-key "C-x C-l" #'downcase-region)
  ($/set-key "C-c C-l" #'downcase-region))
