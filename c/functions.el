(defun string-shift-right (g) "." (format "\t%s" g))

(progn ;; runtime/platform dependent defun
  (when (not (functionp 'scratch-buffer))
    (defun scratch-buffer ()
      "."
      (interactive)
      (switch-to-buffer (get-buffer-create "*scratch*" t) t t))))

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
  (scratch-buffer)
  (mapcar
   #'(lambda (b)
       (ignore-errors (set-buffer-modified-p nil))

       (ignore-errors (revert-buffer 1 1))
       (kill-buffer b))
   (buffer-list))
  (while (> (get-window-count t) 1)
    (delete-window (frame-first-window)))
  (ignore-errors (erase-messages))
  (ignore-errors (erase-scratch))
  (ignore-errors (erase-scratch)))

(defun get-window-count (&optional all-frames)
  "returns integer."
  (let ((windows 0))
    (progn
      (walk-windows
       (lambda (window) (setq windows (1+ windows)))
       nil
       (not (null all-frames)))
      windows)))

(defun minor-mode-slist ()
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

(defun disable-bars ()
  "."
  (interactive)
  (progn (scroll-bar-mode 0) (menu-bar-mode 0) (tool-bar-mode 0)))

(defun disable-auto-save-list ()
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

(defun Ox33b4O/$/ep ()
  "."
  (interactive)
  (find-file "~/.emacs.d/t/k.el"))

(defun contrast-color (c)
  "C."
  (interactive "s")

  (compute-bright-dark-from-color-value c "#919588" "#1C1C1C"))

(defun compute-bright-dark-from-color-value (c bright dark)
  "C."
  (interactive "s")
  (let* ((values (x-color-values c))
         (fp (or (car values) 1))
         (sp (or (elt values 1) 1))
         (tp (or (elt values 2) 1))
         )
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

(defun colorize-hexadecimal-text ()
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
                  (Ox33b4O/$/delete-overlays-within cbeg cend)
                  (make-overlay cbeg cend))))
          (overlay-put x2133 'bcc t)
          (overlay-put x2133 'face
                       (list :foreground
                             (contrast-color faber)
                             :background faber)))))))

(defun buffer-elisp-heuristic ()
  "."
  (or
   (string= "emacs-lisp-mode" (Ox33b4O/$/mode-name))
   (string= "elisp-mode" (Ox33b4O/$/mode-name))
   (string= "lisp-mode" (Ox33b4O/$/mode-name))
   (string= "el" (file-name-extension (buffer-file-name)))))

(defun region-points ()
  "."
  (if mark-active
      (save-mark-and-excursion
        (list (marker-position (mark-marker)) (point)))
    (save-mark-and-excursion
      (widen)
      (list (point-min) (point-max)))))

(defun eval-elisp-buffer ()
  (interactive)
  "evaluates the entire buffer as emacs-lisp expression so long as calling `buffer-elisp-heuristic' returns non-nil."
  (if (buffer-elisp-heuristic)
      (save-mark-and-excursion
        (widen)
        (eval-buffer)
        (message "%s eval'd " (buffer-name)))
    (progn
      (message "cannot evaluate buffer %s because it is not in %s, trying to run pretty formatter instead"
               (Ox33b4O/$/paint-mode-line-color (buffer-name))
	       (Ox33b4O/$/paint-mode-line-color "elisp-mode"))
      (g/format/prettify))
    ))

(defun Ox33b4O/$/reload-all-c ()
  "."
  (interactive)
  (cleanup-elc)
  (load-file "~/.emacs.d/c/boot.el"))
(defun Ox33b4O/$/reload-init ()
  "."
  (interactive)
  (cleanup-elc)
  (load-file "~/.emacs.d/init.el"))

