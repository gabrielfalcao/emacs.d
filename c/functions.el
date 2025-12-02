(defun string-shift-right (g) "." (format "\t%s" g))

(progn ;; runtime/platform dependent defun
  (unless (functionp 'scratch-buffer)
    (defun scratch-buffer ()
      "."
      (interactive)
      (switch-to-buffer (get-buffer-create "*scratch*" t) t t)))

  (unless (functionp 'scratch-buffer)
    (defun scratch-buffer ()
      "."
      (interactive)
      (switch-to-buffer (get-buffer-create "*scratch*" t) t t)))


  )

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
   (
    (file-exists-p (buffer-file-name))
    (file-name-directory (buffer-file-name))
    (expand-file-name "~/.emacs.d")
    )
   )
  )

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

(defun current-line ()
  "returns the current line number at marker."
  (line-number-at-pos (point)))

(defun marker-pos-line-and-column ()
  (format
   "line=%s col=%s"
   (line-number-at-pos (marker-position (mark-marker)) t)
   (column-at-pos (marker-position (mark-marker)))))

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
                                   (format "%s" commit-message))))
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


(defun git-commit-staged ()
  "."
  (interactive)
  (let* ((git-commit-output-buf (get-buffer-create "*git-commit*"))
         (current-working-dir (file-name-directory (expand-file-name (buffer-file-name))))
         (commit-message
          (read-string "Commit Message: " (format "saves %s" current-working-dir)))
         ) ;; let
    (or
     (when (zerop (length commit-message))
       (user-error "aborted due to empty commit message"))
     (if (eq 0
             (let* ((exitcode
                     (call-process "git" nil git-commit-output-buf nil "commit"
                                   "-m"
                                   (format "%s" commit-message))))
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
  "\\(https://github[.]com[/]\\|git@github[.]com[:]\\)\\([a-zA-Z0-9_-]+\\)[/]\\([a-zA-Z0-9_-]+\\)[.]git")

(defun get-git-remote-url-vendor-username-and-repo ()
  "."
  "\\(https://[^.]+[.][^.]+[/]\\|git@[^.]+[.][^.]+[:]\\)\\([a-zA-Z0-9_-]+\\)[/]\\([a-zA-Z0-9_-]+\\)[.]git")

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

    ;; (defun state ()
    ;;   (format "{\n    open-count: %s,\n    close-count: %s,\n    open-pos: %s,\n    close-pos: %s\n}" open-count close-count open-pos close-pos))
    ;;
    ;; (message "%s" (state))
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
    ;; (defun state ()
    ;;   (format "{\n    point: %s\n    til-next-open: %s,\n    til-next-close: %s,\n    open-count: %s,\n    close-count: %s\n}"
    ;;           (point)
    ;;           til-next-open til-next-close open-count close-count))
    ;;
    ;; (message "%s" (state))
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

(defun erase-scratch ()
  "."
  (interactive)
  (erase-buffer-by-name  "*Scratch*"))

(defun git-add ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git add -f %s" (expand-file-name (buffer-file-name)))))

(defun git-rm-force ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git rm --force %s" (expand-file-name (buffer-file-name)))))

(defun git-rm-cached ()
  "."
  (interactive)
  (shell-command-to-string
   (format "git rm --cached %s" (expand-file-name (buffer-file-name)))))

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
         (prettierjs-args (list tmp-buffer nil "-w" current-filename ))
         (exit-code
          (apply #'call-process (append (list "prettier" nil) prettierjs-args))))
    ;; (if (string-match "[.][a-z][a-z0-9-]+rc$" current-filename)
    ;;     ;; explicitly specify parser to prettier when filename ends with `.*rc'
    ;;     (append (list "--parser" "json") prettierjs-args)
    ;;   ;;
    ;;   prettierjs-args)
    ;; ))))

    (message
     (format "prettier -w %s exitted with code: %s" current-filename exit-code))

    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)
         ))
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
       (if (and (listp error-details)
                (not (null (nth 4 error-details))))
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
    (ignore-errors (kill-buffer tmp-buffer))
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
     (user-error
      (format "elfmt %s failed with code: %s"
	      (abbreviate-file-name current-filename)
	      exit-code)))))

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
   ((string= "javacript-mode" (Ox33b4O/$/mode-name))
    (prettierjs))
   ((string= "json-mode" (Ox33b4O/$/mode-name))
    (prettierjs))
   ((string= "web-mode" (Ox33b4O/$/mode-name))
    (prettierjs))
   ((string= "shell-script-mode" (Ox33b4O/$/mode-name))
    (shfmt))
   ((string= "sh-mode" (Ox33b4O/$/mode-name))
    (shfmt))
   ((string= "elisp-mode" (Ox33b4O/$/mode-name))
    (elfmt))
   ((string= "py-mode" (Ox33b4O/$/mode-name))
    (blackpy))
   ((string= "python-mode" (Ox33b4O/$/mode-name))
    (blackpy))
   (t (progn
        (message "can't prettify `%s' yet" (Ox33b4O/$/mode-name))
        ))))

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
                     (line-number-at-pos (match-beginning 1) t)
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
  (if (null (symbolp symbol-name-param))
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

(defun shell-script-curly-wrap-variables-region (beg end)
  "."
  (interactive "*r")
  (let* ((regexp "[$]\\([a-zA-Z0-9_][a-zA-Z0-9_]*\\)")
         (replacement "${\\1}"))
    (save-mark-and-excursion
      (replace-regexp-within-bounds regexp replacement beg end))))

(defun shell-script-curly-wrap-variables-buffer ()
  (interactive)
  (save-mark-and-excursion
    (let* ((beg (point-min))
           (end (point-max)))
      (widen)
      (shell-script-curly-wrap-variables-region beg end))))
(defalias 'shell-script-fix-variables-region
  #'shell-script-curly-wrap-variables-region)

(defalias 'shell-script-fix-variables-buffer
  #'shell-script-curly-wrap-variables-buffer)

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
        (get-directory-path-mkdir "~/notes/linux/"))
      (get-directory-path-mkdir "~/projects/notes/osx")))

(defun current-wip-location ()
  "."
  (or (when (runtime-is-linux)
        (get-directory-path-mkdir "~/notes/linux/wip/emacs"))
      (get-directory-path-mkdir "~/projects/notes/osx/wip/emacs")))


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
  "opens the todo page."
  (interactive)
  (open-note (file-name-concat (current-notes-location) "todo.rst")))

(defun todo-today (&optional utc)
  "inserts a new <h2> entry in the `todo' document with the format 'TODO %Y-%m-%d'"
  (interactive)
  (insert
   (format-time-string "%Y-%m-%d" nil (if (not (null utc)) 0 nil))))


(defun backlog ()
  "."
  (interactive)
  (open-note (file-name-concat (current-notes-location) "backlog.rst")))

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
  (open-note (file-name-concat (current-notes-location) "notes.rst")))

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

(defun shebang-files ()
  "."
  (interactive)
  (insert-shebang "shebang-files.sh"))

(defun shebang-argparse ()
  "."
  (interactive)
  (insert-shebang "shebang-argparse.sh"))

(defalias 'shebang-full
  #'shebang-argparse)

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

(defun auto-propertize-string (string &optional algorithm)
  "colorizes the given string."
  (if (not (stringp string))
      (user-error "%S is not a string (auto-propertize-string %S)" string string))
  (propertize
   (format "%s" string)
   'face
   (get-auto-propertize-face-fg-and-bg-list string (or algorithm
						       'sha256))))

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
  "runs \"git rm -rf \" against `buffer-file-name'."
  (interactive)
  (let* ((git-status-output-buf
          (get-buffer-create "*git-delete*"))
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
         (kill-buffer tmp-buffer)
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
  (save-mark-excursion-and-match-data
    (goto-char beg)
    (while (re-search-forward "\\(^\\|\\b\\)[a-fA-F0-9]+\\(\\b\\|$\\)" end t)
      (let* ((val (format "%s" (string-to-number (match-string) 16)))
             ;; (hexa (or (and (length= val 1) (format "0%s" val))
             ;;           val))
             )
        (replace-match val)))))

(defun decimal-to-hex-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-mark-excursion-and-match-data
    (goto-char beg)
    (while (re-search-forward "\\(^\\|\\b\\)[0-9]+\\(\\b\\|$\\)" end t)
      (replace-match
       (format "%02x" (string-to-number (match-string 0))))
      )))

;; WIP/TODO: replace with rgb-parser.el
;; (defun hex-rgb-to-ansi-region (beg end)
;;   "BEG END."
;;   (interactive "*r")
;;   (let ((regexp-6
;;          "\\([A-F0-9]\\{2\\}\\|[A-F0-9]\\{4\\}\\|[A-F0-9]\\{6\\}\\)")
;;         (regexp-2 "[A-F0-9]\\{2\\}"))
;;     (save-mark-and-excursion
;;       (goto-char beg)
;;       (if (re-search-forward regexp-6 end t)
;;           (progn
;;             (goto-char (match-beginning 0))
;;             (while (re-search-forward regexp-2 end t)
;; 	      (goto-char (match-beginning 0))
;; 	      (replace-match
;; 	       (format
;; 		"$(( 0x%x ));"
;;                 (string-to-number (match-string 0) 16)))
;; 	      (setq end (point))
;; 	      (backward-word 0))
;;             )
;; 	(user-error "no match for regex %S in %S" regexp-6
;;                     (buffer-substring-no-properties beg end)))
;;       )))

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

(defvar c-message-write-to-minibuffer
  t
  "`c-message' will always write to minibuffer unless this var is set to `nil'")

(defvar interactive-read-fmt-and-args-history
  nil)

(defun number-to-ordinal (n)
  "Converts an integer N into its ordinal string representation (e.g., \"1st\", \"2nd\")."
  (let* ((abs-n (abs n)) ; Use absolute value for suffix logic
         (last-two-digits (% abs-n 100))
         (last-digit (% abs-n 10))
         (suffix
          (cond
           ;; Exception for numbers ending in 11, 12, or 13
           ((memq last-two-digits '(11 12 13)) "th")
           ;; Suffixes based on the last digit
           ((eq last-digit 1) "st")
           ((eq last-digit 2) "nd")
           ((eq last-digit 3) "rd")
           ;; Default suffix for all others
           (t "th"))))
    (format "%d%s" n suffix)))

(defun interactive-read-fmt-and-args ()
  (let* ((args (list))
         (fmt (read-string "format string: " nil interactive-read-fmt-and-args-history))
         (expected-fmt-specs (save-match-data
                               (let ((specs (list))
                                     (start nil))

                                 (while (string-match "\b\\(%[^%][^[:space:]\n]*[a-zA-F]+\\)\b\\s-*" fmt start t)
                                   (setq start (match-end))
                                   (push (match-string 1 fmt) specs)
                                   );; while
                                 );;let
                               );;save-match-data
                             )
         );; let* varlist
    (seq-do-indexed #'(lambda (spec index)
                        (let* ((arg-number (+ 1 index))
                               (nth-arg (number-to-ordinal arg-number))
                               (initial-prompt (format "%s format arg `%s': " nth-arg (auto-propertize-string spec)))
                               (prompt initial-prompt)
                               (sexp (read--expression prompt))
                               (prop-sexp (auto-propertize-string (format "%S" sexp)))
                               (prop-spec (auto-propertize-string spec))

                               (last-error nil)
                               (prompt-errors (list))
                               sexp-value)
                          (while (condition-case sexp-error
                                     (and (setq sexp-value (eval-expression sexp))
                                          (null (format-string-signal-error spec sexp-value)))

                                   (eval-sexp-string-error (progn
                                                             (setq
                                                              last-error (format "error evaluating expression %s: %s"
                                                                                 prop-sexp
                                                                                 (propertize-error-string eval-err))
                                                              prompt-errors (append (cons eval-err sexp)))
                                                             sexp-error))

                                   (format-string-error (progn
                                                          (setq
                                                           last-error (format "value %s is invalid for %s format arg `%s': %s"
                                                                              sexp-value
                                                                              nth-arg
                                                                              prop-spec
                                                                              sexp-error)
                                                           prompt-errors (append (cons format-err sexp)))
                                                          format-err))));; end while

                          (push sexp-value args)
                          );; end let*
                        );; end lambda
                    expected-fmt-specs));; seq-do-indexed
  )



(defun c-message (fmt &rest args)
  "drop-in replacement for `message' that output colorized messages to a buffer named \"*C-Messages*\""
  (interactive (interactive-read-fmt-and-args))

  (let* (
        (output (format "%s\n" (apply #'format fmt args)))
        (trimmed-output (string-trim output))
        ;; (output (concat (apply #'format (append (list fmt) args)) "\n"))
        (buffer (get-buffer-create c-message-buffer))
        )
    (with-current-buffer buffer
      (read-only-mode -1)
      (widen)
      (end-of-buffer)
      (insert output)
      (end-of-buffer)
      (goto-char (point-max))
      )

    (unless (null c-message-write-to-minibuffer)
      (write-to-minibuffer trimmed-output))
    trimmed-output
    ))

(defun c-message-force-minibuffer (fmt &rest args)
  (interactive (interactive-read-fmt-and-args))
  (setq c-message-write-to-minibuffer t)
  (funcall #'c-message fmt args))

(defun c-message-no-minibuffer (fmt &rest args)
  (interactive (interactive-read-fmt-and-args))
  (setq c-message-write-to-minibuffer nil)
  (funcall #'c-message fmt args))


(defun c-message-eval-expression (expression)
  (interactive "X")
  (c-message-open "%s" expression))

(defun erase-c-messages (&optional dont-erase-minibuffer)
  "."
  (interactive)
  (erase-buffer-by-name  "*C-Messages*")
  (unless (not (null dont-erase-minibuffer))
    (erase-minibuffer)))

(defun c-message-open (fmt &rest args)
  "drop-in replacement for `c-message' opens the `*C-Messages*' buffer after outputing the message"
  (interactive "*s")
  (delete-other-windows (frame-first-window))
  ;;(erase-c-messages)
  (let ((output (funcall #'c-message fmt args)))
  (or (when ;; c-message-buffer is open and is the first active buffer in current frame...
          (and (not (null (get-buffer-window c-message-buffer)))
	       (eq (frame-first-window) (get-buffer-window c-message-buffer)))
        (message "... then split frame horizontally with the c-message-buffer at the right side")
        ;; ... then split frame horizontally with the c-message-buffer at the right side
        (set-window-buffer (split-window-right) (get-buffer c-message-buffer))
        ;; ... and set the previously active buffer (if any) to the left
        (debug-active-buffers
         ;; TODO: first lets figure out the most recent buffer before c-message-buffer
         )
        ) ;; `end' `when' c-message-buffer is open and is the first active buffer in current frame
      (progn ;; currently active buffer is not c-message-buffer
        ;; so let's split right and set c-message-buffer to the right
        (let* ((right-side (split-window-right))
	       (cmbuffer (get-buffer-create c-message-buffer)))

          (message "(set-window-buffer %S %S)" right-side cmbuffer)
          (set-window-buffer right-side cmbuffer)))
      );; `end' `or' clause
  output))


(defun display-symbol (sym &optional fallback)
  "returns a string with the symbol's value"
  (format "%s" (condition-case err
                   (or (when (stringp sym)
                         (message "symbol %S is stringp" sym)
                         (intern-soft sym))
                       (when (symbolp sym)
                         (message "symbol %S is symbolp" sym)
                         (symbol-value sym))
                       (when (listp sym)
                         (message "symbol %S is listp" sym)
                         (format "'(%s)" (string-join (mapcar #'display-symbol sym)
                                                      " ")))
                       (when (sequencep sym)
                         (message "symbol %S is listp" sym)
                         (format ";; sequencep\n(%s)" (string-join (mapcar #'display-symbol sym)
                                                                   " ")))
                       (when (not (null fallback))
                         (message "displaying fallback %S because symbol is %S" sym)
                         fallback)
                       (progn
                         (message "displaying symbol %S because there is no fallback" sym)
                         sym
                         )
                       ) ;; end (or

                 (error (let (
                              (error-message (format "error in `display-symbol': %s" (error-message-string err)))
                              ) ;;end let varlist
                          (message "%s" error-message)
                          error-message) ;; end let
                        )) ;; end condition-case
          )
  );;end defun display-symbol
(defalias 'symbol-display #'display-symbol)

(defun c-message-debug-symbols (symbol-list &rest context-symbol-list)
  (if (and (not (listp symbol-list))
           (not (symbolp symbol-list)))
      (error "c-message-debug-symbols `symbol-list' is neither a list or a symbol: `%S'" symbol-list))

  (let* ((symbol-list (if (symbolp symbol-list) (list symbol-list)
                        symbol-list))
         (tag-attributes
          (mapcar #'(lambda (sym)
                      (format "%s=%s" sym (display-symbol sym))
                      ) ;;end lambda
                  context-symbol-list) ;; end mapcar
          ) ;;end var tag-attributes
         (inner-tags  (mapcar #'(lambda (sym) (auto-propertize-string
                                               ;;string
                                               (format
                                                "    <%s>\n    %s\n    </%s>"
                                                sym
                                                (string-join
                                                 (mapcar #'(lambda (line) (format "    %s" line))
                                                         (string-lines (display-symbol sym)) ;;end string-lines
                                                         );;end mapcar
                                                 "\n")
                                                sym))) ;; end mapcar lambda
                              symbol-list) ;; end mapcar
		      ) ;;end var inner-tags
         (debug-tag (auto-propertize-string (format "<debug %s>" (string-join tag-attributes " ")))
                    ) ;;end var debug-tag
         )

    (c-message  "%s\n%s\n%s" debug-tag (string-join inner-tags "\n") debug-tag))
  )

(defun debug-active-buffers()
  (interactive)
  (erase-messages)
  (message "<debug-active-buffers>")
  (let* (
         (active-buffers (buffer-list))
         (active-buffer-count (length active-buffers))
         (iter-active-buffer-index 0))
    (message "active-buffers:\n%s"
             (string-join (mapcar #'(lambda (buf)
				      (let ((bufstring (format "    %s[%d]" (buffer-name buf) iter-active-buffer-index)
						       ))
                                        (setq iter-active-buffer-index (+ iter-active-buffer-index 1))
                                        bufstring))
                                  active-buffers)
                          "\n"))
    )
  (message "</debug-active-buffers>")
  )

(defun re-builder-debug-state()
  (interactive)
  ;; (if (not (string= reb-buffer "*RE-Builder*"))
  ;;     (user-error "reb-buffer does not match name: `%s'" reb-buffer)
  ;;   (c-message "reb-buffer is set: %S" reb-buffer)
  ;;   )

  (let* ((re-builder-buffer (get-buffer reb-buffer))
         (reb-debug-local-vars (list "nothing"))
         (reb-debug-local-vars
          (if (bufferp re-builder-buffer)
	      ;; (with-current-buffer re-builder-buffer
	      (with-current-buffer reb-target-buffer
                (list
                 (format "reb-regexp [buffer-local] =`%s'" reb-regexp)
                 (format "reb-regexp-src [buffer-local] =`%S'" reb-regexp-src)
                 (format "reb-overlays [buffer-local] =`%S'" reb-overlays)
                 )
                )
            (list (format "no buffer-local vars in %s buffer: %S" reb-buffer re-builder-buffer))
            )
          )
         ) ;;end let* declarations
    (c-message-open "re-builder vars:\n%s\n\nre-builder buffer-local vars:\n%s"
                    (string-join (mapcar #'(lambda (string) (format "    %s" string))
                                         (list
					  (format "reb-mode =`%S'" reb-mode)
					  (format "reb-target-buffer =`%S'" reb-target-buffer)
					  (format "reb-target-window =`%S'" reb-target-window)
					  (format "reb-window-config =`%S'" reb-window-config)
					  (format "reb-subexp-mode =`%S'" reb-subexp-mode)
					  (format "reb-subexp-displayed =`%S'" reb-subexp-displayed)
					  (format "reb-mode-string =`%S'" reb-mode-string)
					  (format "reb-valid-string =`%S'" reb-valid-string)
					  ))
				 "\n")
		    (string-join (mapcar #'(lambda (string) (format "    %s" string)) reb-debug-local-vars) "\n"))
    )
  )

(defun re-builder-clean-and-reset()
  (interactive)
  (if (not (string= reb-buffer "*RE-Builder*"))
      (user-error "reb-buffer does not match name: `%s'" reb-buffer))

  (with-current-buffer reb-target-buffer
    (setq-local  reb-regexp nil
                 reb-regexp-src nil
                 reb-overlays nil)
    )

  (let ((re-builder-buffer (get-buffer reb-buffer)))
    (if (bufferp reb-target-buffer)
        (kill-buffer re-builder-buffer)))

  (setq reb-mode nil
        reb-target-buffer nil
        reb-target-window nil
        reb-window-config nil
        reb-subexp-mode nil
        reb-subexp-displayed nil
        reb-mode-string ""
        reb-valid-string ""
        )
  )

(defun string-to-list-of-strings (string)
  "like `string-to-list' but returns a list of strings instead of a list of chars.
signals error if the `string' argument is not a string"
  (if (not (stringp string))
      (error "string-to-list-of-strings %S" string))
  (mapcar #'(lambda (chr) (format "%c" chr)) (string-to-list string)))

(defvar insert-regexp-negate-string-history
  (list)
  "history of strings input in previous calls to `insert-regexp-negate-string'"
  )

;;(enable-debug-on-error)
(defun get-regexp-string-negation (string)
  (if (not (stringp string))
      (error "string-to-list-of-strings %S" string))

  (let* ((string-members (string-to-list-of-strings string))
         (member-count (length string-members))
         (index 0)
         (current "")
         (result (list)))
    (while (and (< index (+ member-count 1)) (stringp current))
      (let* ((previous (string-join (mapcar #'(lambda (item) (format "[%s]" item))
					    (seq-subseq string-members 0 index)))
		       );;previous
             )

        ;; KGMtbWVzc2FnZS1kZWJ1Zy1zeW1ib2xzIChsaXN0ICdwcmV2aW91cyAncmVzdWx0KSAnaW5kZXggJ21lbWJlci1jb3VudCAnY3VycmVudCk=
        (setq
         result (append result (list (format "%s[^%s]" previous current)))
         index (+ index 1)
         current (nth index string-members)
         )
        )
      )
    ;; KGMtbWVzc2FnZS1kZWJ1Zy1zeW1ib2xzICdyZWItbW9kZS1zdHJpbmcp
    (if (and (eq (get-buffer reb-buffer) (current-buffer))
             (string= reb-re-syntax "read"))
        (format "\\\\(%s\\\\)" (string-join result "\\\\|"))
      (format "\\(%s\\)" (string-join result "\\|"))
      )
    )
  )

(defun insert-regexp-negate-string (string)
  (interactive
   (list
    (read-string
     "string to negate as regexp group: " "STRING" insert-regexp-negate-string-history)))

  (let* ((regexp (get-regexp-string-negation string)))

    ;; KGMtbWVzc2FnZS1vcGVuICIlcyIgcmVnZXhwKQogICAgKGMtbWVzc2FnZS1kZWJ1Zy1zeW1ib2xzIChsaXN0ICdyZWItcmUtc3ludGF4ICdyZWdleHApKQ==
    (insert regexp)
    )
  )

(defun call-process-get-status-and-info-default-conversion-function (element)
  (cond
   ((stringp element)
    element) ;; stringp

   ((or (numberp element)
        (characterp element))
    (format "%s" element))

   ((or (numberp element)
        (characterp element))
    (format "%s" element))

   ((or (listp element)
        (vectorp element))
    (mapcar #'call-process-get-status-and-info-default-conversion-function
            element))

   ((sequencep element) ;; XXX: should this handle "sequences at
    ;; large" fallback differently ?
    (mapcar #'call-process-get-status-and-info-default-conversion-function
            element))
   ((null element)
    "false")
   ((eq t element)
    "true")

   (t (format "%s" element))
   ) ;;cond
  );; defun


;; git-status-porcelain stuff
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
    (list exitcode output)))

;; (defconst git-status-porcelain-class-group-regexp
;;   "\\([[:space:]!?ACDMRTU]\\)"

;;   "regular expression used within `git-status-porcelain-class-group-regexp' in call to `string-match'."
;;   )

(defconst git-status-porcelain-regexp
  ;; "^\\(.\\)\\(.\\)\\s-+\\(.+\\)$"
  "^\\([[:space:]!?ACDMRTU]\\)\\([[:space:]!?ACDMRTU]\\)[[:space:]]+\\(.*\\)$"

  "regular expression used within `git-status-get-filenames' in call to `string-match'."
  )

(defun git-status-porcelain-class-char-to-symbol(char)
  "`maps the given `char' to semantic symbols according to table below:

' ' = unmodified
`!' = ignored
`?' = untracked
`A' = added
`C' = copied (if config option status.renames is set to \"copies\")
`D' = deleted
`M' = modified
`R' = renamed
`T' = file type changed (regular file, symbolic link or submodule)
`U' = updated but unmerged
."
  (let ((input (cond ((or (stringp char) (characterp char))
		      (format "%s" char))
		     ((and (listp char)
                           (length= char 1))
		      (car char))
		     (t
		      (error "invalid value (neither string nor character) for argument `char': %S" char))))
        (len (length input)))
    (if (> len 1)
        (error "`char' argument must be a string of length 1, instead got `%S' (normalized to `%s' of length `%d')"
	       char input len))
    (cond

     ((string= " " input)
      (list :sym 'unmodified
	    :desc ""
	    :long_desc "unmodified"
	    )
      ;; end list
      );; end clause

     ((string= "!" input)
      (list :sym 'ignored
	    :desc ""
	    :long_desc "ignored"
	    )
      ;; end list
      );; end clause

     ((string= "?" input)
      (list :sym 'untracked
	    :desc ""
	    :long_desc "untracked"
	    )
      ;; end list
      );; end clause

     ((string= "A" input)
      (list :sym 'added
	    :desc ""
	    :long_desc "added"
	    )
      ;; end list
      );; end clause

     ((string= "C" input)
      (list :sym 'copied
	    :desc ""
	    :long_desc "copied (if config option status.renames is set to \"copies\")"
	    :note "(if config option status.renames is set to \"copies\")"
	    )
      ;; end list
      );; end clause

     ((string= "D" input)
      (list :sym 'deleted
	    :desc ""
	    :long_desc "deleted"
	    )
      ;; end list
      );; end clause

     ((string= "M" input)
      (list :sym 'modified
	    :desc ""
	    :long_desc "modified"
	    )
      ;; end list
      );; end clause

     ((string= "R" input)
      (list :sym 'renamed
	    :desc ""
	    :long_desc "renamed"
	    )
      ;; end list
      );; end clause

     ((string= "T" input)
      (list :sym 'file
	    :desc " type changed"
	    :long_desc "file type changed (regular file, symbolic link or submodule)"
	    :note "(regular file, symbolic link or submodule)"
	    )
      ;; end list
      );; end clause

     ((string= "U" input)
      (list :sym 'updated
	    :desc " but unmerged"
	    :long_desc "updated but unmerged"
	    )
      ;; end list
      );; end clause


     );;end cond
    );;end let
  );; end defun git-status-porcelain-class-char-to-symbol

(defun git-status-porcelain-categorized()
  "runs git status --porcelain=v1 in the current working directory and parses the status characters according to the list below:

` ' = unmodified
`!' = ignored
`?' = untracked
`A' = added
`C' = copied (if config option status.renames is set to \"copies\")
`D' = deleted
`M' = modified
`R' = renamed
`T' = file type changed (regular file, symbolic link or submodule)
`U' = updated but unmerged

."
  (interactive)
  ;;(replace-regexp-in-string regexp rep string &optional fixedcase literal subexp start)

  (let* ((status-code-and-output (git-status-porcelain))
         (status (car status-code-and-output))
         (output (car (cdr status-code-and-output)))
         (output-lines (save-match-data (string-lines output t)))
	 ;; (seq-filter #'numberp '(a b 3 4 f 6))
	 ;;   ⇒ (3 4 6)
	 ;;
	 ;; (seq-remove #'numberp '(1 2 c d 5))
	 ;;   ⇒ (c d)

         (classified-paths
	  ;;(seq-remove #'null
          (mapcar #'(lambda (line)
		      (save-match-data
                        (setq case-fold-search nil) ;; case sensitive
			(if (string-match git-status-porcelain-regexp line)
			    (let ((staged (match-string 1 line))   ;; then
				  (unstaged (match-string 2 line)) ;; then
				  (path (match-string 3 line)))    ;; then
			      (list 'staged staged             ;; then
				    'unstaged unstaged         ;; then
				    'path path))               ;; end inner let varlist

                          ;; else
                          nil ;; else ;; KGxpc3QgJ3N0YWdlZCBuaWwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICd1bnN0YWdlZCBuaWwKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICdwYXRoIG5pbCkpKQ==
                          ) ;;end if
                        ) ;; end save-match-data
		      ) ;;end lambda
                  ;; sequence
                  output-lines ;; sequence
                  ) ;; mapcar
	  ;; ) ;;seq-remove
          )
         )  ;; end let* varlist
    ;; let* [body]
    (let ;; [debug]
        ((result (format "
status=%S
output=%S
output-lines=%S
classified-paths=%S
"
                         status
                         output
                         output-lines
                         classified-paths
                         ))
         ) ;; end varlist let[debug]
      ;; let[debug] body
      (erase-messages)
      (message "%s" result)
      (c-message-open "%s" result)
      );; end let[debug]
    ) ;;end let*
  );; end defun git-status-get-filenames


;;(enable-debug-on-error)
(defun flat-assoc-list-p (seq &optional signal-error)
  "returns `t' if `seq' is valid flat-assoc-list or else `nil', unless
`signal-error' is not nil, in which case signals an `error' instead.
"
  (let* ((error-or-nil #'(lambda (&rest error-args)
			   (if (not (null signal-error))
			       (apply #'error error-args)
			     nil)))
         (len (or (when (listp seq) (length seq))
                  -1)) ;; set len
         ;; end varlist
         )
    (cond ((= len -1)
           (error-or-nil "`seq' must be a list, instead got %S" seq))
          ((or (< len 2)
	       (not (= (% len 2) 0)))
           (error-or-nil "length `seq' should be even but actually is %d" len))
          (t t))))

(defun flat-list-get-assoc-key-value (seq key &optional signal-error)
  "Retrieves value under `key' within sequence `seq' as long as the sequence
is even-numbered with an even number of items where every even-numbered
nth item is a symbol and its subsequent odd-numbered nth neighbor is a
value.

Returns `nil' if key is not found in `seq'.

Signals error if

* `seq' is odd-numbered or not a valid list
* `key' is neither a symbol nor a string
"
  (if (flat-assoc-list-p seq signal-error)
      (let* ((pairs (seq-partition seq 2))
             (kv (alist-get key pairs)))
        (cond ((and (not (null kv))
                    (listp kv))
	       (car kv))
	      (t nil)))
    ))


(defun flat-list-get-assoc-keys (seq)
  "`SEQ' `SIGNAL-ERROR'."

  (if (flat-assoc-list-p seq)
      (let* ((pairs (seq-partition seq 2))
             (keys
	      (mapcar #'(lambda (pair) (car pair)) pairs)))
        keys)))

(defun flat-list-get-assoc-values (seq)
  "`SEQ' `SIGNAL-ERROR'."

  (if (flat-assoc-list-p seq)
      (let* ((pairs (seq-partition seq 2))
             (values
	      (mapcar #'(lambda (pair) (car (cdr pair))) pairs)))
        values)))

(defun rename-current-file(new-file)
  "renames the file being edited in the current buffer and updates the file
name in the current buffer accordingly such that subsequent calls to
`buffer-file-name' point at the new file name.

if the current buffer is not a file buffer, then this function simply
writes the buffer's content to the `new-file' file name, which
essentially the same as calling `write-file' with the exception that
that no hooks get triggered incurring changes to current buffer's major
and minor modes. To be precise, no `auto-mode' changes happen.
"

  )
;; (defconst slugify-string-default-separator
;;   "-"
;;   "the separator that replaces non-slug-compatible characters of target string")
;;
;; (defun slugify-string-get-nonstandard-sep-assoc(sep)
;;   (if (not (stringp sep))
;;       (error "`sep' is not a string: %s" sep))
;;   (save-match-data
;;     (when (string-match "^\\(\\([a-zA-Z0-9@+/\\~!*_-]+\\)\\|\\([^a-zA-Z0-9[:space:]\n_-]+\\)\\)+$" sep)
;;       (list :all (match-string 0 sep) ;;body
;;             :outer (match-string 1 sep)
;;             :ascii (match-string 2 sep)
;;             :non-space (match-string 3 sep)) ;;end when body
;;             )
;;     ))
;;
;; (defun slugify-string-regexp-middle(sep)
;;   "returns the regexp to slugify string based on a given separator"
;;   (if (not (stringp sep))
;;       (error "`sep' is not a string: %s" sep))
;;
;;   (let ((nonstandard-sep
;;          (slugify-string-get-nonstandard-sep-assoc sep))
;;         );; end let varlist
;;     (or (when (or (string= sep "_")
;;                   (string= sep slugify-string-default-separator)
;;                   (not (listp nonstandard-sep)))
;;           ;; body
;;           "[^a-zA-Z0-9_-]+") ;;end when body
;;         (when (listp nonstandard-sep)
;;           (let ((nons-all (flat-list-get-assoc-key-value nonstandard-sep :all))
;;                 (nons-outer (flat-list-get-assoc-key-value nonstandard-sep :outer))
;;                 (nons-ascii (flat-list-get-assoc-key-value nonstandard-sep :ascii))
;;                 (nons-nspc (flat-list-get-assoc-key-value nonstandard-sep :non-space)))
;;            KGMtbWVzc2FnZS1kZWJ1Zy1zeW1ib2xzIChsaXN0ICdub25zdGFuZGFyZC1zZXAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICdub25zLWFsbCAgJ25vbnMtb3V0ZXIgICdub25zLWFzY2lpICAnbm9ucy1uc3BjICdzZXApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnc2VwICdub25zLWFsbCAgJ25vbnMtb3V0ZXIgICdub25zLWFzY2lpICAnbm9ucy1uc3BjKQ==
;;
;;             (format "[^a-zA-Z0-9_%s-]+" slugify-string-default-separator)))
;;         slugify-string-default-separator))
;;   )
;;
;;
;;
;; (defun slugify-string-regexp-ends(sep)
;;   "returns the regexp to fix the ends of the string post slugifying it"
;;   (if (not (stringp sep))
;;       (error "`sep' is not a string: %s" sep))
;;   (let ((nonstandard-sep
;;          (slugify-string-get-nonstandard-sep-assoc sep))
;;         );; end let varlist
;;     (or (when (or (string= sep "_")
;;                   (string= sep slugify-string-default-separator)
;;                   (not (listp nonstandard-sep)))
;;           (format "\\(^[%s]+\\|[%s]+$\\)" sep sep))
;;         (when (listp nonstandard-sep)
;;           (let ((nons-all (flat-list-get-assoc-key-value nonstandard-sep :all))
;;                 (nons-outer (flat-list-get-assoc-key-value nonstandard-sep :outer))
;;                 (nons-ascii (flat-list-get-assoc-key-value nonstandard-sep :ascii))
;;                 (nons-nspc (flat-list-get-assoc-key-value nonstandard-sep :non-space))
;;                 (actual-sep slugify-string-default-separator))
;;           ;; KGMtbWVzc2FnZS1kZWJ1Zy1zeW1ib2xzIChsaXN0ICdub25zdGFuZGFyZC1zZXAKICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICdub25zLWFsbCAgJ25vbnMtb3V0ZXIgICdub25zLWFzY2lpICAnbm9ucy1uc3BjICdzZXApCiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAnc2VwICdub25zLWFsbCAgJ25vbnMtb3V0ZXIgICdub25zLWFzY2lpICAnbm9ucy1uc3BjKQ==
;;
;;             (format "\\(^[%s]+\\|[%s]+$\\)" actual-sep actual-sep)))
;;         slugify-string-default-separator)
;;     )
;;   )
;;
;;
;; (defun slugify-string (string &optional separator)
;;   "returns a slugified version of `string'"
;;   (let* ((raw-sep  (string-trim (cond ((stringp separator)
;; 				       separator)
;; 				      ((characterp separator)
;; 				       (format "%s" separator))
;; 				      ((null separator) slugify-string-default-separator)
;; 				      (t (progn
;;                                            (warn "ignoring slugify-string argument `separator' because it unexpected type: %S"
;;                                                  separator)
;;                                            slugify-string-default-separator)))))
;;          (n-sep (replace-regexp-in-string "[[:space:]]+" "" raw-sep))
;;          (n-len (length n-sep))
;;          (sep (or (when (= n-len 0) slugify-string-default-separator)
;;                   n-sep)))
;;
;;     (replace-regexp-in-string slugify-string-regexp-middle  ))
;;
;;


;; (let* ((result (call-process-get-status-and-info "uname" nil "-a"))
;;        (keys (flat-list-get-assoc-keys result))
;;        (values (flat-list-get-assoc-values result))
;;        (exit-code (flat-list-get-assoc-key-value result :exit-code))
;;        (stdout (flat-list-get-assoc-key-value result :stdout))
;;        (stderr (flat-list-get-assoc-key-value result :stderr))
;;        (call-process-args (flat-list-get-assoc-key-value result :call-process-args))
;;        (shell-command (flat-list-get-assoc-key-value result :shell-command)))

;;   (erase-c-messages)
;;   KGMtbWVzc2FnZS1kZWJ1Zy1zeW1ib2xzIChsaXN0ICdyZXN1bHQgJ2tleXMgJ3ZhbHVlcyAnZXhpdC1jb2RlICdzdGRvdXQgJ3N0ZGVyciAnY2FsbC1wcm9jZXNzLWFyZ3MpICdzaGVsbC1jb21tYW5kKQ==
;;   )
;;                                         ;

(defun shell-script-insert-ansi-clear()
  (interactive)
  (insert "\necho -en \"\\x1b[2J\\x1b[3J\\x1b[H\""))

(defun shell-script-single-quote-string(string)
  "returns single-quoted `string' unless already single-quoted or double-quoted"
  (or (when (string-match "^\\s-*\".*\"\\s-*$" string)
        (string-trim string))
      (when (string-match "^\\s-*'.*'\\s-*$" string)
        (string-trim string))
      (format "'%s'" string)
      );; end of
  );; end defun shell-script-single-quote-string

(defun shell-script-string-list-to-bash-indexed-array (string-list &optional item-separator-string noerror)
  (let* ((default-separator "\n")
         (separator (or (when (and (stringp item-separator-string)
                                   (length> item-separator-string 0))
                          item-separator-string)
                        (when (stringp item-separator-string)
                          (warn "item-separator-string is empty, falling back to \"%S\"" default-separator)
                          default-separator)
                        (error "item-separator-string is not a string but rather: %S" item-separator-string))
                    );; end (let* (separator ...
         (safe-string-only-list (if (listp string-list)
                                    (seq-filter #'stringp string-list)
                                  (error "string-list is not a list but rather: %S" string-list)
                                  )
                                );; end (let* safe-string-only-list
         (safe-string-coerced-list (mapcar #'(lambda (value)
                                               (if (stringp value)
                                                   value
                                                 (format "%S" value)))
                                           string-list));; end (let* (safe-string-coerced-list
         (string-values-list (list))
         (total-items (length string-list))
         (total-valid-strings (length safe-string-only-list))
         (total-invalid-items (- total-items total-valid-strings))

         );; end (let* (...varlist...))
    (if (not (= total-invalid-items 0))
        (if (null noerror)
            (let ((invalid-items (seq-filter #'(lambda (item) (not (stringp item))) string-list)))
              (error "%d invalid items - nonstring - items in `string-list' (%d total items)\n\ninvalid: %S\n\nall: %S"
                     total-invalid-items
                     total-items
                     invalid-items
                     safe-string-coerced-list));; end if (not (null noerror)) / then => (let ((invalid-items ...
          ;; else
          (setq string-values-list safe-string-coerced-list)
          ))

    (if (and (not (stringp item-separator-string))
             (not (null item-separator-string))
             (not noerror)
             )
        (error "item-separator-string is not a string but rather: %S" item-separator-string) ;; end if/then

      (progn ;; else
        (if (and (not (null item-separator-string))
                 (not noerror)) ;; end if/then -> and
            (error "ignoring nonnull and nonstring `item-separator-string' `%S'" item-separator-string) ;; end if/then
          ) ;; end if not null item-separator-string
        (setq item-separator-string default-separator));;end (progn ...)
      ) ;; end if

    ;; end input validation

    (format "( %s )"
            (string-join (mapcar #'shell-script-single-quote-string
                                 string-values-list)
                         "\n" )) ;; result
    ) ;; end (let*
  ) ;;end (defun shell-script-string-list-to-bash-indexed-array ...)

(defun shell-script-gen-safe-variable-name-from-string(variable-name)
  "returns string with valid bash variable name from input string in `variable-name' parameter.

this function works by passing `variable-name' into a pipelines of processes:

1. (if available) runs the string through the program `slugify-string'
2. or; (if available) fallbacks to running through the program `heck-string' with args ~--to=snake~
3. replaces all INVALID SEQUENCES of characters with \"_\" (underscore)
4. removes all sequences of underscores from the beginning and/or from the end of the string, if any.


this function first /slugifies/ the input string by passing it to the program `slugify-string' (if available in the `PATH' environment variable).

In the context of this function, the regular expression
\"\\(^[_]+\\|[_]+$\\)\" constitutes INVALID SEQUENCES.

This function is significantly more effective when the command-line tool
`slugify-string' is available because it \"nicely downgrades\" all
non-ascii unicode letters to their unicode equivalents via unicode transliteration.

Examples:

(shell-script-gen-safe-variable-name-from-string \"άνθρωποι\")
=> \"anthropoi\"
(shell-script-gen-safe-variable-name-from-string \" 𐐢𐐮𐐻𐑊e 𐐝𐐻𐐪𐑉\")
=> \"litle_star\"


the string is then pipelined by 2 regular expressions before returing

the slugify-string


"
  (let* ((raw-pipeline
          (list
           (or (when (executable-find "slugify-string")
                 #'(lambda (string)
                     (let* (
                            (result (call-program-with-list-args "slugify-string" nil t nil string))
                            (exit-code (flat-list-get-assoc-key-value result :exit-code))
                            (output (string-trim (flat-list-get-assoc-key-value result :output)))
                            )
                       (or (when (and (= exit-code 0)
                                      (length> output 0)
                                      ) ;; end (when (and ...
                             output) ;end (when ...)
                           (progn
                             (when (length= output 0)
                               (warn "slugify-string `%S' returned empty string" string))
                             (when (not (length= output 0))
                               (warn "slugify-string `%S' exited with code %s" string exit-code))
                             ;; return string as is
                             string) ;; end progn
                           ) ;; end or
                       )  ;; end let*
                     );; end lambda
                 ) ;; end (when (executable-find "slugify-string" ...
               (when (executable-find "heck-string")
                 #'(lambda (string)
                     (let* (
                            (result (call-program-with-list-args "heck-string" nil t nil "--to=snake" string))
                            (exit-code (flat-list-get-assoc-key-value result :exit-code))
                            (output (string-trim (flat-list-get-assoc-key-value result :output)))
                            )
                       (or (when (and (= exit-code 0)
                                      (length> output 0)
                                      ) ;; end (when (and ...
                             output) ;end (when ...)
                           (progn
                             (when (length= output 0)
                               (warn "heck-string --to=snake `%S' returned empty string" string))
                             (when (not (length= output 0))
                               (warn "heck-string --to=snake `%S' exited with code %s" string exit-code))
                             ;; return string as is
                             string) ;; end progn
                           ) ;; end or
                       )  ;; end let*
                     );; end lambda
                 ) ;; end (when (executable-find "heck-string --to=snake" ...
               (list) ;; fallback to empty list
               );; end (or ...
           #'(lambda (string)
               (replace-regexp-in-string "[^a-z0-9_]+" "_" string)) ;; replaces INVALID SEQUENCES with underscore
           #'(lambda (string)
               (replace-regexp-in-string "\\(^[_]+\\|[_]+$\\)" "" string)) ;; removes sequences of underscores from beginning and end of string
           #'(lambda (string)
               (downcase string)) ;; lowercases string
           ) ;; end (list ...
          ) ;; end (let* ...(raw-pipeline (list ...functions...)))

         (pipeline (seq-filter #'functionp raw-pipeline)
                   );; end (let* ...(pipeline seq-filter #'functionp)...)
         )
    (seq-reduce #'(lambda (value process)
                    (apply #'process (list value)));; end #'(lambda ... )
                pipeline ;; SEQUENCE
                variable-name ;; INITIAL-VALUE
                )
    ) ;; end (let* ...)
  ) ;; end (defun shell-script-gen-safe-variable-name-from-string ...)

(defun shell-script-meta-gen-variable-declaration (variable-name
                                                   variable-value
                                                   &optional variable-is-local
                                                   noerror
                                                   )
  "returns `flat-assoc-list-p' with context for declaration of one variable
with elisp-to-bash value conversion and (optionally) an additional
variable with the count (`length') of items if and when the main
variable is an array and `with-count-variable' is not null."
  (let ((declaration-keyword (if (not (null variable-is-local))
                                 "local"
                               "declare"))
        (declaration-flag "--")
        (post-declaration-comment nil)
        (safe-variable-name (shell-script-gen-safe-variable-name-from-string variable-name))
        (safe-variable-value (format "%S" variable-value))
        (string-values-list (list))

        (is-array nil)
        (array-length-declaration-flag "-i")
        (array-length-variable-name "-i")
        (array-length-variable-value 0)
        ); end (let ...varlist...)
    (cond (
           ((or (stringp variable-value)
                (and (numberp variable-value)
                     (not (integerp variable-value)))
                )
            (setq
             safe-variable-value (shell-script-single-quote-string variable-value)
             declaration-flag "--"
             ))

           ((integerp variable-value)
            (setq
             safe-variable-value (format "%d" variable-value)
             declaration-flag "-i"
             ))


           ((and (not flat-assoc-list-p variable-value)
                 (listp variable-value))
            (setq
             safe-variable-value (shell-script-string-list-to-bash-indexed-array string-values-list "\n" noerror )
             declaration-flag "-a"
             safe-variable-name (format "%s_items" safe-variable-name)

             is-array t
             array-length-variable-name (format "%s_count" safe-variable-name)
             array-length-variable-value (length safe-variable-value)
             array-length-declaration-flag "-i"
             ))

           ((flat-assoc-list-p variable-value)
            (setq
             safe-variable-value (shell-script-string-list-to-bash-associative-array string-values-list "\n" noerror )
             declaration-flag "-A"
             safe-variable-name (format "%s_items" safe-variable-name)

             is-array t
             array-length-variable-name (format "%s_count" safe-variable-name)
             array-length-variable-value (length safe-variable-value)
             array-length-declaration-flag "-i"
             ))
           ((not (null noerror))
            (let ((coerced-string (shell-script-single-quote-string (format "%S" variable-value))))
              (setq
               post-declaration-comment (format "coercing unsupported variable (type) `%S' to string: %s" variable-value coerced-string)
               is-array nil
               safe-variable-value coerced-string
               declaration-flag "--")))
           (t
            (error "unsupported variable (type) %S" variable-value))
           );; end...clauses...
          );; end cond
    (or (when is-array
          (list
           :declaration-keyword declaration-keyword                     ;; (if (not (null variable-is-local)) "local" "declare")
           :declaration-flag declaration-flag                           ;; (cond (
                                        ;                                                                       ;;    (listp             "-a")
                                        ;                                                                       ;;    (flat-assoc-list-p "-A")
                                        ;                                                                       ;; )
           :is-array is-array                                           ;; nil
           :post-declaration-comment post-declaration-comment           ;; string or nil
           :safe-variable-name safe-variable-name                       ;; (shell-script-gen-safe-variable-name-from-string variable-name)
           :safe-variable-value safe-variable-value                     ;; string, integer or list of strings
           :array-length-declaration-flag array-length-declaration-flag ;; "-i"
           :array-length-variable-name array-length-variable-name       ;; (format "%s_count" safe-variable-name)
           :array-length-variable-value array-length-variable-value     ;; (length safe-variable-value)
           ))
        (list
         :declaration-keyword declaration-keyword                     ;; (if (not (null variable-is-local)) "local" "declare")
         :declaration-flag declaration-flag                           ;; (cond (
                                        ;                                                                       ;;    (stringp           "--")
                                        ;                                                                       ;;    (integerp          "-i")
                                        ;                                                                       ;;    (t                 "--") ;; fallback is always string via `%S'
                                        ;                                                                       ;; )
         :is-array is-array                                           ;; nil
         :post-declaration-comment post-declaration-comment           ;; string or nil
         :safe-variable-name safe-variable-name                       ;; (shell-script-gen-safe-variable-name-from-string variable-name)
         :safe-variable-value safe-variable-value                     ;; string or integer
         )
        );; end (or ...
    );; end (defun (let ...)))
  );; end defun shell-script-meta-gen-variable-declaration


(defun shell-script-gen-variable-declaration-from-flat-assoc-list (context)
  "returns a string with bash code containing variable declaration(s) in addition to a for-each iteration when the main variable is an array (indexed or associative)
  CONTEXT must be a valid `flat-assoc-list-p'."

  (if (not (flat-assoc-list-p context))
      (error "`context' is not a 'flat-assoc-list-p': %S" context))

  (let (
        declaration-keyword           (flat-list-get-assoc-key-value context :declaration-keyword)
        declaration-flag              (flat-list-get-assoc-key-value context :declaration-flag)
        is-array                      (flat-list-get-assoc-key-value context :is-array)
        post-declaration-comment      (flat-list-get-assoc-key-value context :post-declaration-comment)
        safe-variable-name            (flat-list-get-assoc-key-value context :safe-variable-name)
        safe-variable-value           (flat-list-get-assoc-key-value context :safe-variable-value)
        array-length-declaration-flag (flat-list-get-assoc-key-value context :array-length-declaration-flag)
        array-length-variable-name    (flat-list-get-assoc-key-value context :array-length-variable-name)
        array-length-variable-value   (flat-list-get-assoc-key-value context :array-length-variable-value)
        )
    (let* (
           (indent-length 4)
           (padding-left (string-join (-repeat indent-length " ")))
           (declarations (append
                          (list (format "%s %s=%s" declaration-keyword declaration-flag safe-variable-name safe-variable-value))
                          (when is-array
                            (list (format "%s %s=%s" declaration-keyword array-length-declaration-flag array-length-variable-name array-length-variable-value)
                                  );; end (list
                            )) ;; end (append
                         );; end (let ((declarations ...))
           (index-variable-name (if (and is-array is-flat-assoc-list)
                                    "key"
                                  "index"))
           (index-variable-declaration-flag (if (and is-array is-flat-assoc-list)
                                                "--"
                                              "-i"))
           (bash-snippet-for-each
            (when is-array
              (string-join (list
                            (format "if [ ${%s} -gt 0 ]; then" array-length-variable-name)
                            (format "%s%s %s %s=0"
                                    padding-left declaration-keyword
                                    index-variable-declaration-flag
                                    index-variable-name)
                            (format "%s%s -- arg=\"\"" padding-left declaration-keyword)
                            (format "%sfor %s in ${!%s[@]}; do"
                                    padding-left
                                    index-variable-name safe-variable-name)
                            (format "%s%s%s %s %s current=$(( $%s + 1 ))"
                                    padding-left padding-left
                                    (if is-flat-assoc-list
                                        "#" ;; comment this declaration when flat-list because index-variable most likely has non-numerical characters
                                      "" ;;
                                      )
                                    declaration-keyword
                                    index-variable-declaration-flag
                                    index-variable-name)
                            (format "%s%sarg=${%s[$%s]}"
                                    padding-left padding-left
                                    safe-variable-name
                                    index-variable-name
                                    )
                            (format "%sdone" padding-left)
                            (format "fi")
                            );; end (string-join (list ...
                           );; end (string-join (list ... "\n"))
              );; end (when is-array
            );; end (let* ...(bash-snippet-for-each ...))
           );; end (let* ...varlist...)
      );; end (let* ...)
    );; end (defun (let ...
  );; end (defun shell-script-gen-variable-declaration-from-flat-assoc-list ...

(defun shell-script-gen-variable-declaration (variable-name
                                              variable-value
                                              &optional variable-is-local
                                              noerror)
  "returns a string with a valid bash variable declaration
examples:

(shell-script-gen-variable-declaration \"my_array\" (list \"item pos 0\" \"item-pos-1\" \"item3\" 1010 \"$HOME\") \"\n\" t t)
=> \"declare -a my_array=( \\\"item pos 0\\\" \\\"item-pos-1\\\" \\\"item3\\\" \\\"1010\\\"  \\\"$HOME\\\"  )\"
"
  (let ((declaration-keyword (if (not (null variable-is-local))
                                 "local"
                               "declare"))
        (declaration-flag "--")
        (post-declaration-comment nil)
        (safe-variable-name (shell-script-gen-safe-variable-name-from-string variable-name))
        (safe-variable-value (format "%S" variable-value))
        (string-values-list nil)
        ); end let
    (cond (
           ((or (stringp variable-value)
                (and (numberp variable-value)
                     (not (integerp variable-value)))
                )
            (setq
             safe-variable-value (shell-script-single-quote-string variable-value)
             declaration-flag "--"
             ))

           ((integerp variable-value)
            (setq
             safe-variable-value (format "%d" variable-value)
             declaration-flag "-i"
             ))


           ((and (not flat-assoc-list-p variable-value)
                 (listp variable-value))
            (setq
             safe-variable-value (shell-script-string-list-to-bash-indexed-array string-values-list "\n" noerror )
             declaration-flag "-a"
             ))

           ((flat-assoc-list-p variable-value)
            (setq
             safe-variable-value (shell-script-string-list-to-bash-associative-array string-values-list "\n" noerror )
             declaration-flag "-A"
             ))
           ((not (null noerror))
            (let ((coerced-string (shell-script-single-quote-string (format "%S" variable-value))))
              (setq
               post-declaration-comment (format "coercing unsupported variable (type) `%S' to string: %s" variable-value coerced-string)
               safe-variable-value coerced-string
               declaration-flag "--")))
           (t
            (error "unsupported variable (type) %S" variable-value))
           );; end...clauses...
          );; end cond
    (format "%s %s=%s" declaration-keyword declaration-flag safe-variable-name safe-variable-value)
    ) ;; end (let
  );; end (defun shell-script-gen-variable-declaration ...)


;; WIP defun shell-script... OzsgKGRlZnVuIHNoZWxsLXNjcmlwdC1pbnNlcnQtZm9yLWVhY2gtaW4taW5kZXhlZC1hcnJheShhcnJheS12YXJpYWJsZS1uYW1lCjs7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgYXJyYXktdmFyaWFibGUtdmFsdWUKOzsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAmb3B0aW9uYWwgdmFyaWFibGUtaXMtbG9jYWwKOzsgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBub2Vycm9yCjs7ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgKQo7OyAgIChpbnRlcmFjdGl2ZSkKOzsgICAoaWYgKG5vdCAoc3RyaW5ncCBhcnJheS12YXJpYWJsZS1uYW1lKSkKOzsgICAgICAgKGVycm9yICJgYXJyYXktdmFyaWFibGUtbmFtZScgaXMgbm90IGEgc3RyaW5nOiAlUyIgYXJyYXktdmFyaWFibGUtbmFtZSkpCjs7ICAgKGlmIChub3QgKGxpc3RwIGFycmF5LXZhcmlhYmxlLXZhbHVlKSkKOzsgICAgICAgKGVycm9yICJgYXJyYXktdmFyaWFibGUtdmFsdWUnIGlzIG5vdCBhIGxpc3Q6ICVTIiBhcnJheS12YXJpYWJsZS12YWx1ZSkpCgo7OyAgIChsZXQqICgoY3VycmVudC1wb3MgKG1hcmtlci1wb3NpdGlvbiAobWFyay1tYXJrZXIpKSkKOzsgICAgICAgICAgKGN1cnJlbnQtbGluZS1udW1iZXIgKGxpbmUtbnVtYmVyLWF0LXBvcyBjdXJyZW50LXBvcykpCjs7ICAgICAgICAgIChjdXJyZW50LWNvbHVtbi1udW1iZXIgKGNvbHVtbi1hdC1wb3MgY3VycmVudC1wb3MpKQo7OyAgICAgICAgICAoZWRpdGluZy1mdW5jdGlvbiB2YXJpYWJsZS1pcy1sb2NhbCkKOzsgICAgICAgICAgKHJlc3VsdCAoc2hlbGwtc2NyaXB0LW1ldGEtZ2VuLXZhcmlhYmxlLWRlY2xhcmF0aW9uCjs7ICAgICAgICAgICAgICAgICAgIGFycmF5LXZhcmlhYmxlLW5hbWUKOzsgICAgICAgICAgICAgICAgICAgYXJyYXktdmFyaWFibGUtdmFsdWUKOzsgICAgICAgICAgICAgICAgICAgdmFyaWFibGUtaXMtbG9jYWwKOzsgICAgICAgICAgICAgICAgICAgbm9lcnJvcgo7OyAgICAgICAgICAgICAgICAgICB0Cjs7ICAgICAgICAgICAgICAgICAgICJcbiIpKQo7OyAgICAgICAgICAoZGVjbGFyYXRpb25zLXN0cmluZyAoc2hlbGwtc2NyaXB0LWdlbi12YXJpYWJsZS1kZWNsYXJhdGlvbi1mcm9tLWZsYXQtYXNzb2MtbGlzdCByZXN1bHQpKQo7OyAgICAgICAgICAoc2FmZS12YXJpYWJsZS1kZWNsYXJlLWtleXdvcmQgKGZsYXQtbGlzdC1nZXQtYXNzb2Mta2V5LXZhbHVlIHJlc3VsdCA6ZGVjbGFyYXRpb24ta2V5d29yZCkpCjs7ICAgICAgICAgIChzYWZlLXZhcmlhYmxlLWZsYWcgKGZsYXQtbGlzdC1nZXQtYXNzb2Mta2V5LXZhbHVlIHJlc3VsdCA6ZGVjbGFyYXRpb24tZmxhZykpCjs7ICAgICAgICAgIChzYWZlLXZhcmlhYmxlLW5hbWUgKGZsYXQtbGlzdC1nZXQtYXNzb2Mta2V5LXZhbHVlIHJlc3VsdCA6dmFyaWFibGUtbmFtZSkpCjs7ICAgICAgICAgIChzYWZlLXZhcmlhYmxlLXZhbHVlIChmbGF0LWxpc3QtZ2V0LWFzc29jLWtleS12YWx1ZSByZXN1bHQgOnZhcmlhYmxlLXZhbHVlKSkKOzsgICAgICAgICAgKQoKCjs7ICAgKGluc2VydCAiCjs7ICAgICAlcwo7OyAgICAgaWYgWyAkeyVzfSAtZ3QgMCBdOyB0aGVuCjs7ICAgICAgICAgJXMgLS0gYXJnPSIiCjs7ICAgICAgICAgZm9yIGluZGV4IGluICR7ISVzW0BdfTsgZG8KOzsgICAgICAgICAgICAgJXMgLWkgY3VycmVudD0kKCggJGluZGV4ICsgMSApKQo7OyAgICAgICAgICAgICBhcmc9JHslc1skaW5kZXhdfQo7OyAgICAgICAgIGRvbmUKOzsgICAgIGZpCjs7ICIgdmFyaWFibGUtZGVjbGFyYXRpb24ta2V5d29yZCApKQo7OyAgICkK

(defvar debug-fun-history
  (list)
  "history of calls to `debug-fun'")

(defun debug-fun-get-completing-read-collection (string pred action)
  (let ((prefix-completions (mapcar #'intern (all-completions string definition-prefixes))))
    (complete-with-action action obarray string
                          (if pred (lambda (sym)
                                     (or (funcall pred sym)
                                         (memq sym prefix-completions)))))
    )
  )
(defun debug-fun-get-completing-read-predicate (f)
  (or (commandp f) (fboundp f) (get f 'function-documentation)))

(defun debug-fun-read-function-from-minibuffer (&rest unused-args)
  (let* (
         ;; (completing-read-function #'debug-completing-read-function)
         (collection #'debug-fun-get-completing-read-collection)
         (predicate #'debug-fun-get-completing-read-predicate)
         (function-name (completing-read  "function to call: " collection predicate t nil debug-fun-history))
         (function-symbol (condition-case err
                              (intern function-name)
                            (error (let ((error-message "error in `debug-fun-read-function-from-minibuffer': %s"
                                                        (error-message-string err)))
                                     (c-message "%s" error-message)
                                     error-message)
                                   ) ;; end condition-case (error
                            ) ;; end condition-case
                          ) ;; end (let* ... function-symbol
         (function-object (format "%S" function-symbol))

         ) ;;end varlist (let*
    (when (not (null unused-args))
      (c-message-debug-symbols (list 'unused-args)))

    ;; KGxldCAoKHRoaXMtZnVuY3Rpb24gImRlYnVnLWZ1bi1yZWFkLWZ1bmN0aW9uLWZyb20tbWluaWJ1ZmZlciIpKQogICAgICAoYy1tZXNzYWdlLWRlYnVnLXN5bWJvbHMKICAgICAgIChsaXN0ICdmdW5jdGlvbi1uYW1lICdmdW5jdGlvbi1zeW1ib2wgJ2Z1bmN0aW9uLW9iamVjdCAncmVzdWx0ICkKICAgICAgICd0aGlzLWZ1bmN0aW9uKSk=

    (list function-symbol)
    ))

(defun debug-fun(function-name)
  (interactive (debug-fun-read-function-from-minibuffer));; end interactive
  ;; (c-message-open "%s\n%s" function-name (apply function-to-call args-to-function-to-call))
  (erase-c-messages)
  (let* (
         (function-symbol (condition-case err
                              (or (when (or (functionp function-name)
                                            (commandp function-name))
                                    (c-message "function-name is function")
                                    function-name)
                                  (when (symbolp function-name)
                                    (c-message "function-name is symbol")
                                    (symbol-value function-name))
                                  (when (stringp function-name)
                                    (c-message "function-name is string")
                                    (intern function-name))
                                  (user-error "unexpected function-name argument: %S" function-name))

                            (error (let ((error-message (format "error in `debug': %s" (error-message-string err))))
                                     (c-message "%s" error-message)
                                     error-message)
                                   )))
         (function-arity (car (func-arity function-symbol)))
         ) ;; end let* varlist
    (let ((this-function "debug-fun")
          (function-symbol-is-list (if (listp function-symbol) "t" "nil"))
          (function-name-is-list (if (listp function-name) "t" "nil"))
          )
      (c-message-debug-symbols
       (list 'function-name 'function-symbol 'function-arity 'function-name-is-list 'function-symbol-is-list)
       'this-function 'function-symbol-is-list 'function-name-is-list 'function-arity
       ) ;; end c-message-debug-symbols
      );; end let

    (if (= 0 function-arity)
        (c-message "(%s)\n%S" function-name
                   (condition-case err
                       (funcall function-symbol)
                     (error (format "failed to call function %S: %S" function-name err ))
                     )) ;; end c-message
      ;; else
      (user-error "cannot call function %S without args because it takes %s argument%s"
                  function-name
                  function-arity
                  (if (= 1 function-arity) "" "s")) ;; end handler (error ...)
      ) ;; end if
    ) ;;end (let*
  )

(defun debug/Ox33b4O/$/mark-indicator/active()
  (interactive)
  ;;(enable-debug-on-error)
  (erase-c-messages)
  (Ox33b4O/$/mark-indicator/active))


(defun debug-completing-read-function (prompt collection &optional predicate
                                              require-match initial-input
                                              hist def inherit-input-method)
  "fork of `completing-read-function' that debugs buffer-local variables set within the `minibuffer-with-setup-hook' call "

  (when (consp initial-input)
    (setq initial-input
          (cons (car initial-input)
                ;; `completing-read' uses 0-based index while
                ;; `read-from-minibuffer' uses 1-based index.
                (1+ (cdr initial-input)))))

  (let* ((base-keymap (if require-match
                          minibuffer-local-must-match-map
                        minibuffer-local-completion-map))
         (keymap (if (memq minibuffer-completing-file-name '(nil lambda))
                     base-keymap
                   ;; Layer minibuffer-local-filename-completion-map
                   ;; on top of the base map.
                   (make-composed-keymap
                    minibuffer-local-filename-completion-map
                    ;; Set base-keymap as the parent, so that nil bindings
                    ;; in minibuffer-local-filename-completion-map can
                    ;; override bindings in base-keymap.
                    base-keymap)))
         (keymap (if minibuffer-visible-completions
                     (make-composed-keymap
                      (list minibuffer-visible-completions-map
                            keymap))
                   keymap))
         (buffer (current-buffer))
         (c-i-c completion-ignore-case)
         (result
          (progn
            (let ((minibuffer-completion-table collection) (minibuffer-completion-predicate predicate) (minibuffer-completion-confirm (unless (eq require-match t) require-match)) (minibuffer--require-match require-match) (minibuffer--original-buffer buffer) (completion-ignore-case c-i-c))
              (c-message-debug-symbols (list 'minibuffer-completion-table 'minibuffer-completion-predicate 'minibuffer-completion-confirm 'minibuffer--require-match 'minibuffer--original-buffer 'completion-ignore-case))
              )

            (minibuffer-with-setup-hook
                (lambda ()

                  (setq-local minibuffer-completion-table collection)
                  (setq-local minibuffer-completion-predicate predicate)
                  ;; FIXME: Remove/rename this var, see the next one.
                  (setq-local minibuffer-completion-confirm
                              (unless (eq require-match t) require-match))
                  (setq-local minibuffer--require-match require-match)
                  (setq-local minibuffer--original-buffer buffer)
                  ;; Copy the value from original buffer to the minibuffer.
                  (setq-local completion-ignore-case c-i-c))
              (read-from-minibuffer prompt initial-input keymap
                                    nil hist def inherit-input-method)))))
    (when (and (equal result "") def)
      (setq result (if (consp def) (car def) def)))
    result))
(erase-c-messages)

(defconst blackpy-regex-error-details
  "^\\(error:\\s-*\\)?\\(cannot\\s-*format\\s-*\\(\\s-*\\([^:[:space:]]+\\)\\(:?\\)\\(\\s-*\\)\\)\\)\\(\\s-*\\([^:]+\\)\\(:\\)?\\(\\s-*\\)\\)\\(\\s-*\\([^:]+\\)\\(:\\)?\\(\\s-*\\)\\)\\(\\s-*\\([^:]+\\)\\(:\\)?\\(\\s-*\\)\\)\\(\\s-*\\(.+\\)\\(\\s-*\\)\\)$"
  )

(defun blackpy ()
  "TODO: use `call-process-get-status-and-info' instead of duplicating most of the code of `blackpy'."
  (interactive)
  (erase-messages)
  (let* ((current-filename (expand-file-name (buffer-file-name)))
         (tmp-buffer-name (format "*blackpy:%s*" current-filename))
         (tmp-buffer (create-fresh-buffer tmp-buffer-name))
         (blackpy-args (list tmp-buffer nil current-filename ))
         (exit-code
          (apply #'call-process (append (list "black" nil) blackpy-args))))
    (message
     (format "black %s exitted with code: %s" current-filename exit-code))

    (or
     (when (eq exit-code 0)
       (progn
         (message
          (format "%s formatted"
                  (abbreviate-file-name current-filename)))
         (revert-buffer t t t)
         ))
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
                 (beginning-of-buffer)
                 (goto-char (point-min))

                 (if (re-search-forward
		      blackpy-regex-error-details
		      regex-point-end
		      t 1)
                     (progn
                       ;; (let ((full-match (match-string 0))
                       ;;       (matched-groups (mapcar #'(lambda (group-num)
                       ;;                                   ;;(cons group-num (match-string group-num))
                       ;;                                   (list
                       ;;                                    (format "<match-string-%d>" group-num (match-string group-num))
                       ;;                                    )
                       ;;                                   (number-sequence 1 21))))
                       ;;       (c-message-debug-symbols (list 'matched-groups 'full-match 'error-string 'blackpy-regex-error-details ) 'full-match)
                       ;;       )
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
	       )
	     ))
       (if (and (listp error-details)
                (not (null (nth 4 error-details))))
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
          (format "black %s failed with code: %s"
                  (abbreviate-file-name current-filename)
                  exit-code)))
       ))
    (ignore-errors (kill-buffer tmp-buffer))
    ))

(defun isearch-input-regexp-read-function-from-minibuffer (prompt)
  (setq c-message-write-to-minibuffer nil)
  ;; (c-message-open "")
  (let* (
         (regexp-ring (symbol-value 'regexp-search-ring))
         (initial-input (car regexp-ring))
         (regexp (read-string (format "%s: " prompt) initial-input
                              'regexp-search-ring))
         )
    (add-to-history 'regexp-search-ring regexp)
    (list regexp)
    ))

(defun isearch-forward-input-regexp(regexp)
  "updates isearch ring with `regexp' and subsequently calls isearch-forward-regexp"
  (interactive (isearch-input-regexp-read-function-from-minibuffer "isearch-forward-regexp"))
;;   (c-message-debug-symbols 'regexp)
  (isearch-update-ring regexp t)
  (isearch-forward-regexp)
  (isearch-update)
  )
(defun isearch-backward-input-regexp(regexp)
  "updates isearch ring with `regexp' and subsequently calls isearch-backward-regexp"
  (interactive (isearch-input-regexp-read-function-from-minibuffer "isearch-backward-regexp"))
  (isearch-update-ring regexp t)
  (isearch-backward-regexp)
  (isearch-update)
  )

(defun format-error-string (message &optional short-desc label)
  "returns string propertized with font-lock face background and foreground colors

`MESSAGE' must be a string.
`SHORT-DESC', if provided, should be a string.
`LABEL', if provided, should be a string.
"
  (declare (pure t) (side-effect-free t) (important-return-value t))
  (when (null short-desc)
    (setq label ""))
  (when (null label)
    (setq label "error"))
  (let* ((prefix-noproperties (string-join (mapcar #'(lambda (element) (format "%s" element)) (list label short-desc))))
         (prefix (propertize prefix-noproperties
                             'face
                             (list :foreground "#F13976" ;; #FC580C ;;
                                   ;; #DB5045 ;;
                                   ;; #F80101 ;;
                                   ;; #F5BF08 ;;
                                   ;; #F6CA51 ;;
                                   ;; #DCDC88 ;;
                                   ;; #F49101 ;;
                                   :background "#211F17" ;; #1C1C1C ;;
                                   ;; #312F27 ;;
                                   ;; #211F17
                                   ))
                 )
         (inner-message (format "%s" message))
         (message (propertize inner-message
                              'face
                              (list :foreground "#F6A3D7" ;; #F937B9
                                    ;; #C63367
                                    ;; #F479C4
                                    ;; #EF5AAA
                                    ;; #FF79C6
                                    :background "#3d3d3d" ;; #211F17
                                    ;; #1C1C1C
                                    ;; #312F27
                                    ;; #211F17
                                    )))
         )
    (format "%s %s" prefix message)
    )
  )



(defconst make-indent-default-width
  4)


(defun make-indent (&optional width)
  (declare (pure t) (side-effect-free t) (important-return-value t))

  (let ((width (cond ((null width)
                      make-indent-default-width)
                     ((and (numberp width)
                           (> width 0))
                      width)
                     ((numberp width)
                      (error "`width' is a negative number: %S" width))
                     (error "`width' is not a positive number: %S" width))))
    (string-join (make-list width ""))))

;; OzsgKGRlZnVuIGVuc3VyZS1saXN0LW9mLXN0cmluZ3MgKHN0cmluZ3MgJm9wdGlvbmFsIG5vZXJyb3IpCjs7ICAgInRha2VzIGEgbGlzdCBvZiBzdHJpbmdzIGFuZCByZXR1cm5zIGEgbGlzdCB3aGVyZSBldmVyeSBpdGVtIGlzIGEgc3RyaW5nCjs7IGBTVFJJTkdTJyBpcyBhIGxpc3Qgb2Ygc3RyaW5ncwoKOzsgVGhlIG9wdGlvbmFsIHRoaXJkIGFyZ3VtZW50IGBOT0VSUk9SJyBpbmRpY2F0ZXMgd2hhdCBzaG91bGQgaGFwcGVuIHdoZW4KOzsgYW55IGVsZW1lbnQgaW4gdGhlIGBTVFJJTkdTJyBsaXN0IGlzIG5vdCBhIHN0cmluZzogaWYgaXQgaXMgbmlsIG9yCjs7IG9taXR0ZWQsIGVtaXQgYW4gZXJyb3I7Cjs7IGZsYXR0ZW5zIG5lc3RlZCBsaXN0cyBpZiBgQVJHJyBpcyBgZmxhdCcuCjs7IG1vZGUgaWYgQVJHIGlzIG5pbCwgb21pdHRlZCwgb3IgaXMgYSBwb3NpdGl2ZSBudW1iZXIuICBEaXNhYmxlIHRoZSBtb2RlCjs7IGlmIEFSRyBpcyBhIG5lZ2F0aXZlIG51bWJlci4KCjs7IGlmIGl0IGlzIHQgb3IgYW55IG5vbi1uaWwgdmFsdWUsIGNvbnZlcnQgdGhlCjs7IGVsZW1lbnQgdG8gc3RyaW5nIGxpa2UgYHByaW5jJyB3b3VsZC4KOzsgIgo7OyAgIChsZXQgKChwYWRkaW5nIChtYWtlLWluZGVudCB3aWR0aCkpCjs7ICAgICAgICAgKGl0ZW1zIChzZXEtbWFwLWluZGV4ZWQKOzsgICAgICAgICAgICAgICAgICMnKGxhbWJkYSAoaW5kZXggaXRlbSkKOzsgICAgICAgICAgICAgICAgICAgICAodW5sZXNzIChhbmQgKHN0cmluZ3AgaXRlbSkgbm9lcnJvcikKOzsgICAgICAgICAgICAgICAgICAgICAgIChlcnJvciAiYHN0cmluZ3MnIGVsZW1lbnQgJXMgaXMgbm90IGEgc3RyaW5nIGNvbnM6ICVTIiBpbmRleCBpdGVtKSkKOzsgICAgICAgICAgICAgICAgICAgICAoZm9ybWF0ICIlcyVzIiBwYWRkaW5nIGl0ZW0pKSkpKSkpCg==
(defun indent-strings (strings &optional width noerror)
  "takes a list of strings and return a new list indenting each string
`STRINGS' is a list of strings
`WIDTH' has the behavior of `make-indent'.

The optional third argument `NOERROR' indicates what should happen when
any element in the `STRINGS' list is not a string: if it is nil or
omitted, emit an error; if it is t or any non-nil value, convert the
element to string like `princ' would.
"
  (declare (pure t) (side-effect-free t) (important-return-value t))
  (let* ((padding (make-indent width))
         (items (seq-map-indexed
                 #'(lambda (index item)
                     (unless (or (stringp item) noerror)
                       (error "`strings' element %s is not a string cons: %S" index item))
                     (format "%s%s" padding item))
                 strings)))))

(defun create-debug-tag-pair (name &optional attributes)
  "returns a pair of strings that look like the open and close of an xml element.
`NAME' is the string with the tag name.
`ATTRIBUTES' if provided, must be a list where each element is either a string or a cons corresponding to an attribute name and its value."
  (declare (pure t) (side-effect-free t) (important-return-value t))
  (unless (stringp name)
    (error "`name' is not a string: %S" name))
  (unless (listp attributes)
    (setq attributes (ensure-list attributes)))

  (let ((items (seq-map-indexed
                #'(lambda (index attr)
                    (cond ((stringp name)
                           name)
                          ((consp attr)
                           (let ((key (car attr))
                                 (value (cdr attr)))
                             (unless (or (stringp key)
                                         (numberp key))
                               (error "the car of `attributes' index %s is neither a string nor a number: %S" index key))
                             (format "%s=%S" key value)))
                          (t
                           (error "`attributes' index %s is neither a string nor a cons: %S" index attr))
                          ))
                attributes)))
    (cons (format "<%s>" (string-join (list name (string-join items))))
          (format "</%s>" name))))

(defun make-debug-tag (name &optional attributes &rest debug-values)
  "returns a string to debug `debug-values'"
  (declare (pure t) (side-effect-free t) (important-return-value t))

  (let* ((values (indent-strings debug-values nil t))
         (closes (length> values 0))
         (pair (create-debug-tag-pair name (append attributes (and closes '/))))
         (open (car pair))
         (close (unless (not closes) (cdr pair))))

    (string-join
     (indent-strings (list open (string-join values "\n") close))
     "\n")
    ))

(defun current-indentation-data()
  "returns a plist with the line-number, column and position of the current or next line's indentation"
  (save-match-data
    (save-mark-and-excursion
      (beginning-of-line)
      (let* (
             (initial-column (current-column))
             (initial-line (line-number-at-pos (point)))
             (initial-pos (point))
             (indentation-col initial-column)
             (indentation-line initial-line)
             (indentation-pos initial-pos)
             (nline initial-line)
             (ncol initial-column)
             )
        (while (and (not (eobp))
                    (string-match "[[:space:]]" (format "%c" (char-after (point)))))
          (forward-char)
          (setq
           indentation-column (current-column)
           indentation-line (line-number-at-pos (point))
           indentation-pos (point));;setq
          (let* ((delta (- indentation-pos initial-pos))
                 (plural (or (and (= delta 1) "") "s")))
            (c-message "forwarded %d char%s" delta plural)
            ;;(c-message-debug-symbols (list 'indentation-column 'indentation-line 'indentation-pos))
            )
          )


        (while (and (not (eobp))
                    (not (string-match "[[:space:]]" (format "%c" (char-after (point))))))
          (forward-char)
          (setq
           indentation-column (current-column)
           indentation-line (line-number-at-pos (point))
           indentation-pos (point)
           )
          (let* ((delta (- indentation-pos initial-pos))
                 (plural (or (and (= delta 1) "") "s")))
            (c-message "forwarded %d char%s" delta plural)
            ;;(c-message-debug-symbols (list 'indentation-column 'indentation-line 'indentation-pos))
            )

          );; while
        (unless (> indentation-pos initial-pos)
          (list
           :column (current-column)
           :line-number (line-number-at-pos (point))
           :pos (point)));list ; return value
        );;let*
      );;save-mark-and-excursion
    );;save-match-data
  );; defun current-indentation-data

(defun current-indentation()
  (or (plist-get (current-indentation-data) :column) 0))

(defun shell-script-insert-argv-skel(&optional local arg-prefix)
  (let* ((declare-stmt (cond ((or (equal t local)
                                  (equal local 'local)
                                  (equal local :local))
                              "local")
                             ((or (null local)
                                  (equal local 'declare)
                                  (equal local :declare))
                              "declare")
                             ("declare")))
         (arg-prefix (cond
                      ((stringp arg-prefix)
                       (format "%s_" (string-trim-right arg-prefix "_+")))
                      ((null arg-prefix) "")
                      (t
                       (error "shell-script-insert-argv-skel argument arg-prefix should be string or nil, got %S" arg-prefix))
                      ))
         (replacements (list (cons "%declare%" declare-stmt) (cons "%arg_prefix%" arg-prefix ) ))
         (col (current-indentation))
         (statements (mapcar #'(lambda (stmt)
                                 (seq-reduce #'(lambda (string kv)
                                                 (let ((from (car kv))
                                                       (to (cdr kv)))
                                                   (replace-regexp-in-string from to string t)))
                                             replacements stmt))
                             '(
                               "%declare% -a %arg_prefix%argv=($@)"
                               "%declare% -i %arg_prefix%argc=${!%arg_prefix%argv[@]}"
                               "%declare% -i index=0"
                               "%declare% -i current=0"
                               "%declare% -- arg=\"\""
                               ""
                               "if [ ${%arg_prefix%argc} -eq 0 ]; then"
                               "    1>&2 echo -e \"[${BASH_SOURCE[0]}:${BASH_LINENO[0]}]\" \"missing arguments\""
                               "    exit 1"
                               "fi"
                               ""
                               "for index in ${!%arg_prefix%argv[@]}; do"
                               "    current=$(($index + 1))"
                               "    arg=\"${%arg_prefix%argv[$index]}\""
                               "    case \"${arg}\" in"
                               "        -h|--help)"
                               "            1>&2 echo -e \"HELP\""
                               "            ;;"
                               "        *)"
                               "            ;;"
                               "    esac"
                               "done"
                               ""
                               )))
         )

    (save-mark-and-excursion
      (seq-do #'(lambda (stmt)
                  (beginning-of-line)
                  (forward-char col)
                  (insert stmt "\n" (string-join (make-list col " ")))
                  );;end lambda
              statements))
    ))

(defun shell-script-declare-argv()
  (interactive)
  (shell-script-insert-argv-skel))

(defvar shell-script-local-argv-read-input-history
  (list))

(defun shell-script-local-argv-read-input (prompt)
  (setq c-message-write-to-minibuffer nil)
  (let* (
         (initial-input (car shell-script-local-argv-read-input-history))
         (arg-prefix (string-trim (read-string (format "%s: " prompt) initial-input
                                               'shell-script-local-argv-read-input-history)))
         )
    (add-to-history 'shell-script-local-argv-read-input-history arg-prefix)
    (list arg-prefix)
    ))

(defun shell-script-local-argv(arg-prefix)
  (interactive (shell-script-local-argv-read-input "prefix (optional)"))
  (shell-script-insert-argv-skel t arg-prefix))

(defmacro save-mark-excursion-and-match-data (&rest body)
  "shortcut to nesting macro calls to `save-match-data' and `save-mark-and-excursion'."
  (declare (indent 0) (debug t))
  `(save-match-data
     (save-mark-and-excursion
       ,@body)))

(defun interactive-read-region-enabling-prompt ()
  (unless (region-active-p)
    (user-error "no region active is not active"))
  (list (region-beginning) (region-end)))

(defun mode-name-as-string()
  (let ((result
  (or (and (stringp mode-name)
           mode-name)
      (and (listp mode-name)
           (car mode-name))
      (error (signal 'type-error (format "mode-name has unexpected type %s: %S" (type-of mode-name) mode-name)))
      )))
    (downcase result)))

(defun shell-script-expand-oneliner-region (beg end)
  ;; OzsgOzsgKGRlZnVuIHNoZWxsLXNjcmlwdC1leHBhbmQtb25lbGluZXIgKGJlZyBlbmQpCjs7IDs7ICAgKGludGVyYWN0aXZlICJyIikKOzsgOzsgICAocmVwbGFjZS1yZWdleHAtaW4tcmVnaW9uCjs7IDs7ICAgICJcXGJcXChkb1xcfGRvbmVcXHx0aGVuXFx8ZWxzZVxcfGZpXFwpXFxiIiAiXG5cXDFcbiIgYmVnIGVuZCkpCjs7ICh1bmRlZnVuICMnc2hlbGwtc2NyaXB0LWV4cGFuZC1vbmVsaW5lcikK
  (interactive (interactive-read-region-enabling-prompt))
  (unless (string= (mode-name-as-string) "shell-script")
    (user-error "only works in shell-script-mode, not %s-mode" (mode-name-as-string)))
  (let* ((new-end (copy-marker end))
         (last-pos (copy-marker end))
          )
    (save-mark-excursion-and-match-data
      (widen)
    (replace-regexp-in-region "\\(do\\|;\\)\\s-+\\b\\(if\\|then\\|else\\|fi\\|done\\)\\b"
                              "\\1\n\\2\n" beg end)
        (setq last-pos (point)
          new-end (point))
        )

    (save-mark-excursion-and-match-data
      (replace-regexp-in-region "\\(if\\|then\\)[\n[:space:]]+"
                                "\\1 " beg new-end)
      (replace-regexp-in-region "\\(;\\)\\(\\s-*\\)\n\\(\\s-*\\)\\(then\\)\\s-+"
                              "\\1 \\2 \\3\\4\n\\2\\3"
                              beg new-end)
    ) ;; save-mark-excursion-and-match-data
    (save-mark-and-excursion
      (widen)
      (goto-char beg)
      (indent-region beg new-end)
      )
    (save-mark-and-excursion
      (widen)
      (flush-lines "^\\s-*[;]\\s-*$" beg new-end)
      )
    );; let*
  );defun

(define-error 'format-string-error "Format Error" 'c-functions-internal-error)
(define-error 'type-error "Format Error" 'error)
(define-error 'eval-sexp-string-error "Eval Expression Error" 'c-functions-internal-error)

(defun format-string-signal-error(spec value)
  (condition-case format-err
      (and (funcall #'format (list spec sexp-value ))
           nil)
    (error (signal 'format-string-error format-err))))


(defun eval-sexp-signal-error(sexp)
  (condition-case eval-err
      (and                (eval-expression sexp)
                          nil)
    (error (signal 'eval-sexp-string-error eval-err))))

(defun rgb-red-green-blue-assign-create-regex-propertized-symlist-for-each-band(band index)
  (let* ((band-name (symbol-name band))
         (subexp-val (* 2 (+ 1 index)))
         (match (match-beginning subexp-val))
         (val (string-to-number match))
         (hexa (format "%02x" val))
         (sym-name (format "%s#%s" band-name hexa))
         (sym (intern sym-name))
         ) ;; let* varlist
    (put sym 'decimal-value val)
    (put sym 'hexa hexa)
    (put sym 'band band)
    (put sym 'sym-name sym-name)
    sym);; end (let*
  );; end (lambda

(defun rgb-triband-symlist()
  (list 'red 'green 'blue))

(defun rgb-red-green-blue-get-triband-list-from-match-data()
  (seq-map-indexed #'rgb-red-green-blue-assign-create-regex-propertized-symlist-for-each-band
                   (rgb-triband-symlist)))

(defun rgb-red-green-blue-band-sym-to-hex(sym)
  (or (get sym 'hexa)
      (error "expected symbol %s to have property `'hexa'" sym)))


(defun rgb-red-green-blue-matched-triband-to-rgb-hex(bands)
  (format "#%s" (string-join (mapcar #'rgb-red-green-blue-band-sym-to-hex
                                     bands))))

(defconst rgb-red-green-blue-assign-regex
  ;;"\\(\\bred\\b\\s-*=\\s-*\\([0-9]+\\)\\s-*\\)\\(\\bgreen\\b\\s-*=\\s-*\\([0-9]+\\)\\s-*\\)\\(\\bblue\\b\\s-*=\\s-*\\([0-9]+\\)\\s-*\\)"
  "\\(red\\s-*=\\s-*\\([0-9]+\\)\\s-*\\)\\(green\\s-*=\\s-*\\([0-9]+\\)\\s-*\\)\\(blue\\s-*=\\s-*\\([0-9]+\\)\\s-*\\)"
  )

(defun rgb-red-green-blue-re-search-forward(beg end)
  (re-search-forward rgb-red-green-blue-assign-regex end t))

(defun rgb-red-green-blue-assign-to-rgb-hex-region(beg end)
  (interactive "*r")
  ;;red=255 green=0 blue=66
  ;;     (save-mark-excursion-and-match-data
  (save-match-data
    (let* ((new-end end)
           (re-match-index (rgb-red-green-blue-re-search-forward beg new-end))
           (matched-indexes (list re-match-index))
           );end let* varlist
      (unless (not (null re-match-index))
        (user-error "%s" (c-message "could not match regexp %S againt text: %S"
                               rgb-red-green-blue-assign-regex
                               (buffer-substring-no-properties beg new-end))))
      (while re-match-index
        (setq bands (rgb-red-green-blue-get-triband-list-from-match-data))
        (setq rgb-hex (rgb-red-green-blue-matched-triband-to-rgb-hex bands))
        (setq new-end (match-end))
        (goto-char (match-beginning))
        (replace-match rgb-hex)
        (goto-char (match-end))
        (setq re-match-index (rgb-red-green-blue-re-search-forward beg end))
        (push re-match-index matched-indexes)
        );; end while
      );; end let*
    );; save-match-data
  ;;       );; save-mark-excursion-and-match-data
  );;end defun
