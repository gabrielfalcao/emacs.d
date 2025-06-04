(defun string-shift-right (g) "." (format "\t%s" g))
(defun delete-package (pkg-desc &optional force nosave)
  "."
  (interactive
   (progn
     (let* ((package-table
             (mapcar
              (lambda (p) (cons (package-desc-full-name p) p))
              (delq nil
                    (mapcar
                     (lambda (p) (unless (package-built-in-p p) p))
                     (apply #'append (mapcar #'cdr (package--alist)))))))
            (package-name
             (completing-read "Delete package: "
                              (mapcar #'car package-table)
                              nil t)))
       (list
        (cdr (assoc package-name package-table))
        current-prefix-arg nil))))
  (package-delete pkg-desc force nosave))
(defun kill-bufs ()
  "."
  (interactive)
  (mapcar
   #'(lambda (b)
       (ignore-errors
         (set-buffer-modified-p nil)
         (revert-buffer 1 1))
       (kill-buffer b))
   (buffer-list)))

(defun minor-mode-slist()
  "."
  (mapcar
   (lambda (l) (format "%s" (car l)))
   minor-mode-alist))

(defun string-list-html-like-display (nn sl)
  "."
  (format "<%s>\n%s\n</%s>" nn
          (string-join (mapcar 'string-shift-right sl) "\n")
          nn))

(defun uniquify-all-lines-buffer ()
  "."
  (interactive "*")
  (uniquify-all-lines-region (point-min) (point-max)))
(defun uniquify-all-lines-region (start end)
  "."
  (interactive "*r")
  (save-excursion
    (let ((end (copy-marker end)))
      (while (progn
               (goto-char start)
               (re-search-forward
                "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
        (replace-match "\\1\n\\2")))))

(defun disable-bars()
  "."
  (interactive)
  (progn (scroll-bar-mode 0) (menu-bar-mode 0) (tool-bar-mode 0)))

(defun disable-auto-save-list()
  "."
  (interactive)
  (mapc
   #'(lambda (d) (delete-directory (expand-file-name d) t nil))
   (list "~/.emacs.d/auto-save-list" "~/.emacs.backups")))

(defun reverse-string (beg end)
  "."
  (interactive "*r")
  (replace-region-contents beg end
                           (lambda ()
                             (reverse
                              (buffer-substring-no-properties beg end)))))

(defun $$$$$ ()
  "."
  (interactive)
  (global-company-mode)
  (disable-auto-save-list)
  (disable-bars)
  (set-frame-parameter nil 'fullscreen 'maximized)
  ($$$$$$$$))

(defun $/ep() "." (interactive) (find-file "~/.emacs.d/t/k.el"))

(defun c$dg$ (&rest substrate)
  (interactive)
  (ignore-errors
    (colorize-hexadecimal-text)
    ($/paint-mode-line)
    (disable-auto-save-list)
    (disable-bars)
    ($$$$$)))

(defun contrast-color (c)
  "C."
  (interactive "s")
  (compute-bright-dark-from-color-value c "#FFF" "#333"))
(defun compute-bright-dark-from-color-value (c bright dark)
  "C."
  (interactive "s")
  (let* ((values (x-color-values c))
         (fp (car values))
         (sp (elt values 1))
         (tp (elt values 2)))
    (if (> #x0f
           (floor
            (+
             (+
              (* float-pi fp)
              (* sp
                 (* float-pi
                    (-
                     (+ float-pi float-pi)
                     (+
                      (/ float-pi float-e)
                      (* float-pi (/ float-pi 1.998879)))))))
             (*
              (/
               (+ tp (/ (/ float-pi float-e) #x64))
               (* float-pi float-pi))))
            #x100))
        bright dark)))

(defun collapse-string (s)
  "S."
  (replace-regexp-in-string "\\s-+" " "
                            (string-trim
                             (replace-regexp-in-string
                              "\\(\\s-+\\|\xa\\)+" " " s))))

(defun collapse-lines-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents beg end
                               #'(lambda ()
                                   (collapse-string region))))))

(defun colorize-hexadecimal-text()
  (interactive)
  (save-excursion
    (let (begb hwmb cbeg cend faber)
      (setq begb (point-min))
      (setq hwmb (point-max))
      (goto-char begb)
      (while (and
              (re-search-forward "\\([#][a-f0-9]\\{3\,6\\}\\b\\)" hwmb t)
              (<= (point) hwmb))
        (let* ((cbeg (match-beginning 1))
               (cend (match-end 1))
               (faber (buffer-substring-no-properties cbeg cend))
               (x2133
                (progn
                  ($/delete-overlays-within cbeg cend)
                  (make-overlay cbeg cend))))
          (overlay-put x2133 'bcc t)
          (overlay-put x2133 'face
                       (list :foreground
                             (contrast-color faber)
                             :background faber)))))))

(defun $/pl/fmt (fmtexect)
  "FMTEXECT MAJOR-MODE."
  (unless (not (buffer-modified-p (current-buffer)))
    (user-error "%s ought to be saved" (buffer-name)))
  (unless (stringp fmtexect) (user-error "fmtexect nonstring"))
  (save-mark-and-excursion
    (let* ((target (expand-file-name (buffer-file-name)))
           (buffer (current-buffer))
           (name (format "*%s %s *" fmtexect target))
           (err
            (make-temp-file fmtexect nil
                            ($/hash-take-last-n-chars 'sha512 6
                                                      (buffer-file-name)))))
      (if (and (file-readable-p target) (file-regular-p target))
          (progn
            (unless (stringp err) (user-error "err nonstring"))
            (let* ((eco
                    (format "%d"
                            (call-process fmtexect nil
                                          '(buffer err)
                                          t target)))
                   (ets
                    (format "%d"
                            (file-attribute-size (file-attributes err)))))
              (if (or
                   (not(equal "0" eco))
                   (not(equal "0" ets)))
                  (progn (message "%s" err)))))))))
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
  (or
   (string="emacs-lisp-mode" ($/mode-name))
   (string="elisp-mode" ($/mode-name))
   (string="el" (file-name-extension (buffer-file-name)))))

(defun region-points()
  "."
  (if mark-active
      (save-mark-and-excursion
        (list (marker-position (mark-marker)) (point)))
    (list (point-min) (point-max))))

(defun $/levate ()
  "."
  (interactive)
  (if (buffer-elisp-heuristic)
      (let* ((beg-end (region-points))
             (beg (car beg-end))
             (end (car (cdr beg-end)))
             (region (buffer-substring-no-properties beg end)))
        (if (string-match-p "\\s-*[(]\\(.\\|\n\\)+[)]\\s-*" region)
            (progn
              (eval-region beg end)
              (message "\"%s\" eval'd" (buffer-name)))
          (message "does not seem to be valid elisp: %s" region)))
    (message "\"%s\" aint no el" (buffer-name))))

(defun $/undefine-key (key)
  "KEY."
  (when (not
         (or
          (stringp key)
          (vectorp key)
          (integerp key)
          ;;                 (arrayp key)
          (consp key)
          (listp key)))
    (user-error "key %S has invalid type: %s" key (type-of key)))
  (when (integerp key) (global-unset-key key))
  (when (stringp key) (global-unset-key (kbd key)))

  (when (or (consp key) (vectorp key)
            ;;            (arrayp key)
            (listp key))
    (cdr (mapc '$/undefine-key key))))

(defun $/set-key (key def)
  "KEY DEF."
  (when (not
         (or
          (stringp key)
          (vectorp key)
          (integerp key)
          ;;                  (arrayp key)
          (consp key)
          (listp key)))
    (user-error "key %S has invalid type: %s" key (type-of key)))

  (when (integerp key)
    (progn ($/undefine-key key) (global-set-key key)))

  (when (stringp key)
    (progn ($/undefine-key key) (global-set-key (kbd key) def)))
  (when (or (consp key)
            ;;            (arrayp key)
            (vectorp key)
            (listp key))
    (cdr
     (mapc #'(lambda (key) ($/set-key key def)) key))))


(defun $/set-extra-key (key def)
  "KEY DEF."
  (when (not
         (or
          (stringp key)
          (vectorp key)
          (integerp key)
          ;;                 (arrayp key)
          (consp key)
          (listp key)))
    (user-error "key %S has invalid type: %s" key (type-of key)))
  (when (integerp key) (global-set-key key def))

  (when (stringp key) (global-set-key (kbd key) def))
  (when (or (consp key) (vectorp key)
            ;;            (arrayp key)
            (listp key))
    (cdr
     (mapc #'(lambda (key) ($/set-extra-key key def)) key))))



(defun fold-file-name(file-name)
  "."
  (interactive "f")
  ((replace-regexp-in-string
    (string-join "^" (getenv "HOME"))
    "~"
    (expand-file-name file-name))))

(defun getcwd()
  "."
  (interactive)
  (cond
   ((file-exists-p (buffer-file-name))
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
  (mapcar
   #'(lambda (n) (string-join (list n k) ""))
   (list "M-, M-" "M-, ")))

(defun show-face-at-point()
  "."
  (interactive)
  (message "%S" (face-at-point)))

(defun $/bfan ()
  "."
  (or
   (when (equal (buffer-file-name-relative) (buffer-name))
     ($/paint-buffer-name))
   (format "%s %s"
           ($/paint-buffer-name)
           ($/colorize-face-fg
            (format "[%s]" (buffer-file-name-relative))
            "#FF4018" ))))

(defun $/paint-buffer-name ()
  "."
  ($/colorize-face-fg (buffer-name) "#C6DBDC"))

(defun $/hash-take-last-n-chars (algo count contents)
  "."
  (let* ((data (secure-hash algo contents))
         (end (length data))
         (beg (- end count)))
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
         (buffer-substring-no-properties (point-min) (point-max))))
    (format "%s %s %s"
            ($/string-hash-take-last-n-chars 'sha256 8 data)
            ($/string-hash-take-last-n-chars 'sha1 8 data)
            ($/string-hash-take-last-n-chars 'md5 8 data))))

(defun $/mark-indicator()
  "."
  (list
   '(:eval
     (list
      (if mark-active
          (propertize
           (format " ⇒ %S %S [%S] ⇐ "
                   (marker-position (mark-marker))
                   (point)
                   (count-lines
                    (marker-position (mark-marker))
                    (point)))
           'face
           (list :background "#FF4018" :foreground
                 (contrast-color "#FF4018")))
        "")))
   " "))

(defun $/acl-owner(f)
  "F."
  (interactive)
  (if (stringp f)
      ($/mt (format "(%s)" f))
    ""))

(defun $/acl-group(f)
  "F."
  (interactive)
  (if (stringp f)
      ($/mt (format "(%s)" f))
    ""))

(defun $/acl-other(f)
  "F."
  (interactive)
  (if (stringp f)
      ($/mt (format "(%s)" f))
    ""))

(defun $/paint-mode-line-colorize (c contents)
  (let* ((foreground
          (format "#%s" ($/hash-take-last-n-chars 'sha512 6 c)))
         (background
          (compute-bright-dark-from-color-value foreground
                                                ($/mode-line-foreground)
                                                ($/mode-line-background))))
    ;;(debug "($/paint-mode-line-colorize %S %S) => %s %s" c contents foreground background)
    (propertize
     (format "%s" contents)
     'face
     (list :foreground foreground :background background))))


(defun $/paint-mode-line-color (contents)
  ($/paint-mode-line-colorize contents contents))

(defun $/paint-non-file-buffer()
  "."
  (list
   ($/paint-mode-name)
   " "
   ($/paint-buffer-name)
   " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t"
   '(:eval ($/mark-indicator))))



(defun $/paint-mode-name-string()
  (format "%s-mode"
          (replace-regexp-in-string
           "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$" "\\1"
           (downcase
            (cond
             ((listp mode-name)
              (car mode-name))
             ((stringp mode-name)
              mode-name)
             ((t (format "%S" mode-name))))))))

(defun $/paint-mode-name()
  ($/paint-mode-line-color ($/paint-mode-name-string)))



;; 987-2711

(defun $/paint-file-buffer()
  "."
  (list
   '(:eval ($/mark-indicator))
   " "
   '(:eval ($/bfan))
   " "
   (propertize " ⇒ " 'face
               (list :background
                     ($/mode-line-background)
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
  (let* ((narrow
          (if (buffer-file-name)
              ($/paint-file-buffer)
            ($/paint-non-file-buffer)))
         (wide
          (list mode-line-front-space narrow mode-line-end-spaces)))
    (setq mode-line-format wide)
    (force-mode-line-update)
    wide))

(defun $/mode-name()
  (format "%s-mode"
          (replace-regexp-in-string
           "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$" "\\1"
           (downcase
            (cond
             ((listp mode-name)
              (car mode-name))
             ((stringp mode-name)
              mode-name)
             ((t (format "%S" mode-name))))))))

(defun g/build ()
  (interactive "*")
  (cond
   ((string= "rust-mode" ($/mode-name))
    ($/pl/fmt
     (file-name-concat (getenv "HOME") ".cargo/bin/cargo check")))
   ((string= "typescript-mode" ($/mode-name))
    ($/pl/fmt/prettierjs))
   ((string= "javacript-mode" ($/mode-name))
    ($/pl/fmt/prettierjs))
   ((nil t))))

(defun $/base64-encode-region (beg end)
  (interactive "*r")
  (save-excursion
    (replace-region-contents beg end
                             (lambda ()
                               (collapse-string-2
                                (base64-encode-string
                                 (buffer-substring-no-properties beg end)))))))
(defun collapse-string-2 (s)
  "S."
  (replace-regexp-in-string "\\s-+" "" (collapse-string s)))
(defun collapse-lines-region-2 (beg end)
  "."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents beg end
                               #'(lambda ()
                                   (collapse-string-2 region))))))

(defun $/mt(p) "P." (interactive) p)
  ;; (let* ((p (replace-regexp-in-string "[o-t]" "🧾" p))
  ;;        (p (replace-regexp-in-string "[s-w]" "🖍️" p))
  ;;        (p (replace-regexp-in-string "[xX]" "👥️" p)))
  ;;   p))


(defun $/fm ()
  "."
  (interactive)
  (let ((ffb
         (format "%s"
                 (file-attribute-modes
                  (file-attributes (buffer-file-name))))))
    (let* ((acls (split-string ffb "-+" t "[^a-z]"))
           (aclsl (proper-list-p acls)))
      (cond
       ((= 1 aclsl)
        (format "%s" ($/acl-owner (car acls))))
       ((= 2 aclsl)
        (format "%s%s"
                ($/acl-owner(car acls) ($/acl-group (elt 1 acls)))))
       ((= 3 aclsl)
        (format "%s%s%s"
                ($/acl-owner(car acls)
                            ($/acl-group (elt 1 acls))
                            ($/acl-other(elt 1 acls)))))))))


(defun $/flush-kill-ring ()
  "."
  (interactive)
  (setq kill-ring nil file-name-history nil))
(defun $/kill-all-buffers-and-flush-kill-ring ()
  "."
  (interactive)
  (ignore-errors (kill-bufs) ($/flush-kill-ring) (erase-messages)))

(defun $/string-hash-take-last-n-chars (algo hwm contents)
  "."
  ;; (format "%s:%s"  (symbol-name algo) ($/hash-take-last-n-chars algo hwm contents)))
  (format "%s" ($/hash-take-last-n-chars algo hwm contents)))


(defun server-reboot ()
  "."
  (interactive)
  (server-force-delete)
  (server-mode 9))


(defun $/hash (algo)
  "."
  (interactive "S")
  (unless (memq algo (secure-hash-algorithms))
    (user-error
     (format "\"%s\" aint no valid secure-hash algo" algo)))
  (let* ((pipa (region-points))
         (pi (car pipa))
         (pa (car (cdr pipa)))
         (bs (buffer-substring-no-properties pi pa))
         (hg (secure-hash algo bs)))
    (message "%S" hg)
    hg))

(defun $/sec-hash-region (algo)
  "."
  (interactive "S")
  (let* ((pipa (region-points))
         (pi (car pipa))
         (pa (car (cdr pipa)))
         (bs (buffer-substring-no-properties pi pa))
         (hg (secure-hash algo bs)))
    (replace-region-contents pi pa (lambda () hg))))


(defun $/delete-overlays-within (beg end)
  "."
  (let ((mp beg))
    (while (<= mp end)
      (setq mp (+ mp (/ #xe #xe)))
      (mapcar 'delete-overlay (overlays-in beg mp)))))


(defun setup-utf8 ()
  (interactive)
  (mapc
   #'(lambda (pnoitcnuf)
       (if (functionp pnoitcnuf)
           (funcall pnoitcnuf 'utf-8-unix)
         (setq pnoitcnuf 'utf-8-unix)))
   (list 'prefer-coding-system
         'set-default-coding-systems
         'set-keyboard-coding-system
         'set-clipboard-coding-system
         'set-next-selection-coding-system
         'set-selection-coding-system
         'set-terminal-coding-system
         'locale-coding-system )))


(defun $/chacha20-hardcoded (text шоли$)
  "."
  (let* ((pipa (region-points))
         (pi (car pipa))
         (pa (car (cdr pipa)))
         (tmp (get-buffer-create "tmp"))
         (shell-result
          (save-mark-and-excursion
            (shell-command
             (format (base64-decode-string шоли$) text)
             tmp nil)
            (set-buffer tmp)
            (delete-blank-lines)
            (flush-lines "^\s-*$")
            (buffer-substring-no-properties (point-min) (point-max)))))
    (kill-buffer tmp)
    shell-result))


(defun $/encrypt-chacha20-hardcoded ()
  "."
  (interactive)
  (save-mark-and-excursion
    (let* ((pipa (region-points))
           (pi (car pipa))
           (pa (car (cdr pipa))))
      (replace-region-contents
       pi pa
       (lambda ()
         ($/chacha20-hardcoded
          (buffer-substring-no-properties pi pa)
          "MHgwYzlmNjAwMCAtLSAnJXMn"))))))


(defun $/decrypt-chacha20-hardcoded ()
  "."
  (interactive)
  (save-mark-and-excursion
    (let* ((pipa (region-points))
           (pi (car pipa))
           (pa (car (cdr pipa))))
      (replace-region-contents
       pi pa
       (lambda ()
         ($/chacha20-hardcoded
          (buffer-substring-no-properties pi pa)
          "MHgwYzlmNjAwMCAtZCAtLSAnJXMn"))))))

;;($/undefine-key (list "C-c C-e C-2" "C-c C-d C-2"))
(progn
  ($/set-key (list "C-c C-e C-2 C-0") '$/encrypt-chacha20-hardcoded)
  ($/set-key
   (list "C-c C-e C-d C-2 C-0")
   '$/decrypt-chacha20-hardcoded))


(defun string-list-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
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
                                         "\\s-+" "\n"
                                         (replace-regexp-in-string
                                          "^\\s-+" ""
                                          (replace-regexp-in-string
                                           "\\s-+$" ""
                                           region)))))))))
      (flush-lines "^$" beg end))))


(defun refactor-test-node-info-buffer ()
  "."
  (interactive "*")
  (refactor-test-node-info-region (point-min) (point-max))
  (rust-format-buffer)
  (remove-trailing-commas-buffer)
  (fix-vec-buffer)
  (rust-format-buffer))


(defun refactor-test-node-info-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda () (refactor-node-info-string region)))
      (flush-lines "^$" beg end)
      (indent-region beg end))))

(defun refactor-node-info-string (string)
  "STRING."
  (regex-fix-vec
   (regex-fix-value-names
    (regex-fix-operation-names
     (regex-fix-begin-names
      (regex-fix-node-names (regex-fix-node-info string)))))))


(defun regex-fix-node-names (string)
  "STRING."
  (let ((fixed
         (replace-regexp-in-string
          "\\(^\\s-*\\|\\s-*(\\s-*\\)\\(Expression\\|Ident\\|Operation\\|FunctionDeclaration\\|Args\\|Block\\|Value\\|Begin\\|End\\)"
          "\\1Node"
          string)))
    (if (not (string= fixed string))
        (regex-fix-node-names fixed)
      fixed)))


(defun regex-fix-operation-names (string)
  "STRING."
  (let ((fixed
         (replace-regexp-in-string
          "Node::Operation(\\(Node::\\)?\\(Not\\|Add\\|Sub\\|Mul\\|Div\\|Assign\\|Pow\\|Negate\\)"
          "Node::Operation(Operation::\\2"
          (replace-regexp-in-string
           "\\(^\\s-*\\|\\s-*(\\s-*\\)\\(Not\\|Add\\|Sub\\|Mul\\|Div\\|Assign\\|Pow\\|Negate\\)"
           "\\1Operation::\\2"
           string))))
    (if (not (string= fixed string))
        (regex-fix-operation-names fixed)
      fixed)))



(defun regex-fix-value-names (string)
  "STRING."
  (let ((fixed
         (replace-regexp-in-string
          "Node::Value(\\(Node::\\)?\\(Boolean\\|Integer\\|String\\|Null\\)"
          "Node::Value(Value::\\2"
          (replace-regexp-in-string
           "\\(^\\s-*\\|\\s-*(\\s-*\\)\\(Boolean\\|Integer\\|String\\|Null\\)"
           "\\1Value::\\2"
           string))))
    (if (not (string= fixed string))
        (regex-fix-value-names fixed)
      fixed)))


(defun regex-fix-begin-names (string)
  "STRING."
  (let ((fixed
         (replace-regexp-in-string
          "Node::Begin(\\(Node::\\)?\\(Block\\|Function\\)"
          "Node::Begin(Begin::\\2"
          (replace-regexp-in-string
           "\\(^\\s-*\\|\\s-*(\\s-*\\)\\(Block\\|Function\\)"
           "\\1Begin::\\2"
           string))))
    (if (not (string= fixed string))
        (regex-fix-begin-names fixed)
      fixed)))

(defun regex-fix-node-info (string)
  "STRING."
  (let ((fixed
         (replace-regexp-in-string
          "^\\s-+NodeInfo\\s-+[{]\\(.\\|\n\\)*?string:\\s-+\"\\([^\"]+\\)\",\n\\(.\\|\n\\)*?start_pos: -*\\(.\\|\n\\)*?line:\\s-+\\([0-9]+\\)\\(.\\|\n\\)*?column:\\s-+\\([0-9]+\\)\\(.\\|\n\\)+*?end_pos: -*\\(.\\|\n\\)*?line:\\s-+\\([0-9]+\\)\\(.\\|\n\\)*?column:\\s-+\\([0-9]+\\)\\(.\\|\n\\)+?\\(.\\|\n\\)+?[}]\\(.\\|\n\\)+?[}]\\(.\\|\n\\)+?[}],?\\([^)]+\\|\n\\| -+\\)"
          "stub_node_info(&input, \"\\2\", (\\5, \\7), (\\10, \\12))"
          string)))
    (if (not (string= fixed string))
        (regex-fix-node-info fixed)
      fixed)))



(defun regex-fix-vec (string)
  "STRING."
  ;; (replace-regexp-in-string
  ;;  "\\s-*\\((\\|[^#]\\)\\s-*[[]" "\\1vec!["
  (replace-regexp-in-string
   "\\(^\\s-+\\|\\s-+\\|[^!#]\\|(\\)[[]\\(^\\s-+\\|\\s-+\\|[^!#]\\|(\\)"
   "\\1vec![\\2"
   string))

(defun fix-vec-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda () (regex-fix-vec region))))))

(defun fix-vec-buffer ()
  "."
  (interactive "*")
  (fix-vec-region (point-min) (point-max)))


(defun regex-single-space-all-whitespace-and-newlines (string)
  "STRING."
  (replace-regexp-in-string
   "\\s-+$" ""
   (replace-regexp-in-string
    "^\\s-+" ""
    (replace-regexp-in-string "\\(\\s-\\|\n\\)+" " " string))))


(defun single-space-all-whitespace-and-newlines-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda ()
           (regex-single-space-all-whitespace-and-newlines region)))
      (flush-lines "^$" beg end))))

;; (defun regex-remove-trailing-commas (string)
;;   "STRING."
;;   (replace-regexp-in-string
;;    ")\\(\\s-\\|\n\\)*,\\(\\s-\\|\n\\)*)" "))"
;;    (replace-regexp-in-string
;;     "]\\(\\s-\\|\n\\)*,\\(\\s-\\|\n\\)*]" "]]"
;;     (replace-regexp-in-string
;;      "}\\(\\s-\\|\n\\)*,\\(\\s-\\|\n\\)*}" "}}"
;;      string))))

(defun regex-remove-trailing-commas (string)
  "STRING."
  (replace-regexp-in-string
   "\\([)]\\|[]]\\|[}]\\)\\(\\s-\\|\n\\)*,\\(\\s-\\|\n\\)*\\([)]\\|[]]\\|[}]\\)"
   "\\1\\4"
   string))

(defun regex-remove-trailing-commas-all (string)
  "STRING."
  (let ((fixed (regex-remove-trailing-commas string)))
    (if (not (string= fixed string))
        (regex-remove-trailing-commas-all fixed)
      fixed)))

(defun remove-trailing-commas-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda () (regex-remove-trailing-commas-all region))))))

(defun remove-trailing-commas-buffer ()
  "."
  (interactive "*")
  (remove-trailing-commas-region (point-min) (point-max)))


(defun regex-remove-duplicate-new-lines (string)
  "STRING."
  (replace-regexp-in-string
   "\\s-+$" ""
   (replace-regexp-in-string
    "^\\s-+" ""
    (replace-regexp-in-string "\\(\\s-*\n\\s-*\\|\n\\)+" "\n\n" string))))


(defun remove-duplicate-new-lines-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda () (regex-remove-duplicate-new-lines region))))))

(defun remove-duplicate-new-lines-buffer ()
  "."
  (interactive "*")
  (remove-duplicate-new-lines-region (point-min) (point-max)))


(disable-bars)


(defun fix-begin-names-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda () (regex-fix-begin-names region))))))

(defun fix-begin-names-buffer ()
  "."
  (interactive "*")
  (fix-begin-names-region (point-min) (point-max)))


(defun fix-node-info-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda () (regex-fix-node-info region))))))

(defun fix-node-info-buffer ()
  "."
  (interactive "*")
  (fix-node-info-all-region (point-min) (point-max)))


(defun regex-cargo-dependencies-normalize (string)
  "STRING."
  (replace-regexp-in-string
   "^\\([a-z][a-z0-9_-]+\\)\\(\\s-*\\|\n\\)*[=]\\(\\s-*\\|\n\\)*\"\\([0-9.]+\\)\""
   "\\1 = { version = \"\\4\" }" string))



(defun cargo-dependencies-normalize-region(beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda () (regex-cargo-dependencies-normalize region))))))



(defun regex-tm-theme (string)
  "STRING."
  (setq case-fold-search nil)
  (let ((result (replace-regexp-in-string

                 string)))
    (setq case-fold-search t)
    result))



(defun tm-theme-region(beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^\\(\\w+.*\\)$" nil t)
      (replace-match
       (format
        "set.themes.insert(\"%s\".to_string(), theme_from_bytes(include_bytes!(\"./%s.tmTheme\")));"
        (match-string 0)
        (match-string 0))
       t))))



;; (defun regex-cargo-dependencies-to-cargo-add (string)
;;   "STRING."
;;   ;; ;; ICA7OyA7O3F1YXNpIDs7Il5cXChbYS16XVthLXowLTlfLV0rXFwpXFwoXFxzLVxcfFxuXFwpKj9bPV1cXChcXHMtXFx8XG5cXCkqP1t7XVxcKC5cXHxcblxcKSo/XFwodmVyc2lvblxccy0qPVxccy0qXCJbMC05Ll0rP1wiXFwpLFxcKFxccy1cXHxcblxcKSo/XFwoZmVhdHVyZXNcXChcXHMtXFx8XG5cXCkqPz1cXChcXHMtXFx8XG5cXCkqP1tbXVxcKFxcKFxccy1cXHxcblxcfFthLXowLTlcIl8tXSs/XFwoXFxzLSosXFxzLSokXFwpXFwpKlxcfFxuXFwpKlxcKVxccy0qW11dXFxzLSpbfV1cXHMtKiIKICA7OyA7OzsgKHJlcGxhY2UtcmVnZXhwLWluLXN0cmluZwogIDs7IDs7OyAgIl5cXChbYS16XVthLXowLTlfLV0rXFwpXFxzLSpbPV1cXHMtKlt7XS4qJCIKICA7OyA7OzsgICJcXDEgZmVhdHVyZXMgPSAiCiAgOzsgOzs7IChyZXBsYWNlLXJlZ2V4cC1pbi1zdHJpbmcKICA7OyA7OzsgICJeXFwoW2Etel1bYS16MC05Xy1dK1xcKVxccy0qPVxcKFtePV0rXFwpPVteLF0rXFwoXFxzLVxcfFxuXFwpKj8sXFwoXFxzLVxcfFxuXFwpKj9mZWF0dXJlc1xcKFxccy1cXHxcblxcKSo9XFwoXFxzLVxcfFxuXFwpKltbXVxcKC4qXFwpW11dLiokIgogIDs7IDs7OyAgIlxcMSBmZWF0dXJlcyA9IFxcNyIKICA7OyAgKHJlcGxhY2UtcmVnZXhwLWluLXN0cmluZwogIDs7ICAgOzsgOzsiPS4qZmVhdHVyZXMgPSBbW11cXChcblxcfFxccy1cXCkqXFwoXFwoXFwoW15cbl0rXFwoXG4qXFx8XFxzLSpcXClcXClcXClcXChcblxcfFxccy1cXCkqXFwpW11dXFwoXG5cXHxcXHMtXFwpKlt9XVxcKFxuXFx8XFxzLVxcKSoiCiAgOzsgICA7OyAiPS4qW3tdLipmZWF0dXJlc1xccy0qPVxccy0qP1tbXVxcKFxuXFx8XFxzLVxcKSo/XFwoXFwoXFwoW15cbl0rXFwoXG4qXFx8XFxzLSo/XFwpXFwpXFwpXFwoXG5cXHxcXHMtXFwpKj9cXClbXV1cXChcblxcfFxccy1cXCkqP1t9XVxcKFxuXFx8XFxzLVxcKSo/IgogIDs7ICAgOzsgOzsgIj0uKmZlYXR1cmVzXFxzLSo9XFxzLSpbW11cXChcblxcfFxccy1cXCkqXFwoXFwoXFwoW15cbl0rXFwoXG4qXFx8XFxzLSpcXClcXClcXClcXChcblxcfFxccy1cXCkqXFwpW11dXFwoXG5cXHxcXHMtXFwpKlt9XVxcKFxuXFx8XFxzLVxcKSoiCiAgOzsgICAiXlxcKFthLXpdW2EtejAtOV8tXStcXClcXChcXHMtXFx8XG5cXCkqWz1dLipbe10uKmZlYXR1cmVzXFxzLSo9XFxzLSo/W1tdXFwoXG5cXHxcXHMtXFwpKj9cXChcXChcXChbXlxuXStcXChcbipcXHxcXHMtKj9cXClcXClcXClcXChcblxcfFxccy1cXCkqP1xcKVtdXVxcKFxuXFx8XFxzLVxcKSo/W31dXFwoXG5cXHxcXHMtXFwpKj8iCiAgOzsgICAiXFwxIGZlYXR1cmVzID0gXFw2IgogIDs7IChyZXBsYWNlLXJlZ2V4cC1pbi1zdHJpbmcKICA7OyAgIj0uKmZlYXR1cmVzXFxzLSo9XFxzLSpcXChcXChcIlxcfFtbXVxcKVxcKC4qXFwpXCJcXCk/IgogIDs7ICAiID0gZmVhdHVyZXMgPSBcIlxcM1wiIgogIDs7IChyZXBsYWNlLXJlZ2V4cC1pbi1zdHJpbmcKICA7OyAgIl5cXChbYS16MC05Xy1dK1xcKVxccy0qPVxccy0qW3tdLipmZWF0dXJlc1xccy0qPVxccy0qXFwoXCJcXHxbW11cXClcXCguKlxcKVwiLioiCiAgOzsgICIgXFwxIGZlYXR1cmVzID0gXFwzIgo=
;;   ;; ;; (replace-regexp-in-string
;;   ;; ;;  "[^]]+\\s-*[}]$"
;;   ;; (replace-regexp-in-string
;;   ;;  "\\s-*\\([]]\\|,\\)*\\s-*[}]"
;;   ;;  "]"
;;   ;; (replace-regexp-in-string
;;   ;;  "^\\([a-z0-9_-]+\\)\\s-*[=]\\s-[{].*$"
;;   ;;  "\\1 features = []"
;;   ;; (replace-regexp-in-string
;;   ;;  "^\\([a-z0-9_-]+\\)\\s-*=\\s-*[{].*features\\s-*[=]\\s-*[[]?"
;;   ;;  "\\1 features = ["
;;   (replace-regexp-in-string
;;    "^\\([a-z0-9_-]+\\)\\s-*[=]\\s-*[{]\\s-*version\\s-*=\\s-*\\S-+\\s-*[}]"
;;    "\\1 features = []"
;;   (replace-regexp-in-string
;;    "[[]\\(\n\\|\\s-\\)*\\(.*?,\\|[]]\\)*\\(\n\\|\\s-\\)*[]]"
;;    " \\2 "
;;    (replace-regexp-in-string
;;     "^\\([a-z][a-z0-9_-]+\\)\\(\\s-\\|\n\\)*[=]\\(\\s-\\|\n\\)*[{]\\(\\s-\\|\n\\)*\\(version\\s-*=\\s-*\"[0-9.]+\"\\)\\(\\s-\\|\n\\)[}]"
;;     "\\1 = { \\5, features = [] }"
;;     string
;;     ))))
;;    ;; )))))



;; (defun cargo-dependencies-to-cargo-add-region(beg end)
;;   "BEG END."
;;   (interactive "*r")
;;   (save-excursion
;;     (cargo-dependencies-normalize-region beg end)
;;     (let ((region (buffer-substring-no-properties beg end)))
;;       (replace-region-contents
;;        beg end
;;        #'(lambda ()
;;            (regex-cargo-dependencies-to-cargo-add region)))
;;       )))



(defun rust-members-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda ()
           (replace-regexp-in-string
            "^\\(\\(.\\|\n\\)*\\)$"
            "{\\1};"
            (replace-regexp-in-string
             "^\\s-*///?.*$"
             ""
             (replace-regexp-in-string
              "^\\s-*\\(pub\\s-*\\)?\\((super\\|crate\\|self\\|in\\s-*[^)]+)\\)?\\s-*\\(struct\\|union\\|trait\\|enum\\|fn\\)\\s-*\\([<][^>]*[>]\\)?\\s-*\\([A-Za-z_][a-zA-Z0-9_]+\\).*"
              "\\5,"
              (replace-regexp-in-string
               "^\\s-*\\(\\s-+\\|}\\|use\\|impl\\|extern\\s-*crate\\|\\(pub\\(\s-*\\(in\s-*\\)?[a-z0-9:]+\\)?\\)?\\s-*mod\\|[#][[]\\|)\\).*"
               ""
               region))))))))
  (save-excursion (flush-lines "^$" beg end nil)))


