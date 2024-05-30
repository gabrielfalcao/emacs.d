;; package -- 8O1.el
;;    /##  ### /### /###     /###     /###     /###
;;   / ###  ##/ ###/ /##  / / ###  / / ###  / / #### /
;;  /   ###  ##  ###/ ###/ /   ###/ /   ###/ ##  ###/
;; ##    ### ##   ##   ## ##    ## ##       ####
;; ########  ##   ##   ## ##    ## ##         ###
;; #######   ##   ##   ## ##    ## ##           ###
;; ##        ##   ##   ## ##    ## ##             ###
;; ####    / ##   ##   ## ##    /# ###     / /###  ##
;;  ######/  ###  ###  ### ####/ ## ######/ / #### /
;;   #####    ###  ###  ### ###   ## #####     ###/
(server-mode 9)
    (progn
      (add-hook 'before-save-hook 'delete-trailing-whitespace)
      (add-hook 'write-files-hook 'disavail-asl)
      (user-full-name)
      (global-unset-key (kbd "C-c C-u"))
      (global-unset-key (kbd "C-x C-d"))
      (global-unset-key (kbd "C-x C-e"))
      (global-set-key (kbd "C-c C-u C-d C-a") #'(lambda (&optional buffer) (interactive "ob UNlock BUffer")
                                                  (when buffer (pop-to-buffer buffer))
                                                  (read-only-mode -1)))
      (global-set-key (kbd "C-x C-d C-s") 'describe-symbol)
      (global-set-key (kbd "C-x C-d C-g") 'shortdoc-display-group)
      (global-set-key (kbd "C-x C-d C-X")
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


      (global-set-key (kbd "C-x C-e e") 'g/ep)
      (global-set-key (kbd "C-x C-e b") 'g/wkzg)
      (global-set-key (kbd "M-s") 'save-buffer)
      (global-set-key (kbd "C-c C-p") #'(lambda () (interactive) (message "cur %d" (point))))
      (global-set-key (kbd "C-<") 'decrease-left-margin)
      (global-set-key (kbd "C-Ꮎ") 'next-line)
      (global-set-key (kbd "C-n") 'next-line)
      (global-set-key (kbd "C-p") 'previous-line)
      (global-set-key (kbd "C-Ꮑ") 'previous-line)
      (global-set-key (kbd "C-a") 'move-beginning-of-line)
      (global-set-key (kbd "C-e") 'move-end-of-line)
      (global-set-key (kbd "C-Ꭰ") 'move-beginning-of-line)
      (global-set-key (kbd "C-Ꭱ") 'move-end-of-line)
      (global-set-key (kbd "C-k") 'kill-line)
      (global-set-key (kbd "C-Ꮈ") 'kill-line)
      (global-set-key (kbd "C-Ꮲ") 'decrease-left-margin)
      (global-set-key (kbd "C-Ꮄ") 'increase-left-margin)
      (global-set-key (kbd "C->") 'increase-left-margin)

      (global-unset-key (kbd "C-x 5 2"))
      (global-set-key (kbd "C-c C-r") 'ruskify-region)
      (global-set-key (kbd "C-x 5 3") 'make-frame-command)
      (global-set-key (kbd "<f12>") 'cargo-mode-build)
      (progn
        (global-set-key (kbd "C-c C-n") 'uncomment-region)
        (global-set-key (kbd "C-x C-n") 'uncomment-region)
        (global-set-key (kbd "C-c c") 'comment-region)
        (global-set-key (kbd "C-#") 'comment-region))

      (progn
        (global-set-key (kbd "C-c C-x C-e") 'base64-encode-region)
        (global-set-key (kbd "C-c C-x C-d") 'base64-decode-region)
        (global-set-key (kbd "C-c C-e C-3") 'rot13-region)
        (global-set-key (kbd "C-c C-e C-b") 'base64-encode-region)
        )
      (progn
        (put 'upcase-region 'disabled nil)
        (global-set-key (kbd "C-x C-u") #'(lambda () (interactive) (error "C-x C-k")))
        (global-set-key (kbd "C-x C-k") #'upcase-region)
        (global-set-key (kbd "C-c C-k") #'upcase-region)
        )
      (progn
        (put 'downcase-region 'disabled nil)
        (global-set-key (kbd "C-x C-l") #'downcase-region)
        (global-set-key (kbd "C-c C-l") #'downcase-region))

      (global-set-key [(shift C-tab)] #'(lambda () (interactive) (other-window -1)))
      (global-set-key [(meta n)] #'(lambda () (interactive) (scroll-up 1)))
      (global-set-key [(meta p)] #'(lambda () (interactive) (scroll-down 1)))
      (global-set-key [(meta j)] #'(lambda () (interactive) (scroll-other-window 1)))
      (global-set-key [(meta k)] #'(lambda () (interactive) (scroll-other-window -1)))
      (global-set-key [(ctrl s)] 'isearch-forward)



      (progn
        (global-unset-key (kbd "C-g"))
        (global-set-key (kbd "C-g") 'keyboard-quit)
        (global-set-key (kbd "M-u") 'ah)
        (global-set-key (kbd "M-l") 'ah)
        (global-set-key (kbd "M-ESC") 'ah)
        (global-unset-key (kbd "C-q"))
        (global-unset-key (kbd "C-s"))
        (global-unset-key (kbd "C-S"))
        (global-set-key (kbd "C-q") 'keyboard-quit)
        (global-set-key (kbd "C-s") 'isearch-forward-regexp)
        (global-set-key (kbd "C-S") 'isearch-backward-regexp))
      (progn
        (global-unset-key (kbd "M-o"))
        (global-unset-key (kbd "M-g"))
        (global-set-key (kbd "M-G") #'(lambda () (interactive) (insert "Ꭶ")))
        (global-set-key (kbd "M-g g") 'goto-line)
        (global-set-key (kbd "M-g M-g") 'goto-line)
        (global-set-key (kbd "M-O") #'(lambda () (interactive) (insert "ॐ"))))

      (setq mac-option-modifier 'meta)
      (setq mac-command-modifier 'meta)
      (global-set-key [kp-delete] 'delete-char)
      (progn
        (prefer-coding-system 'utf-8)
        (setq locale-coding-system 'utf-8)
        (setq current-language-environment "UTF-8")
        (set-default-coding-systems 'utf-8)
        (set-terminal-coding-system 'utf-8)
        (set-keyboard-coding-system 'utf-8)
        (set-selection-coding-system 'utf-8))
      (column-number-mode)
      (setq select-enable-clipboard nil)
      (setq ring-bell-function 'ignore)
      (setq inhibit-splash-screen t)
      (setq inhibit-startup-screen t)
      (setq show-paren-delay 0 show-paren-style 'parenthesis)
      (show-paren-mode 6)
      (setq-default cursor-type 'bar)
      (setq-default indent-tabs-mode nil)
      (setq scroll-conservatively 101)
      (setq show-trailing-whitespace t)
      (setq backup-by-copying t backup-directory-alist '(("." . "~/.emacs.backups")) delete-old-versions t kept-new-versions 0 kept-old-versions 0 version-control t)
      (add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
      (add-to-list 'default-frame-alist '(ns-appearance . dark))
      (setq completion-ignored-extensions '(".lock" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".dfsl" ".pfsl" ".d64fsl" ".p64fsl" ".lx64fsl" ".lx32fsl" ".dx64fsl" ".dx32fsl" ".fx64fsl" ".fx32fsl" ".sx64fsl" ".sx32fsl" ".wx64fsl" ".wx32fsl" ".fasl" ".ufsl" ".fsl" ".dxl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo"))
;;; nichts
      (setq read-file-name-completion-ignore-case t)

      (message "%s loaded" (buffer-name)))


;;;
