;;       ________             ~
;;     ,88888GG8Ga,  8G    d8888     d8G'
;;   ,d8G"      "V8G 18     88     d88G'
;;   a8"         'Vd  VG        ,ad8"
;;   "            )8   "8aaaaa8888G"
;;               ,dG     """"""
;;              ,a8"   ________
;;      "8gggggggO1  ,d88888888888G,
;;       "8'    'a8G,88"           "V8)
;;               "V8G'               d8)
;;                'VdG               ,88'
;;                 )8G               d88'
;; 8(G             ,dG              (8G'
;; "18            ,a8"             d88'
;;   VG,_________,a8     "'VBG    888
;;    "8ggggggggg8"       'V88888V"
;;       """"""""            """"'
(defun Ꭶ/mode-line-foreground ()
  (interactive)
  "#FF4018")

(defun Ꭶ/mode-line-background ()
  (interactive)
  "#333")

(defun Ꭶ()
  "ॐ"
  (interactive)

  (let* (
         (ᎦbackgroundᎦ              "#1C1C1C")
         (ᎦvariableᎦ                "#FF1133")
         (ᎦstringᎦ                  "#AAA")
         (ᎦregexpᎦ                  "#DDD")
         (ᎦadmonitionᎦ              "#F80101")
         (ᎦadmonitionᎦ              "#C10100")
         (ᎦwarningᎦ                 "#F80101")
         (ᎦerrorᎦ                   "#DB5045")
         (ᎦnumberᎦ                  "#FC580C")
         (ᎦnormalᎦ                  "#FE3333")
         (Ꭶmode-line-inactive-bgᎦ   "#312F27")
         (Ꭶmode-line-inactive-fgᎦ   "#F66A00")
         (Ꭶmethod-declarationᎦ      "#F64028")
         (Ꭶtype-faceᎦ               "#999")
         (Ꭶline-fgᎦ                 "#F94900")
         (Ꭶline-numberᎦ             "#161A1F")
         (Ꭶcurrent-line-numberᎦ     "#C10000")
         (ᎦkeywordsᎦ                "#FF0946")
         (Ꭶcurrent-lineᎦ            "#151515")
         (ᎦoperatorsᎦ               "#FFF")
         (ᎦconstantᎦ                "#A80000")
         (ᎦcommentsᎦ                "#999")
         (ᎦselᎦ                     "#B10000")
         (ᎦcursorᎦ                  "#FFF")
         (ΩᎦ                        "#FB1")
         )

    (require 'linum)
    (require 'make-mode)
    (require 'ibuffer)
    (require 'calendar)
    (require 'rect)
    (require 'compile)
    (setq ns-allow-anti-aliasing t)
    (setq ns-function-modifier 'control)
    (setq ns-option-modifier 'meta)
    (setq ns-command-modifier 'meta)

    (show-paren-mode 10)
    (setq-default indent-tabs-mode nil)
    (setq-default truncate-lines t)
    (global-font-lock-mode 1)
    (transient-mark-mode 1)



    (set-face-attribute 'default nil :font "JetBrains Mono Thin-20")
    (set-face-attribute 'info-menu-header nil :foreground "#DB5045" :underline nil :bold t :font "JetBrains Mono Thin-20")
    (global-prettify-symbols-mode 0)
    (setq linum-format "%6d")
    (global-linum-mode -1)
    (display-line-numbers-mode t)
    ;; (setq display-line-numbers-major-tick 0)
    ;; (setq display-line-numbers-minor-tick 0)
    (set-face-attribute 'cursor nil :background ᎦcursorᎦ :foreground ᎦcursorᎦ)
    (setq-default cursor-type '(bar . 3))
    (set-face-attribute 'Info-quoted nil :bold nil :background ᎦbackgroundᎦ :foreground ᎦnormalᎦ )
    (set-face-attribute 'bold nil        :bold t :background ᎦbackgroundᎦ :foreground ᎦnormalᎦ )
    (set-face-attribute 'default nil :foreground ᎦnormalᎦ :background ᎦbackgroundᎦ)
    (set-face-attribute 'button nil :foreground ᎦkeywordsᎦ :underline t)
    (set-face-attribute 'default nil :background ᎦbackgroundᎦ :foreground ᎦnormalᎦ)
    (set-face-attribute 'header-line nil :background (Ꭶ/mode-line-background) :foreground ᎦnormalᎦ)
    (set-face-attribute 'highlight nil :background Ꭶcurrent-lineᎦ :foreground (Ꭶ/mode-line-foreground))
    (set-face-attribute 'info-xref nil :foreground "#27CE79" :underline nil :bold nil)
    (set-face-attribute 'info-xref-visited nil
                        :foreground "#787878"
                        :overline nil
                        :underline "#D87101"
                        :bold t)

    (set-face-attribute 'info-menu-star nil :foreground (Ꭶ/mode-line-foreground) :underline nil :bold t)
    (set-face-attribute 'info-header-xref nil  :foreground ᎦkeywordsᎦ :underline t)
    (set-face-attribute 'show-paren-match nil :background (Ꭶ/mode-line-foreground) :foreground ᎦbackgroundᎦ :weight 'bold)
    (set-face-attribute 'show-paren-match-expression nil :background Ꭶtype-faceᎦ  :weight 'bold)
    (set-face-attribute 'show-paren-mismatch nil :background ᎦerrorᎦ  :foreground ᎦnormalᎦ :weight 'bold)
    (set-face-attribute 'region nil :background ᎦselᎦ :foreground ᎦbackgroundᎦ)
    (set-face-attribute 'makefile-space nil :background ᎦbackgroundᎦ :foreground ᎦerrorᎦ)
    (set-face-attribute 'ibuffer-locked-buffer nil :background ᎦwarningᎦ :foreground ᎦbackgroundᎦ)
    (set-face-attribute 'separator-line nil :background ᎦbackgroundᎦ :foreground ᎦkeywordsᎦ )
    (set-face-attribute 'font-lock-builtin-face nil :foreground ᎦoperatorsᎦ)
    (set-face-attribute 'font-lock-comment-delimiter-face nil :foreground ᎦcommentsᎦ)
    (set-face-attribute 'font-lock-comment-face nil :foreground ᎦcommentsᎦ)
    (set-face-attribute 'font-lock-constant-face nil :foreground ᎦconstantᎦ)
    (set-face-attribute 'font-lock-doc-face nil :foreground ΩᎦ)
    (set-face-attribute 'font-lock-doc-markup-face nil :foreground ᎦstringᎦ)
    (set-face-attribute 'font-lock-function-name-face nil :foreground Ꭶmethod-declarationᎦ)
    (set-face-attribute 'font-lock-keyword-face nil :foreground ᎦkeywordsᎦ)
    (set-face-attribute 'font-lock-negation-char-face nil :foreground ᎦadmonitionᎦ)
    (set-face-attribute 'font-lock-constant-face nil :foreground ᎦnumberᎦ)
    (set-face-attribute 'font-lock-preprocessor-face nil :foreground ᎦkeywordsᎦ)
    (set-face-attribute 'font-lock-constant-face nil :foreground ᎦconstantᎦ)
    (set-face-attribute 'font-lock-regexp-grouping-backslash nil :foreground ᎦregexpᎦ)
    (set-face-attribute 'font-lock-regexp-grouping-construct nil :foreground ᎦregexpᎦ)
    (set-face-attribute 'font-lock-string-face nil :foreground ᎦstringᎦ)
    (set-face-attribute 'font-lock-type-face nil :foreground Ꭶtype-faceᎦ)
    (set-face-attribute 'font-lock-variable-name-face nil :foreground ᎦvariableᎦ)
    (set-face-attribute 'font-lock-warning-face nil :foreground ᎦadmonitionᎦ :background ᎦbackgroundᎦ)
    (set-face-attribute 'fringe nil :background ᎦbackgroundᎦ :foreground ᎦbackgroundᎦ :box '(:width 0))
    (set-face-attribute 'holiday nil :background ᎦadmonitionᎦ :foreground ᎦbackgroundᎦ)
    (set-face-attribute 'calendar-weekday-header nil :background ᎦbackgroundᎦ :foreground Ꭶmode-line-inactive-bgᎦ)
    ;; (set-face-attribute 'line-number nil :background ᎦbackgroundᎦ :foreground Ꭶcurrent-line-numberᎦ)
    ;; (set-face-attribute 'line-number-current-line nil :background Ꭶcurrent-line-numberᎦ :foreground ᎦbackgroundᎦ)
    (set-face-attribute 'line-number nil :background ᎦbackgroundᎦ :foreground ᎦcommentsᎦ)
    (set-face-attribute 'line-number-current-line nil :background ᎦbackgroundᎦ :foreground Ꭶcurrent-line-numberᎦ)
    (set-face-attribute 'line-number-major-tick nil :background ᎦbackgroundᎦ :foreground ᎦcommentsᎦ)
    (set-face-attribute 'line-number-minor-tick nil :background ᎦbackgroundᎦ :foreground ᎦstringᎦ)
    (set-face-attribute 'minibuffer-prompt nil :foreground ᎦvariableᎦ)
    (set-face-attribute 'rectangle-preview nil :background Ꭶline-numberᎦ)
    (set-face-attribute 'mode-line nil :background (Ꭶ/mode-line-background) :foreground (Ꭶ/mode-line-foreground))
    (set-face-attribute 'mode-line-inactive nil :background Ꭶmode-line-inactive-bgᎦ :foreground Ꭶmode-line-inactive-fgᎦ
                        :box '(:line-width (0 . 0)))
    (set-face-attribute 'mode-line-emphasis nil :bold nil :background nil :foreground nil)
    (set-face-attribute 'vertical-border nil :background nil :foreground nil)
    (set-face-attribute 'isearch nil :background (Ꭶ/mode-line-foreground) :foreground (Ꭶ/mode-line-background))
    (set-face-attribute 'isearch-fail nil :background ᎦerrorᎦ :foreground ᎦbackgroundᎦ)
    (set-face-attribute 'error nil :background ᎦerrorᎦ :foreground "#333")
    (set-face-attribute 'shadow nil :foreground "#333")
    (set-face-attribute 'fill-column-indicator nil :foreground "#111")
    (set-face-attribute 'warning nil :foreground ᎦwarningᎦ :background ᎦbackgroundᎦ)
    (set-face-attribute 'underline :underline)

    (set-face-attribute 'compilation-mode-line-fail nil :background "#EEE" :background "#222")
    (set-face-attribute 'lazy-highlight nil :background Ꭶcurrent-lineᎦ :foreground ᎦselᎦ)
    (when (require 'ert)
      (progn
        (set-face-attribute 'ert-test-result-expected nil :background "#3cc14c" :foreground ᎦbackgroundᎦ)
        (set-face-attribute 'ert-test-result-unexpected nil :background ᎦerrorᎦ :foreground ᎦbackgroundᎦ)
        (set-face-attribute 'escape-glyph nil :background ᎦbackgroundᎦ :foreground ᎦerrorᎦ)
        (set-face-attribute 'homoglyph nil :background ᎦbackgroundᎦ :foreground ᎦadmonitionᎦ)
        (set-face-attribute 'fill-column-indicator nil :background ᎦbackgroundᎦ)))

    (when
        (require 'web-mode)
      (progn
        (set-face-attribute 'web-mode-json-key-face nil :foreground ᎦkeywordsᎦ)
        (set-face-attribute 'web-mode-json-string-face nil :foreground ᎦvariableᎦ)
        (set-face-attribute 'web-mode-json-context-face nil :foreground "#79B9FF")))

    (when
        (require 'markdown-mode)
      (progn
        (set-face-attribute 'markdown-markup-face nil :foreground ᎦvariableᎦ))
        (set-face-attribute 'markdown-link-face nil :foreground "#79B9FF")
      )

    (mapc #'(lambda (s)
              (set-face-attribute s nil :background "#000" :foreground "#000"))
          (list
           'border
           'child-frame-border
           'header-line-highlight
           'internal-border
           'window-divider
           'window-divider-first-pixel
           'window-divider-last-pixel
           'mode-line-highlight))))


(add-hook 'after-init-hook 'Ꭶ)
(add-hook 'after-save-hook 'Ꭶ)
(Ꭶ)
