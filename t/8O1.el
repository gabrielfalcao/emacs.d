;;; package -- 8-kbd.el
;;;    /##  ### /### /###     /###     /###     /###
;;;   / ###  ##/ ###/ /##  / / ###  / / ###  / / #### /
;;;  /   ###  ##  ###/ ###/ /   ###/ /   ###/ ##  ###/
;;; ##    ### ##   ##   ## ##    ## ##       ####
;;; ########  ##   ##   ## ##    ## ##         ###
;;; #######   ##   ##   ## ##    ## ##           ###
;;; ##        ##   ##   ## ##    ## ##             ###
;;; ####    / ##   ##   ## ##    /# ###     / /###  ##
;;;  ######/  ###  ###  ### ####/ ## ######/ / #### /
;;;   #####    ###  ###  ### ###   ## #####     ###/
;;; Commentary:
;;;
;;; Code:
(scroll-bar-mode t)
(menu-bar-mode 0)
(tool-bar-mode 0)
(server-mode t)
(global-set-key (kbd "C-c u") #'(lambda () (interactive) (error "C-x C-n")))
(global-set-key (kbd "C-c C-p") #'(lambda () (interactive) (message "cur %d" (point))))
(progn
  (global-set-key (kbd "C-c C-n") 'uncomment-region)
  (global-set-key (kbd "C-x C-n") 'uncomment-region)
  (global-set-key (kbd "C-c c") 'comment-region)
  (global-set-key (kbd "C-#") 'comment-region))

(progn
  (global-set-key (kbd "C-c C-x C-e") 'base64-encode-region)
  (global-set-key (kbd "C-c C-x C-d") 'base64-decode-region)
  (global-set-key (kbd "C-c C-e C-3") 'rot13-region))

(global-set-key (kbd "C-<") 'decrease-left-margin)
(global-set-key (kbd "C->") 'increase-left-margin)
(progn
  (put 'upcase-region 'disabled nil)
  (global-set-key (kbd "C-x C-u") #'(lambda () (interactive) (error "C-x C-k")))
  (global-set-key (kbd "C-x C-k") #'upcase-region)
  )
(progn
  (put 'downcase-region 'disabled nil)
  (global-set-key (kbd "C-x C-l") #'downcase-region))

(global-set-key [(shift C-tab)] #'(lambda () (interactive) (other-window -1)))
(global-set-key [(meta n)] #'(lambda () (interactive) (scroll-up 1)))
(global-set-key [(meta p)] #'(lambda () (interactive) (scroll-down 1)))
(global-set-key [(meta j)] #'(lambda () (interactive) (scroll-other-window 1)))
(global-set-key [(meta k)] #'(lambda () (interactive) (scroll-other-window -1)))
(global-set-key [(ctrl s)] 'isearch-forward)
(global-set-key (kbd "C-c C-s") 'isearch-backward)

(mapc #'(lambda (dbk)
              (ignore-errors
                (global-unset-key (kbd dbk))))
      '(
        "M-s-F"
        "M-s-f"
        "M-s-h"
        "M-|"
        "M-t"

        ))
;; M-s       
;; M-s .     
;; M-s M-w   
;; M-s _     
;; M-s h     
;; M-s h f   
;; M-s h l   
;; M-s h p   
;; M-s h r   
;; M-s h u   
;; M-s h w   
;; M-s o     
;; M-s w     
;; M-s-F     
;; M-s-f     
;; M-s-h     
;; M-t       
;; M-u       
;; M-v       
;; M-w       
;; M-x       
;; M-y       
;; M-z       
;; M-{       
;; M-|       
;; M-}       
;; M-~       


(global-set-key (kbd "C-g") #'(lambda () (interactive) (progn
                                                         (message "g")
							 (keyboard-quit))))
(global-set-key (kbd "M-u") #'(lambda () (interactive) (error "aint happenin'")))
(global-set-key (kbd "M-l") #'(lambda () (interactive) (error "aint happenin'")))
(global-set-key (kbd "C-q") 'keyboard-quit)
(global-set-key [(ctrl s)] 'isearch-forward-regexp)
(global-set-key [(ctrl shift s)] 'isearch-backward-regexp)
(global-set-key (kbd "M-O") #'(lambda () (interactive) (insert "ॐ")))
(global-set-key (kbd "M-G") #'(lambda () (interactive) (insert "Ꭶ")))
;; (global-set-key (kbd "M-g") #'(lambda () (interactive)
;;                                 (insert-char (string-make-unibyte "Ꭶ"))))
(global-unset-key (kbd "M-o"))
(global-unset-key (kbd "M-g"))

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
(global-font-lock-mode 1)
(transient-mark-mode 1)
(set-frame-font "Monaco-17")
(set-face-attribute 'default t :font "Monaco-17")
(global-prettify-symbols-mode 0)
(require 'linum)
(global-linum-mode 1)
(setq linum-format "%4d")
(setq-default truncate-lines t)
(setq show-paren-delay 0 show-paren-style 'parenthesis)
(show-paren-mode 1)
(setq-default cursor-type 'bar)
(setq-default indent-tabs-mode nil)
(setq scroll-conservatively 101)
(setq show-trailing-whitespace t)

(defun uniquify-all-lines-region (start end)
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while
          (progn
            (goto-char start)
            (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
        (replace-match "\\1\n\\2")))))
(defun uniquify-all-lines-buffer ()
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))
(defun kill-bufs ()
  (interactive)
  (mapcar #'(lambda (b)
              (ignore-errors
                (set-buffer-modified-p nil)
                (revert-buffer 1 1))
              (kill-buffer b))
          (buffer-list)))
(setq
 backup-by-copying t
 backup-directory-alist
 '(("." . "~/.emacs.backups"))
 delete-old-versions t
 kept-new-versions 10
 kept-old-versions 10
 version-control t)
(add-to-list 'default-frame-alist '(ns-transparent-titlebar . t))
(add-to-list 'default-frame-alist '(ns-appearance . dark))
(setq completion-ignored-extensions '(".lock" ".o" "~" ".bin" ".lbin" ".so" ".a" ".ln" ".blg" ".bbl" ".elc" ".lof" ".glo" ".idx" ".lot" ".svn/" ".hg/" ".git/" ".bzr/" "CVS/" "_darcs/" "_MTN/" ".fmt" ".tfm" ".class" ".fas" ".lib" ".mem" ".x86f" ".sparcf" ".dfsl" ".pfsl" ".d64fsl" ".p64fsl" ".lx64fsl" ".lx32fsl" ".dx64fsl" ".dx32fsl" ".fx64fsl" ".fx32fsl" ".sx64fsl" ".sx32fsl" ".wx64fsl" ".wx32fsl" ".fasl" ".ufsl" ".fsl" ".dxl" ".lo" ".la" ".gmo" ".mo" ".toc" ".aux" ".cp" ".fn" ".ky" ".pg" ".tp" ".vr" ".cps" ".fns" ".kys" ".pgs" ".tps" ".vrs" ".pyc" ".pyo"))
;;; nichts
(setq read-file-name-completion-ignore-case t)

(provide '8O1)


;; Key translations:
;; key             binding
;; ---             -------

;; C-#             comment-region
;; C--             negative-argument
;; C-/             undo
;; C-0 .. C-9      digit-argument
;; C-<             decrease-left-margin
;; C-<backspace>   backward-kill-word
;; C-<delete>      kill-word
;; C-<down-mouse-1>                mouse-buffer-menu
;; C-<down-mouse-2>                facemenu-menu
;; C-<down-mouse-2> <dc>           list-colors-display
;; C-<down-mouse-2> <df>           list-faces-display
;; C-<down-mouse-2> <dp>           describe-text-properties
;; C-<down-mouse-2> <fc>           facemenu-face-menu
;; C-<down-mouse-2> <fc> d         facemenu-set-default
;; C-<down-mouse-2> <fc> i         facemenu-set-italic
;; C-<down-mouse-2> <fc> l         facemenu-set-bold-italic
;; C-<down-mouse-2> <fc> o         facemenu-set-face
;; C-<down-mouse-2> <fc> u         facemenu-set-underline
;; C-<down-mouse-2> <fg>           facemenu-foreground-menu
;; C-<down-mouse-2> <in>           facemenu-indentation-menu
;; C-<down-mouse-2> <in> <decrease-right-margin>
;; C-<down-mouse-2> <in> <increase-left-margin>
;; C-<down-mouse-2> <in> <increase-right-margin>
;; C-<down-mouse-2> <ju>           facemenu-justification-menu
;; C-<down-mouse-2> <ju> c         set-justification-center
;; C-<down-mouse-2> <ju> l         set-justification-left
;; C-<down-mouse-2> <ju> r         set-justification-right
;; C-<down-mouse-2> <ju> u         set-justification-none
;; C-<down-mouse-2> <ra>           facemenu-remove-all
;; C-<down-mouse-2> <rm>           facemenu-remove-face-props
;; C-<down-mouse-2> <sp>           facemenu-special-menu
;; C-<down-mouse-2> <sp> r         facemenu-set-read-only
;; C-<down-mouse-2> <sp> s         facemenu-remove-special
;; C-<down-mouse-2> <sp> t         facemenu-set-intangible
;; C-<down-mouse-2> <sp> v         facemenu-set-invisible
;; C-<down>        forward-paragraph
;; C-<end>         end-of-buffer
;; C-<f10>         buffer-menu-open
;; C-<home>        beginning-of-buffer
;; C-<insert>      kill-ring-save
;; C-<insertchar>  kill-ring-save
;; C-<kp-0>        C-0
;; C-<kp-1>        C-1
;; C-<kp-2>        C-2
;; C-<kp-3>        C-3
;; C-<kp-4>        C-4
;; C-<kp-5>        C-5
;; C-<kp-6>        C-6
;; C-<kp-7>        C-7
;; C-<kp-8>        C-8
;; C-<kp-9>        C-9
;; C-<kp-add>      C-+
;; C-<kp-begin>    C-<begin>
;; C-<kp-decimal>  C-.
;; C-<kp-delete>   C-<delete>
;; C-<kp-divide>   C-/
;; C-<kp-down>     C-<down>
;; C-<kp-end>      C-<end>
;; C-<kp-enter>    C-<enter>
;; C-<kp-home>     C-<home>
;; C-<kp-insert>   C-<insert>
;; C-<kp-left>     C-<left>
;; C-<kp-multiply> C-*
;; C-<kp-next>     C-<next>
;; C-<kp-prior>    C-<prior>
;; C-<kp-right>    C-<right>
;; C-<kp-subtract> C--
;; C-<kp-up>       C-<up>
;; C-<left>        left-word
;; C-<next>        scroll-left
;; C-<prior>       scroll-right
;; C-<right>       right-word
;; C-<up>          backward-paragraph
;; C-<wheel-down>  mouse-wheel-text-scale
;; C-<wheel-up>    mouse-wheel-text-scale
;; C-=             er/expand-region
;; C->             increase-left-margin
;; C-?             undo-redo
;; C-M-%           query-replace-regexp
;; C-M--           negative-argument
;; C-M-.           xref-find-apropos
;; C-M-/           dabbrev-completion
;; C-M-0 .. C-M-9  digit-argument
;; C-M-<down-mouse-1>              mouse-drag-region-rectangle
;; C-M-<down>      down-list
;; C-M-<drag-mouse-1>              ignore
;; C-M-<end>       end-of-defun
;; C-M-<home>      beginning-of-defun
;; C-M-<kp-0>      C-M-0
;; C-M-<kp-1>      C-M-1
;; C-M-<kp-2>      C-M-2
;; C-M-<kp-3>      C-M-3
;; C-M-<kp-4>      C-M-4
;; C-M-<kp-5>      C-M-5
;; C-M-<kp-6>      C-M-6
;; C-M-<kp-7>      C-M-7
;; C-M-<kp-8>      C-M-8
;; C-M-<kp-9>      C-M-9
;; C-M-<kp-add>    C-M-+
;; C-M-<kp-begin>  C-M-<begin>
;; C-M-<kp-decimal> C-M-.
;; C-M-<kp-delete> C-M-<delete>
;; C-M-<kp-divide> C-M-/
;; C-M-<kp-down>   C-M-<down>
;; C-M-<kp-end>    C-M-<end>
;; C-M-<kp-enter>  C-M-<enter>
;; C-M-<kp-home>   C-M-<home>
;; C-M-<kp-insert> C-M-<insert>
;; C-M-<kp-left>   C-M-<left>
;; C-M-<kp-multiply> C-M-*
;; C-M-<kp-next>   C-M-<next>
;; C-M-<kp-prior>  C-M-<prior>
;; C-M-<kp-right>  C-M-<right>
;; C-M-<kp-subtract> C-M--
;; C-M-<kp-up>     C-M-<up>
;; C-M-<left>      backward-sexp
;; C-M-<mouse-1>   mouse-set-point
;; C-M-<right>     forward-sexp
;; C-M-<up>        backward-up-list
;; C-M-S-<kp-0>    C-M-S-0
;; C-M-S-<kp-1>    C-M-S-1
;; C-M-S-<kp-2>    C-M-S-2
;; C-M-S-<kp-3>    C-M-S-3
;; C-M-S-<kp-4>    C-M-S-4
;; C-M-S-<kp-5>    C-M-S-5
;; C-M-S-<kp-6>    C-M-S-6
;; C-M-S-<kp-7>    C-M-S-7
;; C-M-S-<kp-8>    C-M-S-8
;; C-M-S-<kp-9>    C-M-S-9
;; C-M-S-<kp-add>  C-M-S-+
;; C-M-S-<kp-begin> C-M-S-<begin>
;; C-M-S-<kp-decimal> C-M-S-.
;; C-M-S-<kp-delete> C-M-S-<delete>
;; C-M-S-<kp-divide> C-M-S-/
;; C-M-S-<kp-down> C-M-S-<down>
;; C-M-S-<kp-end>  C-M-S-<end>
;; C-M-S-<kp-enter> C-M-S-<enter>
;; C-M-S-<kp-home> C-M-S-<home>
;; C-M-S-<kp-insert> C-M-S-<insert>
;; C-M-S-<kp-left> C-M-S-<left>
;; C-M-S-<kp-multiply> C-M-S-*
;; C-M-S-<kp-next> C-M-S-<next>
;; C-M-S-<kp-prior> C-M-S-<prior>
;; C-M-S-<kp-right> C-M-S-<right>
;; C-M-S-<kp-subtract> C-M-S--
;; C-M-S-<kp-up>   C-M-S-<up>
;; C-M-S-l         recenter-other-window
;; C-M-S-v         scroll-other-window-down
;; C-M-SPC         mark-sexp
;; C-M-\           indent-region
;; C-M-_           undo-redo
;; C-M-a           beginning-of-defun
;; C-M-b           backward-sexp
;; C-M-c           exit-recursive-edit
;; C-M-d           down-list
;; C-M-e           end-of-defun
;; C-M-f           forward-sexp
;; C-M-h           mark-defun
;; C-M-j           default-indent-new-line
;; C-M-k           kill-sexp
;; C-M-l           reposition-window
;; C-M-n           forward-list
;; C-M-o           split-line
;; C-M-p           backward-list
;; C-M-q           indent-pp-sexp
;; C-M-r           isearch-backward-regexp
;; C-M-s           isearch-forward-regexp
;; C-M-t           transpose-sexps
;; C-M-u           backward-up-list
;; C-M-v           scroll-other-window
;; C-M-w           append-next-kill
;; C-M-x           eval-defun
;; C-S-<backspace>                 kill-whole-line
;; C-S-<kp-0>      C-S-0
;; C-S-<kp-1>      C-S-1
;; C-S-<kp-2>      C-S-2
;; C-S-<kp-3>      C-S-3
;; C-S-<kp-4>      C-S-4
;; C-S-<kp-5>      C-S-5
;; C-S-<kp-6>      C-S-6
;; C-S-<kp-7>      C-S-7
;; C-S-<kp-8>      C-S-8
;; C-S-<kp-9>      C-S-9
;; C-S-<kp-add>    C-S-+
;; C-S-<kp-begin>  C-S-<begin>
;; C-S-<kp-decimal> C-S-.
;; C-S-<kp-delete> C-S-<delete>
;; C-S-<kp-divide> C-S-/
;; C-S-<kp-down>   C-S-<down>
;; C-S-<kp-end>    C-S-<end>
;; C-S-<kp-enter>  C-S-<enter>
;; C-S-<kp-home>   C-S-<home>
;; C-S-<kp-insert> C-S-<insert>
;; C-S-<kp-left>   C-S-<left>
;; C-S-<kp-multiply> C-S-*
;; C-S-<kp-next>   C-S-<next>
;; C-S-<kp-prior>  C-S-<prior>
;; C-S-<kp-right>  C-S-<right>
;; C-S-<kp-subtract> C-S--
;; C-S-<kp-up>     C-S-<up>
;; C-S-<tab>       ??
;; C-S-s           isearch-backward-regexp
;; C-SPC           set-mark-command
;; C-\             toggle-input-method
;; C-]             abort-recursive-edit
;; C-_             undo
;; C-a             move-beginning-of-line
;; C-b             backward-char
;; C-c             mode-specific-command-prefix
;; C-c ! ?         flycheck-describe-checker
;; C-c ! C         flycheck-clear
;; C-c ! C-w       flycheck-copy-errors-as-kill
;; C-c ! H         display-local-help
;; C-c ! V         flycheck-version
;; C-c ! c         flycheck-buffer
;; C-c ! e         flycheck-explain-error-at-point
;; C-c ! h         flycheck-display-error-at-point
;; C-c ! i         flycheck-manual
;; C-c ! l         flycheck-list-errors
;; C-c ! n         flycheck-next-error
;; C-c ! p         flycheck-previous-error
;; C-c ! s         flycheck-select-checker
;; C-c ! v         flycheck-verify-setup
;; C-c ! x         flycheck-disable-checker
;; C-c C-n         uncomment-region
;; C-c C-p         ??
;; C-c C-s         isearch-backward
;; C-c C-w         clipboard-kill-ring-save
;; C-c C-x         Prefix Command
;; C-c C-x C-e     base64-encode-region
;; C-c C-y         clipboard-yank
;; C-c ESC         Prefix Command
;; C-c M-y         clipboard-yank
;; C-c c           comment-region
;; C-c u           ??
;; C-d             delete-char
;; C-e             move-end-of-line
;; C-f             forward-char
;; C-g             ??
;; C-h             help-command
;; C-h .           display-local-help
;; C-h 4           Prefix Command
;; C-h <f1>        help-for-help
;; C-h <help>      help-for-help
;; C-h ?           help-for-help
;; C-h C           describe-coding-system
;; C-h C-\         describe-input-method
;; C-h C-c         describe-copying
;; C-h C-d         view-emacs-debugging
;; C-h C-e         view-external-packages
;; C-h C-f         view-emacs-FAQ
;; C-h C-h         help-for-help
;; C-h C-n         view-emacs-news
;; C-h C-o         describe-distribution
;; C-h C-p         view-emacs-problems
;; C-h C-s         search-forward-help-for-help
;; C-h C-t         view-emacs-todo
;; C-h C-w         describe-no-warranty
;; C-h F           Info-goto-emacs-command-node
;; C-h I           describe-input-method
;; C-h K           Info-goto-emacs-key-command-node
;; C-h L           describe-language-environment
;; C-h P           describe-package
;; C-h R           info-display-manual
;; C-h RET         view-order-manuals
;; C-h S           info-lookup-symbol
;; C-h a           apropos-command
;; C-h b           describe-bindings
;; C-h c           describe-key-briefly
;; C-h d           apropos-documentation
;; C-h e           view-echo-area-messages
;; C-h f           describe-function
;; C-h g           describe-gnu-project
;; C-h h           view-hello-file
;; C-h i           info
;; C-h k           describe-key
;; C-h l           view-lossage
;; C-h m           describe-mode
;; C-h n           view-emacs-news
;; C-h o           describe-symbol
;; C-h p           finder-by-keyword
;; C-h q           help-quit
;; C-h r           info-emacs-manual
;; C-h s           describe-syntax
;; C-h t           help-with-tutorial
;; C-h v           describe-variable
;; C-h w           where-is
;; C-h x           describe-command
;; C-j             electric-newline-and-maybe-indent
;; C-k             kill-line
;; C-l             recenter-top-bottom
;; C-n             next-line
;; C-o             open-line
;; C-p             previous-line
;; C-q             keyboard-quit
;; C-r             isearch-backward
;; C-s             isearch-forward
;; C-s-SPC         ns-do-show-character-palette
;; C-t             transpose-chars
;; C-u             universal-argument
;; C-v             scroll-up-command
;; C-w             kill-region
;; C-x             Control-X-prefix
;; C-x             Prefix Command
;; C-x             Prefix Command
;; C-x #           server-edit
;; C-x $           set-selective-display
;; C-x '           expand-abbrev
;; C-x (           kmacro-start-macro
;; C-x )           kmacro-end-macro
;; C-x *           calc-dispatch
;; C-x +           balance-windows
;; C-x -           shrink-window-if-larger-than-buffer
;; C-x .           set-fill-prefix
;; C-x 0           delete-window
;; C-x 1           delete-other-windows
;; C-x 2           split-window-below
;; C-x 3           split-window-right
;; C-x 4           ctl-x-4-prefix
;; C-x 4 .         xref-find-definitions-other-window
;; C-x 4 0         kill-buffer-and-window
;; C-x 4 1         same-window-prefix
;; C-x 4 4         other-window-prefix
;; C-x 4 C-j       dired-jump-other-window
;; C-x 4 C-o       display-buffer
;; C-x 4 a         add-change-log-entry-other-window
;; C-x 4 b         switch-to-buffer-other-window
;; C-x 4 c         clone-indirect-buffer-other-window
;; C-x 4 d         dired-other-window
;; C-x 4 f         find-file-other-window
;; C-x 4 m         compose-mail-other-window
;; C-x 4 p         project-other-window-command
;; C-x 4 r         find-file-read-only-other-window
;; C-x 5           ctl-x-5-prefix
;; C-x 5 .         xref-find-definitions-other-frame
;; C-x 5 0         delete-frame
;; C-x 5 1         delete-other-frames
;; C-x 5 2         make-frame-command
;; C-x 5 5         other-frame-prefix
;; C-x 5 C-o       display-buffer-other-frame
;; C-x 5 b         switch-to-buffer-other-frame
;; C-x 5 c         clone-frame
;; C-x 5 d         dired-other-frame
;; C-x 5 f         find-file-other-frame
;; C-x 5 m         compose-mail-other-frame
;; C-x 5 o         other-frame
;; C-x 5 p         project-other-frame-command
;; C-x 5 r         find-file-read-only-other-frame
;; C-x 6           2C-command
;; C-x 6 <f2>      2C-two-columns
;; C-x 6 b         2C-associate-buffer
;; C-x 6 s         2C-split
;; C-x 8           Prefix Command
;; C-x 8 !         ¡
;; C-x 8 "         Prefix Command
;; C-x 8 " "       ¨
;; C-x 8 " A       Ä
;; C-x 8 " E       Ë
;; C-x 8 " I       Ï
;; C-x 8 " O       Ö
;; C-x 8 " U       Ü
;; C-x 8 " a       ä
;; C-x 8 " e       ë
;; C-x 8 " i       ï
;; C-x 8 " o       ö
;; C-x 8 " s       ß
;; C-x 8 " u       ü
;; C-x 8 " y       ÿ
;; C-x 8 $         ¤
;; C-x 8 '         Prefix Command
;; C-x 8 ' '       ´
;; C-x 8 ' A       Á
;; C-x 8 ' E       É
;; C-x 8 ' I       Í
;; C-x 8 ' O       Ó
;; C-x 8 ' U       Ú
;; C-x 8 ' Y       Ý
;; C-x 8 ' a       á
;; C-x 8 ' e       é
;; C-x 8 ' i       í
;; C-x 8 ' o       ó
;; C-x 8 ' u       ú
;; C-x 8 ' y       ý
;; C-x 8 *         Prefix Command
;; C-x 8 * !       ¡
;; C-x 8 * "       ″
;; C-x 8 * $       ¤
;; C-x 8 * '       ′
;; C-x 8 * *       •
;; C-x 8 * +       ±
;; C-x 8 * -       ­
;; C-x 8 * .       ·
;; C-x 8 * <       «
;; C-x 8 * =       ¯
;; C-x 8 * >       »
;; C-x 8 * ?       ¿
;; C-x 8 * C       ©
;; C-x 8 * E       €
;; C-x 8 * L       £
;; C-x 8 * P       ¶
;; C-x 8 * R       ®
;; C-x 8 * S       §
;; C-x 8 * Y       ¥
;; C-x 8 * c       ¢
;; C-x 8 * m       µ
;; C-x 8 * o       °
;; C-x 8 * u       µ
;; C-x 8 * x       ×
;; C-x 8 * |       ¦
;; C-x 8 +         ±
;; C-x 8 ,         Prefix Command
;; C-x 8 , C       Ç
;; C-x 8 , c       ç
;; C-x 8 -         ­
;; C-x 8 .         ·
;; C-x 8 /         Prefix Command
;; C-x 8 / =       ≠
;; C-x 8 / A       Å
;; C-x 8 / E       Æ
;; C-x 8 / O       Ø
;; C-x 8 / a       å
;; C-x 8 / e       æ
;; C-x 8 / o       ø
;; C-x 8 1         Prefix Command
;; C-x 8 1 /       Prefix Command
;; C-x 8 1 / 4     ¼
;; C-x 8 2         Prefix Command
;; C-x 8 3         Prefix Command
;; C-x 8 <         «
;; C-x 8 =         ¯
;; C-x 8 >         »
;; C-x 8 ?         ¿
;; C-x 8 C         ©
;; C-x 8 L         £
;; C-x 8 N         Prefix Command
;; C-x 8 O         Prefix Command
;; C-x 8 O e       œ
;; C-x 8 P         ¶
;; C-x 8 R         ®
;; C-x 8 S         §
;; C-x 8 Y         ¥
;; C-x 8 [         ‘
;; C-x 8 ]         ’
;; C-x 8 ^         Prefix Command
;; C-x 8 ^ 1       ¹
;; C-x 8 ^ 2       ²
;; C-x 8 ^ 3       ³
;; C-x 8 ^ A       Â
;; C-x 8 ^ E       Ê
;; C-x 8 ^ I       Î
;; C-x 8 ^ O       Ô
;; C-x 8 ^ U       Û
;; C-x 8 ^ a       â
;; C-x 8 ^ e       ê
;; C-x 8 ^ i       î
;; C-x 8 ^ o       ô
;; C-x 8 ^ u       û
;; C-x 8 _         Prefix Command
;; C-x 8 _ <       ≤
;; C-x 8 _ >       ≥
;; C-x 8 _ H       ‑
;; C-x 8 _ a       ª
;; C-x 8 _ f       ‒
;; C-x 8 _ h       ‐
;; C-x 8 _ m       —
;; C-x 8 _ n       –
;; C-x 8 _ o       º
;; C-x 8 _ q       ―
;; C-x 8 `         Prefix Command
;; C-x 8 ` A       À
;; C-x 8 ` E       È
;; C-x 8 ` I       Ì
;; C-x 8 ` O       Ò
;; C-x 8 ` U       Ù
;; C-x 8 ` a       à
;; C-x 8 ` e       è
;; C-x 8 ` i       ì
;; C-x 8 ` o       ò
;; C-x 8 ` u       ù
;; C-x 8 a         Prefix Command
;; C-x 8 a =       ↔
;; C-x 8 a >       →
;; C-x 8 c         ¢
;; C-x 8 m         µ
;; C-x 8 o         °
;; C-x 8 u         µ
;; C-x 8 x         ×
;; C-x 8 {         “
;; C-x 8 |         ¦
;; C-x 8 }         ”
;; C-x 8 ~         Prefix Command
;; C-x 8 ~ =       ≈
;; C-x 8 ~ A       Ã
;; C-x 8 ~ D       Ð
;; C-x 8 ~ N       Ñ
;; C-x 8 ~ O       Õ
;; C-x 8 ~ T       Þ
;; C-x 8 ~ a       ã
;; C-x 8 ~ d       ð
;; C-x 8 ~ n       ñ
;; C-x 8 ~ o       õ
;; C-x 8 ~ t       þ
;; C-x 8 ~ ~       ¬
;; C-x ;           comment-set-column
;; C-x <           scroll-left
;; C-x <left>      previous-buffer
;; C-x <right>     next-buffer
;; C-x =           what-cursor-position
;; C-x >           scroll-right
;; C-x @ a         event-apply-alt-modifier
;; C-x @ c         event-apply-control-modifier
;; C-x @ h         event-apply-hyper-modifier
;; C-x @ m         event-apply-meta-modifier
;; C-x @ s         event-apply-super-modifier
;; C-x C-+         text-scale-adjust
;; C-x C--         text-scale-adjust
;; C-x C-0         text-scale-adjust
;; C-x C-;         comment-line
;; C-x C-<left>    previous-buffer
;; C-x C-<right>   next-buffer
;; C-x C-=         text-scale-adjust
;; C-x C-SPC       pop-global-mark
;; C-x C-b         list-buffers
;; C-x C-c         save-buffers-kill-terminal
;; C-x C-d         list-directory
;; C-x C-e         eval-last-sexp
;; C-x C-f         find-file
;; C-x C-j         dired-jump
;; C-x C-k         upcase-region
;; C-x C-l         downcase-region
;; C-x C-n         uncomment-region
;; C-x C-o         delete-blank-lines
;; C-x C-p         mark-page
;; C-x C-q         read-only-mode
;; C-x C-r         find-file-read-only
;; C-x C-s         save-buffer
;; C-x C-t         transpose-lines
;; C-x C-u         ??
;; C-x C-v         find-alternate-file
;; C-x C-w         write-file
;; C-x C-x         exchange-point-and-mark
;; C-x C-z         suspend-frame
;; C-x DEL         backward-kill-sentence
;; C-x ESC         Prefix Command
;; C-x M-:         repeat-complex-command
;; C-x RET         Prefix Command
;; C-x RET F       set-file-name-coding-system
;; C-x RET X       set-next-selection-coding-system
;; C-x RET c       universal-coding-system-argument
;; C-x RET f       set-buffer-file-coding-system
;; C-x RET k       set-keyboard-coding-system
;; C-x RET l       set-language-environment
;; C-x RET p       set-buffer-process-coding-system
;; C-x RET r       revert-buffer-with-coding-system
;; C-x RET t       set-terminal-coding-system
;; C-x RET x       set-selection-coding-system
;; C-x SPC         rectangle-mark-mode
;; C-x TAB         indent-rigidly
;; C-x [           backward-page
;; C-x \           activate-transient-input-method
;; C-x ]           forward-page
;; C-x ^           enlarge-window
;; C-x `           next-error
;; C-x a           Prefix Command
;; C-x a '         expand-abbrev
;; C-x a +         add-mode-abbrev
;; C-x a -         inverse-add-global-abbrev
;; C-x a e         expand-abbrev
;; C-x a g         add-global-abbrev
;; C-x a i         Prefix Command
;; C-x a i l       inverse-add-mode-abbrev
;; C-x a l         add-mode-abbrev
;; C-x a n         expand-jump-to-next-slot
;; C-x a p         expand-jump-to-previous-slot
;; C-x b           switch-to-buffer
;; C-x d           dired
;; C-x e           kmacro-end-and-call-macro
;; C-x f           set-fill-column
;; C-x h           mark-whole-buffer
;; C-x i           insert-file
;; C-x k           kill-buffer
;; C-x l           count-lines-page
;; C-x m           compose-mail
;; C-x n           Prefix Command
;; C-x n g         goto-line-relative
;; C-x n n         narrow-to-region
;; C-x n p         narrow-to-page
;; C-x n w         widen
;; C-x o           other-window
;; C-x p           Prefix Command
;; C-x p &         project-async-shell-command
;; C-x p D         project-dired
;; C-x p F         project-or-external-find-file
;; C-x p G         project-or-external-find-regexp
;; C-x p b         project-switch-to-buffer
;; C-x p c         project-compile
;; C-x p d         project-find-dir
;; C-x p e         project-eshell
;; C-x p f         project-find-file
;; C-x p g         project-find-regexp
;; C-x p k         project-kill-buffers
;; C-x p p         project-switch-project
;; C-x p r         project-query-replace-regexp
;; C-x p s         project-shell
;; C-x p v         project-vc-dir
;; C-x p x         project-execute-extended-command
;; C-x q           kbd-macro-query
;; C-x r           Prefix Command
;; C-x r +         increment-register
;; C-x r C-SPC     point-to-register
;; C-x r ESC       Prefix Command
;; C-x r M         bookmark-set-no-overwrite
;; C-x r N         rectangle-number-lines
;; C-x r SPC       point-to-register
;; C-x r b         bookmark-jump
;; C-x r c         clear-rectangle
;; C-x r d         delete-rectangle
;; C-x r f         frameset-to-register
;; C-x r g         insert-register
;; C-x r i         insert-register
;; C-x r j         jump-to-register
;; C-x r k         kill-rectangle
;; C-x r l         bookmark-bmenu-list
;; C-x r m         bookmark-set
;; C-x r n         number-to-register
;; C-x r o         open-rectangle
;; C-x r r         copy-rectangle-to-register
;; C-x r s         copy-to-register
;; C-x r t         string-rectangle
;; C-x r w         window-configuration-to-register
;; C-x r x         copy-to-register
;; C-x r y         yank-rectangle
;; C-x s           save-some-buffers
;; C-x t           Prefix Command
;; C-x t 0         tab-close
;; C-x t 1         tab-close-other
;; C-x t 2         tab-new
;; C-x t C-r       find-file-read-only-other-tab
;; C-x t G         tab-group
;; C-x t M         tab-move-to
;; C-x t N         tab-new-to
;; C-x t O         tab-previous
;; C-x t RET       tab-switch
;; C-x t b         switch-to-buffer-other-tab
;; C-x t d         dired-other-tab
;; C-x t f         find-file-other-tab
;; C-x t m         tab-move
;; C-x t n         tab-duplicate
;; C-x t o         tab-next
;; C-x t p         project-other-tab-command
;; C-x t r         tab-rename
;; C-x t t         other-tab-prefix
;; C-x t u         tab-undo
;; C-x u           undo
;; C-x v           vc-prefix-map
;; C-x v =         vc-diff
;; C-x v D         vc-root-diff
;; C-x v G         vc-ignore
;; C-x v I         vc-log-incoming
;; C-x v L         vc-print-root-log
;; C-x v M         Prefix Command
;; C-x v M L       vc-log-mergebase
;; C-x v O         vc-log-outgoing
;; C-x v P         vc-push
;; C-x v a         vc-update-change-log
;; C-x v b         vc-switch-backend
;; C-x v d         vc-dir
;; C-x v g         vc-annotate
;; C-x v h         vc-region-history
;; C-x v i         vc-register
;; C-x v l         vc-print-log
;; C-x v m         vc-merge
;; C-x v r         vc-retrieve-tag
;; C-x v s         vc-create-tag
;; C-x v u         vc-revert
;; C-x v v         vc-next-action
;; C-x v x         vc-delete-file
;; C-x v ~         vc-revision-other-window
;; C-x x           Prefix Command
;; C-x x g         revert-buffer-quick
;; C-x x i         insert-buffer
;; C-x x n         clone-buffer
;; C-x x r         rename-buffer
;; C-x x t         toggle-truncate-lines
;; C-x x u         rename-uniquely
;; C-x z           repeat
;; C-x {           shrink-window-horizontally
;; C-x }           enlarge-window-horizontally
;; C-y             yank
;; C-z             suspend-frame
;; M-!             shell-command
;; M-$             ispell-word
;; M-%             query-replace
;; M-&             async-shell-command
;; M-'             abbrev-prefix-mark
;; M-(             insert-parentheses
;; M-)             move-past-close-and-reindent
;; M-,             xref-pop-marker-stack
;; M--             negative-argument
;; M-.             xref-find-definitions
;; M-/             dabbrev-expand
;; M-:             eval-expression
;; M-;             comment-dwim
;; M-<             beginning-of-buffer
;; M-<backspace>   M-DEL
;; M-<begin>       beginning-of-buffer-other-window
;; M-<clear>       C-M-l
;; M-<delete>      M-DEL
;; M-<down-mouse-1>                mouse-drag-secondary
;; M-<drag-mouse-1>                mouse-set-secondary
;; M-<end>         end-of-buffer-other-window
;; M-<escape>      M-ESC
;; M-<f10>         toggle-frame-maximized
;; M-<home>        beginning-of-buffer-other-window
;; M-<kp-0>        M-0
;; M-<kp-1>        M-1
;; M-<kp-2>        M-2
;; M-<kp-3>        M-3
;; M-<kp-4>        M-4
;; M-<kp-5>        M-5
;; M-<kp-6>        M-6
;; M-<kp-7>        M-7
;; M-<kp-8>        M-8
;; M-<kp-9>        M-9
;; M-<kp-add>      M-+
;; M-<kp-begin>    M-<begin>
;; M-<kp-decimal>  M-.
;; M-<kp-delete>   M-<delete>
;; M-<kp-divide>   M-/
;; M-<kp-down>     M-<down>
;; M-<kp-end>      M-<end>
;; M-<kp-enter>    M-<enter>
;; M-<kp-home>     M-<home>
;; M-<kp-insert>   M-<insert>
;; M-<kp-left>     M-<left>
;; M-<kp-multiply> M-*
;; M-<kp-next>     M-<next>
;; M-<kp-prior>    M-<prior>
;; M-<kp-right>    M-<right>
;; M-<kp-subtract> M--
;; M-<kp-up>       M-<up>
;; M-<left>        left-word
;; M-<linefeed>    C-M-j
;; M-<mouse-1>     mouse-start-secondary
;; M-<mouse-2>     mouse-yank-secondary
;; M-<mouse-3>     mouse-secondary-save-then-kill
;; M-<next>        scroll-other-window
;; M-<prior>       scroll-other-window-down
;; M-<return>      M-RET
;; M-<right>       right-word
;; M-<tab>         C-M-i
;; M-<wheel-down>  mwheel-scroll
;; M-<wheel-left>  mwheel-scroll
;; M-<wheel-right>                 mwheel-scroll
;; M-<wheel-up>                    mwheel-scroll
;; M-=             count-words-region
;; M->             end-of-buffer
;; M-?             xref-find-references
;; M-@             mark-word
;; M-DEL           backward-kill-word
;; M-ESC :         eval-expression
;; M-G             ??
;; M-O             ??
;; M-S-<kp-0>      M-S-0
;; M-S-<kp-1>      M-S-1
;; M-S-<kp-2>      M-S-2
;; M-S-<kp-3>      M-S-3
;; M-S-<kp-4>      M-S-4
;; M-S-<kp-5>      M-S-5
;; M-S-<kp-6>      M-S-6
;; M-S-<kp-7>      M-S-7
;; M-S-<kp-8>      M-S-8
;; M-S-<kp-9>      M-S-9
;; M-S-<kp-add>    M-S-+
;; M-S-<kp-begin>  M-S-<begin>
;; M-S-<kp-decimal> M-S-.
;; M-S-<kp-delete> M-S-<delete>
;; M-S-<kp-divide> M-S-/
;; M-S-<kp-down>   M-S-<down>
;; M-S-<kp-end>    M-S-<end>
;; M-S-<kp-enter>  M-S-<enter>
;; M-S-<kp-home>   M-S-<home>
;; M-S-<kp-insert> M-S-<insert>
;; M-S-<kp-left>   M-S-<left>
;; M-S-<kp-multiply> M-S-*
;; M-S-<kp-next>   M-S-<next>
;; M-S-<kp-prior>  M-S-<prior>
;; M-S-<kp-right>  M-S-<right>
;; M-S-<kp-subtract> M-S--
;; M-S-<kp-up>     M-S-<up>
;; M-SPC           just-one-space
;; M-X             execute-extended-command-for-buffer
;; M-\             delete-horizontal-space
;; M-^             delete-indentation
;; M-`             tmm-menubar
;; M-a             backward-sentence
;; M-b             backward-word
;; M-c             capitalize-word
;; M-d             kill-word
;; M-e             forward-sentence
;; M-f             forward-word
;; M-h             mark-paragraph
;; M-i             tab-to-tab-stop
;; M-j             ??
;; M-k             ??
;; M-l             ??
;; M-m             back-to-indentation
;; M-n             ??
;; M-p             ??
;; M-q             fill-paragraph
;; M-r             move-to-window-line-top-bottom
;; M-s             Prefix Command
;; M-s .           isearch-forward-symbol-at-point
;; M-s M-w         eww-search-words
;; M-s _           isearch-forward-symbol
;; M-s h           Prefix Command
;; M-s h f         hi-lock-find-patterns
;; M-s h l         highlight-lines-matching-regexp
;; M-s h p         highlight-phrase
;; M-s h r         highlight-regexp
;; M-s h u         unhighlight-regexp
;; M-s h w         hi-lock-write-interactive-patterns
;; M-s o           occur
;; M-s w           isearch-forward-word
;; M-s-F           isearch-backward-regexp
;; M-s-f           isearch-forward-regexp
;; M-s-h           ns-do-hide-others
;; M-t             transpose-words
;; M-u             ??
;; M-v             scroll-down-command
;; M-w             kill-ring-save
;; M-x             execute-extended-command
;; M-y             yank-pop
;; M-z             zap-to-char
;; M-{             backward-paragraph
;; M-|             shell-command-on-region
;; M-}             forward-paragraph
;; M-~             not-modified
;; Major Mode Bindings:
