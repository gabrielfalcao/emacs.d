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







(defun Ꭶ()
  "ॐ"
  (interactive)
  (let* ((Ꭶvisual-selectionᎦ   "#C6DCFC")
         (ᎦvariableᎦ           "#F49101")
         (ᎦstringᎦ             "#DCDC88")
         (ᎦregexpᎦ             "#C63367")
         (ᎦadmonitionᎦ         "#F80101")
         (ᎦoperatorsᎦ          "#F682FF")
         (ᎦnumberᎦ             "#FC580C")
         (ᎦnormalᎦ             "#DEDEDE")
         (Ꭶmode-inactive-fgᎦ   "#9195B2")
         (Ꭶmode-line-fgᎦ       "#ffcc00")
         (Ꭶmode-inactive-bgᎦ   "#010000")
         (Ꭶmode-line-bgᎦ       "#333"   )
         (Ꭶmethod-declarationᎦ "#A6E22E")
         (Ꭶtype-faceᎦ          "#36F6E9")
         (Ꭶtype-faceᎦ          "#1996C9")
         (Ꭶline-fgᎦ            "#919588")
         (Ꭶline-numberᎦ        "#161A1F")
         (ᎦkeywordsᎦ           "#F13976")
         (Ꭶcursor-underscoreᎦ  "#EEDC82")
         (Ꭶcurrent-lineᎦ       "#151515")
         (ᎦconstantᎦ           "#F07EF8")
         (ᎦcommentsᎦ           "#A79C83")
         (ᎦbackgroundᎦ         "#1C1C1C"))
    (with-demoted-errors "set-face-attribute: %s"
      (progn
        (set-face-attribute 'Info-quoted nil :bold nil :background ᎦbackgroundᎦ :foreground ᎦnormalᎦ )
        (set-face-attribute 'bold nil        :bold nil :background ᎦbackgroundᎦ :foreground ᎦnormalᎦ )
        (set-face-attribute 'default nil :foreground ᎦnormalᎦ :background ᎦbackgroundᎦ)
        (set-face-attribute 'button nil :foreground ᎦkeywordsᎦ :underline t)
        (set-face-attribute 'default nil :background ᎦbackgroundᎦ :foreground ᎦnormalᎦ)
        (set-face-attribute 'header-line nil :background Ꭶmode-line-bgᎦ :foreground ᎦnormalᎦ)
        (set-face-attribute 'highlight nil :background Ꭶcurrent-lineᎦ)
        (set-face-attribute 'info-header-xref nil :foreground ᎦkeywordsᎦ :underline t)
        (set-face-attribute 'region nil :background Ꭶvisual-selectionᎦ :foreground ᎦbackgroundᎦ)
        (set-face-attribute 'underline nil :underline )
        (set-face-attribute 'font-lock-builtin-face nil :foreground ᎦoperatorsᎦ)
        (set-face-attribute 'font-lock-comment-delimiter-face nil :foreground ᎦcommentsᎦ)
        (set-face-attribute 'font-lock-comment-face nil :foreground ᎦcommentsᎦ)
        (set-face-attribute 'font-lock-constant-face nil :foreground ᎦconstantᎦ)
        (set-face-attribute 'font-lock-doc-face nil :foreground ᎦstringᎦ)
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
        (set-face-attribute 'font-lock-warning-face nil :foreground ᎦadmonitionᎦ)
        (set-face-attribute 'fringe nil :background ᎦbackgroundᎦ)
        (set-face-attribute 'linum nil :background Ꭶline-numberᎦ :foreground Ꭶline-fgᎦ)
        (set-face-attribute 'minibuffer-prompt nil :foreground ᎦvariableᎦ)
        (set-face-attribute 'mode-line nil :background Ꭶmode-line-bgᎦ :foreground Ꭶmode-line-fgᎦ)
        (set-face-attribute 'mode-line-inactive nil :background Ꭶmode-inactive-bgᎦ :foreground Ꭶmode-inactive-fgᎦ)
        (set-face-attribute 'cursor nil :background Ꭶcursor-underscoreᎦ)
        (set-face-attribute 'vertical-border nil :background ᎦbackgroundᎦ)
        (set-face-attribute 'show-paren-mismatch nil :background ᎦadmonitionᎦ :foreground ᎦnormalᎦ :weight 'bold)
        (set-face-attribute 'show-paren-match nil :background ᎦkeywordsᎦ :foreground ᎦnormalᎦ :weight 'bold)
        (set-face-attribute 'isearch nil :background ᎦregexpᎦ :foreground Ꭶvisual-selectionᎦ)
        (set-face-attribute 'isearch-fail nil :background ᎦadmonitionᎦ)
        (set-face-attribute 'lazy-highlight nil :background ᎦoperatorsᎦ :foreground Ꭶvisual-selectionᎦ)
        (set-face-attribute 'bold nil :bold t)))))

(add-hook 'after-change-major-mode-hook
          'Ꭶ)

(Ꭶ)
