;;; package -- 6O1
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
(setq initial-scratch-message nil)
(setq-default message-log-max 0)
(setq-default warning-log-max 0)
(setq initial-buffer-choice "~/projects")

(add-hook
 'after-change-major-mode-hook
 #'(lambda ()
     (interactive)
     (progn
       (mapc #'(lambda (kenga)
                 (let ((quecu (format "*%s*" (base64-decode-string kenga))))
                   (and (get-buffer quecu)
                        (kill-buffer))))
             '("V2FybmluZ3M=" (rot13-string "p2AlLKEwnN=="))))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'minibuffer-exit-hook
          #'(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))
(setq inhibit-startup-buffer-menu t)
(provide '6O1)
(add-hook 'minibuffer-exit-hook
          #'(lambda ()
             (let ((buffer "*Completions*"))
               (and (get-buffer buffer)
                    (kill-buffer buffer)))))
