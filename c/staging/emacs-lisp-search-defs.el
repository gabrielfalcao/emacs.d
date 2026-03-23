(defvar emacs-lisp-defsymbols
  '( ;;
     def-edebug-elem-spec
      def-edebug-spec
      defadvice
      defalias
      default
      default-boundp
      default-directory
      default-file-modes
      default-file-name-coding-system
      default-font-height
      default-font-width
      default-frame-alist
      default-frame-scroll-bars
      default-indent-new-line
      default-input-method
      default-justification
      default-keyboard-coding-system
      default-korean-keyboard
      default-line-height
      default-minibuffer-frame
      default-process-coding-system
      default-sendmail-coding-system
      default-tags-table-function
      default-terminal-coding-system
      default-text-properties
      default-toplevel-value
      default-transient-input-method
      default-value
      defclass
      defconst
      defconst-1
      defconst-mode-local
      defcustom
      defcustom-c-stylevar
      defface
      defgroup
      defimage
      define-abbrev
      define-abbrev-table
      define-abbrevs
      define-advice
      define-alternatives
      define-auto-insert
      define-button-type
      define-category
      define-ccl-program
      define-char-code-property
      define-charset
      define-charset-alias
      define-charset-internal
      define-child-mode
      define-coding-system
      define-coding-system-alias
      define-coding-system-internal
      define-compilation-mode
      define-derived-mode
      define-error
      define-fringe-bitmap
      define-generic-mode
      define-global-abbrev
      define-global-minor-mode
      define-globalized-minor-mode
      define-hash-table-test
      define-ibuffer-column
      define-ibuffer-filter
      define-ibuffer-op
      define-ibuffer-sorter
      define-icon
      define-inline
      define-key
      define-key-after
      define-keymap
      define-keymap--compile
      define-mail-abbrev
      define-mail-alias
      define-mail-user-agent
      define-minor-mode
      define-mode-abbrev
      define-mode-local-override
      define-multisession-variable
      define-obsolete-face-alias
      define-obsolete-function-alias
      define-obsolete-variable-alias
      define-overload
      define-overloadable-function
      define-package
      define-prefix-command
      define-short-documentation-group
      define-skeleton
      define-symbol-prop
      define-thing-chars
      define-translation-hash-table
      define-translation-table
      define-widget
      define-widget-keywords
      defined-colors
      defined-colors-with-face-attributes
      defining-kbd-macro
      definition-prefixes
      defmacro
      defmath
      defsubst
      deftheme
      defun
      defun-declarations-alist
      defun-markdown-buffer
      defun-markdown-ref-checker
      defun-prompt-regexp
      defvar
      defvar-1
      defvar-keymap
      defvar-local
      defvar-mode-local
      defvaralias
     ;;
     )
  "list of symbols which define types in emacs lisp")

(with-c-message-open
 (erase-c-messages)
 (c-message-open)
 (c-message "symbols:\n\n%s\n"
            (string-join
             (mapcar
              (lambda (input-sym)
                (let* (
                       (sym (cl-typecase input-sym
                              (symbol input-sym)
                              (string (intern-soft input-sym))
                              (cons (cadr input-sym))
                              (list (car input-sym))
                              (t (signal 'type-error (format "value argument `input-sym' `%S' is of invalid type: \"%s\"" input-sym (cl-type-of input-sym))))
                              )
                            )

                              (cadr cand-sym))
                       (name (symbol-name sym))
                       (value (condition-case err
                                  (symbol-value sym))

                       )
                  (format "%s (%s): %S" name (cl-type-of value) value))
                )
              emacs-lisp-defsymbols)
             "\n"))
 )
