;;; package -- init
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
;;;   none
;;;
;;; Code:


(progn
  (require 'package)
  (setq package-archives nil)
  (require 'use-package)
  (use-package flycheck :init (global-flycheck-mode))
  (setq use-package-always-ensure t)
  (add-to-list 'load-path "~/.emacs.d/site-g")
  (add-to-list 'custom-safe-themes "c22b959c98815a8a718ce4689edf28749aa9d108be6a4e96d993f8bef4d8cf0e")
  (add-to-list 'custom-safe-themes "cc50aa77450a8b1fea9ffdd99d0e3f008db33c845126f14943799bf706c5ac86")
  (load-library "kanagawa")
  (load-library "typst-mode")
  (load-library "5O1")
  (load-library "7O1")
  (load-library "8O1"))
