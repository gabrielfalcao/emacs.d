(defun elisp-regexp-for(what type)
  (cond ((string= "function")
         (str "defun[[:space:]\x0a]+[a-z_-]*[a-z0-9_-]*\(workbench\|wip\)+[a-z_-]*[a-z0-9_-]*[[:space:]\x0a][(][a-z0-9_-]*"))
        ))

(defun shell-script-variable-declaration-regexp (must-include-dash-g)
  (let (
        (parts (list "^\\(\s-*\\)declare\\(\s-+[-]\\)\\([a-fh-z-]*\\)g\\([a-fh-z-]*\\)\\(\s-+\\)\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)\\([=]\\('\\(.*\\)'\\|\"\\(.*\\)\"\\|\\([0-9]+\\)\\|\\(.*\\)\\)?\\)?"))
        "^\\(\s-*\\)declare\\(\s-+[-]\\)\\([a-fh-z-]*\\)g\\([a-fh-z-]*\\)\\(\s-+\\)\\([a-zA-Z_]+[a-zA-Z0-9_]*\\)\\([=]\\('\\(.*\\)'\\|\"\\(.*\\)\"\\|\\([0-9]+\\)\\|\\(.*\\)\\)?\\)?"
        )
    ); end let
  ); end defun shell-script-variable-declaration-regexp
(defun shell-script-ensure-all-declare-stmts-global-dash-g-in-region(beg end)
  (let ((regexp-and-replacement-plists (list (list :regexp

    (save-match-data
      (save-mark-and-excursion
        ;; (widen)
        ;; (goto-char beg)
        (while (re-search-forward  end t count)

          (let ((replacement
                 (format "%s%s%s%s"
                         (match-string 1)
                         sol
                         (match-string 2)
                         eol)))
            ;; (c-message-open "%s" replacement)
            (replace-match replacement nil t)))))))

  (save-match-data
    (
      → declare -g\1\2