(defun rust-extract-members-regex (package-name string)
  "STRING."
  (format "pub use %s::{\n%s\n};" package-name
          (rust-comma-separated-members-regex string)))

(defun rust-comma-separated-members-regex (string)
  "STRING."
  (let ((members
         (replace-regexp-in-string
          "^\\s-*///?.*$"
          ""
          (replace-regexp-in-string
           "^\\s-*\\(pub\\s-*\\)?\\((super\\|crate\\|self\\|in\\s-*[^)]+)\\)?\\s-*\\(struct\\|union\\|trait\\|type\\|enum\\|fn\\)\\s-*\\([<][^>]*[>]\\)?\\s-*\\([A-Za-z_][a-zA-Z0-9_]+\\).*"
           "\\5,"
           (replace-regexp-in-string
            "^\\s-*\\(\\s-+\\|}\\|use\\|impl\\|extern\\s-*crate\\|\\(pub\\(\s-*\\(in\s-*\\)?[a-z0-9:]+\\)?\\)?\\s-*\\(mod\\|macro_\\(rules\\|export\\)[!]?\s-*\\)\\|[#][[]\\|)\\).*[{]?.*$"
            ""
            string)))))
    (replace-regexp-in-string
     "^\\(\\(.\\|\n\\)*\\)$"
     "\\1"
     (replace-regexp-in-string
      "\\(\\s-*\\|\n*\\)+"
      ""
      (with-temp-buffer
        (insert members)
        (flush-lines "^$" (point-min) (point-max))
        (buffer-string))))))

