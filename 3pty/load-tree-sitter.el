(progn
  (add-to-list 'load-path "~/.emacs.d/3pty/elisp-tree-sitter/core")
  (add-to-list 'load-path "~/.emacs.d/3pty/elisp-tree-sitter/lisp")
  (add-to-list 'load-path "~/.emacs.d/3pty/elisp-tree-sitter/langs"))

(require 'tree-sitter)
(require 'tree-sitter-hl)
(require 'tree-sitter-langs)
(require 'tree-sitter-debug)
(require 'tree-sitter-query)
