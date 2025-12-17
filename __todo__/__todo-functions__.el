;; TODO: build rust refactoring tool using `minibuffer-lazy-highlight-setup' to find callers of functions, structs etc
;; WIP/TODO: replace with rgb-parser.el
           ;; TODO: first lets figure out the most recent buffer before c-message-buffer
;;;TODO 2025-12-05 19:37:48+0000 ;;;  (and (unless (or (null dir-path)
;;;TODO 2025-12-05 19:37:48+0000 ;;;                   (stringp dir-path))
;;;TODO 2025-12-05 19:37:48+0000 ;;;         (error "dir-path is not a string but rather %s: %S" (type-of dir-path) dir-path))
;;;TODO 2025-12-05 19:37:48+0000 ;;;       (unless (file-exists-p dir-path)
;;;TODO 2025-12-05 19:37:48+0000 ;;;         (make-directory dir-path t) t)
;;;TODO 2025-12-05 19:37:48+0000 ;;;       (unless (file-directory-p dir-path)
;;;TODO 2025-12-05 19:37:48+0000 ;;;         (error "dir-path is not a directory: %S" dir-path)))
;;;TODO 2025-12-05 19:37:48+0000 ;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;; (defcustom indentation-level-indent-commented-bracket-braces-parenthesis
;;;TODO @ 2025-12-05 18:54:48+0000;;;   4
;;;TODO @ 2025-12-05 18:54:48+0000;;;   "indentation level as number of spaces to indent each item found
;;;TODO @ 2025-12-05 18:54:48+0000;;;  `indent-commented-bracket-braces-parenthesis-region'")
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;; (defvar indent-commented-bracket-braces-parenthesis-region-current-level
;;;TODO @ 2025-12-05 18:54:48+0000;;;   1)
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;; (defun make-indent-commented-bracket-braces-parenthesis()
;;;TODO @ 2025-12-05 18:54:48+0000;;;   (let* ((current indent-commented-bracket-braces-parenthesis-region-current-level)
;;;TODO @ 2025-12-05 18:54:48+0000;;;          (level (indentation-level-indent-commented-bracket-braces-parenthesis))
;;;TODO @ 2025-12-05 18:54:48+0000;;;          (amount (* current level)))
;;;TODO @ 2025-12-05 18:54:48+0000;;;     (make-indent amount)
;;;TODO @ 2025-12-05 18:54:48+0000;;;     ))
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;; (defun indent-commented-bracket-braces-parenthesis-region (beg end)
;;;TODO @ 2025-12-05 18:54:48+0000;;;   "indents commented regions such as:
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;; (symbol-plist #'current-buffer):
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;(
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;;byte-compile byte-compile-no-args byte-opcode byte-current-buffer gv-expander #
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;[
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;;385 \"\"
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;[
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;;gv--defsetter current-buffer #
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;[
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;;385 \"\"
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;[
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;;set-buffer append] 6 ...]] 7
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;(
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;;\"/Applications/Emacs.app/Contents/Resources/lisp/emacs-lisp/gv.elc\" . 8972)] byte-obsolete-generalized-variable
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;(
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;{
;;;TODO @ 2025-12-05 18:54:48+0000;;; ;;;set-buffer \"29.1\") side-effect-free error-free)
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;; "
;;;TODO @ 2025-12-05 18:54:48+0000;;;   (interactive "*r")
;;;TODO @ 2025-12-05 18:54:48+0000;;;   (save-mark-excursion-and-match-data
;;;TODO @ 2025-12-05 18:54:48+0000;;;     (let* (
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (regex-open "^;;\\([(]\\|[[]\\|[{]\\)")
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (regex-close "^;;\\([)]\\|[]]\\|[}]\\)")
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (initial-beg beg)
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (initial-end end)
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (last-beg beg)
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (last-end end)
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (next-beg beg)
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (next-end end)
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (current-regexp regex-open)
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (match (re-search-forward regex-open initial-end t))
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (last-match match)
;;;TODO @ 2025-12-05 18:54:48+0000;;;            (finished nil)
;;;TODO @ 2025-12-05 18:54:48+0000;;;            ); end let* varlist
;;;TODO @ 2025-12-05 18:54:48+0000;;;       ;; @within let* body
;;;TODO @ 2025-12-05 18:54:48+0000;;;       (unless match
;;;TODO @ 2025-12-05 18:54:48+0000;;;         (error "no match for regexp %S within %s and %s"
;;;TODO @ 2025-12-05 18:54:48+0000;;;                     (location-at-pos beg) (location-at-pos end)));; end unless
;;;TODO @ 2025-12-05 18:54:48+0000;;;       ;; @within let* body
;;;TODO @ 2025-12-05 18:54:48+0000;;;       (while (re-search-forward regex-open initial-end t 1)
;;;TODO @ 2025-12-05 18:54:48+0000;;;         (setq last-beg beg
;;;TODO @ 2025-12-05 18:54:48+0000;;;               last-end end
;;;TODO @ 2025-12-05 18:54:48+0000;;;               beg (match-beginning 0)
;;;TODO @ 2025-12-05 18:54:48+0000;;;               end (match-end 0))
;;;TODO @ 2025-12-05 18:54:48+0000;;;         (with-next-match-beginning-end
;;;TODO @ 2025-12-05 18:54:48+0000;;;          regex-open beg end
;;;TODO @ 2025-12-05 18:54:48+0000;;;          #'(lambda (n-beg n-end)  ;; further matches found
;;;TODO @ 2025-12-05 18:54:48+0000;;;              (setq next-beg n-beg
;;;TODO @ 2025-12-05 18:54:48+0000;;;                    next-end n-end))
;;;TODO @ 2025-12-05 18:54:48+0000;;;          #'(lambda ()             ;; no further regexp matches
;;;TODO @ 2025-12-05 18:54:48+0000;;;              (setq next-beg nil
;;;TODO @ 2025-12-05 18:54:48+0000;;;                    next-end nil
;;;TODO @ 2025-12-05 18:54:48+0000;;;                    finished t))
;;;TODO @ 2025-12-05 18:54:48+0000;;;          );; end with-next-match-beginning-end
;;;TODO @ 2025-12-05 18:54:48+0000;;;         (goto-char next-beg))
;;;TODO @ 2025-12-05 18:54:48+0000;;;       ;;(unless finished
;;;TODO @ 2025-12-05 18:54:48+0000;;;       ;;(while (re-search-forward regex-close initial-end t 1))
;;;TODO @ 2025-12-05 18:54:48+0000;;;       );; end let*
;;;TODO @ 2025-12-05 18:54:48+0000;;;     );; end defun indent-commented-bracket-braces-parenthesis-region
;;;TODO @ 2025-12-05 18:54:48+0000;;;   )
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;;
;;;TODO @ 2025-12-05 18:54:48+0000;;; (defmacro with-next-match-beginning-end(regexp beg end body)
;;;TODO @ 2025-12-05 18:54:48+0000;;;   (save-mark-excursion-and-match-data
;;;TODO @ 2025-12-05 18:54:48+0000;;;       (goto-char beg)
;;;TODO @ 2025-12-05 18:54:48+0000;;;       ;; <if>
;;;TODO @ 2025-12-05 18:54:48+0000;;;       (if (re-search-forward regexp end 1)
;;;TODO @ 2025-12-05 18:54:48+0000;;;           ;; <then>
;;;TODO @ 2025-12-05 18:54:48+0000;;;           (let ( ;;if then
;;;TODO @ 2025-12-05 18:54:48+0000;;;                 (next-beg (match-beginning 0))
;;;TODO @ 2025-12-05 18:54:48+0000;;;                 (next-end (match-end 0)))
;;;TODO @ 2025-12-05 18:54:48+0000;;;             (funcall body next-beg next-end)
;;;TODO @ 2025-12-05 18:54:48+0000;;;             )
;;;TODO @ 2025-12-05 18:54:48+0000;;;         ;; </then>
;;;TODO @ 2025-12-05 18:54:48+0000;;;         ;; <else>
;;;TODO @ 2025-12-05 18:54:48+0000;;;         (funcall body nil nil)
;;;TODO @ 2025-12-05 18:54:48+0000;;;         ;; </else>
;;;TODO @ 2025-12-05 18:54:48+0000;;;         )
;;;TODO @ 2025-12-05 18:54:48+0000;;;       ;; </if>
;;;TODO @ 2025-12-05 18:54:48+0000;;;       )
;;;TODO @ 2025-12-05 18:54:48+0000;;;   )
;;;TODO @ 2025-12-05 18:54:48+0000;;;
