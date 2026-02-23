;; (defconst c/regexp/emacs-macos-30.1/original-var/search-whitespace-regexp "[ 	]+")
;; (defconst c/regexp/emacs-macos-30.1/original-var/isearch-lax-whitespace t)
;; (defconst c/regexp/emacs-macos-30.1/original-var/isearch-regexp-lax-whitespace nil)

(setq
 search-whitespace-regexp "[\x09\x0a\x0b\x0c\x20\\x09\\x0a\\x0b\\x0c\\x20]+"
;;  search-whitespace-regexp "[
;;  ]+"
 isearch-lax-whitespace t
 isearch-regexp-lax-whitespace t
)
;;
;; `isearch-lax-whitespace' is nil for ordinary incremental search, or
;; `isearch-regexp-lax-whitespace' is nil for regexp incremental search,
