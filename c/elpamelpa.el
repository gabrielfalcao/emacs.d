(progn
  (require 'package)
  (or (when (null global-package-online)
       (progn
         (setq package-archives
           '(
             ("gnu" . "https://elpa.gnu.org/packages/")
             ("nongnu" . "https://elpa.nongnu.org/nongnu/")
             ("melpa" . "https://melpa.org/packages/")
             ("melpa-stable" . "https://stable.melpa.org/packages/")))
         (package-initialize)
         t))
    (setq package-archives nil)))
