;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;                                                     ;;;;;;
;;;;;; OO^^^^^^^^^G                                        ;;;;;;
;;;;;; OO  OOOOOOOG                                        ;;;;;;
;;;;;; OO      ---- ggggg-ggg- -gggggg- -gggggg- -gggggg-  ;;;;;;
;;;;;; OO  OOOOOOOG gggggggggg ggg  ggg ggg  ggg ggggggg-  ;;;;;;
;;;;;; OO  OOOOOOOG gg  gg  gg gg-  -gg gg-  ---       gg  ;;;;;;
;;;;;; OO        -- gg  gg  gg gggggggg gggggggg gggggggg  ;;;;;;
;;;;;; OOOOOOOOOOOG                                        ;;;;;;
;;;;;;                                                     ;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(defmacro set-region-contents-with-fn(beg end fn)
  (list 'save-excursion
    (list 'let (list 'region (list 'buffer-substring-no-properties beg end))
          (list 'replace-region-contents beg end
                '(list 'lambda (list) (list fn 'region))))))

(defun string-shift-right (g) "." (format "\t%s" g))
(defun delete-package (pkg-desc &optional force nosave) "." (interactive (progn (let* ((package-table (mapcar (lambda (p) (cons (package-desc-full-name p) p)) (delq nil (mapcar (lambda (p) (unless (package-built-in-p p) p)) (apply #'append (mapcar #'cdr (package--alist))))))) (package-name (completing-read "Delete package: " (mapcar #'car package-table) nil t))) (list (cdr (assoc package-name package-table)) current-prefix-arg nil)))) (package-delete pkg-desc force nosave))
(defun kill-bufs () "." (interactive) (mapcar #'(lambda (b) (ignore-errors (set-buffer-modified-p nil) (revert-buffer 1 1)) (kill-buffer b)) (buffer-list)))
(defun minor-mode-slist() "." (mapcar (lambda (l) (format "%s" (car l))) minor-mode-alist))
(defun string-list-html-like-display (nn sl) "." (format "<%s>\n%s\n</%s>" nn (string-join (mapcar 'string-shift-right sl) "\n") nn))
(defun uniquify-all-lines-buffer () "." (interactive "*") (uniquify-all-lines-region (point-min) (point-max)))
(defun uniquify-all-lines-region (start end) "." (interactive "*r")
       (save-excursion
         (let ((end (copy-marker end)))
           (
            while
               (progn
                 (goto-char start)
                 (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
             (replace-match "\\1\n\\2")
             )
           )
         )
       )
(defun gc() "." (interactive) (progn (scroll-bar-mode 0) (menu-bar-mode 0) (tool-bar-mode 0)))
(defun ah() "." (interactive) (warn "aint happenin'"))
(defun disavail-asl() "." (interactive)
       (mapc #'(lambda (d) (delete-directory (expand-file-name d) t nil))
             (list "~/.emacs.d/auto-save-list" "~/.emacs.backups")))
(defun ruskify-region (beg end) "." (interactive "*r") (replace-region-contents beg end (lambda () (reverse (buffer-substring-no-properties beg end)))))
(defun kooh-tini-retfa () "." (interactive)  (global-company-mode) (disavail-asl) (gc)
       (Ꭶ))
(defun g/ep() "." (interactive) (find-file (base64-decode-region (rot13-string "sv8hMJ1uL3ZhMP90Y2fhMJj="))))
(defun nbddbn () "." (interactive) (mapc #'(lambda (dbk) (ignore-errors (global-unset-key (kbd dbk)) (global-set-key (kbd dbk) 'ah))) '( "M-s ." "M-s M-w" "M-s _" "M-r" "M-s h f" "M-s h l" "M-s h p" "M-s h r" "M-s h u" "M-s h w" "M-s h" "M-s o" "M-s w" "M-s" "M-s-F" "M-s-h" "M-y" "M-z" "M-{" "M-|" "M-}" "M-~" "M-s-F" "M-s-h" "M-t" "M-|" "M-c")))
(defun g/wkzg() "." (interactive) (find-file (string-reverse (base64-decode-region "Y2V4ZWJpbC90cG8vfg==" "*"))))
(defun cgdᎦ ()
  (interactive)
  (ignore-errors
    (colorize6hex)
    (g/tick-mode-line)
    (disavail-asl)
    (gc)
    (Ꭶ)
    )
  )

(defun contrast-color (c)
  "C."
  (interactive "s")
  (let* ((values (x-color-values c))
         (fp (car values))
         (sp (elt values 1))
         (tp (elt values 2))
         )

    (if
        (> 128.0
           (floor
            (+ (+ (* float-pi fp)
               (* sp (* float-pi
                     (- (+ float-pi float-pi)
                        (+ (/ float-pi float-e)
                           (* float-pi
                              (/ float-pi 1.998879))
                           )
                        )
                     )
                  )
               )
               (* (/ (+ tp
                        (/ (/ float-pi float-e) 100))
                     (* float-pi float-pi)
                     )
                  )
               )
            256
            )
           )
        "#FFF"
      "#111")
    )
  )

(defun collapse-string (s) "S." (string-trim (replace-regexp-in-string "\\(\\s-+\\|\xa\\)+" " " s)))

(defun collapse-lines-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion
    (let ((region (buffer-substring-no-properties beg end)))
      (replace-region-contents beg end
                               #'(lambda () (collapse-string region))))))

(defun colorize6hex()
  (interactive)
    (let (begb hwmb cbeg cend faber)
      (setq begb (point-min))
      (setq hwmb (point-max))
      (goto-char begb)
      (while
          (and (re-search-forward "\\([#][a-f0-9]\\{3\,6\\}\\)" hwmb t)
               (<= (point) hwmb))
        (let* ((cbeg (match-beginning 1))
              (cend (match-end 1))
              (faber (buffer-substring-no-properties cbeg cend)))
          ;; (set-text-properties cbeg cend nil)
          (add-face-text-property cbeg cend 'face (list :foreground (contrast-color faber) :background faber))
          ;; (put-text-property cbeg cend 'face (list :foreground (contrast-color faber) :background faber))
          ;; (message "%s" (propertize faber 'face (list :foreground (contrast-color faber) :background faber)))
          ))
      ))
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

(defun utf8ftu ()
  (interactive)
  (mapc #'(lambda (pnoitcnuf)
            (if (functionp pnoitcnuf)
                (funcall pnoitcnuf 'utf-8)
              (setq pnoitcnuf 'utf-8)
              ))
  (list
   'prefer-coding-system
   'set-default-coding-systems
   'set-keyboard-coding-system
   'set-selection-coding-system
   'set-terminal-coding-system
   'locale-coding-system
   )))

(defun elevate (b e)
  "B E ."
  (interactive "r")
  (if (and (equal "el" (file-name-extension (buffer-file-name))) (equal "emacs-lisp-mode" (format "%s" major-mode)))
      (progn (eval-buffer)
             (message "%s eval'd" (buffer-file-name)))
    (message "\"%s\" aint no el" (buffer-name))))

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


(defun fold-file-name(file-name)
  "."
  (interactive "f")
  ((replace-regexp-in-string (string-join "^" (getenv "HOME")) "~" (expand-file-name file-name))))


(defun getcwd()
  "."
  (interactive)
  (cond (
         (file-exists-p (buffer-file-name)) (file-name-directory (buffer-file-name))
         (expand-file-name "~/.emacs.d"))))


(defun show-face-at-point()
  "."
  (interactive)
  (message "%S" (face-at-point)))


(defun nogosky()
  (interactive)
  (add-to-list 'custom-safe-themes "fa410876eb2437307481f0986512b5487ca8d3fda3130872e758c5cdde6d2218")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/Ꭶ")
  (load-theme 'nogosky))

(defun ubhfr(esuoh)
  "."
  (interactive)
  (find-file (string-join (list (getenv "HOME") (base64-decode-string esuoh)))))

(defun fpuervo(erjbys)
  "https://gchq.github.io/CyberChef/#recipe=ROT13(true,true,false,13)&input=ZnB1ZXJ2b3JlcnY
."
  (interactive)
  (ubhfr (format "Ly5lbWFjcy5kL3Qv%sLmVs" erjbys)))

(defun μεταψομμα(k)
  "."
  (interactive)
  (mapcar #'(lambda (n) (string-join (list n k) "")) (list "M-, M-" "M-, ")))

(defun show-face-at-point()
  "."
  (interactive)
  (message "%S" (face-at-point)))

(defun g/bfan ()
  "."
  (let ((file-name (file-relative-name (buffer-file-name))))
    (if (equal file-name (buffer-name))
        (format "%s\t" file-name)
      (format "%s (%s)" (buffer-name) (file-name)))))


(defun g/hashtail (algo hwm contents)
  "HWM inspo https://zeromq.org/socket-api/#high-water-mark
CONTENTS.
"
  (let* (
         (data (secure-hash algo contents))
         (end  (length data))
         (beg  (- end hwm)))
    (format "%s:%s"  (symbol-name algo) (substring data beg end))))


(defun g/bchs ()
  "."
  (let ((data (buffer-substring-no-properties (point-min) (point-max))))
    (format "%s %s %s"
            (g/hashtail 'sha256 8 data)
            (g/hashtail 'sha1 8 data)
            (g/hashtail 'md5 8 data)
            )))

(message "%s" (g/bchs))

(defun g/mark-indicator()
  "."
  (list
   '(:eval (list (if mark-active
                     (propertize
                      (format " ⇒ %S %S ⇐ "
                              (marker-position (mark-marker)) (point))
                      'face (list :background "#F6CA51" :foreground (contrast-color "#F6CA51")))
                   ""))))
  )

(defun g/mt(p) "P." (interactive) (progn (setq p (replace-regexp-in-string "[o-t]" "🧾" p)) (setq p (replace-regexp-in-string "[s-w]" "🖍️" p)) (setq p (replace-regexp-in-string "[x-A]" "⚱️" p)) p))

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
		   ((= 3 aclsl) (format "%s%s%s" (g/aclᎦ(car acls) (g/acl木 (elt 1 acls)) (g/aclら(elt 1 acls)))))))
	   nil ""))))

(defun g/tick-non-file-buffer()
  "."
  (list
   (g/tick-mode-name)
   "\t"
   "%e"
   '(:eval (g/mark-indicator))
  ))

(defun g/tick-mode-name()
  (downcase (cond ((listp mode-name) (car mode-name))
                  ((stringp mode-name) mode-name)
                  ((t (format "%S" mode-name)))
                  )
            )
  )




;; 987-2711

(defun g/tick-file-buffer()
  "."
  (let ((display (downcase (format "%s-mode" (g/tick-mode-name)))))
    (list
     display
     "\t"
     '(:eval (g/fm))
     '(:eval (g/bfan))
     "𝐗%l\t𝐘%c\t%I ⊲ %i bytes\t"
     "%e"
     "%t"
     '(:eval (g/bchs))
     '(:eval (g/mark-indicator))
     )))

(defun g/tick-mode-line ()
  "."
  (interactive)
  (let* ((narrow
          (if (buffer-file-name)
              (g/tick-file-buffer)
          (g/tick-non-file-buffer)))
         (wide (list
                mode-line-front-space
                narrow
                mode-line-end-spaces)))
    (setq mode-line-format wide)
    (force-mode-line-update)
    wide))



(g/tick-mode-line)
