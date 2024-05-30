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
(setq-default message-log-max 1)
(setq-default warning-log-max 1)
(setq initial-buffer-choice (base64-decode-string (rot13-string "sv9jpz9dMJA0pl9jMKWmo25uoP8=")))

(add-hook 'after-change-major-mode-hook
          #'(lambda ()
              (interactive)
              (progn
                (mapc
                 #'(lambda (kenga) (let ((quecu (format "*%s*" (base64-decode-string kenga)))) (and (get-buffer quecu) (kill-buffer quecu)))) (list "V2FybmluZ3M=" (rot13-string "p2AlLKEwnN=="))))))
