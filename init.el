2;; OO^^^^^^^^^G
;; OO  OOOOOOOG
;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-
;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-
;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg
;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg
;; OOOOOOOOOOOG
(set-face-attribute 'default nil :font "JetBrains Mono-1" :background "#fff")
(setq mode-line-format (list (base64-decode-string "V2VsY29tZSBHcmFuZE1hc3RlciBnYWJyaWVsLmRlbW91cmEgcGxlYXNlIHdhaXQgYXMgdGhlIHN5c3RlbSByZW5kZXJzIGl0c2VsZiBwcmVwYXJlZCBmb3IgdGhpbmUgY3JhZnRzLi4u")))
(setq server-socket-dir "~/.emacs.d/socket" server-log t)
(let ((foreground "#A79C83")
      (background "#333"))
  (set-face-attribute 'default nil :foreground foreground :background background :font "JetBrains Mono-20")
  (set-face-attribute 'mode-line nil :background background :foreground foreground)
  (set-face-attribute 'mode-line-inactive nil :background background :foreground foreground
                      :box '(:line-width (0 . 0))))
(progn (add-to-list 'load-path "~/.emacs.d/3pty") (add-to-list 'load-path "~/.emacs.d/t") (load-library "k"));; (load-library "load-tree-sitter"))
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(csharp-mode lua-mode yaml-mode web-mode typescript-mode toml-mode toml terraform-mode swift-mode solidity-flycheck rust-mode restclient python-mode protobuf-mode php-mode pcre2el nginx-mode markdown-mode jsonnet-mode jinja2-mode highlight-indentation haml-mode go-mode flycheck-rust expand-region exec-path-from-shell elixir-mode dockerfile-mode company cargo-mode blacken autothemer ansi)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