(defun Ox33b4O/$/undefine-key (key)
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
    (cdr (mapc 'Ox33b4O/$/undefine-key key))))

(defun Ox33b4O/$/set-key (key def)
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
    (progn (Ox33b4O/$/undefine-key key) (global-set-key key)))

  (when (stringp key)
    (progn
      (Ox33b4O/$/undefine-key key)
      (global-set-key (kbd key) def)))
  (when (or (consp key)
            ;;            (arrayp key)
            (vectorp key)
            (listp key))
    (cdr
     (mapc #'(lambda (key) (Ox33b4O/$/set-key key def)) key))))

(defun Ox33b4O/$/set-extra-key (key def)
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
     (mapc #'(lambda (key) (Ox33b4O/$/set-extra-key key def)) key))))

(defun fold-file-name (file-name)
  "."
  (interactive "f")
  ((replace-regexp-in-string
    (string-join "^" (getenv "HOME"))
    "~"
    (expand-file-name file-name))))

(defun getcwd ()
  "."
  (interactive)
  (cond
   ((file-exists-p (buffer-file-name))
    (file-name-directory (buffer-file-name))
    (expand-file-name "~/.emacs.d"))))

(defun show-face-at-point ()
  "."
  (interactive)
  (message "%S" (face-at-point)))

(defun spolsky ()
  (interactive)
  (add-to-list 'custom-safe-themes
               "fa410876eb2437307481f0986512b5487ca8d3fda3130872e758c5cdde6d2218")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/themes")
  (load-theme 'spolsky))

(defun fpuervo (erjbys)
  "https://gchq.github.io/CyberChef/#recipe=ROT13 (true,true,false,13)&input=ZnB1ZXJ2b3JlcnY
."
  (interactive)
  (load-file-from-home (format "Ly5lbWFjcy5kL3Qv%sLmVs" erjbys)))

(defun meta-comma (k)
  "."
  (interactive)
  (mapcar
   #'(lambda (n) (string-join (list n k) ""))
   (list "M-, M-" "M-, ")))

(defun show-face-at-point ()
  "."
  (interactive)
  (message "%S" (face-at-point)))

(defun Ox33b4O/$/hash-take-last-n-chars (algo count contents)
  "."
  (let* ((data (secure-hash algo contents))
         (end (length data))
         (beg (- end count)))
    (substring data beg end)))

(defun Ox33b4O/$/hash-take-first-n-chars (algo end contents)
  "."
  (let* ((data (secure-hash algo contents))
         (beg 0))
    (substring data beg end)))

(defun Ox33b4O/$/text-properties ()
  "."
  (interactive)
  (message "%S" (text-properties-at (car (region-points)))))

(defun Ox33b4O/$/colorize-face-fg (text faber)
  "."
  (propertize text 'face (list :foreground faber)))

(defun buffer-file-name-relative ()
  "."
  (format "%s" (file-relative-name (buffer-file-name))))

;; KGRlZnVuIGRlYnVnLyQvYmNocyAoKQogICIuIgogIChpbnRlcmFjdGl2ZSkKCiAgKG1lc3NhZ2UKICAgKGZvcm1hdCAiPCQvYmNocyBkZWJ1Zz5cblxubW9kZTogJyVTJ1xuXG5maWxlLWF0dHJpYnV0ZS1tb2RlOiAnJVMnXG5cbiQvYmZhbjogJyVzJ1xuXG5idWZmZXItbmFtZTogJyVTJ1xuPC8kL2JjaHMgZGVidWc+IgogICAgICAgICAgICgkL21vZGUtbmFtZSkKICAgICAgICAgICAoZmlsZS1hdHRyaWJ1dGUtbW9kZXMgKGZpbGUtYXR0cmlidXRlcyAoYnVmZmVyLWZpbGUtbmFtZSkpKQogICAgICAgICAgICgkL2JmYW4pCiAgICAgICAgICAgKGJ1ZmZlci1uYW1lKQoKICAgICAgICAgICApKQo=

(defun Ox33b4O/$/bchs ()
  "."
  (let ((data
         (buffer-substring-no-properties (point-min) (point-max))))
    (format "%s %s %s"
            (Ox33b4O/$/string-hash-take-last-n-chars 'sha256 8 data)
            (Ox33b4O/$/string-hash-take-last-n-chars 'sha1 8 data)
            (Ox33b4O/$/string-hash-take-last-n-chars 'md5 8 data))))

(defun Ox33b4O/$/acl-owner (f)
  "F."
  (interactive)
  (format "(owner: %S)" f))

(defun Ox33b4O/$/acl-group (f)
  "F."
  (interactive)
  (format "(group: %S)" f))

(defun Ox33b4O/$/acl-other (f)
  "F."
  (interactive)
  (format "(group: %S)" f))

;; (defun current-column ()
;;   "returns the current column number."
;;   (- (point) (line-beginning-position)))

(defun column-at-pos (pos)
  "returns the current column number at marker."
  (save-mark-and-excursion (goto-char pos) (current-column)))

(defun marker-begin ()
  (format
   "line=%s col=%s"
   (line-number-at-pos (marker-position (mark-marker)))
   (column-at-pos (marker-position (mark-marker)))))
(defun marker-end ()
  (format "line=%s col=%s"
          (line-number-at-pos (point))
          (current-column)))

(defun Ox33b4O/$/base64-encode-region (beg end)
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

(defun Ox33b4O/$/mt (p) "P." (interactive) (format "%S" p))
;; (let* ((p (replace-regexp-in-string "[o-t]" "🧾" p))
;;        (p (replace-regexp-in-string "[s-w]" "🖍️" p))
;;        (p (replace-regexp-in-string "[xX]" "👥️" p)))
;;   p))

(defun Ox33b4O/$/fm ()
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
        (format "%s aclsl:%S"
                (Ox33b4O/$/acl-owner (nth 0 acls))
                aclsl ))
       ;; (t (progn
       ;;           (format "WAT: %S" (car acls))))
       ((= 2 aclsl)
        (format "%s%s"
                (Ox33b4O/$/acl-owner (nth 0 acls)
                                     (Ox33b4O/$/acl-group
                                      (nth 1 acls)))))
       ((= 3 aclsl)
        (format "%s%s%s"
                (Ox33b4O/$/acl-owner (nth 0 acls)
        			     (Ox33b4O/$/acl-group
                                      (nth 1 acls))
        			     (Ox33b4O/$/acl-other (nth 1 acls)))))
       (t (format "fallback ffb: %S" ffb)))
      ;; ;; (message  "ffb:%S acls: %S\naclsl:%S" ffb acls aclsl)
      )))

(defun Ox33b4O/$/flush-kill-ring ()
  "."
  (interactive)
  (setq kill-ring nil file-name-history nil))
(defun Ox33b4O/$/kill-all-buffers-and-flush-kill-ring ()
  "."
  (interactive)
  (progn
    (kill-bufs)
    (Ox33b4O/$/flush-kill-ring)
    (erase-messages)
    (while (> (get-window-count) 1) (delete-window))))

(defun Ox33b4O/$/string-hash-take-last-n-chars (algo hwm contents)
  "."
  ;; (format "%s:%s"  (symbol-name algo) (Ox33b4O/$/hash-take-last-n-chars algo hwm contents)))
  (format "%s" (Ox33b4O/$/hash-take-last-n-chars algo hwm contents)))

(defun server-reboot ()
  "."
  (interactive)
  (ignore-errors (server-force-delete))
  (ignore-errors (server-mode 9))
  (ignore-errors (server-start)))

(defun Ox33b4O/$/hash (algo)
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

(defun Ox33b4O/$/sec-hash-region (algo)
  "."
  (interactive "S")
  (let* ((pipa (region-points))
         (pi (car pipa))
         (pa (car (cdr pipa)))
         (bs (buffer-substring-no-properties pi pa))
         (hg (secure-hash algo bs)))
    (replace-region-contents pi pa (lambda () hg))))

(defun Ox33b4O/$/delete-overlays-within (beg end)
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

(defun Ox33b4O/$/chacha20-hardcoded (text шоли$)
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

(defun Ox33b4O/$/encrypt-chacha20-hardcoded ()
  "."
  (interactive)
  (save-mark-and-excursion
    (let* ((pipa (region-points))
           (pi (car pipa))
           (pa (car (cdr pipa))))
      (replace-region-contents
       pi pa
       (lambda ()
         (Ox33b4O/$/chacha20-hardcoded
          (buffer-substring-no-properties pi pa)
          "MHgwYzlmNjAwMCAtLSAnJXMn"))))))

(defun Ox33b4O/$/decrypt-chacha20-hardcoded ()
  "."
  (interactive)
  (save-mark-and-excursion
    (let* ((pipa (region-points))
           (pi (car pipa))
           (pa (car (cdr pipa))))
      (replace-region-contents
       pi pa
       (lambda ()
         (Ox33b4O/$/chacha20-hardcoded
          (buffer-substring-no-properties pi pa)
          "MHgwYzlmNjAwMCAtZCAtLSAnJXMn"))))))

;;(Ox33b4O/$/undefine-key (list "C-c C-e C-2" "C-c C-d C-2"))
(ignore-errors
  (Ox33b4O/$/set-key
   (list "C-c C-e C-2 C-0")
   'Ox33b4O/$/encrypt-chacha20-hardcoded)
  (Ox33b4O/$/set-key
   (list "C-c C-e C-d C-2 C-0")
   'Ox33b4O/$/decrypt-chacha20-hardcoded))

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
          "Node::Operation (\\(Node::\\)?\\(Not\\|Add\\|Sub\\|Mul\\|Div\\|Assign\\|Pow\\|Negate\\)"
          "Node::Operation (Operation::\\2"
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
          "Node::Value (\\(Node::\\)?\\(Boolean\\|Integer\\|String\\|Null\\)"
          "Node::Value (Value::\\2"
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
          "Node::Begin (\\(Node::\\)?\\(Block\\|Function\\)"
          "Node::Begin (Begin::\\2"
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
          "stub_node_info (&input, \"\\2\", (\\5, \\7), (\\10, \\12))"
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

(defun cargo-dependencies-normalize-region (beg end)
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

(defun tm-theme-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "^\\(\\w+.*\\)$" nil t)
      (replace-match
       (format
        "set.themes.insert (\"%s\".to_string (), theme_from_bytes (include_bytes!(\"./%s.tmTheme\")));"
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

;; (defun cargo-dependencies-to-cargo-add-region (beg end)
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
    (let* ((region (buffer-substring-no-properties beg end))
           (region
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
                    "^\\s-*\\(pub\\s-*\\)?\\((super\\|crate\\|use\\|self\\|in\\s-*[^)]+)\\)?\\s-*\\(struct\\|union\\|trait\\|enum\\|fn\\)\\s-*\\([<][^>]*[>]\\)?\\s-*\\([A-Za-z_][a-zA-Z0-9_]+\\).*"
                    "\\5,"
                    (replace-regexp-in-string
                     "^\\s-*\\(\\s-+\\|}\\|impl\\|extern\\s-*crate\\|\\(pub\\(\s-*\\(in\s-*\\)?[a-z0-9:]+\\)?\\)?\\s-*mod\\|[#][[]\\|)\\).*"
                     ""
                     region))))))))
      (if called-interactively-p (erase-messages) (message "%s" region))
      region)
    (flush-lines "^$" beg end nil)))

(defun rust-path-to-current-file-mod ()
  (let* ((current-file-name (expand-file-name (buffer-file-name)))
         (no-extension
          (file-name-sans-extension (file-name-base current-file-name))))
    (or
     (when (string= no-extension "mod")
       (file-name-parent-directory current-file-name))
     (when (string= no-extension "lib")
       (file-name-parent-directory current-file-name))
     current-file-name)))

(defun rust-guess-package-name-of-file (filename)
  (let* ((current-file-name (expand-file-name filename))
         (no-extension (file-name-base current-file-name)))
    (if (string= no-extension "mod")
        (file-name-base (file-name-directory current-file-name))
      no-extension)))

(defun rust-insert-members-from-file ()
  "BEG END."
  (interactive)
  (let ((rust-file-name
         (expand-file-name
          (read-file-name
           "insert members of rust file: "
           (rust-path-to-current-file-mod)
           nil 'confirm-after-completion))))

    (let* ((tmp-buffer-name
            (format "*rust-autocomplete:%s*" rust-file-name))
           (tmp-buffer (get-buffer-create tmp-buffer-name))
           (exit-code
            (call-process "rust-autocomplete" nil tmp-buffer nil "list" rust-file-name)))
      (if (eq 0 exit-code)
          (let ((items
                 (with-current-buffer tmp-buffer
                   (widen)
                   (buffer-substring-no-properties
                    (point-min)
                    (point-max)))))
            (kill-buffer tmp-buffer)
            (insert (format "\n%s\n" items))
            (rust-format-buffer))
	(progn
          (switch-to-buffer tmp-buffer)
          (user-error
           (format "failed to list items of file %s"
                   (abbreviate-file-name (rust-file-name))))))
      )))

(defun rust-insert-members-from-file-with-docs ()
  "BEG END."
  (interactive)
  (let ((rust-file-name
         (expand-file-name
          (read-file-name
           "insert members of rust file: "
           (rust-path-to-current-file-mod)
           nil 'confirm-after-completion))))

    (let* ((tmp-buffer-name
            (format "*rust-autocomplete:%s*" rust-file-name))
           (tmp-buffer (get-buffer-create tmp-buffer-name))
           (exit-code
            (call-process "rust-autocomplete" nil tmp-buffer nil "list" "--docs" rust-file-name)))
      (if (eq 0 exit-code)
          (let ((items
                 (with-current-buffer tmp-buffer
                   (widen)
                   (buffer-substring-no-properties
                    (point-min)
                    (point-max)))))
            (kill-buffer tmp-buffer)
            (insert (format "\n%s\n" items))
            (rust-format-buffer))
	(progn
          (switch-to-buffer tmp-buffer)
          (user-error
           (format "failed to list items of file %s"
                   (abbreviate-file-name (rust-file-name))))))
      )))

(defun rust-delete-comments ()
  "."
  (interactive)
  (let ((regexp "^\\s-*//\\(\\s-\\|$\\)"))
    (if mark-active
        (save-mark-and-excursion
          (flush-lines regexp (point-min) (point-max)))
      (progn
        (widen)
        (flush-lines regexp (point-min) (point-max))))))

(defun rust-add-error-variant ()
  "."
  (interactive)
  (let ((error-name
         (read-string "new error variant name (PascalCase): ")))
    (save-mark-and-excursion
      (widen)
      (replace-regexp-within-bounds
       "\\(\\(Error::\\)?IOError (\\([^)]+\\))\\s-*\\(,\\|=>\\s-e[.]to_string (),\\)\\)"
       (format "\\1\n    \2%s\3 \4\n" error-name)
       (point-min)
       (point-max))
      (replace-regexp-within-bounds
       "\\(\\(Error::\\)?IOError (\\([^)]+\\))\\s-*=>\\s-\\(\"[^\"]+\",\\)\\)"
       (format "\\1\n    \2%s\3 => \"%s\"\n" error-name error-name)
       (point-min)
       (point-max)))))

(defun rust-delete-docs ()
  "."
  (interactive)
  (let ((regexp "^\\s-*//[/!]"))
    (if mark-active
        (save-mark-and-excursion
          (flush-lines regexp (point-min) (point-max)))
      (progn
        (widen)
        (flush-lines regexp (point-min) (point-max))))))

(defun rust-delete-all-comments ()
  "."
  (interactive)
  (let ((regexp "^\\s-*//"))
    (if mark-active
        (save-mark-and-excursion
          (flush-lines regexp (point-min) (point-max)))
      (progn
        (widen)
        (flush-lines regexp (point-min) (point-max))))))

(defun cargo-manifest-insert-tests-from-folder (folder-path)
  (interactive
   (list
    (expand-file-name
     (read-file-name
      "insert members of rust file: "
      (rust-path-to-current-file-mod)
      nil 'confirm-after-completion))))

  (let* ((test-files (directory-files folder-path t "[.]rs$"))

         (test-names
          (mapcar #'(lambda (name) (file-name-base name)) test-files))
         (entries (-zip-pair test-names test-files))
         (toml-entries
          (mapcar
           #'(lambda (entry)
               (format "[[test]]\nname = \"%s\"\npath = \"%s\""
                       (car entry)
                       (file-name-concat
                        (file-name-base folder-path)
                        (file-name-nondirectory
                         (concat (cdr entry) "")))))
           entries))))
  (messages-buffer)
  (erase-messages)
  (messages-buffer)
  (message "%s" (concat toml-entries))
  (find-file
   (file-name-concat (file-name-directory folder-path) "Cargo.toml"))
  (with-current-buffer "Cargo.toml"
    (widen)
    (goto-char (point-max))
    (insert "\n")
    (insert "\n")
    (mapcar #'(lambda (entry) (insert entry)) toml-entries)))

(defun fgbg-foreback (beg end)
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

(defun comment-step-region (beg end)
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
    when-buffer-filename-meets (cond &rest body)
  "REGEXP FN."
  `(let ((filename (expand-file-name (buffer-file-name))))
     (if ,cond (progn ,@body))))

(defmacro
    when-buffer-meets (cond &rest body)
  "REGEXP FN."
  `(if ,cond (progn ,@body)))

(defmacro
    when-buffer-filename-matches (regexp &rest body)
  "REGEXP FN."
  `(let ((filename (expand-file-name (buffer-file-name))))
     (if (string-match-p ,regexp filename)
         (progn ,@body))))

(defun git-diff-exitcode-output (&optional ref)
  "."
  (let* ((git-diff-output-buf
          (create-fresh-buffer
           (format "*git-diff:%s*" (buffer-file-name-relative))))
         (exitcode
          (or
           (when (stringp ref)
             (call-process
              "git" nil git-diff-output-buf nil "diff" ref
              (buffer-file-name-relative)))
           (when (null ref)
             (call-process
              "git" nil git-diff-output-buf nil "diff"
              (buffer-file-name-relative)))
           (user-error
            (format "ref is neither nil nor string: %S" ref))))
         (output
          (with-current-buffer git-diff-output-buf
	    (widen)
	    (buffer-string))))
    (ignore-errors (kill-buffer git-diff-output-buf))
    (cons exitcode output)))

(defun git-diff-internal (&optional ref)
  (let* ((exitcode-output (git-diff-exitcode-output ref))
         (exitcode (nth 0 exitcode-output))
         (output (nth 1 exitcode-output))
         (buffer
          (create-fresh-buffer
           (format "*git-diff:%s*" (buffer-file-name-relative)))))
    (if (eq 0 exitcode-output)
        (progn
          (with-current-buffer buffer
            (widen)
            (diff-mode)
            (setq major-mode 'diff-mode)
            (insert output))
          (pop-to-buffer-same-window buffer t))
      (user-error (format "git diff failed with status %d" exitcode)))))

(defun git-diff () (interactive) (git-diff-internal))

(defun git-diff-head () (interactive) (git-diff-internal "HEAD"))

(defun git-diff-ref ()
  (interactive)
  (let ((ref (read-string "git diff against ref: " "HEAD")))
    (git-diff-internal ref)))

(defun git-status-porcelain ()
  "."
  (let* ((git-status-output-buf
          (get-buffer-create "*git-status-porcelain*"))
         (exitcode
          (call-process
           "git" nil git-status-output-buf nil "status" "--porcelain"))
         (output
          (with-current-buffer git-status-output-buf
	    (widen)
	    (buffer-string))))
    (ignore-errors (kill-buffer git-status-output-buf))
    (cons exitcode output)))

(defun git-status ()
  "."
  (interactive)
  (let* ((result (git-status-porcelain))
         (exitcode (car result))
         (output (car (cdr result))))

    (if (eq 0 exitcode)
        (message "git status ok: %s" output)
      (user-error
       (format "git-status error (%s): %s" exitcode output)))))

(defun git-current-branch ()
  (car
   (seq-filter
    (apply-partially #'string-match-p "[*]\s-\\(\\)")
    (string-lines (shell-command-to-string "git branch")))))

(defun git-commit ()
  "."
  (interactive)
  (let* ((git-commit-output-buf (get-buffer-create "*git-commit*"))
         (filename (buffer-file-name-relative))
         (commit-message
          (read-string "Commit Message: " (format "saves %s" filename))))
    (or
     (when (zerop (length commit-message))
       (user-error "aborted due to empty commit message"))
     (if (eq 0
             (let* ((exitcode
                     (call-process "git" nil git-commit-output-buf nil "commit"
                                   (buffer-file-name-relative)
                                   "-m"
                                   (format "'%s'" commit-message))))
               exitcode))
	 (progn
           (message "commited '%s'" commit-message)
           (kill-buffer git-commit-output-buf))
       (progn
         (user-error
          (format "failed to commit '%s': %s" commit-message
                  (with-current-buffer git-commit-output-buf
		    (widen)
		    (buffer-string)))
          (kill-buffer git-commit-output-buf)))))))

(defun git-save () "." (interactive) (git-add) (git-commit))

(defun get-regexp-github-remote-url ()
  "."
  "\(https://github[.]com[/]\|git@github[.]com[:]\)\([a-zA-Z0-9_-]+\)[/]\([a-zA-Z0-9_-]+\)[.]git")

(defun get-git-remote-url-vendor-username-and-repo ()
  "."
  "\(https://[^.]+[.][^.]+[/]\|git@[^.]+[.][^.]+[:]\)\([a-zA-Z0-9_-]+\)[/]\([a-zA-Z0-9_-]+\)[.]git")

(defun git-push (allow-github)
  "."
  (let* ((remotes (git-remote-names))
         (allow-github (not (null allow-github)))
         (linux-remote
          (-first
           #'(lambda (remote) (string= "linux" (car remote)))
           remotes))
         (github-remote
          (-first
           #'(lambda (remote)
               (string-match
                (get-regexp-github-remote-url)
                (cdr remote)
                nil t )))
          remotes)
         (has-linux-remote (not (null linux-remote)))
         (has-github-remote (not (null github-remote)))
         (push-remote
          (cond
           (has-linux-remote (car linux-remote))
           ((and allow-github has-github-remote)
            github-remote)
           (t
            (-first
             #'(lambda (remote)
                 (and
                  (not (string= "linux" (car remote)))
                  (null
                   (string-match
                    (get-regexp-github-remote-url)
                    (cdr remote)
                    nil t ))))
             remotes)))))
    (cond
     ((null push-remote)
      (let ((error-message
             (format "no suitable remotes found in current git dir (allow-github=%s)"
                     (if allow-github "true" "false"))))
        (user-error error-message)
	(cons 101 error-message)))
     (t
      (let* ((remote-name (car push-remote))
             (remote-url (cdr push-remote))
             (git-push-output-buf
              (get-buffer-create (format "*git-push-%s*" remote-name)))
             (exitcode
              (call-process
               "git" nil git-push-output-buf nil "push" remote-name))
             (output
              (with-current-buffer git-push-output-buf
	        (widen)
	        (buffer-string))))
	(ignore-errors (kill-buffer git-push-output-buf))
	(cons exitcode output))))))

(defun git-remote-names ()
  "."
  (save-match-data
    (split-string
     (shell-command-to-string "git remote show -n")
     nil t )))

(defun git-remote-get-url (remote-name)
  "returns a cons cell where the head is the remote name and the tail is the remote url."
  (let ((remote-url
         (shell-command-to-string
          (format "git remote get-url %s" remote-name))))
    (cons remote-name remote-url)))

(defun git-remotes ()
  "returns list of cons cells where the head is the remote name and the tail is the remote url."
  (mapcar 'git-remote-get-url (git-remote-names)))

;; (progn (message  "%s" (git-remotes)))

(defun git-commit-all ()
  "."
  (interactive)
  (let *((commit-message
          (read-string "Commit Message:")))
       (or
        (when (zerop (length commit-message))
          (user-error "aborted due to empty commit message"))
        (progn
          (shell-command-to-string
           (format "git commit -a -m '%s'" commit-message))))))

(defun git-autocommit-current-file-buffer ()
  (let* ((current-branch-name (git-current-branch))
         (last-commit-message
          (shell-command-to-string "git log --max-count=1 --format=%s"))
         (branch-name
          (format "%s@%s"
                  (Ox33b4O/$/hash-take-last-n-chars 'sha512 8 filename)
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
                     (format-time-string "%Y-%m-%d %H:%M:%S"))))
    (set-buffer-modified-p nil)))

(defun git-autocommit-opt-libexec ()
  "."
  (when-buffer-filename-meets
   (string-match-p
    (concat "^" (getenv "HOME") "/opt/libexec")
    filename)
   (git-autocommit-current-file-buffer)
   (message  "auto-commited %s" filename)))

(defun git-autocommit-emacs-d-c-sources ()
  "."
  (when-buffer-filename-matches
   (concat "^" (getenv "HOME") "/.emacs.d/c")
   (git-autocommit-current-file-buffer)
   (message "auto-commited emacs file %s" filename)))

(defmacro
    set-region-contents-with-fn (beg end fn)
  "BEG END FN."
  `(save-excursion
     (let ((region (buffer-substring-no-properties beg end))
           (repl (,fn region)))
       (replace-region-contents beg end #'(lambda () repl)))))

(defun delete-comments-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((regexp (concat "^\\s-*" (regexp-quote comment-start) ".*"))
          )
      (flush-lines regexp beg end))))

(defun delete-comments-buffer ()
  "BEG END."
  (interactive)
  (delete-comments-region (point-min) (point-max)))

(defun flush-empty-lines-region (beg end)
  "."
  (interactive "*r")
  (flush-lines "^$" beg end nil))

(defun flush-empty-lines-buffer ()
  "."
  (interactive)
  (save-excursion
    (widen)
    (flush-empty-lines-region (point-min) (point-max))))

(defun decr-next-number ()
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
          (message "forward-line %s" pos))
      (progn
        (goto-char (match-beginning 1))
        (message "goto-char %s" (match-beginning 1))))))

(defun incr-next-number ()
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
          (message "forward-line %s" pos))
      (progn
        (goto-char (match-beginning 1))
        (message "goto-char %s" (match-beginning 1))))))

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

    (message "%s" (state))
    (if (not (use-region-p))
        (progn
          (message  "setting region at %s" beg-pos)
          (push-mark (point) t t)))

    (if (not (eq beg-pos (point)))
        (progn
          (goto-char beg-pos)
          (message "current pos %s" beg-pos)))

    (or
     (when (not (null (re-search-forward close-regexp nil t)))
       ;; search next close parenthesis
       (progn
         (message  "search next close parenthesis")
         ;; close parenthesis found, set cur-pos to its match-end
         (setq cur-pos (match-end 0))
         (setq close-count (1+ close-count))
         (goto-char cur-pos)

         (or
          ;; get position of next open parenthesis if before curernt close parenthesis
          (and
           (not (null (re-search-forward open-regexp nil t)))
           (progn
             (message "peeking onto next open parenthesis")

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
         (message "unexpected third case")
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
         (message  "too-many-open-parenthesis 4th case")
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

(defun find-next-close-parens ()
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

    (message "%s" (state))
    (goto-next-close-parenthesis open-char close-char open-count close-count)

    ))

(defun disable-read-only-mode ()
  "shortcut to (read-only-mode -1)"
  (read-only-mode -1))

(defun enable-read-only-mode ()
  "shortcut to (read-only-mode 1)"
  (read-only-mode 1))

(defun erase-all-non-file-buffers ()
  "."
  (interactive)
  (ignore-errors
    (erase-scratch)
    (erase-messages)
    (mapcar #'erase-buffer-by-name (buffer-list-builtin-only))))

(defun erase-buffer-by-name (buffer-name)
  "."
  (let ((buffer-to-erase (get-buffer  buffer-name)))
    (if (bufferp buffer-to-erase)
        (with-current-buffer buffer-to-erase
          (let ((buffer-was-read-only (when (and (numberp buffer-read-only)
                                                 (< buffer-read-only 0)))))
          (read-only-mode -1)
          (widen)
          (erase-buffer)
          (if buffer-was-read-only
              (read-only-mode 1)))
            ) ;; end inner let
          ) ;;end if
    ) ;; end outer let
  )

(defun erase-messages ()
  "."
  (interactive)
  (erase-buffer-by-name  "*Messages*"))

(defun erase-c-messages ()
  "."
  (interactive)
  (erase-buffer-by-name  "*C-Messages*"))

(defun erase-scratch ()
  "."
  (interactive)
  (erase-buffer-by-name  "*Scratch*"))

(defun git-add ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git add -f %s" (expand-file-name (buffer-file-name)))))

(defun git-restore-staged ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git restore --staged %s"
           (expand-file-name (buffer-file-name))))
  (shell-command-to-string
   (format "git restore %s" (expand-file-name (buffer-file-name))))
  (revert-buffer t t t))

(defun create-fresh-buffer (new-buffer-name &optional inhibit-buffer-hooks)
  (let ((existing-buffer (get-buffer new-buffer-name)))
    (when (not (null existing-buffer))
      (kill-buffer existing-buffer)))
  (get-buffer-create new-buffer-name inhibit-buffer-hooks))

(defun prettierjs ()
  "."
  (interactive)
  (erase-messages)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-buffer-name (format "*prettierjs:%s*" current-filename))
         (tmp-buffer (create-fresh-buffer tmp-buffer-name))
         (exit-code
          (call-process "prettier"
                        nil
                        tmp-buffer
                        nil "-w" current-filename )))
    (message
     (format "prettier -w %s exitted with code: %s" current-filename exit-code))

    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)
         (ignore-errors (kill-buffer tmp-buffer))))
     (let* ((error-string (with-current-buffer tmp-buffer
			    (widen)
			    (goto-char (point-min))
			    (buffer-substring-no-properties (point-min) (point-max))
			    ))
            (error-details
             (with-current-buffer tmp-buffer
               (widen)
               (goto-char (point-min))
               (let ((regex-point-beg (point))
                     (regex-point-end
                      (save-excursion (end-of-line) (point))))
                 ;;^ ;; [error] index.ts: SyntaxError: Function type notation must be parenthesized when used in a union type. (96:46)
                 ;;  ;; [error] utils.ts: SyntaxError: Expression expected. (183:21)
                 (goto-char (point-min))

                 (if (re-search-forward
                      "^\\s-*[[]\\([^]]+\\)[]]\\s-*\\([^:]+\\):\\s-*\\([^:]+\\)[:]\\s-*\\([^(]+\\)\\s-+[(]\\([1-9][0-9]*\\):\\([1-9][0-9]*\\)[)]"
                      regex-point-end
                      t 1)
                     (let ((message-type (match-string 1))
                           (error-filename (match-string 2))
                           (error-type (match-string 3))

                           (error-message (match-string 4))
                           (error-lineno
                            (string-to-number (match-string 5)))
                           (error-column
                            (string-to-number (match-string 6))))
                       (list
                        message-type
                        error-filename
                        error-type
                        error-message
                        error-lineno
                        error-column
                        )
                       )
                   )
                 )
               )
             ))
       (ignore-errors (kill-buffer tmp-buffer))
       (if (listp error-details)
           (let* (
                  (message-type (nth 0 error-details))
                  (error-filename (nth 1 error-details))
                  (error-type (nth 2 error-details))
                  (error-message (nth 3 error-details))
                  (error-lineno (nth 4 error-details))
                  (error-column (nth 5 error-details))
                  )
             (goto-line error-lineno)
             (goto-char (+ (point) error-column))
             (message
              "%s in %s line %d column %d => %s: %s"
              (propertize (format "%s" message-type) 'face
                          (list :background "#3d3d3d"
                                :foreground "#FF3232"))

              error-filename
              error-lineno
              error-column
              (propertize (format "%s" error-type) 'face
                          (list :background "#3d3d3d"
                                :foreground "#FF3232"))
              (propertize (format "%s" error-message) 'face
                          (list :background "#FF3232"
                                :foreground "#3d3d3d"))

              ))
         ;; else
         (pop-to-buffer-same-window tmp-buffer)
         (user-error
          (format "prettier -w %s failed with code: %s"
                  (abbreviate-file-name current-filename)
                  exit-code)))
       ))
    ))

(defun shfmt-break-onliner-region (beg end)
  "."
  (interactive "*r")
  (let ((break-up-oneliner-regex
         "\\([;]\\s-\\|\\bdo\\b\\|\\bthen\\b\\|\\bthen\\b\\|\\belse\\b\\|\\bfi\\b\\|\\besac\\b\\|[;][;]\\)"))
    (save-mark-and-excursion
      (goto-char beg)
      (replace-regexp break-up-oneliner-regex "\n\\1\n" nil
                      (point-min)
                      (point-max)))))

(defun shfmt ()
  ".
;; https://github.com/mvdan/sh
;; go install mvdan.cc/sh/v3/cmd/shfmt@latest

shfmt -bn -ci -i 4 -ln=bash -w %s
"
  (interactive)
  ;; (shfmt-break-onliner)
  (let* ((current-shell-buffer (current-buffer))
         (current-filename (expand-file-name (buffer-file-name)))
         (tmp-buffer-name (format "*shfmt:%s*" current-filename))
         (tmp-buffer
          (progn
            (ignore-errors (kill-buffer tmp-buffer-name))
            (get-buffer-create tmp-buffer-name)))
         (exit-code
          (call-process "shfmt"
                        nil
                        tmp-buffer
                        nil "-bn" "-ci" "-i" "4" "-ln=bash" "-w" current-filename )))
    (message
     (format "shfmt -bn -ci -i 4 -ln=bash -w %s exitted with code: %s" current-filename exit-code))
    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)
         (ignore-errors (kill-buffer tmp-buffer))))
     (progn
       (let ((result
              ;; t
	      (with-current-buffer tmp-buffer
	        (widen)

                (goto-char (point-min))
	        (re-search-forward
                 "^\\([^:]+\\)[:]\\([0-9]+\\)[:]\\([0-9]+\\)[:]\s-*\\(.+\\)$"
                 ;; "^\s-*\\([^:]+\\):\\([0-9]+\\):\\([0-9]+\\)\s-*\\(.+\\)$"
                 (point-max)
                 t)
	        (let* ((error-filename (match-string 1))
	               (error-lineno (match-string 2))
	               (error-column (match-string 3))
	               (error-message (match-string 4))
	               (result-list
                        (list error-filename error-lineno error-column error-message)))
                  result-list))

              ))
         (if (listp result)
             (let ((error-filename (nth 0 result))
                   (error-lineno (string-to-number (nth 1 result)))
                   (error-column (string-to-number (nth 2 result)))
                   (error-message (nth 3 result)))
	       (goto-line error-lineno current-shell-buffer)
	       (beginning-of-line)
               (let ((error-point (+ (point) (- error-column 1)))
                     (eol
                      (save-mark-and-excursion
                        (end-of-line 1)
                        (point))))
                 (goto-char error-point)
                 (push-mark error-point t t)
                 ;; (goto-char eol)
                 )
	       (message
                (format "line %d: %s" error-lineno
			(propertize error-message 'face
                                    (list :foreground "#F13976"))))
               (kill-buffer tmp-buffer))
	   (switch-to-buffer tmp-buffer t t)
	   (user-error
            (format "shfmt -bn -ci -i 4 -ln=bash -w %s failed with code: %s"
                    (abbreviate-file-name current-filename)
                    exit-code))))))))

(defun elfmt ()
  "."
  (interactive)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-buffer-name (format "*elfmt:%s*" current-filename))
         (tmp-buffer (get-buffer-create tmp-buffer-name))
         (exit-code
          (call-process "elfmt" nil tmp-buffer nil current-filename )))
    (message
     (format "elfmt %s exitted with code: %s" current-filename exit-code))
    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)))
     (progn
       (user-error
        (format "elfmt %s failed with code: %s"
                (abbreviate-file-name current-filename)
                exit-code))))))

(defun g/format/prettify ()
  (interactive "*")
  (ignore-errors (erase-messages))
  (cond
   ((string= "rust-mode" (Ox33b4O/$/mode-name))
    (rustfmt))
   ((string= "lua-mode" (Ox33b4O/$/mode-name))
    (stylua))
   ((string= "typescript-mode" (Ox33b4O/$/mode-name))
    (prettierjs))
   ((string= "shell-script-mode" (Ox33b4O/$/mode-name))
    (shfmt))
   ((string= "sh-mode" (Ox33b4O/$/mode-name))
    (shfmt))
   ((string= "javacript-mode" (Ox33b4O/$/mode-name))
    (prettierjs))
   ((string= "elisp-mode" (Ox33b4O/$/mode-name))
    (elfmt))
   ((nil t))))

(defun git-restore ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git restore %s" (expand-file-name (buffer-file-name))))
  (revert-buffer t t t))

(defun buffer-list-builtin-only ()
  "returns all open emacs-only buffers, i.e: starting and ending in `*'."
  (seq-filter
   (apply-partially #'string-match-p "^[*].*[*]$")
   (mapcar 'buffer-name (buffer-list))))

(defun only-builtin-buffers-open-p ()
  "returns `t' if all open buffers are only emacs buffers as determined by `buffer-list-builtin-only'"
  (=
   (length (buffer-list))
   (length (buffer-list-builtin-only))))

(defun buffer-list-existing-files-only ()
  "returns all open emacs buffers which point at actually existing files."
  (seq-filter
   #'(lambda (buf)
       (and
        (not (null (buffer-file-name buf)))
        (file-exists-p (buffer-file-name buf))))
   (buffer-list)))

;; (defun ask-whether-to-kill-emacs (&optional predicate)
;;     (interactive)
;;   (when (only-builtin-buffers-open-p)
;;     (y-or-n-p "exit emacs?")))
;;
;; (setq confirm-kill-emacs 'ask-whether-to-kill-emacs)
(setq confirm-kill-emacs nil)

;; TODO: build rust refactoring tool using `minibuffer-lazy-highlight-setup' to find callers of functions, structs etc

(defun buffer-names-in-current-frame ()
  "."
  (let ((buffer-names (list)))
    (walk-windows
     (lambda (window)
       (with-window-non-dedicated window
         (setq buffer-names
	       (append buffer-names
		       (list (format "%s" (buffer-name))))))))
    (delete-dups buffer-names)))

(defun eval-messages ()
  "setup windows for elisp evaluation/testing in the current frame."
  (interactive)
  (scratch-buffer)
  (let* ((windows
          (let ((windows 0))
            (progn
	      (walk-windows
	       (lambda (window) (setq windows (1+ windows))))
	      windows)))
         (right (split-window-right))
         (current (frame-first-window)))
    (while (> (get-window-count) 1) (delete-window))
    (set-window-buffer right "*Messages*")
    (set-window-buffer current "*scratch*")
    (erase-messages)
    (with-current-buffer "*scratch*"
      (read-only-mode -1)
      (widen)
      (replace-region-contents
       (point-min)
       (point-max)
       (lambda () "(erase-messages)\n\n (message\n (format \"%s\"\n\n))"))
      (goto-char (point-min))
      (forward-word 5)
      (end-of-line 1)
      (forward-char 1)
      (indent-for-tab-command))))

;; (defadvice find-file (before existing-file activate compile)
;;   "when interactive, try to auto-complete to existing file first."
;;   (interactive
;;    (list
;;     (find-file-read-args "Find file: "
;;                          (read-buffer "Find file: "
;;                                       (existing-file-current-buffer)
;;                                       (null current-prefix-arg))))))

;; (defun existing-file-current-buffer ()
;;   (let* ((path (confirm-nonexistent-file-or-buffer)))
;;     (message  "confirm-nonexistent-file-or-buffer: %s" path)
;;     ;;(abbreviate-file-name (expand-file-name (buffer-file-name)))
;;     path
;;     ))

(defun rust-get-item ()
  (interactive)
  (erase-messages)
  (save-mark-and-excursion
    (beginning-of-line 1)
    (re-search-forward
     "^\\(\\s-*\\(pub -*\\(([^)]+)\\)?\\)?\\(struct\\|enum\\|fn\\) -*\\([a-zA-Z_][a-zA-Z0-9_]*\\)\\( -*\\|w+\\|[^({]\\|\n\\)+?[{(]\\([^)}]\\|\n\\)+?[)}]\\( -*\\|\n\\|[^{]\\)+?[{]\\([^}]\\|\n\\)+?[}]\\)")
    (let* ((item (match-string 0))
           (vis (match-string 1))
           (type (match-string 2))
           (name (match-string 3)))
      (message
       (format "rust-get-item `%s %s %s': %s" vis type name item)))))

(defun format-peg-once (column)
  (or
   (when (not (integerp column))
     (user-error (format "column is not a number: %S" column)))
   (beginning-of-line 1)
   (re-search-forward "=")
   (goto-char (match-beginning 1))
   (backward-char)
   (insert-char-until-column column)
   (re-search-forward
    "=\\(\\s-*?\\)\\([ @_$][{]\\)"
    (replace-match "= \\2"))
   (forward-line)))

(defun insert-char-until-column (char column)
  "."
  (interactive
   (let* ((char (read-string "character (s) to insert: "))
          (column (read-number "column number")))
     (list char column)))
  (while (> column (current-column)) (insert char)))

(defun insert-space-until-column (column)
  "."
  (interactive
   (let* ((column (read-number "insert space until column number: ")))
     (list column)))
  (while (> column (current-column)) (insert " ")))

(defun format-peg (column)
  (interactive
   (let* ((column (read-number "insert space until column number: ")))
     '(column)))
  (widen)
  (beginning-of-buffer)
  (while (> (point-max) (point))
    (format-peg-once column)))

(defun c$dg$ (&rest substrate)
  (interactive)
  (progn
    (colorize-hexadecimal-text)
    (Ox33b4O/$/paint-mode-line)
    (disable-auto-save-list)
    (disable-bars)
    ($$$$$)))

(defun enable-debug-on-error ()
  (interactive)
  (ignore-errors (kill-buffer "*Backtrace*"))
  (ignore-errors (erase-messages))
  (setq debug-on-error t))
(defun disable-debug-on-error ()
  (interactive)
  (ignore-errors (erase-messages))
  (setq debug-on-error nil))

(defun replace-regexp-within-bounds (regexp replacement &optional beg end)
  "."
  ;; (if (or (null beg) (null end))
  ;;     (user-error "regexp=%S\nreplacement=%S\nbeg=%S\nend=%S" regexp replacement beg end))
  (let* ((beg (or beg (point-min)))
         (end (or end (point-max))))

    ;; goto beginning of buffer
    (goto-char beg)

    ;; search exactly 1 occurrence until the `end' without causing
    ;; errors `t', saving (point) of last ocurrence in `current-match'.
    (let* ((current-match (re-search-forward regexp end t 1))
           (last-match
            (if (null current-match)
                (user-error
                 (format "failed to search regexp `%s'" regexp))
              (match-beginning 0))))

      (while (and
	      (not (null current-match)) ;; stop iteration when last re-search-forward returns nil
	      (not (null last-match))

	      (< last-match current-match)
	      (< (point) end)
	      (not (null (match-beginning 1))))

	(setq current-match (re-search-forward regexp end t 1))
	(if (not (null (match-beginning 1)))
            (goto-char (match-beginning 1)))
	(replace-match replacement)
	(if (not (null (match-end 1)))
            (goto-char (match-end 1)))
	(end-of-line 0)
	(if (not (null (match-end 2)))
            (goto-char (match-end 2)))
	;; (sleep-for 0.1)
	(re-search-forward regexp end t)
	(setq last-match (match-beginning 0))
	(if (not (null (match-beginning 0)))
            (goto-char (match-beginning 0)))
	(backward-word 1)
	(setq current-match (match-end 1))
	(if (>
             (length (string-trim (match-string-no-properties 1)))
             0)
            (message
             (format "replaced %s in line %s col %s"
                     (match-string-no-properties 0)
                     (line-number-at-pos (match-beginning 1))
                     (column-at-pos (match-beginning 1)))))

	))))

(defun shift-right-tabbed-table-string (s)
  "S."
  (replace-regexp-in-string
   "\t\\([A-Za-z0-9]+\\)\t"
   "    @\\1                @" s))

(defun shift-right-tabbed-table-lines-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents beg end
			       #'(lambda ()
                                   (shift-right-tabbed-table-string region))))))

(defun undefun (symbol-name-param)
  (if (nil (symbolp symbol-name-param))
      (user-error
       (format "undefun: param '%S' is not a symbol-name-param" symbol-name-param))

    (progn
      (progn (fmakunbound symbol-name-param))
      (progn (unintern symbol-name-param obarray))
      (progn (unintern symbol-name-param obarray-cache)))))

(defun decimal-to-hexadecimal-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (re-search-forward "\\([0-9]+\\)" nil t 1)
    (replace-match
     (format "0x%x" (string-to-number (match-string 0)))
     t)))

(defun decimal-to-char-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (re-search-forward "\\([0-9]+\\)" nil t 1)
    (replace-match
     (format "%s"
             (char-to-string (string-to-number (match-string 0))))
     t)))

(defun shell-script-fix-variables-region (beg end)
  "."
  (interactive "*r")
  (let* ((regexp "[$]\\([a-zA-Z0-9_][a-zA-Z0-9_]*\\)")
         (replacement "${\\1}"))
    (save-mark-and-excursion
      (replace-regexp-within-bounds regexp replacement beg end))))

;;;;;;;
;; WIP
(defun shell-script-fix-variable-assignments-region (beg end) ;; WIP
  "."
  ;; WIP
  (interactive "*r")
  (let* ((regexp
          "^\\(\\s-*\\)\\([a-z0-9_]+\\)=\\([$][(].*[)]\\|[$][{][a-z_][a-z0-9_]+[^}]*[}]\\);?\\s-*$")
         (replacement "\1\2=\"\3\""))
    (save-mark-and-excursion
      (replace-regexp-within-bounds regexp replacement beg end))))
;; WIP
;;;;;;;

(defun shell-script-fix-variables-buffer ()
  (interactive)
  (let* ((beg (point-min))
         (end (point-max))
         (regexp "[$]\\([a-zA-Z0-9_][a-zA-Z0-9_]*\\)")
         (replacement "${\\1}"))
    (if mark-active
        (user-error "mark is active, use shell-script-fix-variables-region instead.")
      (save-excursion
        (widen)
        (replace-regexp-within-bounds regexp replacement beg end)))))
(setq debug-on-error nil)

(defun find-file-if-exists (file-path)
  "."
  (if (file-exists-p file-path)
      (find-file file-path)
    (user-error (format "file does not exist: %s" file-path))))

(defun wip ()
  "."
  (interactive)
  (find-file-if-exists "~/projects/work/poems.codes/poc/wip.rst"))

(defun ps1 ()
  "."
  (interactive)
  (find-file-if-exists "~/.config/ps1.toml"))

(defun reload () "." (interactive) (revert-buffer nil t))

(defun get-directory-path-mkdir (abbrev-path)
  "."
  (let ((location (expand-file-name abbrev-path)))
    (when (not (file-exists-p location))
      (progn (mkdir location t)))
    location))

(defun current-notes-location ()
  "."
  (or (when (runtime-is-linux)
        (get-directory-path-mkdir "~/notes"))
      (get-directory-path-mkdir "~/projects/notes")))

(defun current-wip-location ()
  "."
  (or (when (runtime-is-linux)
        (get-directory-path-mkdir "~/notes/wip/emacs"))
      (get-directory-path-mkdir "~/projects/notes/wip/emacs")))


(defun open-note (note-name)
  (let* ((name (file-name-base note-name))
         (old-notes-location "~/projects/work/poems.codes/poc")

         (old-path
          (format "~/projects/work/poems.codes/poc/%s.rst" name))
         (note-path (format "%s/%s.rst" (current-notes-location) name)))

    (message
     (format "note-name: %s"
             (propertize note-name 'face (list :foreground "#FC0"))))
    (message
     (format "name: %s"
             (propertize name 'face (list :foreground "#0F0"))))
    (message
     (format "old-path: %s"
             (propertize old-path 'face (list :foreground "#0FF"))))
    (message
     (format "note-path: %s"
             (propertize note-path 'face (list :foreground "#F0F"))))
    (when (file-exists-p old-path)
      (if (not (file-exists-p note-path))
          ;; rename file if note-path does not exist
          (progn
            ;; (copy-file old-path note-path t t t t)
            (rename-file old-path note-path t)
            (message  "renamed %s -> %s" old-path note-path))
        ;; rename file to name with timestamp if note-path exists
        (progn
          (let ((stamped-note-path
                 (format "%s/%s%s.rst"
                         (current-notes-location)
                         name
                         (format-time-string "%Y-%m-%dT%H%M%S"))))
            ;; (copy-file old-path stamped-note-path t t t t)
            (rename-file old-path stamped-note-path t)
            (message
             (format "renamed %s -> %s" old-path stamped-note-path))))))
    (find-file note-path)))

(defun insert-timestamp-for-mode (timestamp-to-insert)
  "."
  (if (not (stringp timestamp))
      (user-error
       (format "format-timestamp-for-mode received non-string argument %S" timestamp))
    (let ((text-to-insert (format "%s " timestamp-to-insert)))
      (or
       (when (or
              (string= "rest-mode" (Ox33b4O/$/mode-name))
              (string= "markdown-mode" (Ox33b4O/$/mode-name)))
         (setq text-to-insert
               (format "- at %s:\n  - Journal entry ..." timestamp-to-insert))
         (newline)
         (beginning-of-line 0)))
      (insert text-to-insert))))

(defun insert-timestamp ()
  "."
  (interactive "*")
  (insert-timestamp-for-mode
   (format-time-string "%Y-%m-%dT%H:%M:%S%Z")))

(defun insert-date ()
  "."
  (interactive)
  (insert-timestamp-for-mode (format-time-string "%Y-%m-%d")))

(defun insert-time ()
  "."
  (interactive)
  (insert-timestamp-for-mode (format-time-string "%H:%M:%S")))

(defun wip () "." (interactive) (open-note "wip.rst"))

(defun note ()
  "."
  (interactive)
  (let* ((file-compatible-timestamp
          (format-time-string "%Y-%m-%d-at-%H-%M-%S-%p-%Z"))
         (title
          (format "%s"
                  (format-time-string "Note %Y-%m-%dT at %H:%M%p %Z")))
         (timestamp (format-time-string "%Y-%m-%dT%H:%M:%S%Z"))
         (name
          (read-string "New Note Name: "
                       (format "note-%s.rst" file-compatible-timestamp)
                       t))
         (note-path
          (format "%s/%s%s.rst"
                  (current-notes-location)
                  name
                  file-compatible-timestamp))
         (rst-note-file-header
          (format "%s\n%s\n\n\n" title
                  (replace-regexp-in-string "." "~" title)))
         (note-buffer
          (progn
	    (find-file note-path)
	    (find-buffer-visiting note-path nil))))
    (switch-to-buffer note-buffer)
    (insert rst-note-file-header)
    (write-file note-path nil)
    (git-add)
    (insert-timestamp)))

(defun todo ()
  "."
  (interactive)
  (open-note "~/projects/notes/todo.rst"))

(defun backlog ()
  "."
  (interactive)
  (open-note "~/projects/notes/backlog.rst"))

(defun now-file-safe ()
  "."
  (let ((ts (format-time-string "%Y-%m-%dT%H-%M-%S%z")))
    (when (called-interactively-p interactive) (insert ts))
    ts))

(defun context-switch-note ()
  "."
  (interactive)
  (open-note (format "~/todo/%s.rst" (now-file-safe))))

(defun notes ()
  "."
  (interactive)
  (open-note "~/projects/notes/notes.rst"))

(defun regex-ansi-underline-to-spaced (string)
  "STRING."
  (replace-regexp-in-string
   "^\\(\\s-+\\)\\(bar_text_left\\s-+\\)\\([0-9]+\\)\\s-+\\([0-9]+\\)\\(\\s-*.*\\)[$](ansi_underline\\s-+\\(\"[^\"]+\"\\))"
   "\\1\\2 \\3 \\4\\5$(ansi_spaced \\4 \\3 \\6)"string))

(defun ansi-underline-to-spaced-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents
       beg end
       #'(lambda () (regex-ansi-underline-to-spaced region))))))

(defun shebang () "." (interactive) (insert-shebang "shebang.sh"))

(defun shebang-full ()
  "."
  (interactive)
  (insert-shebang "shebang-full.sh"))

(defun shebang-root ()
  "."
  (interactive)
  (insert-shebang "shebang-root.sh"))

(defun shebang-simplest ()
  "."
  (interactive)
  (insert-shebang "shebang-simplest.sh"))

(defun insert-shebang (template-name)
  "."
  (if (not (stringp template-name))
      (user-error "template-name is not a string: %S" template-name))

  (let ((template-string
         (get-template-string-from-filename template-name))
        (buf-filename (buffer-file-name)))
    (if (or (null buf-filename) (not (file-exists-p buf-filename)))
        (user-error
         (format "save buffer `%s' to actual file before using shebang" buf-filename))
      (let ((curpoint (point)))
	(save-mark-and-excursion
	  (widen)
	  (goto-char (point-min))
	  (insert template-string)
	  (goto-char curpoint))

	(save-buffer 0)
	(chmod buf-filename (string-to-number "755" 8))
	(shfmt)))
    ))

(defun read-file-to-string (filename)
  "inserts template file at beginning of current buffer."
  (if (not (stringp filename))
      (user-error
       (format "[read-file-to-string error] arg FILENAME is not a string: %S" filename)))
  (if (not (file-exists-p filename))
      (user-error
       (format "[read-file-to-string error] FILENAME does not exist: %s" filename)))
  (if (not (file-regular-p filename))
      (user-error
       (format "[read-file-to-string error] FILENAME is not a regular file: %s" filename)))
  (if (not (file-readable-p filename))
      (user-error
       (format "[read-file-to-string error] FILENAME not readable: %s" filename)))
  (let ((file-contents-string
         (with-temp-buffer
	   (insert-file-contents filename)
	   (widen)
	   (buffer-substring-no-properties (point-min) (point-max)))))
    file-contents-string))

(defun insert-template (name)
  "inserts template file at beginning of current buffer."
  (insert (get-template-string-from-filename name)))

(defun get-template-string-from-filename (name)
  "inserts template file at beginning of current buffer."
  (if (not (stringp name))
      (user-error
       (format "insert-template: arg NAME is not a string: %S" name)))

  (let ((template-path
         (file-name-concat
          (expand-file-name "~/.emacs.d/c/templates")
          name)))
    (if (not (file-exists-p template-path))
        (user-error
         (format "insert-template: file does not exist: %s" template-path)))
    (if (not (file-readable-p template-path))
        (user-error
         (format "insert-template: file not readable: %s" template-path)))
    (let ((template-contents (read-file-to-string template-path)))
      template-contents)
    ))

(defun make-script ()
  "."
  (interactive)
  (let* ((target (expand-file-name (buffer-file-name)))
         (executable (string-to-number "755" 8)))
    (when (not (file-exists-p target)) (basic-save-buffer nil))
    (chmod target executable)

    (message
     (format
      "%s is now executable %o"
      (auto-propertize-string (abbreviate-file-name target))
      ;; (auto-propertize-string (file-name-base target))
      executable))

    ))

(defun get-auto-propertize-face-fg-and-bg-list (string &optional hash-algorithm)
  "Returns a list with `:foreground' and `:background' attributes for the
`face' property using the first 6 characters of the `secure-hash' of
the given string.

The computed `:foreground' color depends on the HASH-ALGORITHM parameter which is
forwarded as the ALGORITHM paramter of the `'secure-hash' function.

If omitted or `nil', HASH-ALGORITHM defaults to 'sha256. For a list of
acceptable algorithms check the help of `secure-hash'.

The `:background' property is computed in contrast with its
`:foreground' counterpart via `contrast-color'.
"
  (if (not (stringp string))
      (user-error "argument STRING (%S) is not a string (get-auto-propertize-face-fg-and-bg-list `%S')" string string))
  (if (and
       (not (null hash-algorithm))
       (not (symbolp hash-algorithm)))
      (user-error
       "(optional) argument HASH-ALGORITHM (%S) is not a symbol (get-auto-propertize-face-fg-and-bg-list `%S' `%S')" hash-algorithm string hash-algorithm))

  (let* ((foreground
          (format "#%s"
                  (if (not (null hash-algorithm))
                      (Ox33b4O/$/hash-take-first-n-chars hash-algorithm 6 string)
                    (Ox33b4O/$/hash-take-first-n-chars 'sha256 6 string)
                    )))
         (background (contrast-color foreground)))
    (list :foreground foreground :background background)))

(defun auto-propertize-string (string)
  "colorizes the given string."
  (if (not (stringp string))
      (user-error "%S is not a string (auto-propertize-string %S)" string string))
  (propertize
   (format "%s" string)
   'face
   (get-auto-propertize-face-fg-and-bg-list string 'sha256)))

(defun cleanup-elc ()
  "."
  (interactive)
  (let* ((tmp (get-buffer-create "*cleanup-elc*"))
         (exit-code (call-process "cleanup-elc" nil tmp))
         (stderr
          (with-current-buffer tmp
            (widen)
            (buffer-substring-no-properties (point-min) (point-max)))))
    (cond
     ((eq 0 exit-code)
      (message  "elc cleanup ok" )
      (length> stderr 0)
      (message "elc cleanup error:\n'%s'" stderr ))
     )))

(defun shell-script-expand-oneliner (beg end)
  (interactive "r")
  (replace-regexp-in-region
   "\\b\\(do\\|done\\|then\\|else\\|fi\\)\\b" "\n\\1\n" beg end))

(defun get-logwip-string ()
  "."
  (let* ((open-filenames
          (mapcar 'abbreviate-file-name
                  (mapcar 'buffer-file-name
                          (buffer-list-existing-files-only))))
         (filenames-lines
          (string-join
           (mapcar
	    #'(lambda (name) (format "%s\n" name))
            open-filenames)
           " "))
         (timestamp (format-time-string "%Y-%m-%dT%H:%M:%S%Z"))
         (header (format "Emacs WIP Buffers @ %s" timestamp))
         (header-underline (replace-regexp-in-string "." "~" header))
         (hr (replace-regexp-in-string "." "-" header))
         (lines-to-write
          (format "%s\n%s\n\n%s\n%s\n" header header-underline filenames-lines hr)))
    lines-to-write))

(defun logwip ()
  "."
  (interactive)
  (let* ((body (get-logwip-string))
         (wip-log-directory (current-wip-location))
         (wip-log-file-path
          (file-name-concat wip-log-directory
                            (format-time-string "%Y%m%dT%H%M%S%Z.rst")))
         (wip-buffer (get-buffer-create wip-log-file-path)))

    (with-current-buffer wip-buffer (insert body))
    (message
     (format "saved to %s" (abbreviate-file-name wip-log-file-path)))))

(defun file-is-git-tracked ()
  "."
  (let* ((status-output (git-rev-parse (buffer-file-name)))
         (status (car status-output))
         (output (car (cdr status-output))))
    (eq 0 status)))

(defun git-rev-parse (arg)
  "."
  (let* ((extra-args
          (if (listp arg) arg '((format "%S" arg))))
         (call-process-args
          (append
           '("git" nil git-rev-parse-output-buf nil "rev-parse")
           extra-args))
         (git-rev-parse-output-buf
          (get-buffer-create "*git-rev-parse*"))
         (exitcode (apply #'call-process call-process-args))
         (output
          (with-current-buffer git-rev-parse-output-buf
	    (widen)
	    (buffer-string))))
    (ignore-errors (kill-buffer git-rev-parse-output-buf))
    (cons exitcode output)))

(defun git-delete ()
  "."
  (let* ((git-status-output-buf
          (get-buffer-create "*git-status-porcelain*"))
         (exitcode
          (call-process
           "git" nil git-status-output-buf nil "rm" "-rf"
           (buffer-file-name)))
         (output
          (with-current-buffer git-status-output-buf
	    (widen)
	    (buffer-string))))
    (ignore-errors (kill-buffer git-status-output-buf))
    (cons exitcode output)))

(defun call-program-with-list-args (program &optional  args trim-output)
  "calls PROGRAM synchronously in separate process, returns list where HEAD is the exit-status (integer) and TAIL is
the combined stderr/stdout output (string).

If ARGS is nil program is called without arguments.
If ARGS is a list, every member should be a string.
if TRIM-OUTPUT is not nil, then the string output is trimmed of spaces with `string-trim' before returning.

This function is a shortcut to `call-process' to a temporary buffer and
can be rightfully perceived as an alternative `shell-command-to-string'
which returns the exit-status and the string output.
."
  (if (not (stringp program))
      (user-error
       (format "call-process-with-list-args: program is not a string: %S" program)))
  (if (and
       (not (null args))
       (not (listp args)))
      (user-error
       (format "call-process-with-list-args: args `%S' is not a list" args)))
  (let* ((extra-args
          (if (null args)
              (list)
	    (if (listp args)
                args
              (user-error
               (format "call-process-with-list-args: args `%S' is not a list" args)))
	    ))
         (program-to-call-output-buf
          (get-buffer-create (format "*%s*" program)))
         (call-process-args
          (append
           (list program nil program-to-call-output-buf nil )
           extra-args))
         (exitcode (apply #'call-process call-process-args))
         (output
          (with-current-buffer program-to-call-output-buf
	    (widen)
	    (buffer-string))) )
    (ignore-errors (kill-buffer program-to-call-output-buf))
    (cons exitcode
          (if (not (null trim-output)) (string-trim output) output))))

;; ;; testing call-program-with-list-args
;; (progn
;;   (erase-messages)
;;   (message  "which shprettier: %S" (call-program-with-list-args "which" '("shprettier")))
;;   (message  "hostname: %S" (call-program-with-list-args "hostname" nil t)))

(defun ack (regexp)
  "."
  ;; ack --output='$f +$. # $&' 'querySelectorAll' src/lib/dom.generated.d.ts
  (let* ((exit-status-output
          (call-program-with-list-args "ack"
                                       (list
                                        "--output='(cons $. \"$f\") ;; $&" regexp)))
         (exit-status (car exit-status-output))
         (output (car (cdr ( exit-status-output)))))
    (if (eq 0 exit-status)
        (let ((ack-buffer
               (get-buffer-create (format "ack `%s'" regexp))))
          (with-current-buffer ack-buffer (insert output))
          (switch-to-buffer ack-buffer))
      (user-error
       (format "ack `%s' failed with status %d" regexp exit-status)))))

(defun rustfmt ()
  "."
  (interactive)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-buffer-name (format "*rustfmt:%s*" current-filename))
         (tmp-buffer (get-buffer-create tmp-buffer-name))
         (exit-code
          (call-process "rustfmt" nil tmp-buffer nil current-filename )))
    (message
     (format "rustfmt %s exitted with code: %s" current-filename exit-code))
    (or
     (when (eq exit-code 0)
       (progn
         (message
	  "%s formatted with rustfmt"
          (abbreviate-file-name current-filename))
         (revert-buffer t t t))

       (progn
	 (message
          "flushing empty lines in %s"
          (abbreviate-file-name current-filename))
	 (flush-empty-lines-buffer))

       (progn
	 (message
          "adding space between items in %s"
          (abbreviate-file-name current-filename))


	 (save-mark-and-excursion
           (widen)
           (goto-char (point-min))
           ;; skip (pub )?(use|mod)
           (while (re-search-forward "^\\(pub\\s-+\\((crate\\|self\\|in\\s-+[a-z0-9:]+)\\)?\\)?\s-*\\(use\\|mod\\)\\s-+\\(.*\\)$" nil t)
             (goto-char (match-end 1))
             (end-of-line)
             )
           (while (re-search-forward "}\n\\([a-zA-Z0-9#]+\\)" nil t)
             (replace-match "}\n\n\\1")
             (goto-char (match-end 1)))
           ));;progn
       );; when success

     (progn ;; (or)  error
       (user-error
        (format "rustfmt %s failed with code: %s"
                (abbreviate-file-name current-filename)
                exit-code))))))

(defun stylua ()
  "."
  (interactive)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-buffer-name (format "*stylua:%s*" current-filename))
         (tmp-buffer (get-buffer-create tmp-buffer-name))
         (exit-code
          (call-process "stylua"
                        nil
                        tmp-buffer
                        nil "--config-path"
                        (expand-file-name "~/.config/stylua.toml")
                        current-filename )))
    (message
     (format "stylua %s exitted with code: %s" current-filename exit-code))
    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)))
     (progn
       (user-error
        (format "stylua %s failed with code: %s"
                (abbreviate-file-name current-filename)
                exit-code))))))

(defun enable-case-fold-search ()
  (interactive)
  (setq case-fold-search t))

(defun disable-case-fold-search ()
  (interactive)
  (setq case-fold-search nil))

(defun shell-wrap-variables-in-braces-region (beg end)
  "."
  (interactive "*r")
  (replace-regexp-in-region
   "[$]\b\([a-zA-Z_][a-zA-Z0-9_]+\)\b" "${\1}" beg end))

(defun shell-wrap-variables-in-braces-buffer ()
  "."
  (interactive)
  (save-excursion
    (widen)
    (shell-wrap-variables-in-braces-region (point-min) (point-max))))

(defun hex-to-decimal-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "[a-fA-F0-9]+" end t)
      (replace-match
       (format "%s" (string-to-number (match-string 0) 16))))))

(defun decimal-to-hex-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (goto-char beg)
    (while (re-search-forward "[0-9]+" end t)
      (replace-match
       (format "%x" (string-to-number (match-string 0)))))))

(defun hex-rgb-to-ansi-region (beg end)
  "BEG END."
  (interactive "*r")
  (let ((regexp-6
         "\\([A-F0-9]\\{2\\}\\|[A-F0-9]\\{4\\}\\|[A-F0-9]\\{6\\}\\)")
        (regexp-2 "[A-F0-9]\\{2\\}"))
    (save-mark-and-excursion
      (goto-char beg)
      (if (re-search-forward regexp-6 end t)
          (progn
            (goto-char (match-beginning 0))
            (while (re-search-forward regexp-2 end t)
              (goto-char (match-beginning 0))
              (replace-match
               (format
		"$(( 0x%x ));"
                (string-to-number (match-string 0) 16)))
              (setq end (point))
              (backward-word 0))
            )
	(user-error "no match for regex %S in %S" regexp-6
                    (buffer-substring-no-properties beg end)))
      )))

(defun heck-string-to-case-buffer (case beg end)
  "depends on cargo crate heck-string-cli: `cargo install heck-string-cli'
BEG END."
  (let* ((tmp-buffer-name (format "*string-to-%s*" case))
         (tmp-buffer (get-buffer-create tmp-buffer-name))
         (input-string (buffer-substring-no-properties beg end))
         (exit-code
          (call-process "heck-string" nil tmp-buffer nil
                        (format "--to=%s" case)
                        input-string)))

    (if (eq 0 exit-code)
        (let ((output
               (with-current-buffer tmp-buffer
		 (widen)
		 (string-trim (buffer-string)))))
          (kill-buffer tmp-buffer)
          (save-excursion
            (replace-region-contents beg end #'(lambda () output))))

      (kill-buffer tmp-buffer)
      (user-error
       (format "command failed with status %d: string --to=%s '%s'"  case input-string)))))

(defun string-to-train-region (beg end)
  "BEG END."
  (interactive "*r")
  (heck-string-to-case-buffer "train" beg end))

(defun string-to-title-region (beg end)
  "BEG END."
  (interactive "*r")
  (heck-string-to-case-buffer "title" beg end))

(defun string-to-kebab-region (beg end)
  "BEG END."
  (interactive "*r")
  (heck-string-to-case-buffer "kebab" beg end))

(defun string-to-snake-region (beg end)
  "BEG END."
  (interactive "*r")
  (heck-string-to-case-buffer "snake" beg end))

(defun string-to-shouty-snake-region (beg end)
  "BEG END."
  (interactive "*r")
  (heck-string-to-case-buffer "shouty-snake" beg end))

(defun string-to-shouty-kebab-region (beg end)
  "BEG END."
  (interactive "*r")
  (heck-string-to-case-buffer "shouty-kebab" beg end))

(defun string-to-pascal-region (beg end)
  "BEG END."
  (interactive "*r")
  (heck-string-to-case-buffer "pascal" beg end))

(defun string-to-lower-camel-region (beg end)
  "BEG END."
  (interactive "*r")
  (heck-string-to-case-buffer "camel" beg end))

(defun cargo-craft-get-replace-regexp-pattern-string ()
  "."
  "^\\(cargo.craft\\(\\s-+[\\]\\s-*$\\|\\s-+.*[\\]\\s-*$\\|\n+\\)+\\(\n+\\|\\s-+\\|[a-zA-Z0-9_-]+\\)\\(\\w+\\|\"[^\"]+\"\\)\\) → if 1>&2 \\1; then\necho \"cd ${name:-\\4}\"\nfi")

(defun cargo-craft-sh-replace-regexp-call-cd-stderr ()
  "."
  (interactive)
  (let ((regexp
         "^\\(cargo.craft\\(\\s-+[\\]\\s-*$\\|\\s-+.*[\\]\\s-*$\\|\n+\\)+\\(\n+\\|\\s-+\\|[a-zA-Z0-9_-]+\\)\\(\\w+\\|\"[^\"]+\"\\)\\)"))
    (save-excursion
      (widen)
      (goto-char (point-min))
      (if (re-search-forward regexp nil t 1)
          (let* ((old-call (match-string 0))
                 (crate-name (match-string 4))
                 (escaped-crate-name
                  (replace-regexp-in-string "\"" "" crate-name))
                 (new-call
                  (format
		   "if 1>&2 %s; then\necho \"cd \\\"%s\\\"\"\nfi"
                   old-call escaped-crate-name)))
            (replace-match "")
	    (insert new-call)
            (save-buffer 0)
            (shfmt))

	(user-error "no regexp match for: %S" regexp))
      ))
  ;; OzsgOzsgKGRlZnVuIGNhcmdvLWNyYWZ0LWJyZWFrLW9uZWxpbmVyLWNhbGwoKQo7OyA7OyAgICIuIgo7OyA7OyAgIChpbnRlcmFjdGl2ZSkKOzsgOzsgICA7OyBjYXJnbyBjcmFmdCAtY3NtIC1DIGJvb2xlYW4gLUMgbnVtYmVyIC1DIGRhdGV0aW1lIC1DIGpzb24gLUMgeWFtbCAtQyB0b21sIC1DIGluaSAtQyBkYXRlIC1DIHRpbWUgLWQgJ2Nocm9ubyAtRiBjbG9jaycgaXMKOzsKOzsgOzsgICAobGV0ICgocmVnZXhwICJeXFwoY2FyZ29cXChccy0rXHxbLV1cXCljcmFmdFxcKVxcKFxccy0rWy1dW2Etel0rXFx8XFxzLStbLV1bQ11ccy0rW2Etel1bYS16MC05Xy1dK1xcfFxccy0rWy1dW2RdXFxzLStcXCgnW14nXSsnXFx8W2EtekEtWl1bYS16QS1aMC05Xy1dK1xcKVxccy0rXFwoW2EtekEtWl1bYS16QS1aMC05Xy1dK1xcKVxcKSIpKQo7OyA7OyAgICAgKHNhdmUtZXhjdXJzaW9uCjs7IDs7ICAgICAgICh3aWRlbikKOzsgOzsgICAgICAgKGdvdG8tY2hhciAocG9pbnQtbWluKSkKOzsgOzsgICAgICAgKGlmIChyZS1zZWFyY2gtZm9yd2FyZCByZWdleHAgbmlsIHQgMSkKOzsgOzsgICAgICAgICAgIChyZXBsYWNlLW1hdGNoICJcXDEgXFxcblxcMyIpCjs7Cjs7Cjs7IDs7IAkodXNlci1lcnJvciAibm8gcmVnZXhwIG1hdGNoIGZvcjogJVMiIHJlZ2V4cCkKOzsgOzsgCSkKOzsgOzsgICAgICAgKSkKOzsgOzsgICApCjs7ICh1bmRlZnVuICdjYXJnby1jcmFmdC1icmVhay1vbmVsaW5lci1jYWxsKQo=
  )

(defun css-selector-fix-regex-region (beg end)
  "."
  (interactive "*r")
  (save-mark-and-excursion
    (goto-char beg)
    (let ((regexp
           "\"\\([[]\\([a-z0-9A-Z_-]+\\)\\([*^|$~]?=\\)\\([^]\"]+\\)[]]\\)\""))
      (while (re-search-forward regexp end t)
        (replace-match "`\\1`,\n`[\\2\\3'\\4']`,\n`[\\2\\3\"\\4\"]`") ;; works
        ;; (replace-match "\\1,\n\"[\\2\\3'\\4']\",\n\"[\\2\\3\\\"\\4\\\"]\"")
        ;; (replace-match "\\1,\n\"[\\2\\3'\\4']\"") ;; works
        ))
    ))

(defun regexp-adoc-to-markdown ()
  "."
  (let* ((regexp
          "^\([+]\([^+]+\)[+]::\s-+\(.+\($\|
\|\s-*\|.*\)\)\)")
         (replacement "# `\2`
# \3
### \1"))))

(defun insert-regexp-linebreak-tabs-and-spaces ()
  (interactive)
  ;; (let ((space-chars-list (list "\n" "\t" "\x0a" "\x20" "\x09")))
  (let ((space-chars-list (list "\a" "\b"
			        ;; "\n"
			        "\t"
			        "\v"
			        "\f"
			        "\r")))
    (insert (format "\\(%s\\)" (string-join space-chars-list "\\|" )))))

(defun insert-control-character-tab () (interactive) (insert "\t"))

(defun insert-control-character-newline ()
  (interactive)
  (insert "\n"))

(defun insert-control-character-line-tabulation ()
  (interactive)
  (insert "\b"))

(defun insert-control-character-carriage-return ()
  (interactive)
  (insert "\r"))

(defun regexp-adoc-strip-all-but-spaces ()
  (let ((regexp
         "\\([a-zA-Z0-9+=(.|*){@}%,:<>\"'`_-]+\\|[[]\\|[]]\\)+"))))

(defun elisp-escape-regexp-with-double-slashes-in-region (beg end)
  (interactive "*r")
  (if (or
       (not (string= "emacs-lisp-mode" (Ox33b4O/$/mode-name)))
       (not (string= "elisp-mode" (Ox33b4O/$/mode-name))))

      (user-error "this function requires emacs-lisp-mode"))
  (let ((regexp "\\\\\\([^\"]\\)")
        (replacement "\\\\\1"))
    (save-mark-and-excursion
      (goto-char beg)
      (while (re-search-forward regexp end t)
	(replace-match replacement)))
    ;; (replace-match "\\1,\n\"[\\2\\3'\\4']\",\n\"[\\2\\3\\\"\\4\\\"]\"")
    ;; (replace-match "\\1,\n\"[\\2\\3'\\4']\"") ;; works
    ))

(defun disable-delete-trailing-space ()
  (interactive)
  (setq delete-trailing-lines nil)
  (electric-indent-mode -1)
  (electric-indent-local-mode -1))

(defun enable-electric-indent-mode ()
  (interactive)
  (electric-indent-mode 1))

(defun today (&optional utc)
  (interactive)
  (insert
   (format-time-string "%Y-%m-%d" nil (if (not (null utc)) 0 nil))))

(defun now (&optional utc)
  (interactive)
  (insert
   (format-time-string "%Y-%m-%d %H:%M:%S%z"
                       nil
                       (if (not (null utc)) 0 nil))))

(defun delete-prefix-and-timestamp-from-bash-history-region (beg end)
  (interactive "*r")
  (let ((regexp "^\\s-+[0-9]+\\s-+[[][^]]+[]]\\s-+")
        (next-pos beg))
    ;; (replace-regexp-in-region regexp "" beg end)
    (save-mark-and-excursion

      (while (re-search-forward regexp end t)
	(setq next-pos (match-end 0))
	(replace-match "")
	(goto-char next-pos)

	))))

(defun delete-prefix-and-timestamp-from-bash-history-buffer ()
  (interactive)
  (save-mark-and-excursion
    (widen)
    (let ((beg (point-min))
          (end (point-max)))
      (goto-char beg)
      (delete-prefix-and-timestamp-from-bash-history-region beg end))))

(defun rust-format!-static-str-to-to-string-region (beg end)
  "replaces occurrences of `format!(\"static string\")' with `\"static string\".to_string ()' in region
.
"
  (interactive "*r")
  (when (not (numberp beg))
    (user-error "argument BEG is not a number: %S" beg))
  (when (not (numberp end))
    (user-error "argument END is not a number: %S" end))

  (let ((regexp "format!(\\(\"\\([^{}\"]+\\)\"\\))")
        (replacement "\1.to_string ()")
        (initial-position
         (if (> beg 0) (- beg 1) (beg))))
    (save-mark-and-excursion
      (replace-regexp-in-region regexp replacement beg end))))

(defun rust-format!-static-str-to-to-string-buffer ()
  "like `rust-format!-static-str-to-to-string-region' but for entire buffer.
"
  (interactive)
  (save-mark-and-excursion
    (widen)
    (rust-format!-static-str-to-to-string-region
     (point-min)
     (point-max))))

(defvar replace-regexp-all-buffer-replacement-history
  (list))

(defun replace-regexp-all-buffer()
  "like `replace-regexp' but replaces all ocurrences of regex in
the entire buffer without unmarking active regions or losing
cursor position in buffer."
  (interactive)
  (let* ((regexp (read-regexp "replace all regexp in all buffer: "))
         (replacement (read-string "replacement: " nil replace-regexp-all-buffer-replacement-history replace-regexp-all-buffer-replacement-history)))

    (save-mark-and-excursion
      (widen)
      (beginning-of-buffer);;(goto-char (point-min))
      (while (re-search-forward regexp nil t)
        (replace-match replacement)
        (goto-char (match-end 0))
        ) ;;while
      ) ;;save-mark-and-excursion
    ) ;;let
  );;defun

(defun tmpwindow()
  "creates a new tmp buffer with the same mode as the current buffer, then creates a new emacs `frame' (which in terms of OS usually actually means `window') with that tmp buffer.
"
  (interactive)
  (let* ((frame-params '((minibuffer . t)
                         (ns-appearance . dark)
                         (ns-transparent-titlebar . t)
			 (border-color . "#FFFFFF")
                         (cursor-color . "#44FF88")
			 (foreground-color . "#FFFFFF")
                         (background-color . "#000000")
			 (vertical-scroll-bars)))
         (current-mode-name (format "%s" mode-name))
         (current-mode-symbol (intern-soft current-mode-name))
         (tmp-buffer-name (format "tmp-buffer-%s" current-mode-name))
         (tmp-buffer (create-fresh-buffer tmp-buffer-name))
         (tmp-frame (make-frame-on-current-monitor frame-params)) ;; (tmp-frame (make-frame-command)))
         (tmp-frame-type (framep tmp-frame))
         (tmp-frame-is-live (frame-live-p tmp-frame))
         )
    (setq major-mode current-mode-symbol)
    (set-buffer-major-mode tmp-buffer)
    (select-frame-set-input-focus tmp-frame nil)
    (pop-to-buffer-same-window tmp-buffer nil)
    ))

;; 1. set mode in tmp-buffer to current-mode-name
;; 2. open new frame and window with tmp-buffer
;; 3. pop to window/tmp-buffer))
;; (ignore-errors (cleanup-elc))
(setq
 ;; resize-mini-windows is a variable defined in ‘C source code’.
 ;;
 ;; Its value is ‘grow-only’
 ;;
 ;; How to resize mini-windows (the minibuffer and the echo area).
 ;; A value of nil means don’t automatically resize mini-windows.
 ;; A value of t means resize them to fit the text displayed in them.
 ;; A value of ‘grow-only’, the default, means let mini-windows grow only;
 ;; they return to their normal size when the minibuffer is closed, or the
 ;; echo area becomes empty.
 ;;
 ;; This variable does not affect resizing of the minibuffer window of
 ;; minibuffer-only frames.  These are handled by ‘resize-mini-frames’
 ;; only.

 resize-mini-windows t)



(defun string-to-secure-hash-region (algorithm beg end)
  "replaces string in given region with `secure-hash' of region contents."
  (if (not (symbolp algorithm))
      (user-error "(string-to-secure-hash-region) argument ALGORITHM is not a symbol: %S" algorithm))
  (if (not (numberp beg))
      (user-error "(string-to-secure-hash-region) argument BEG is not a number: %S" beg))
  (if (not (numberp end))
      (user-error "(string-to-secure-hash-region) argument END is not a number: %S" end))

  (save-mark-and-excursion
    (let* ((contents (buffer-substring-no-properties beg end))
           (checksum (secure-hash algorithm contents)))
      (replace-region-contents beg end #'(lambda () checksum)))))

(defun string-to-sha1-region (beg end)
  "replaces the string in region with the sha1 checksum of its contents"
  (interactive "*r")
  (string-to-secure-hash-region 'sha1 beg end))

(defun string-to-sha224-region (beg end)
  "replaces the string in region with the sha224 checksum of its contents"
  (interactive "*r")
  (string-to-secure-hash-region 'sha224 beg end))

(defun string-to-sha384-region (beg end)
  "replaces the string in region with the sha384 checksum of its contents"
  (interactive "*r")
  (string-to-secure-hash-region 'sha384 beg end))

(defun string-to-sha256-region (beg end)
  "replaces the string in region with the sha256 checksum of its contents"
  (interactive "*r")
  (string-to-secure-hash-region 'sha256 beg end))

(defun string-to-sha512-region (beg end)
  "replaces the string in region with the sha512 checksum of its contents"
  (interactive "*r")
  (string-to-secure-hash-region 'sha512 beg end))

(defun string-to-md5-region (beg end)
  "replaces the string in region with the md5 checksum of its contents"
  (interactive "*r")
  (string-to-secure-hash-region 'md5 beg end))

(defun write-to-minibuffer (text)
  "writes to minibuffer"
  (let ((output (or (when (stringp text)
        text)
      (format "%S" text))))
  (ignore-errors
    (with-current-buffer (window-buffer (minibuffer-window))
      (read-only-mode -1)
      (widen)
      (erase-buffer)
      (end-of-buffer)
      (insert output)
      (read-only-mode 1)))))

(defun erase-minibuffer ()
  "erases the minibuffer in the current frame"
  (interactive)

  (ignore-errors
    (with-current-buffer (window-buffer (minibuffer-window))
      (read-only-mode -1)
      (widen)
      (erase-buffer)
      (read-only-mode 1))))

(defconst c-message-buffer "*C-Messages*"
  "Name of buffer to use for `c-messages'.")

(defun c-message-open (&rest args)
  "drop-in replacement for `c-message' opens the `*C-Messages*' buffer after outputing the message"
  (interactive "*s")
  (erase-c-messages)
  (apply #'c-message args)
  (let* ((active-buffer (current-buffer))
         (current (frame-first-window))
         (windows
          (let ((windows 0))
            (progn
	      (walk-windows
	       (lambda (window) (setq windows (1+ windows))))
	      windows)))
         (right (progn
                  (ignore-errors
                  (while (> (get-window-count) 1) (delete-window)))
                  (split-window-right)))
         )

    (set-window-buffer right c-message-buffer)
    (set-window-buffer current active-buffer)
  ))


(defun c-message (fmt &rest args)
  "drop-in replacement for `message' that output colorized messages to a buffer named \"*C-Messages*\""
  (interactive "s")

  (let (
         (output (concat (apply #'format (append (list fmt) args)) "\n"))
         (buffer (get-buffer-create c-message-buffer))
         )
    (ignore-errors (with-current-buffer buffer
      (read-only-mode -1)
      (widen)
      (end-of-buffer)
      (insert output)))
    (ignore-errors (write-to-minibuffer output))
  ))
