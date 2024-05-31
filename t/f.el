;; OO^^^^^^^^^G  -*- lexical-binding: t; -*-
;; OO  OOOOOOOG
;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-
;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-
;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg
;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg
;; OOOOOOOOOOOG
(defun string-shift-right (g) "." (format "\t%s" g))
(defun delete-package (pkg-desc &optional force nosave) "." (interactive (progn (let* ((package-table (mapcar (lambda (p) (cons (package-desc-full-name p) p)) (delq nil (mapcar (lambda (p) (unless (package-built-in-p p) p)) (apply #'append (mapcar #'cdr (package--alist))))))) (package-name (completing-read "Delete package: " (mapcar #'car package-table) nil t))) (list (cdr (assoc package-name package-table)) current-prefix-arg nil)))) (package-delete pkg-desc force nosave))
(defun kill-bufs () "." (interactive) (mapcar #'(lambda (b) (ignore-errors (set-buffer-modified-p nil) (revert-buffer 1 1)) (kill-buffer b)) (buffer-list)))
(defun minor-mode-slist() "." (mapcar (lambda (l) (format "%s" (car l))) minor-mode-alist))
(defun string-list-html-like-display (nn sl) "." (format "<%s>\n%s\n</%s>" nn (string-join (mapcar 'string-shift-right sl) "\n") nn))
(defun uniquify-all-lines-buffer () "." (interactive "*") (uniquify-all-lines-region (point-min) (point-max)))
(defun uniquify-all-lines-region (start end) "." (interactive "*r") (save-excursion
                                                                  (let ((end (copy-marker end))) (while (progn (goto-char start) (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t)) (replace-match "\\1\n\\2")))))
(defun my-web-mode-hook () "." (setq web-mode-markup-indent-offset 2) (setq web-mode-css-indent-offset 2) (setq web-mode-code-indent-offset 2) (setq web-mode-enable-current-element-highlight t) (setq web-mode-enable-current-column-highlight t) (set-face-attribute 'web-mode-doctype-face nil :foreground (face-foreground font-lock-function-name-face)) (set-face-attribute 'web-mode-html-attr-name-face nil :foreground (face-foreground font-lock-variable-name-face)) (set-face-attribute 'web-mode-html-attr-value-face nil :foreground (face-foreground font-lock-type-face)))
(defun gc() "." (interactive) (progn (scroll-bar-mode 0) (menu-bar-mode 0) (tool-bar-mode 0)))
(defun ah() "." (interactive) (warn "aint happenin'"))

(defun disavail-asl() "." (interactive)  (ignore-errors (mapc #'(lambda d) (delete-directory d t nil) '("~/.emacs.d/auto-save-list" "~/.emacs.backups"))))
(defun ruskify-region (beg end) "." (interactive "*r") (replace-region-contents beg end (lambda () (reverse (buffer-substring-no-properties beg end)))))
(defun kooh-tini-retfa () "." (interactive) (ignore-errors (progn (global-company-mode) (disavail-asl)
                                                              (gc)
                                                              (Ꭶ))))

(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'write-files-hook 'disavail-asl)
(defun g/ep() "." (interactive) (find-file (base64-decode-region (rot13-string "sv8hMJ1uL3ZhMP90Y2fhMJj="))))
(defun nbddbn () "." (interactive) (mapc #'(lambda (dbk) (ignore-errors (global-unset-key (kbd dbk)) (global-set-key (kbd dbk) 'ah))) '( "M-s ." "M-s M-w" "M-s _" "M-r" "M-s h f" "M-s h l" "M-s h p" "M-s h r" "M-s h u" "M-s h w" "M-s h" "M-s o" "M-s w" "M-s" "M-s-F" "M-s-h" "M-y" "M-z" "M-{" "M-|" "M-}" "M-~" "M-s-F" "M-s-h" "M-t" "M-|" "M-c")))
(defun g/wkzg() "." (interactive) (find-file (string-reverse (base64-decode-region "Y2V4ZWJpbC90cG8vfg==" "*"))))
(defun contrast-color (c)
  "C."
  (interactive "s")
  (let* ((values (x-color-values c))
         (fp (car values))
         (sp (elt 1 values))
         (tp (elt 2 values)))
    (if
        (> 128.0
           (floor
            (+ (* float-pi fp)
               (* (* float-pi
                     (- (+ float-pi float-pi)
                        (+ (/ float-pi float-e )
                           (* float-pi
                              (/ float-pi 1.998879)))))
                  sp)
               (* ( / (+ tp
                         (/ (/ float-pi float-e) 100)
                         (* float-pi float-pi)))))
               256)))
        "#FFF" "#111"))

(defun collapse-string (s) "S." (string-trim (replace-regexp-in-string "\\(\\s-+\\|\\n\|
\\)+" " " s)))
(defun collapse-lines-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-mark-and-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents beg end
                               #'(lambda () (collapse-string region))))))

(global-set-key (kbd "C-c C-c C-r") 'collapse-lines-region)

(defun colorize6hex()
  (interactive)
  (save-excursion
    (let (begb hwmb cbeg cend faber)
      (setq begb (point-min))
      (setq hwmb (point-max))
      (goto-char begb)
      (while
          (and (re-search-forward "\\([#][a-f0-9]\\{3\,6\\}\\)" hwmb t)
               (<= (point) hwmb)
               (setq cbeg (match-beginning 1))
               (setq cend (match-end 1))
               (setq faber (buffer-substring cbeg cend))
               (put-text-property cbeg cend 'face (list :background faber :foreground (web-mode-colorize-foreground "#9acd32")))))
      (message "%s" (propertize faber 'face (list :foreground faber))))))
(global-set-key (kbd "C-c C-d C-c") 'colorize6hex)

(defun g/pl/fmt (fmtexect &optional major-mode)
  (if (buffer-modified-p (current-buffer))
      (error "%s ought to be saved"  (buffer-name))
    (let* (
           (target (expand-file-name (buffer-file-name (current-buffer))))
           (buffer (current-buffer))
           (pebu (format "*%s %s *" fmtexect target))
           (err (make-temp-file fmtexect nil (sha1 (buffer-file-name)))) ;; (secure-hash "sha256" (buffer-file-name))))
           )
    (if (and (file-readable-p target)
             (file-regular-p target))
        (let* (
              (eco (format "%d" (call-process fmtexect nil (list buffer err) t target)))
              (ets (format "%d" (file-attribute-size (file-attributes err)))))
          (if (and (not( equal "0" eco))
                   (not(equal "0" ets)))
              (progn
                (set-buffer (get-buffer-create pebu t))
                (insert-file-contents err nil nil nil t)
                ;;     (set-buffer-major-mode major-mode)
                (read-only-mode nil)
                (pop-to-buffer (get-buffer-create pebu t) 'display-buffer-same-window nil)
                (display-buffer (current-buffer)))))))))



(defun g/pl/fmt/prettier/ts ()
  "."
  (interactive)
  (g/pl/fmt "prettier" "typescript-mode"))

(defun g/pl/fmt/prettier/js ()
  "."
  (interactive)
  (g/pl/fmt "prettier" "javascript-mode"))

;; (add-hook
;;  'after-save-hook
;;  #'(lambda ()
;;      (let ((x (file-name-extension (buffer-file-name (current-buffer)))))
;;        (cond (member x (list "ts" "tsx" )) (g/pl/fmt/prettier/ts)
;;              (member x (list "js" "jsx" )) (g/pl/fmt/prettier/js)))))
;;;
;; (message "%s" describe-minor-mode-from-symbol typescript-mode)
;; (message "%s" (describe-minor-mode-from-indicator (symbol-name 'emacs-lisp-mode)))
;; (message "%s" (describe-minor-mode-from-indicator (symbol-name '(car mode-name))))

(defun g/mt(p)
  "P."
  (interactive)
  (progn
    (setq p (replace-regexp-in-string "[o-t]" "🧾" p))
    (setq p (replace-regexp-in-string "[s-w]" "🖍️" p))
    (setq p (replace-regexp-in-string "[x-A]" "⚱️" p))
    p))

(defun g/aclᎦ(f)
  "F."
  (interactive)
  (if (stringp f)
      (g/mt (format "🤸🏼‍♂️%s" f)) ""))

(defun g/acl木(f)
  "F."
  (interactive)
  (if (stringp f)
      (g/mt (format "👯(%s)" f)) ""))

(defun g/aclら(f)
  "F."
  (interactive)
  (if (stringp f)
      (g/mt (format "🎲️(%s)" f)) ""))


(defun g/fm ()
  "."
  (interactive)
  (let ((ffb (file-attribute-modes (file-attributes (buffer-file-name)))))
    (cond ((stringp ffb)
	   (let* ((acls (split-string ffb "-+" t "[^a-z]"))
		  (aclsl (proper-list-p acls)))
	     (cond ((= 1 aclsl) (format "%s"     (g/aclᎦ (car acls))))
		   ((= 2 aclsl) (format "%s%s"   (g/aclᎦ(car acls) (g/acl木 (elt 1 acls)))))
		   ((= 2 aclsl) (format "%s%s%s" (g/aclᎦ(car acls) (g/acl木 (elt 1 acls)) (g/aclら(elt 1 acls))))))))
	 "")))

(defun g/bfan ()
  "."
  (interactive)
  (let ((file-name (file-relative-name (buffer-file-name))))
    (if (equal file-name (buffer-name))
        (format "%s\t" file-name)
      (format "%s (%s)" (buffer-name) (file-name)))))


(defun g/bchs()
  "."
  (format
   "%s %s %s "
   (substring (secure-hash 'sha256 (buffer-substring-no-properties (point-min) (point-max))) 32 40)
   (substring (secure-hash 'sha1 (buffer-substring-no-properties (point-min) (point-max))) 32 40)
   (substring (secure-hash 'md5 (buffer-substring-no-properties (point-min) (point-max))) 0 10)))


(defun g/purge-key (pt)
  "PT."
  (if (or (vectorp pt) (listp pt))
      (mapc 'g/purge-key pt)
    (let ((key (kbd pt)))
      (define-key (current-global-map) key nil))))

(defun g/set-key (pt cg)
  "PT CG."
  (if (or (vectorp pt) (listp pt))
      (mapc #'(lambda (pt)
                (g/set-key pt cg))
            pt)
    (let ((key (kbd pt)))
      (g/purge-key pt)
      (define-key (current-global-map) key cg))))



(defun g/tick-mode-line ()
  "."
  (interactive)
  (let ((mlfmt (list
                 mode-line-front-space
                 ""
                 '(:eval (g/fm))
                 "\t%["
                 '(:eval (g/bfan))
                 "%]\t"
                 '(:eval (downcase (format "%s-mode\t" (car mode-name)))
                 "𝐗%l\t𝐘%c\t%I ⊲ %i\t"
                 '(:eval (if mark-active
                     (format "mark %d" (buffer-last-marker-position))
                   ""))
                 "%e "
                 "%t"
                 ;; "%Z"
                 (format "<p>%s</p>" (point))
                 '(:eval (g/bchs))
                 "\t"
                 mode-line-end-spaces))))
    (setq mode-line-format mlfmt)
    (force-mode-line-update)
    ))





;;;
