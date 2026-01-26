(load-library "workbench")


(defun Ox33b4O/find-file/~/workbench/today(filename)
  "bound to `C-x' 'M-f'"
  (interactive
   (find-file-open-minibuffer-at-directory-interactive
    (workbench/path)))
  (find-file-open-minibuffer-at-directory-body filename))


(defun Ox33b4O/open-boot-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/boot.el"))

(defun Ox33b4O/open-ui-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/ui.el"))

(defun Ox33b4O/open-e02491d9-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/e02491d9.el"))

(defun Ox33b4O/open-modes-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/modes.el"))

(defun Ox33b4O/open-debug-et-diagnostics-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/debug-et-diagnostics.el"))

(defun Ox33b4O/open-keys-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/keys.el"))

(defun Ox33b4O/open-hooks-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/hooks.el"))

(defun Ox33b4O/open-advices-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/advices.el"))

(defun Ox33b4O/open-functions-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/functions.el"))

(defun Ox33b4O/open-flatten-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/flatten.el"))

(defun Ox33b4O/open-g-modeline-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/g-modeline.el"))

(defun Ox33b4O/open-other-functions-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/other-functions.el"))

(defun Ox33b4O/open-elpamelpa-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/elpamelpa.el"))

(defun Ox33b4O/open-rgb-parser-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/rgb-parser.el"))

(defun Ox33b4O/open-write-refactor-tool-instead-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/write-refactor-tool-instead.el"))

(defun Ox33b4O/open-macros-el()
  (interactive)
  (find-file-existing "~/.emacs.d/c/macros.el"))

(defun find-file-open-minibuffer-at-directory-interactive(initial-directory)
  (let* ((~/opt/libexec/path (expand-file-name initial-directory))
         (result
          (list
           (read-file-name "Find file: " ~/opt/libexec/path "confirm-after-completion" nil nil ))))
    (with-minibuffer-selected-window
      (minibuffer-complete)
      (minibuffer-complete))
    result));; end defun closure

(defun find-file-open-minibuffer-at-directory-body (filename)
  (let* ((value (find-file-noselect filename nil nil t))
         (result
          (if (listp value)
	      (mapcar 'pop-to-buffer-same-window (nreverse value))
	    (pop-to-buffer-same-window value))))
    (with-minibuffer-selected-window
      (minibuffer-complete)
      (minibuffer-complete))
    result))

(defun Ox33b4O/find-file/~/opt/libexec(filename)
  "bound to `C-x' 'M-f'"
  (interactive
   (find-file-open-minibuffer-at-directory-interactive "~/opt/libexec/"))
  (find-file-open-minibuffer-at-directory-body filename))


(defun Ox33b4O/find-file/~/.shell.d(filename)
  "bound to `C-x' 'M-s'"
  (interactive
   (find-file-open-minibuffer-at-directory-interactive "~/.shell.d/"))
  (find-file-open-minibuffer-at-directory-body filename))

(defun Ox33b4O/find-file/~/.emacs.d(filename)
  "bound to `C-x' 'M-s'"
  (interactive
   (find-file-open-minibuffer-at-directory-interactive "~/.emacs.d/"))
  (find-file-open-minibuffer-at-directory-body filename))
