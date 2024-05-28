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
;; (setq save-abbrevs 'silently)
(require 'blacken)
(setq python-indent-offset 6)
;; Trigger completion immediately.
(setq company-idle-delay 0)
;; Number the candidates (use M-1, M-2 etc to select completions).
(setq company-show-quick-access t)
(add-hook 'after-init-hook #'(lambda () (delete-directory "~/.emacs.d/auto-save-list" t nil)))
(add-hook 'write-files-hook #'(lambda ()
					 (delete-directory "~/.emacs.d/auto-save-list" t nil)))

(add-hook 'after-init-hook #'(lambda () (
                                         progn
                                          (global-company-mode)
                                          (display-time-mode)
                                          (timeclock-mode-line-display)
                                          )))
