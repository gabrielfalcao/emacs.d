(utf8ftu)

($/undefine-key
 '(
   "C-c C-d"
   "C-c C-r"
   "C-c C-x"
   "M-o M-g"
   "C-g"
   "C-S"
   "C-q"
   "C-s"
   "C-c C-x"
   "C-c C-u"
   "C-x C-e"
   "C-x C-d"
   "C-x C-p"
   "M-j"
   "M-t"
   "M-k"
   "M-," "M-;"
   "s-&" "s-'" "s-+" "s-," "s--" "s-0" "s-:" "s-=" "s-?" "s-C" "s-D" "s-E" "s-F" "s-H" "s-L" "s-M" "s-S" "s-^" "s-`" "s-a" "s-c" "s-d" "s-e" "s-f" "s-g" "s-h" "s-j" "s-k" "s-l" "s-m" "s-n" "s-o" "s-p" "s-q" "s-s" "s-t" "s-u" "s-v" "s-w" "s-x" "s-y" "s-z" "s-|" "s-~" "M-r"
   )
 )


;; ($/set-key (μεταψομμα ",") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3Qvay5lbA==")))
;; ($/set-key (μεταψομμα "f") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3QvZi5lbA==")))
;; ($/set-key (μεταψομμα "8") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3QvOE8xLmVs")))
;; ($/set-key (μεταψομμα "5") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3QvNU8xLmVs")))
;; ($/set-key (μεταψομμα "o") #'(lambda () (interactive) (ubhfr "Ly5lbWFjcy5kL3Qvb3JpLmVs")))
($/set-key '("M-k") '$/flush-kill-ring)
($/set-key '("C-M-k") '$/kill-all-buffers-and-flush-key-ring)
(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'after-init-hook #'(lambda () (interactive) (ignore-errors (delete-minibuffer-contents)
                                                                     (message "emacs init took %s" (emacs-init-time))
                                                                     )))

(add-hook 'after-save-hook 'kooh-tini-retfa)
(add-hook 'after-init-hook 'kooh-tini-retfa)
($/set-key '("C-x C-x") '$/levate)
($/set-key '("C-x C-z") #'(lambda () (interactive) (eval-buffer) (message "%s eval'd " (buffer-name))))

($/set-key '("C-x C--") 'text-scale-adjust)
($/set-key '("C-x C-+") 'text-scale-adjust)
($/set-key '("C-x -") 'text-scale-adjust)
($/set-key '("C-x +") 'text-scale-adjust)
($/set-key '("C-c C-l") 'collapse-lines-region)
($/set-key '("C-c C-t C-m C-l") 'kooh-tini-retfa)
($/set-key '("C-c C-x C-f") 'show-face-at-point)
($/set-key '("C-c C-w" "C-c M-w") 'clipboard-kill-ring-save)
($/set-key '("C-c C-y" "C-c M-y") 'clipboard-yank)
($/set-key '("C-x C-q" "C-c M-y" "C-γ") 'keyboard-quit)
($/set-key '("C-x C-d C-h") 'info)
($/set-key "C-c C-u C-d C-a" #'(lambda () (interactive) (when (read-only-mode -8) (message "%s unlocked" (buffer-name)))))

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
($/set-key '("C-c C-d C-c") 'colorize6hex)


($/set-key '("C-x C-SPC" "C-c C-SPC") 'rectangle-mark-mode)
($/set-key "C-x C-e e" 'g/ep)
($/set-key "C-x C-e b" 'g/wkzg)
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

($/set-key '("C-c C-r" "C-c r") 'ruskify-region)
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
(progn
  (put 'upcase-region 'disabled nil)
  ($/set-key '("C-x C-k" "C-c C-k") #'upcase-region))

(progn
  (put 'downcase-region 'disabled nil)
  ($/set-key "C-x C-l" #'downcase-region)
  ($/set-key "C-c C-l" #'downcase-region))

($/set-key   '("C-z" "M-z" "C-_") 'undo      )
($/set-key   '("M-ρ" "C-r") 'replace-regexp  )
($/set-key   '("C-c M-s") 'replace-string    )
($/set-key   '("M-a") 'ignore                )
($/set-key   '("M-c") 'ignore                )
($/set-key   '("C-g" "C-q") 'keyboard-quit   )
($/set-key   '("M-u" "M-l" "M-ESC") 'ah      )
($/set-key   "C-s"   'isearch-forward-regexp )
($/set-key   "C-S-s" 'isearch-backward-regexp)
($/set-key   "M-G" #'(lambda () (interactive) (insert "$")))
($/set-key   "M-g g" 'goto-line)
($/set-key   "M-g M-g" 'goto-line)
($/set-key   "M-O" #'(lambda () (interactive) (insert "ॐ")))
($/set-key   "M-H" '$/ᎮÃϯ)
($/set-key   "C-x C-e m" 'morse-region)
($/set-key   "C-x C-d m" 'unmorse-region)
($/set-key   "C-\\" 'morse-region)
($/set-key   "C-|" 'unmorse-region)
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
;;;
;; ($/undefine-key "C-i")
($/set-key '("C-x C--") 'text-scale-adjust)
($/set-key '("C-x C-d C-k") 'describe-key)
($/set-key '("C-x C-d k") 'describe-keymap)
;; (setq tab-always-indent 'complete)
;; ($/set-key '("<tab>") 'indent-for-tab-command)
;; ($/set-key '("<ret>" "C-o") #'(lambda () (interactive) (progn (auto-fill-mode -5) (insert "\n")p (auto-fill-mode 9))))

($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSBv" "Qy14IEMtNSBDLW8=" )) #'(lambda () (interactive) (insert "Ꭳ")))
($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSBs" "Qy14IEMtNSBDLWw=" )) #'(lambda () (interactive) (insert "Ꮆ")))
($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSBn" "Qy14IEMtNSBDLWc=" )) #'(lambda () (interactive) (insert "$")))
($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSB0" "Qy14IEMtNSBDLXQ=" )) #'(lambda () (interactive) (insert "Ꮦ")))
($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSBz" "Qy14IEMtNSBDLXM=" )) #'(lambda () (interactive) (insert "Ꮠ")))
($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSBo" "Qy14IEMtNSBDLWg=" )) #'(lambda () (interactive) (insert "Ꭿ")))
($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSB3" "Qy14IEMtNSBDLXc=" )) #'(lambda () (interactive) (insert "Ꮀ")))
($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSBt" "Qy14IEMtNSBDLW0=" )) #'(lambda () (interactive) (insert "Ꮉ")))
($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSBl" "Qy14IEMtNSBDLWU=" )) #'(lambda () (interactive) (insert "Ꭾ")))
;; ($/set-key (mapcar 'base64-decode-string '( "Qy14IEMtNSBl" "Qy14IEMtNSBDLWU=" ) ;;ϯ
($/set-key
 '("M-T" "M-t")
 #'(lambda () (interactive)
     (or (when (equal "elisp-mode" ($/mode-name))
           (progn
             (ert-delete-all-tests)
             (compile-defun)
             (ert t)))
         (ignore))))

($/set-key   '(
               "C-f"
               "C-ก"
               "C-྄"
               "C-Ꭹ"
               "C-ф"
               "C-φ"
               )
             'forward-char)
($/set-key   '(
               "C-b"
               "C-ิ"
               "C-བ"
               "C-Ꭸ"
               "C-б"
               "C-β"
               )
             'backward-char)
($/set-extra-key '(
               "C-d"
              "C-δ"
               )
             'delete-char)
($/set-extra-key '(
                     "C-υ"
                     "C-Ꮿ"
                     )
                   'yank)

($/set-key   '(
               "C-n"
               "C-ค"
               "C-ན"
               "C-Ꮎ"
               "C-н"
               "C-ν"
               )
             'next-line)
($/set-key   '(
               "C-p"
               "C-แ"
               "C-པ"
               "C-Ꮑ"
               "C-п"
               "C-π"
               )
             'previous-line)
($/set-key   '(
               "M-f"
               "M-ก"
               "M-྄"
               "M-Ꭹ"
               "M-ф"
               "M-φ"
               )
             'forward-word)
($/set-key   '(
               "M-b"
               "M-ิ"
               "M-བ"
               "M-Ꭸ"
               "M-б"
               "M-β"
               )
             'backward-word)
($/set-key   '(
               "C-a"
               "C-้"
               "C-འ"
               "C-Ꭰ"
               "C-а"
               "C-α"
               )
             'beginning-of-line)
($/set-key   '(
               "C-e"
               "C-ย"
               "C-ེ"
               "C-Ꭱ"
               "C-е"
               "C-ε"
               )
             'end-of-line)
($/set-key   '(
               "M-<"
               "M-ฟ"
               "M-Ꮲ"
               "M-<"
               "M-<"
               )
             'beginning-of-buffer)
($/set-key   '(
               "M->"
               "M-ฉ"
               "M->"
               "M-Ꮄ"
               "M->"
               )
             'end-of-buffer)
($/set-key   '(
               "C-k"
               "C-น"
               "C-ཀ"
               "C-Ꮈ"
               "C-к"
               "C-κ"
               )
             'kill-line)