(defun rust-path-to-current-file-mod ()
  (let* ((current-file-name (expand-file-name (buffer-file-name)))
         (no-extension (file-name-sans-extension current-file-name)))
    (or
     (when (string= no-extension "mod")
       (file-name-directory current-file-name))
     (when (string= no-extension "lib")
       (file-name-directory current-file-name))
     no-extension)))

(defun rust-guess-package-name-of-file (filename)
  (let* ((current-file-name (expand-file-name filename))
         (no-extension (file-name-base current-file-name)))
    (if (string= no-extension "mod")
        (file-name-base (file-name-directory current-file-name))
      no-extension)))


(defun rust-insert-members-from-file ()
  "BEG END."
  (interactive)
  (let* ((rust-file-name
          (expand-file-name
           (read-file-name
            "insert members of rust file:"
            (rust-path-to-current-file-mod)
            nil 'confirm-after-completion)))
         (package-name
          (rust-guess-package-name-of-file rust-file-name))
         (string
          (with-temp-buffer
            (insert-file-contents rust-file-name)
            (buffer-string))))
    (insert (rust-extract-members-regex package-name string))
    (rust-format-buffer)))


(defun fgbg-foreback(beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda ()
           (replace-regexp-in-string
            "\\bbg\\b"
            "back"
            (replace-regexp-in-string "\\bfg\\b" "fore" region)))))))


