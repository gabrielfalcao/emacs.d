(defmacro set-region-contents-with-fn(beg end fn)
  (list 'save-excursion (list 'let (list 'region (list 'buffer-substring-no-properties beg end))
                              (list 'replace-region-contents beg end '(list 'lambda (list)
                                                                            (list fn 'region))))))

(defun string-shift-right (g) "." (format "\t%s" g))
(defun delete-package (pkg-desc &optional force nosave) "." (interactive (progn (let* ((package-table (mapcar (lambda (p) (cons (package-desc-full-name p) p)) (delq nil (mapcar (lambda (p) (unless (package-built-in-p p) p)) (apply #'append (mapcar #'cdr (package--alist))))))) (package-name (completing-read "Delete package: " (mapcar #'car package-table) nil t))) (list (cdr (assoc package-name package-table)) current-prefix-arg nil)))) (package-delete pkg-desc force nosave))
(defun kill-bufs () "." (interactive) (mapcar #'(lambda (b) (ignore-errors (set-buffer-modified-p nil) (revert-buffer 1 1)) (kill-buffer b)) (buffer-list)))

(defun minor-mode-slist()
  "."
  (mapcar
   (lambda (l)
     (format "%s" (car l)))
   minor-mode-alist))

(defun string-list-html-like-display (nn sl)
  "."
  (format "<%s>\n%s\n</%s>" nn (string-join (mapcar 'string-shift-right sl) "\n") nn))

(defun uniquify-all-lines-buffer () "." (interactive "*") (uniquify-all-lines-region (point-min) (point-max)))
(defun uniquify-all-lines-region (start end) "." (interactive "*r") (save-excursion (let ((end (copy-marker end))) (while (progn (goto-char start) (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t)) (replace-match "\\1\n\\2")))))

(defun disable-bars() "." (interactive) (progn (scroll-bar-mode nil) (menu-bar-mode nil) (tool-bar-mode nil)))

(defun disable-auto-save-list()
  "."
  (interactive)
  (mapc #'(lambda (d)
            (delete-directory (expand-file-name d) t nil))
        (list "~/.emacs.d/auto-save-list" "~/.emacs.backups")))

(defun reverse-string (beg end) "." (interactive "*r") (replace-region-contents beg end (lambda () (reverse (buffer-substring-no-properties beg end)))))

(defun $$$$$ () "." (interactive) (global-company-mode) (disable-auto-save-list) (disable-bars) ($$$$$$$$))(defun $/ep() "." (interactive) (find-file "~/.emacs.d/t/k.el"))

(defun c$dg$ (&rest substrate)
  (interactive)
  (ignore-errors
    (colorize-hexadecimal-text)
    ($/paint-mode-line)
    (disable-auto-save-list)
    (disable-bars)
    ($$$$$)))

(defun contrast-color (c) "C." (interactive "s") (compute-bright-dark-from-color-value c "#FFF" "#333"))
(defun compute-bright-dark-from-color-value (c bright dark)
  "C."
  (interactive "s")
  (let* ((values (x-color-values c))
         (fp (car values))
         (sp (elt values 1))
         (tp (elt values 2)))
    (if (> #x0f (floor (+ (+ (* float-pi fp)
                             (* sp (* float-pi (- (+ float-pi float-pi)
                                                  (+ (/ float-pi float-e)
                                                     (* float-pi (/ float-pi 1.998879)))))))
                          (* (/ (+ tp (/ (/ float-pi float-e) #x64))
                                (* float-pi float-pi))))
                       #x100))
        bright dark)))

(defun collapse-string (s)
  "S."
  (replace-regexp-in-string "\\s-+" " " (string-trim (replace-regexp-in-string "\\(\\s-+\\|\xa\\)+" " " s))))

(defun collapse-lines-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion (let ((region
                         (buffer-substring-no-properties
                          beg
                          end)))
                    (replace-region-contents beg end #'(lambda ()
                                                         (collapse-string region))))))

(defun colorize-hexadecimal-text()
  (interactive)
  (save-excursion (let (begb hwmb cbeg cend faber)
                    (setq begb (point-min))
                    (setq hwmb (point-max))
                    (goto-char begb)
                    (while (and (re-search-forward "\\([#][a-f0-9]\\{3\,6\\}\\b\\)" hwmb t)
                                (<= (point) hwmb))
                      (let* ((cbeg (match-beginning 1))
                             (cend (match-end 1))
                             (faber
                              (buffer-substring-no-properties
                               cbeg
                               cend))
                             (x2133 (progn
                                      ($/delete-overlays-within cbeg cend)
                                      (make-overlay cbeg cend))))
                        (overlay-put x2133 'bcc t)
                        (overlay-put x2133 'face (list :foreground (contrast-color faber) :background faber))
                        )))))

(defun $/pl/fmt (fmtexect)
  "FMTEXECT MAJOR-MODE."
  (unless (not  (buffer-modified-p (current-buffer)))
    (user-error "%s ought to be saved"  (buffer-name)))
  (unless (stringp fmtexect)
    (user-error "fmtexect nonstring"))
  (save-mark-and-excursion
    (let* ((target (expand-file-name (buffer-file-name)))
           (buffer (current-buffer))
           (name (format "*%s %s *" fmtexect target))
           (err (make-temp-file fmtexect nil ($/hash-take-last-n-chars 'sha512 6 (buffer-file-name)))))
      (if (and (file-readable-p target)
               (file-regular-p target))
          (progn
            (unless (stringp err)
              (user-error "err nonstring"))
            (let* (
                   (eco (format "%d" (call-process fmtexect nil '(buffer err) t target)))
                   (ets (format "%d" (file-attribute-size (file-attributes err)))))
              (if (or (not(equal "0" eco))
                      (not(equal "0" ets)))
                  (progn
                    (message "%s" err)))))))))
                    ;; (set-buffer (get-buffer-create name t))
                    ;; (insert-file-contents err nil nil nil t)
                    ;; (read-only-mode nil)
                    ;; (pop-to-buffer (get-buffer-create name t) 'display-buffer-same-window nil)
                    ;; (display-buffer (current-buffer))))))))))

(defun $/pl/fmt/prettierjs ()
  "."
  (interactive)
  ($/pl/fmt (expand-file-name "~/.emacs.d/libexec/prettier")))



(defun buffer-elisp-heuristic()
  "."
  (or (string="emacs-lisp-mode" ($/mode-name))
      (string="elisp-mode" ($/mode-name))
      (string="el" (file-name-extension (buffer-file-name)))
      ))

(defun region-points()
  "."
  (if mark-active (save-mark-and-excursion (list (marker-position (mark-marker))
                                                 (point)))
    (list (point-min)
          (point-max))))

(defun $/levate ()
  "."
  (interactive)
  (if (buffer-elisp-heuristic)
      (let* ((beg-end (region-points))
             (beg (car beg-end))
             (end (car (cdr beg-end))))
        (eval-region beg end)
        (message "\"%s\" eval'd" (buffer-name)))
    (message "\"%s\" aint no el" (buffer-name))))

(defun $/undefine-key (key)
  "KEY."
  (when (not (or (stringp key)
                 (vectorp key)
                 (integerp key)
;;                 (arrayp key)
                 (consp key)
                 (listp key)))
    (user-error "key %S has invalid type: %s" key (type-of key)))
  (when (integerp key)
    (global-unset-key key))
  (when (stringp key)
    (global-unset-key (kbd key)))

  (when (or (consp key)
            (vectorp key)
;            (arrayp key)
            (listp key))
    (cdr (mapc '$/undefine-key key))))

(defun $/set-key (key def)
  "KEY DEF."
  (when (not  (or (stringp key)
                  (vectorp key)
                  (integerp key)
;                  (arrayp key)
                  (consp key)
                  (listp key)))
    (user-error "key %S has invalid type: %s" key (type-of key)))

  (when (integerp key)
    (progn
      ($/undefine-key key)
      (global-set-key key)))

  (when (stringp key)
    (progn
      ($/undefine-key key)
      (global-set-key (kbd key) def)
      ))
  (when (or (consp key)
;            (arrayp key)
            (vectorp key)
            (listp key))
    (cdr (mapc #'(lambda (key) ($/set-key key def)) key))))


(defun $/set-extra-key (key def)
  "KEY DEF."
  (when (not (or (stringp key)
                 (vectorp key)
                 (integerp key)
;                 (arrayp key)
                 (consp key)
                 (listp key)))
    (user-error "key %S has invalid type: %s" key (type-of key)))
  (when (integerp key)
    (global-set-key key def))

  (when (stringp key)
    (global-set-key (kbd key) def)
    )
  (when (or (consp key)
            (vectorp key)
;            (arrayp key)
            (listp key))
    (cdr (mapc #'(lambda (key) ($/set-extra-key key def)) key))))



(defun fold-file-name(file-name)
  "."
  (interactive "f")
  ((replace-regexp-in-string (string-join "^" (getenv "HOME")) "~" (expand-file-name file-name))))

(defun getcwd()
  "."
  (interactive)
  (cond ((file-exists-p (buffer-file-name))
         (file-name-directory (buffer-file-name))
         (expand-file-name "~/.emacs.d"))))

(defun show-face-at-point()
  "."
  (interactive)
  (message "%S" (face-at-point)))

(defun spolsky()
  (interactive)
  (add-to-list 'custom-safe-themes
               "fa410876eb2437307481f0986512b5487ca8d3fda3130872e758c5cdde6d2218")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  (load-theme 'spolsky))

(defun fpuervo(erjbys)
  "https://gchq.github.io/CyberChef/#recipe=ROT13(true,true,false,13)&input=ZnB1ZXJ2b3JlcnY
."
  (interactive)
  (load-file-from-home (format "Ly5lbWFjcy5kL3Qv%sLmVs" erjbys)))

(defun meta-comma(k)
  "."
  (interactive)
  (mapcar #'(lambda (n)
              (string-join (list n k) ""))
          (list "M-, M-" "M-, ")))

(defun show-face-at-point()
  "."
  (interactive)
  (message "%S" (face-at-point)))

(defun $/bfan ()
  "."
  (or (when (equal (buffer-file-name-relative) (buffer-name))
        ($/paint-buffer-name))
      (format "%s %s"
              ($/paint-buffer-name)
              ($/colorize-face-fg (format "[%s]" (buffer-file-name-relative)) "#FF4018" ))))

(defun $/paint-buffer-name ()
  "."
  ($/colorize-face-fg (buffer-name) "#C6DBDC"))

(defun $/hash-take-last-n-chars (algo count contents)
  "."
  (let* ((data (secure-hash algo contents))
         (end  (length data))
         (beg  (- end count)))
    (substring data beg end)))

(defun $/text-properties()
  "."
  (interactive)
  (message "%S" (text-properties-at (car (region-points)))))

(defun $/colorize-face-fg (text faber)
  "."
  (propertize text 'face (list :foreground faber)))

(defun buffer-file-name-relative ()
  "."
  (format "%s" (file-relative-name (buffer-file-name))))


(defun $/bchs ()
  "."
  (let ((data
         (buffer-substring-no-properties
          (point-min)
          (point-max))))
    (format "%s %s %s" ($/string-hash-take-last-n-chars 'sha256 8 data)
            ($/string-hash-take-last-n-chars 'sha1 8 data)
            ($/string-hash-take-last-n-chars 'md5 8 data))))

(defun $/mark-indicator()
  "."
  (list
   '(:eval
     (list (if mark-active
               (propertize
                (format " ⇒ %S %S [%S] ⇐ "
                        (marker-position (mark-marker)) (point)
                        (count-lines (marker-position (mark-marker)) (point))
                        )
                'face (list :background "#FF4018" :foreground (contrast-color "#FF4018")))
             "")))
   " "))

(defun $/acl-owner(f)
  "F."
  (interactive)
  (if (stringp f)
      ($/mt (format "(%s)" f)) ""))

(defun $/acl-group(f)
  "F."
  (interactive)
  (if (stringp f)
      ($/mt (format "(%s)" f)) ""))

(defun $/acl-other(f)
  "F."
  (interactive)
  (if (stringp f)
      ($/mt (format "(%s)" f)) ""))

(defun $/paint-mode-line-colorize (c contents)
  (let* ((foreground (format "#%s" ($/hash-take-last-n-chars 'sha512 6 c)))
         (background (compute-bright-dark-from-color-value foreground ($/mode-line-foreground) ($/mode-line-background))))
    ;;(debug "($/paint-mode-line-colorize %S %S) => %s %s" c contents foreground background)
    (propertize
     (format "%s" contents)
     'face (list :foreground foreground :background background))))


(defun $/paint-mode-line-color (contents)
  ($/paint-mode-line-colorize contents contents))

(defun $/paint-non-file-buffer()
  "."
  (list ($/paint-mode-name) " " ($/paint-buffer-name) " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t"
        '(:eval ($/mark-indicator))))



(defun $/paint-mode-name-string() (format "%s-mode" (replace-regexp-in-string "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$" "\\1" (downcase (cond ((listp mode-name) (car mode-name)) ((stringp mode-name) mode-name) ((t (format "%S" mode-name)))) ))))

(defun $/paint-mode-name()
  ($/paint-mode-line-color ($/paint-mode-name-string)))



;; 987-2711

(defun $/paint-file-buffer()
  "."
  (list
   '(:eval ($/mark-indicator))
   " "
   '(:eval ($/bfan))
   " " (propertize " ⇒ " 'face (list :background ($/mode-line-background)
                                     :foreground "#F10958"))
   " "
   '(:eval ($/paint-mode-name))
   " "
   '(:eval ($/fm))
   " "
   '(:eval ($/bchs))
   " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t"))

(defun $/paint-mode-line ()
  "."
  (interactive)
  (let* ((narrow (if (buffer-file-name)
                     ($/paint-file-buffer)
                   ($/paint-non-file-buffer)))
         (wide (list mode-line-front-space narrow mode-line-end-spaces)))
    (setq mode-line-format wide)
    (force-mode-line-update) wide))

(defun $/mode-name()
  (format "%s-mode"
          (replace-regexp-in-string
           "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$" "\\1"
           (downcase (cond ((listp mode-name) (car mode-name))
                           ((stringp mode-name) mode-name)
                           ((t (format "%S" mode-name))))))))

(defun g/build ()
  (interactive "*")
  (cond ((string= "rust-mode" ($/mode-name))
         ($/pl/fmt (file-name-concat (getenv "HOME") ".cargo/bin/cargo check")))
        ((string= "typescript-mode" ($/mode-name))
         ($/pl/fmt/prettierjs))
        ((string= "javacript-mode" ($/mode-name))
         ($/pl/fmt/prettierjs))
        ((nil t))))

(defun $/base64-encode-region (beg end) (interactive "*r") (save-excursion (replace-region-contents beg end (lambda () (collapse-string-2 (base64-encode-string (buffer-substring-no-properties beg end)))))))
(defun collapse-string-2 (s) "S." (replace-regexp-in-string "\\s-+" "" (collapse-string s)))
(defun collapse-lines-region-2 (beg end) "." (interactive "*r") (save-excursion (let ((region (buffer-substring-no-properties beg end))) (replace-region-contents beg end #'(lambda () (collapse-string-2 region))))))

(defun $/mt(p)
  "P."
  (interactive)
  p)
  ;; (let* ((p (replace-regexp-in-string "[o-t]" "🧾" p))
  ;;        (p (replace-regexp-in-string "[s-w]" "🖍️" p))
  ;;        (p (replace-regexp-in-string "[xX]" "👥️" p)))
  ;;   p))


(defun $/fm ()
  "."
  (interactive)
  (let ((ffb (format "%s" (file-attribute-modes (file-attributes (buffer-file-name))))))
    (let* ((acls (split-string ffb "-+" t "[^a-z]"))
           (aclsl (proper-list-p acls)))
      (cond ((= 1 aclsl)
             (format "%s"     ($/acl-owner (car acls))))
            ((= 2 aclsl)
             (format "%s%s"   ($/acl-owner(car acls)
                                     ($/acl-group (elt 1 acls)))))
            ((= 3 aclsl)
             (format "%s%s%s" ($/acl-owner(car acls)
                                     ($/acl-group (elt 1 acls))
                                     ($/acl-other(elt 1 acls)))))))))


(defun $/flush-kill-ring () "." (interactive) (setq kill-ring nil file-name-history nil))
(defun $/kill-all-buffers-and-flush-kill-ring () "." (interactive) (ignore-errors (kill-bufs) ($/flush-kill-ring)))

(defun $/string-hash-take-last-n-chars (algo hwm contents)
  "."
  ;; (format "%s:%s"  (symbol-name algo) ($/hash-take-last-n-chars algo hwm contents)))
  (format "%s"  ($/hash-take-last-n-chars algo hwm contents)))


(defun server-reboot () "." (interactive) (server-force-delete) (server-mode 9))


(defun $/hash (algo) "." (interactive "S")
       (unless (memq algo (secure-hash-algorithms))
         (user-error (format "\"%s\" aint no valid secure-hash algo" algo)))
       (let* ((pipa (region-points))
              (pi (car pipa))
              (pa (car (cdr pipa)))
              (bs (buffer-substring-no-properties pi pa))
              (hg (secure-hash algo bs)))
         (message "%S" hg)
         hg))

(defun $/sec-hash-region (algo) "." (interactive "S")
       (let* ((pipa (region-points))
              (pi (car pipa))
              (pa (car (cdr pipa)))
              (bs (buffer-substring-no-properties pi pa))
              (hg (secure-hash algo bs)))
         (replace-region-contents pi pa
                                  (lambda () hg))))


(defun $/delete-overlays-within (beg end)
  "."
  (let ((mp beg))
    (while (<= mp end)
      (setq mp (+ mp (/ #xe #xe)))
      (mapcar 'delete-overlay (overlays-in beg mp)))))


(defun setup-utf8 ()
  (interactive)
  (mapc #'(lambda (pnoitcnuf)
            (if (functionp pnoitcnuf)
                (funcall pnoitcnuf 'utf-8-unix)
              (setq pnoitcnuf 'utf-8-unix) ))
        (list 'prefer-coding-system
              'set-default-coding-systems
              'set-keyboard-coding-system
              'set-clipboard-coding-system
              'set-next-selection-coding-system
              'set-selection-coding-system
              'set-terminal-coding-system
              'locale-coding-system )))


(defun $/chacha20-hardcoded (text шоли$) "."
       (let* ((pipa (region-points))
              (pi (car pipa))
              (pa (car (cdr pipa)))
              (tmp (get-buffer-create "tmp"))
              (shell-result (save-mark-and-excursion
                        (shell-command (format (base64-decode-string шоли$) text) tmp nil)
                        (set-buffer tmp)
                        (delete-blank-lines)
                        (flush-lines "^\s-*$")
                        (buffer-substring-no-properties (point-min) (point-max))))
              )
         (kill-buffer tmp)
         shell-result))


(defun $/encrypt-chacha20-hardcoded () "."
       (interactive)
       (save-mark-and-excursion
         (let* ((pipa (region-points)) (pi (car pipa)) (pa (car (cdr pipa))))
           (replace-region-contents
            pi pa
            (lambda () ($/chacha20-hardcoded (buffer-substring-no-properties pi pa)
                                       "MHgwYzlmNjAwMCAtLSAnJXMn"))))))


(defun $/decrypt-chacha20-hardcoded () "."
       (interactive)
       (save-mark-and-excursion
         (let* ((pipa (region-points)) (pi (car pipa)) (pa (car (cdr pipa))))
           (replace-region-contents
            pi pa
            (lambda () ($/chacha20-hardcoded (buffer-substring-no-properties pi pa)
                                       "MHgwYzlmNjAwMCAtZCAtLSAnJXMn"))))))

;;($/undefine-key (list "C-c C-e C-2" "C-c C-d C-2"))
(progn
  ($/set-key (list "C-c C-e C-2 C-0") '$/encrypt-chacha20-hardcoded)
  ($/set-key (list "C-c C-e C-d C-2 C-0") '$/decrypt-chacha20-hardcoded))


(defun string-list-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion (let ((region
                         (buffer-substring-no-properties
                          beg
                          end)))
                    (replace-region-contents
                     beg end
                     #'(lambda ()
                         (replace-regexp-in-string "$" ","
                                                   (replace-regexp-in-string
                                                    "\\(^\\|$\\)" "\""
                                                    (replace-regexp-in-string
                                                     "\\(^[\"']+\\|[\"']+$\\)" ""
                                                     (replace-regexp-in-string
                                                      "\\(^,+\\|,+$\\)" ""
                                                      (replace-regexp-in-string
                                                       "\\s-+" "
"
                                                       (replace-regexp-in-string
                                                        "^\\s-+" ""
                                                        (replace-regexp-in-string
                                                        "\\s-+$" ""
                                                        region)))
                                                      ))))
                         ))
                    (flush-lines "^$" beg end)
                    )))
