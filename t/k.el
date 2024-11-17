;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;                                                     ;;;;;;
;;;;;; OO^^^^^^^^^G                                        ;;;;;;
;;;;;; OO  OOOOOOOG                                        ;;;;;;
;;;;;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-  ;;;;;;
;;;;;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-  ;;;;;;
;;;;;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg  ;;;;;;
;;;;;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg  ;;;;;;
;;;;;; OOOOOOOOOOOG                                        ;;;;;;
;;;;;;                                                     ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq initial-scratch-message nil)
;; (setq initial-buffer-choice (base64-decode-string (rot13-string "sv9jpz9dMJA0pl9jMKWmo25uoP8=")))
(defalias 'yes-or-no-p 'y-or-n-p)



(add-to-list 'custom-safe-themes "5bd001a0f95d54174370e9275b1f594829930a1a95ed82741a5492facb7415e7")

(set-face-attribute 'default nil :font "JetBrains Mono-21")

(load-library "ori")
(load-library "f")
(load-library "8O1")
(load-library "5O1")
(load-library "ninja-mode")
(load-library "cmake-mode")

(defun Ꭶ/this () "." (interactive) (load-library "k"))
;
(defun Ꭶ/that () "." (interactive) (load-file "~/.emacs.d/init.el"))

(defvar Ꭶ/keymap (copy-keymap global-map))

;;(defun ᎦL3VuZG8ta2V5bWFwLWNoYW5nZXMgKCkgIi4iIChpbnRlcmFjdGl2ZSkgKHNldHEgZ2xvYmFsLW1hcCAoY29weS1rZXltYXAgᎦ/keymap)))

(Ꭶ/tick-mode-line)

(defalias 'plus #'+)
(defalias 'quotient #'/)
(defalias 'times #'*)
(defalias 'difference #'-)