(defun comment-step-region(beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda ()
           (replace-regexp-in-string
            "^\\(\\s-*\\)\\(step\\(_test\\)?!\\)"
            "\\1 // \\2"
            region))))))





(defmacro
    when-buffer-filename-meets(cond &rest body)
  "REGEXP FN."
  `(let ((filename (expand-file-name (buffer-file-name))))
     (if ,cond (progn ,@body))))

(defmacro
    when-buffer-meets(cond &rest body)
  "REGEXP FN."
  `(if ,cond (progn ,@body)))

(defmacro
    when-buffer-filename-matches(regexp &rest body)
  "REGEXP FN."
  `(let ((filename (expand-file-name (buffer-file-name))))
     (if (string-match-p ,regexp filename)
         (progn ,@body))))


(defun git-current-branch()
  (car
   (seq-filter
    (apply-partially #'string-match-p "[*]\s-\\(\\)")
    (string-lines (shell-command-to-string "git branch")))))


(defun git-autocommit-current-file-buffer()
  (let* ((current-branch-name (git-current-branch))
         (last-commit-message
          (shell-command-to-string "git log --max-count=1 --format=%s"))
         (branch-name
          (format "%s@%s"
                  ($/hash-take-last-n-chars 'sha512 8 filename)
                  (file-name-nondirectory filename))))
    (shell-command-to-string (format "git branch %s" branch-name))
    (shell-command-to-string (format "git checkout %s" branch-name))
    (shell-command-to-string (format "git add -f %s" filename))
    (shell-command-to-string
     (format "git commit %s -m '%s'" filename
             (file-name-nondirectory filename)))
    (shell-command-to-string
     (format "git checkout %s" current-branch-name))
    (shell-command-to-string
     (format "git merge --squash %s --no-commit" branch-name))
    (shell-command-to-string
     (format "git commit --amend -m '%s'"
             (format "%s\n%s (%s)" last-commit-message
                     (file-name-nondirectory filename)
                     (time-stamp-string "%Y-%m-%d %H:%M:%S"))))
    (set-buffer-modified-p nil)

    ))








(defun git-autocommit-opt-libexec()
  "."
  (when-buffer-filename-meets
   (string-match-p
    (concat "^" (getenv "HOME") "/opt/libexec")
    filename)
   (git-autocommit-current-file-buffer)
   (message (format "auto-commited %s" filename))))

(defun git-autocommit-emacs-d-c-sources()
  "."
  (when-buffer-filename-matches
   (concat "^" (getenv "HOME") "/.emacs.d/c")
   (git-autocommit-current-file-buffer)
   (message (format "auto-commited emacs file %s" filename))))

(defmacro
    set-region-contents-with-fn(beg end fn)
  "BEG END FN."
  `(save-excursion
     (let ((region (buffer-substring-no-properties beg end))
           (repl (,fn region)))
       (replace-region-contents beg end #'(lambda () repl)))))



(defun toml-prettify-buffer ()
  "."
  (interactive)
  (when-buffer-meets
   (string= major-mode "toml-mode")

   (flush-empty-lines)
   (save-excursion
     (let* ((beg
             (progn
               (goto-char (point-min))
               (forward-word)
               (point)))
            (end (point-max))
            (region (buffer-substring-no-properties beg end))
            (repl
             (replace-regexp-in-string
              "^\\([#]\\s-*\\)?\\([[].*\\)"
              "\n\\1\\2"
              region)))
       (replace-region-contents beg end #'(lambda () repl ))

       (if (not (string= region repl))
           ;; avoid modifying buffer after prettifying its contents
           (set-buffer-modified-p nil))))))

(defun delete-comments-region(beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((regexp (concat "^\\s-*" (regexp-quote comment-start) ".*"))
          )
      (flush-lines regexp beg end))))

(defun delete-comments-buffer()
  "BEG END."
  (interactive)
  (delete-comments-region (point-min) (point-max)))


(defun flush-empty-lines ()
  "."
  (interactive)
  (save-excursion (flush-lines "^$" (point-min) (point-max) nil)))


(defun decr-next-number()
  "."
  (interactive)

  (re-search-forward "\\([0-9]+\\)" nil t)
  (goto-char (match-beginning 1))
  (let ((pos (point)))
    (replace-match
     (format "%s" (- (string-to-number (match-string 1)) 1))
     t)
    (re-search-forward "\\([0-9]+\\)" nil t)
    (if (eq pos (match-beginning 1))
        (progn
          (forward-line)
          (message (format "forward-line %s" pos)))
      (progn
        (goto-char (match-beginning 1))
        (message (format "goto-char %s" (match-beginning 1)))))))

(defun incr-next-number()
  "."
  (interactive)

  (re-search-forward "\\([0-9]+\\)" nil t)
  (goto-char (match-beginning 1))
  (let ((pos (point)))
    (replace-match
     (format "%s" (+ (string-to-number (match-string 1)) 1))
     t)
    (re-search-forward "\\([0-9]+\\)" nil t)
    (if (eq pos (match-beginning 1))
        (progn
          (forward-line)
          (message (format "forward-line %s" pos)))
      (progn
        (goto-char (match-beginning 1))
        (message (format "goto-char %s" (match-beginning 1)))))))


(defun goto-next-close-parenthesis (open-char close-char open-count close-count &optional beg-pos)
  "OPEN-CHAR
   CLOSE-CHAR
   OPEN-COUNT
   CLOSE-COUNT
   &optional
   BEG-POS."
  (unless (eq (length open-char) 1)
    (error "open-char is should have length 1 but is %s"
           (length open-char)))
  (unless (eq (length close-char) 1)
    (error "close-char is should have length 1 but is %s"
           (length close-char)))
  (unless (integerp open-count)
    (error "open-count is should be a number not \"%s\"" open-count))
  (unless (integerp close-count)
    (error "close-count is should be a number not \"%s\"" close-count))
  ;; optional
  (unless (integerp (or beg-pos (point)))
    (error "beg-pos is should be a number not \"%s\"" beg-pos))

  (setq case-fold-search nil)
  (let* ((case-fold-search nil)
         (open-regexp (regexp-quote open-char))
         (close-regexp (regexp-quote close-char))
         (open-count open-count)
         (close-regexp (regexp-quote close-char))
         (close-count close-count)
         (beg-pos (or beg-pos (point)))
         (pos beg-pos)
         (cur-pos beg-pos)
         (open-pos beg-pos)
         (close-pos beg-pos)
         (marker (point-marker))
         (too-many-open-parenthesis (> open-count close-count)))

    (defun state ()
      (format "{\n    open-count: %s,\n    close-count: %s,\n    open-pos: %s,\n    close-pos: %s\n}" open-count close-count open-pos close-pos))


    (message (state))
    (if (not (use-region-p))
        (progn
          (message (format "setting region at %s" beg-pos))
          (push-mark (point) t t)))

    (if (not (eq beg-pos (point)))
        (progn
          (goto-char beg-pos)
          (message (format "current pos %s" beg-pos))))



    (or
     (when (not (null (re-search-forward close-regexp nil t)))
       ;; search next close parenthesis
       (progn
         (message (format "search next close parenthesis"))
         ;; close parenthesis found, set cur-pos to its match-end
         (setq cur-pos (match-end 0))
         (setq close-count (1+ close-count))
         (goto-char cur-pos)

         (or
          ;; get position of next open parenthesis if before curernt close parenthesis
          (and
           (not (null (re-search-forward open-regexp nil t)))
           (progn
             (message (format "peeking onto next open parenthesis"))

             (setq open-count (1+ open-count))
             (if (<= (match-end 0) cur-pos)
                 (progn
                   ;; open parenthesis found before current close parenthesis
                   (message
                    (format "found open parenthesis before next open parenthesis, recursive call should happen next"))
                   t)
               ;; else, done!
               '(("beg-pos" . beg-pos)
                 ("open-pos" . open-pos)
                 ("open-count" . open-count)
                 ("close-pos" . close-pos)
                 ("close-count" . close-count)
                 ("end-pos" . end-pos))))
           (progn
             (setq close-pos cur-pos)
             (setq end-pos cur-pos)
             (setq open-pos (match-end 0))
             ;; go backward to the last close parenthesis so that while in recursive call fast-forwards it
             (goto-char open-pos)
             (message
              (format "recursive call to (goto-next-close-parenthesis open-char: %s close-char: %s open-count: %s close-count: %s close-pos: %s)"  open-char close-char open-count close-count close-pos))
             (goto-next-close-parenthesis open-char close-char open-count close-count open-pos))))))
     (when (not (null (re-search-forward open-regexp nil t)))
       ;; no close parenthesis found, search next open parenthesis
       (progn
         (message (format "unexpected third case"))
         (setq open-pos (match-end 0))
         (setq open-count (1+ open-count))
         (setq end-pos (match-end 0))
         (goto-char cur-pos)
         '(("beg-pos" . beg-pos)
           ("open-pos" . open-pos)
           ("open-count" . open-count)
           ("close-pos" . close-pos)
           ("close-count" . close-count)
           ("end-pos" . end-pos))))
     (when too-many-open-parenthesis
       ;; not enough close parenthesis found, return what it can
       (progn
         (message (format "too-many-open-parenthesis 4th case"))
         (while too-many-open-parenthesis
           (progn
             (message
              (format "too-many-open-parenthesis: %s" (state)))
             (if (not (null (re-search-forward close-regexp nil t)))
                 (progn
                   (message
                    (format "found next close parenthesis within too-many-open-parenthesis"))
                   (setq close-pos (match-end 0))
                   (setq close-count (1+ close-count))
                   (goto-char close-pos)

                   (if (> open-pos close-pos)
                       (progn
                         (message
                          (format "and such close parenthesis happens to appear before open parenthesis: %s"
                                  (state)))
                         ;; (setq open-count (1+ close-count))
                         )
                     (progn
                       (message
                        (format "but close parenthesis appears after close parenthesis: %s"
                                (state)))
                       (setq open-count (1+ close-count))))

                   (setq too-many-open-parenthesis
                         (or
                          (> open-pos close-pos)
                          (> open-count close-count))))
               ;;else, exit loop
               (setq too-many-open-parenthesis nil));; end if
             t))
         (setq end-pos close-pos)

         '(("beg-pos" . beg-pos)
           ("open-pos" . open-pos)
           ("open-count" . open-count)
           ("close-pos" . close-pos)
           ("close-count" . close-count)
           ("end-pos" . end-pos)))))))



(defun find-next-close-parens()
  "."
  (interactive)
  (let* ((open-char "(")
         (close-char ")")
         (til-next-open
          (re-search-forward (concat "\\(\\s-\\|\n\\)*[" open-char "]")))
         (til-next-close
          (re-search-forward
           (concat "\\(\\s-\\|\n\\)*[" close-char "]")))
         (open-count
          (if (>= (point) til-next-open)
              (progn (goto-char til-next-open) 1)
            0))
         (close-count
          (if (and (eq 1 open-count) (> (point) til-next-close))
              (progn (goto-char til-next-close) 1)
            0)))
    (defun state ()
      (format "{\n    point: %s\n    til-next-open: %s,\n    til-next-close: %s,\n    open-count: %s,\n    close-count: %s\n}"
              (point)
              til-next-open til-next-close open-count close-count))

    (message (state))
    (goto-next-close-parenthesis open-char close-char open-count close-count)

    ))

(defun erase-messages()
  "."
  (interactive)
  (with-current-buffer "*Messages*"
    (read-only-mode -1)
    (erase-buffer)
    (read-only-mode 1)))


(defun git-add()
  "."
  (interactive)
  (shell-command-to-string
   (format "git add -f %s" (expand-file-name (buffer-file-name)))))


(defun git-commit()
  "."
  (interactive)
  (let *((commit-message (read-string "Commit Message:")))
       (or (when (zerop (length commit-message))
             (user-error "aborted due to empty commit message"))
           (progn
             (shell-command-to-string
              (format "git commit %s -m '%s'" (expand-file-name (buffer-file-name)) commit-message))))))
