(setup-utf8)

(Ox33b4O/$/undefine-key
 '(
   "C-x C-z"
   "C-c C-d"
   "C-c C-r"
   "C-c C-x"
   ;; "M-o M-g"
   "C-g"
   "C-S"
   "C-S-r"
   "C-S-d"
   "C-S-i"
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


(Ox33b4O/$/set-key (meta-comma ",") #'(lambda () (interactive) (find-file "~/.emacs.d/t/k.el")))
(Ox33b4O/$/set-key (meta-comma "f") #'(lambda () (interactive) (find-file "~/.emacs.d/t/f.el")))
(Ox33b4O/$/set-key (meta-comma "8") #'(lambda () (interactive) (find-file "~/.emacs.d/t/8O1.el")))
(Ox33b4O/$/set-key (meta-comma "5") #'(lambda () (interactive) (find-file "~/.emacs.d/t/5O1.el")))
(Ox33b4O/$/set-key (meta-comma "o") #'(lambda () (interactive) (find-file "~/.emacs.d/t/ori.el")))
(Ox33b4O/$/set-key '("M-k") 'Ox33b4O/$/flush-kill-ring)
(Ox33b4O/$/set-key '("C-M-k") 'Ox33b4O/$/kill-all-buffers-and-flush-kill-ring)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-save-hook '$$$$$)
(add-hook 'after-init-hook '$$$$$)
(add-hook 'after-init-hook #'(lambda () (interactive) (ignore-errors (delete-minibuffer-contents) (message "emacs init took %s to initialize" (emacs-init-time)))))
(Ox33b4O/$/set-key '("C-S-r") 're-builder)
(Ox33b4O/$/set-key '("C-S-d") #'decr-next-number)
(Ox33b4O/$/set-key '("C-S-i") #'incr-next-number)

(Ox33b4O/$/set-key '("C-x C-M-a") #'Ox33b4O/$/reload-all-c)
(Ox33b4O/$/set-key '("C-x C-M-s") #'insert-regexp-linebreak-tabs-and-spaces)
(Ox33b4O/$/set-key '("C-x C-M-t") #'insert-control-character-tab)
(Ox33b4O/$/set-key '("C-x C-M-c TAB") #'insert-control-character-tab)
(Ox33b4O/$/set-key '("C-x C-M-c RET") #'insert-control-character-newline)
(Ox33b4O/$/set-key '("C-x C-M-c DEL") #'insert-control-character-carriage-return)
(Ox33b4O/$/set-key '("C-x C-M-i TAB") #'insert-control-character-tab)
(Ox33b4O/$/set-key '("C-x C-M-i RET") #'insert-control-character-newline)
(Ox33b4O/$/set-key '("C-x C-M-i DEL") #'insert-control-character-carriage-return)
(Ox33b4O/$/set-key '("C-x C-M-e") #'Ox33b4O/$/reload-init)
;; (Ox33b4O/$/set-key '("C-x C-M-g a") 'git-add)
;; (Ox33b4O/$/set-key '("C-x C-M-g s") 'git-save)
(Ox33b4O/$/set-key '("C-x C-g") #'git-save)
(Ox33b4O/$/set-key '("C-x C-a") #'eval-elisp-buffer)
(Ox33b4O/$/set-key '("C-x C-x") #'eval-elisp-buffer)

(Ox33b4O/$/set-key '("C-x C--") 'text-scale-adjust)
(Ox33b4O/$/set-key '("C-x C-+") 'text-scale-adjust)
(Ox33b4O/$/set-key '("C-x -") 'text-scale-adjust)
(Ox33b4O/$/set-key '("C-x +") 'text-scale-adjust)
(Ox33b4O/$/set-key '("C-c C-l") 'collapse-lines-region)
(Ox33b4O/$/set-key '("C-c C-t C-m C-l") '$$$$$)
(Ox33b4O/$/set-key '("C-c C-x C-f") 'show-face-at-point)
(Ox33b4O/$/set-key '("C-c C-w" "C-c M-w") 'clipboard-kill-ring-save)
(Ox33b4O/$/set-key '("C-c C-x C-w") 'clipboard-kill-region)
(Ox33b4O/$/set-key '("C-c C-y" "C-c M-y") 'clipboard-yank)
(Ox33b4O/$/set-key '("C-x C-q" "C-c M-y" "C-γ") 'keyboard-quit)
(Ox33b4O/$/set-key '("C-x C-d C-h") 'info)
;; (Ox33b4O/$/set-key "C-c C-u C-d C-a" #'(lambda () (interactive) (when (read-only-mode -8) (message "%s unlocked" (buffer-name)))))

(Ox33b4O/$/set-key '("C-x M-k") 'Ox33b4O/$/load-library)(Ox33b4O/$/set-key '("C-x M-,") 'Ox33b4O/$/load-init)

(global-set-key (kbd "C-c C-c C-r") 'collapse-lines-region)

;; (Ox33b4O/$/set-key '("M-, M-8" "M-, 8")#'(lambda () (interactive) (rot13(fpuervo) "OE8x"))) ;; https://deezer.page.link/HUJ1z8CfsudS2he96
;; (Ox33b4O/$/set-key '("M-, M-5" "M-, 5")#'(lambda () (interactive) (schreib "NU8x")))
;; (Ox33b4O/$/set-key '("M-, M-t" "M-, t")#'(lambda () (interactive) (schreib "b3Jp")))

(Ox33b4O/$/set-key "C-x C-d C-s" 'describe-symbol)
(Ox33b4O/$/set-key "C-x C-d C-g" 'shortdoc-display-group)
(Ox33b4O/$/set-key "C-x C-d C-X"
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

(Ox33b4O/$/set-key '("C-p" "M-p") #'(lambda () (interactive) (scroll-up 1)))
(Ox33b4O/$/set-key '("C-n" "M-n") #'(lambda () (interactive) (scroll-down 1)))
(Ox33b4O/$/set-key '("C-n" "M-n") #'(lambda () (interactive) (scroll-down 1)))
(Ox33b4O/$/set-key '("<backtab>") #'(lambda () (interactive) (other-frame 1)))
(Ox33b4O/$/set-key '("C-c C-d C-c") 'colorize-hexadecimal-text)


(Ox33b4O/$/set-key '("C-x C-SPC" "C-c C-SPC") 'rectangle-mark-mode)
(Ox33b4O/$/set-key "C-x C-e e" 'g/ep)
(Ox33b4O/$/set-key "M-s" 'save-buffer)
(Ox33b4O/$/set-key "C-c C-p" #'(lambda () (interactive) (message "cur %d" (point))))
(Ox33b4O/$/set-key '("M-f") 'forward-word)
(Ox33b4O/$/set-key '("M-b") 'backward-word)
(Ox33b4O/$/set-key '("C-Ꮎ" "C-n") 'next-line)
(Ox33b4O/$/set-key '("C-p" "C-Ꮑ") 'previous-line)
(Ox33b4O/$/set-key '("C-a" "C-Ꭰ") 'move-beginning-of-line)
(Ox33b4O/$/set-key '("C-e" "C-Ꭱ") 'move-end-of-line)
(Ox33b4O/$/set-key '("C-k" "C-Ꮈ") 'kill-line)
(Ox33b4O/$/set-key '("C-<" "C-Ꮲ") 'decrease-left-margin)
(Ox33b4O/$/set-key '("C-Ꮄ" "C->") 'increase-left-margin)

(Ox33b4O/$/set-key '("C-c C-r" "C-c r") 'reverse-string)
(Ox33b4O/$/set-key '("C-x C-2" "C-x C-e C-g") 'make-frame-command)
(Ox33b4O/$/set-key '("C-x C-e C-o") 'other-frame)
(Ox33b4O/$/set-key "<f12>" 'g/build)
(Ox33b4O/$/set-key '("M-<f10>" "M-<f11>" "M-<f12>" ) 'revert-buffer)
(Ox33b4O/$/set-key '("C-c C-n" "C-x C-n" "C-c C-M-n") 'uncomment-region)
(Ox33b4O/$/set-key '("C-c c" "C-#" "C-c C-M-c") 'comment-region)
(Ox33b4O/$/set-key '("C-c C-x C-e" "C-c C-d C-e"
             "C-c C-e C-b" "C-x C-d C-e")
           'Ox33b4O/$/base64-encode-region)
(Ox33b4O/$/set-key '("C-c C-x C-d" "C-c C-d C-d"
             "C-x C-d C-d")
           'base64-decode-region)

(Ox33b4O/$/set-key '("C-c C-d C-3" "C-x C-d C-3" "C-c C-e C-3" "C-x C-e C-3") 'rot13-region)
(Ox33b4O/$/set-key   '("C-z" "M-z" "C-_") 'undo      )
(Ox33b4O/$/set-key   '("M-ρ" "C-r") 'replace-regexp  )
(Ox33b4O/$/set-key   '("C-c M-s") 'replace-string    )
(Ox33b4O/$/set-key   '("M-a") 'ignore                )
(Ox33b4O/$/set-key   '("M-c") 'ignore                )
(Ox33b4O/$/set-key   '("C-g" "C-q") 'keyboard-quit   )

(Ox33b4O/$/set-key   "C-s"   'isearch-forward-regexp )
(Ox33b4O/$/set-key   "C-S-s" 'isearch-backward-regexp)
(Ox33b4O/$/set-key   "M-G" #'(lambda () (interactive) (insert "$")))
(Ox33b4O/$/set-key   '("M-g g" "M-g M-g") 'goto-line)
(Ox33b4O/$/set-key   "C-x C-z" #'(lambda () (interactive) (insert "\n")))
(Ox33b4O/$/set-key   "C-x C-j" #'(lambda () (interactive) (insert "\n")))

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


(Ox33b4O/$/set-key '("C-x C--") 'text-scale-adjust)
(Ox33b4O/$/set-key '("C-x C-d C-k") 'describe-key)
(Ox33b4O/$/set-key '("C-x C-d k") 'describe-keymap)
;; (setq tab-always-indent 'complete)
;; (Ox33b4O/$/set-key '("<tab>") 'indent-for-tab-command)
(Ox33b4O/$/set-key '("C-x j") #'(lambda () (interactive) (progn (auto-fill-mode -5) (insert "\n"))))


(Ox33b4O/$/set-key   '(
               "C-f"
               )
             'forward-char)
(Ox33b4O/$/set-key   '(
               "C-b"
               )
             'backward-char)

(Ox33b4O/$/set-key   '(
               "C-n"
               )
             'next-line)
(Ox33b4O/$/set-key   '(
               "C-p"
               )
             'previous-line)
(Ox33b4O/$/set-key   '(
               "M-f"
               )
             'forward-word)
(Ox33b4O/$/set-key   '(
               "M-b"
               )
             'backward-word)
(Ox33b4O/$/set-key   '(
               "C-a"
               )
             'beginning-of-line)
(Ox33b4O/$/set-key   '(
               "C-e"
               )
             'end-of-line)
(Ox33b4O/$/set-key   '(
               "M-<"
               )
             'beginning-of-buffer)
(Ox33b4O/$/set-key   '(
               "M->"
               )
             'end-of-buffer)
(Ox33b4O/$/set-key   '(
               "C-k"
               )
             'kill-line)

(progn
  (put 'upcase-region 'disabled nil)
  (Ox33b4O/$/set-key '("C-x C-u" "C-c C-u") #'upcase-region))

(progn
  (put 'downcase-region 'disabled nil)
  (Ox33b4O/$/set-key "C-x C-l" #'downcase-region)
  (Ox33b4O/$/set-key "C-c C-l" #'downcase-region))
