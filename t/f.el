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
  (list 'save-excursion (list 'let (list 'region (list 'buffer-substring-no-properties beg end))
                              (list 'replace-region-contents beg end '(list 'lambda (list)
                                                                            (list fn 'region))))))

(defun string-shift-right (g)
  "."
  (format "\t%s" g))
(defun delete-package (pkg-desc &optional force nosave)
  "."
  (interactive (progn (let* ((package-table (mapcar
                                             (lambda (p)
                                               (cons (package-desc-full-name p) p))
                                             (delq nil (mapcar
                                                        (lambda (p)
                                                          (unless (package-built-in-p p) p))
                                                        (apply #'append (mapcar #'cdr
                                                                                (package--alist)))))))
                             (package-name (completing-read "Delete package: " (mapcar #'car
                                                                                       package-table)
                                                            nil t)))
                        (list (cdr (assoc package-name package-table)) current-prefix-arg nil))))
  (package-delete pkg-desc force nosave))
(defun kill-bufs ()
  "."
  (interactive)
  (mapcar #'(lambda (b)
              (ignore-errors (set-buffer-modified-p nil)
                             (revert-buffer 1 1))
              (kill-buffer b))
          (buffer-list)))
(defun minor-mode-slist()
  "."
  (mapcar
   (lambda (l)
     (format "%s" (car l)))
   minor-mode-alist))
(defun string-list-html-like-display (nn sl)
  "."
  (format "<%s>\n%s\n</%s>" nn (string-join (mapcar 'string-shift-right sl) "\n") nn))
(defun uniquify-all-lines-buffer ()
  "."
  (interactive "*")
  (uniquify-all-lines-region (point-min)
                             (point-max)))
(defun uniquify-all-lines-region (start end)
  "."
  (interactive "*r")
  (save-excursion (let ((end (copy-marker end)))
                    (while (progn (goto-char start)
                                  (re-search-forward "^\\(.*\\)\n\\(\\(.*\n\\)*\\)\\1\n" end t))
                      (replace-match "\\1\n\\2")))))

(defun gc()
  "."
  (interactive)
  (progn (scroll-bar-mode 0)
         (menu-bar-mode 0)
         (tool-bar-mode 0)))
(defun ah()
  "."
  (interactive)
  (warn
   "aint happenin'"))
(defun disavail-asl()
  "."
  (interactive)
  (mapc #'(lambda (d)
            (delete-directory (expand-file-name d) t nil))
        (list "~/.emacs.d/auto-save-list" "~/.emacs.backups")))
(defun ruskify-region (beg end)
  "."
  (interactive "*r")
  (replace-region-contents beg end
                           (lambda ()
                             (reverse
                              (buffer-substring-no-properties
                               beg
                               end)))))
(defun kooh-tini-retfa ()
  "."
  (interactive)
  (global-company-mode)
  (disavail-asl)
  (gc)
  (Ꭶ))
(defun Ꭶ/ep()
  "."
  (interactive)
  (find-file (base64-decode-region (rot13-string "sv8hMJ1uL3ZhMP90Y2fhMJj="))))
(defun nbddbn ()
  "."
  (interactive)
  (mapc #'(lambda (dbk)
            (ignore-errors (global-unset-key (kbd dbk))
                           (global-set-key (kbd dbk) 'ah)))
        '( "M-s ." "M-s M-w" "M-s _" "M-r" "M-s h f" "M-s h l" "M-s h p" "M-s h r" "M-s h u" "M-s h w"
           "M-s h" "M-s o" "M-s w" "M-s" "M-s-F" "M-s-h" "M-y" "M-z" "M-{" "M-|" "M-}" "M-~" "M-s-F"
           "M-s-h" "M-t" "M-|" "M-c")))
(defun Ꭶ/wkzg()
  "."
  (interactive)
  (find-file (string-reverse (base64-decode-region "Y2V4ZWJpbC90cG8vfg==" "*"))))
(defun cgdᎦ ()
  (interactive)
  (ignore-errors
    ;;(colorize6hex)
    (Ꭶ/tick-mode-line)
    (disavail-asl)
    (gc)
    (Ꭶ)))

(defun contrast-color (c)
  "C."
  (interactive "s")
  (compute-bright-dark-from-color-value c "#FFF" "#111"))

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
  (replace-regexp-in-string "\\s-+" " " (string-trim (replace-regexp-in-string "\\(\\s-+\\|\xa\\)+"
                                                                               " " s))))

(defun collapse-lines-region (beg end)
  "BEG END."
  (interactive "*r")
  (save-excursion (let ((region
                         (buffer-substring-no-properties
                          beg
                          end)))
                    (replace-region-contents beg end #'(lambda ()
                                                         (collapse-string region))))))

(defun colorize6hex()
  (interactive)
  (save-excursion (let (begb hwmb cbeg cend faber)
                    (setq begb (point-min))
                    (setq hwmb (point-max))
                    (goto-char begb)
                    (while (and (re-search-forward "\\([#][a-f0-9]\\{3\,6\\}\\)" hwmb t)
                                (<= (point) hwmb))
                      (let* ((cbeg (match-beginning 1))
                             (cend (match-end 1))
                             (faber
                              (buffer-substring-no-properties
                               cbeg
                               cend)))
                        (add-face-text-property cbeg cend
                                                '(:foreground (contrast-color faber)
                                                              :background faber))
                        ;; (add-face-text-property cbeg cend 'face (list :foreground (contrast-color faber) :background faber))
                        ;; (add-face-text-property cbeg cend 'face (list :foreground (contrast-color faber) :background faber))
                        )))))


(defun Ꭶ/pl/fmt (fmtexect &optional major-mode)
  "FMTEXECT MAJOR-MODE."
  (unless (not  (buffer-modified-p (current-buffer)))
    (user-error "%s ought to be saved"  (buffer-name)))
  (unless (stringp fmtexect)
    (user-error "fmtexect nonstring"))
  (unless (symbolp major-mode)
    (user-error "major-mode nonsymbol"))
  (save-mark-and-excursion
    (let* ((target (expand-file-name (buffer-file-name)))
           (buffer (current-buffer))
           (name (format "*%s %s *" fmtexect target))
           (err (make-temp-file fmtexect nil (Ꭶ/hashnurtail 'sha512 6 (buffer-file-name)))))
      (if (and (file-readable-p target)
               (file-regular-p target))
          (let* (
                 (eco (format "%d" (call-process fmtexect nil '(buffer err) t target)))
                 (ets (format "%d" (file-attribute-size (file-attributes err)))))
            (if (or (not(equal "0" eco))
                    (not(equal "0" ets)))
                (progn
                  (set-buffer (get-buffer-create name t))
                  (insert-file-contents err nil nil nil t)
                  ;;     (set-buffer-major-mode major-mode)
                  (read-only-mode nil)
                  (pop-to-buffer (get-buffer-create name t) 'display-buffer-same-window nil)
                  (display-buffer (current-buffer)))))))))

(defun Ꭶ/pl/fmt/prettier/ts ()
  "."
  (interactive)
  (Ꭶ/pl/fmt (expand-file-name "~/.nvm/versions/node/v22.2.0/bin/prettier") 'typescript-mode))

(defun Ꭶ/pl/fmt/prettier/js ()
  "."
  (interactive)
  (Ꭶ/pl/fmt (expand-file-name "~/.nvm/versions/node/v22.2.0/bin/prettier") 'javacript-mode))


(defun utf8ftu ()
  (interactive)
  (mapc #'(lambda (pnoitcnuf)
            (if (functionp pnoitcnuf)
                (funcall pnoitcnuf 'utf-8-hfs-mac)
              (setq pnoitcnuf 'utf-8-hfs-mac) ))
        (list 'prefer-coding-system 'set-default-coding-systems 'set-keyboard-coding-system 'set-clipboard-coding-system 'set-next-selection-coding-system
              'set-selection-coding-system 'set-terminal-coding-system 'locale-coding-system )))
(defun buffer-elisp-heuristic()
  "."
  (or (string="el" (file-name-extension (buffer-file-name)))
      (string="emacs-lisp-mode" (Ꭶ/mode-name))
      (string="elisp-mode" (Ꭶ/mode-name))))
(defun region-points()
  "."
  (if mark-active (save-mark-and-excursion (list (marker-position (mark-marker))
                                                 (point)))
    (list (point-min)
          (point-max))))

(defun Ꭶ/levate ()
  "."
  (interactive)
  (if (buffer-elisp-heuristic)
      (let* ((beg-end (region-points))
             (beg (car beg-end))
             (end (car (cdr beg-end))))
        (eval-region beg end)
        (message "\"%s\" eval'd" (buffer-name)))
    (message "\"%s\" aint no el" (buffer-name))))

(defun Ꭶ/purge-key (pt)
  "PT."
  (if (or (vectorp pt)
          (listp pt))
      (mapc 'Ꭶ/purge-key pt)
    (let ((key (kbd pt)))
      (define-key (current-global-map) key nil))))

(defun Ꭶ/set-key (pt cg)
  "PT CG."
  (if (or (vectorp pt)
          (listp pt))
      (mapc #'(lambda (pt)
                (Ꭶ/set-key pt cg))
            pt)
    (let ((key (kbd pt)))
      (Ꭶ/purge-key pt)
      (define-key (current-global-map) key cg))))


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

(defun nogosky()
  (interactive)
  (add-to-list 'custom-safe-themes
               "fa410876eb2437307481f0986512b5487ca8d3fda3130872e758c5cdde6d2218")
  (add-to-list 'custom-theme-load-path "~/.emacs.d/Ꭶ")
  (load-theme 'nogosky))

(defun ubhfr(esuoh)
  "."
  (interactive)
  (find-file (string-join (list (getenv "HOME")
                                (base64-decode-string esuoh)))))

(defun fpuervo(erjbys)
  "https://gchq.github.io/CyberChef/#recipe=ROT13(true,true,false,13)&input=ZnB1ZXJ2b3JlcnY
."
  (interactive)
  (ubhfr (format "Ly5lbWFjcy5kL3Qv%sLmVs" erjbys)))

(defun μεταψομμα(k)
  "."
  (interactive)
  (mapcar #'(lambda (n)
              (string-join (list n k) ""))
          (list "M-, M-" "M-, ")))

(defun show-face-at-point()
  "."
  (interactive)
  (message "%S" (face-at-point)))

(defun Ꭶ/bfan ()
  "."
  (let ((file-name (file-relative-name (buffer-file-name))))
    (if (equal file-name (buffer-name))
        (format "%s" file-name)
      (format "%s (%s)" (buffer-name)
              (file-name)))))

(defun Ꭶ/hashnurtail (algo hwm contents)
  "HWM inspo https://zeromq.orᎦ/socket-api/#high-water-mark
CONTENTS.
"
  (let* ((data (secure-hash algo contents))
         (end  (length data))
         (beg  (- end hwm)))
    (substring data beg end)))


;; 987-2711

(defun Ꭶ/bchs ()
  "."
  (let ((data
         (buffer-substring-no-properties
          (point-min)
          (point-max))))
    (format "%s %s %s" (Ꭶ/hashtail 'sha256 8 data)
            (Ꭶ/hashtail 'sha1 8 data)
            (Ꭶ/hashtail 'md5 8 data))))

(defun Ꭶ/mark-indicator()
  "."
  (list
   '(:eval
     (list (if mark-active (propertize
                            (format " ⇒ %S %S ⇐ " (marker-position (mark-marker))
                                    (point))
                            'face (list :background "#F6CA51"
                                        :foreground
                                        (contrast-color
                                         "#F6CA51")))
             "")))
   " "))

(defun Ꭶ/aclᎦ(f)
  "F."
  (interactive)
  (if (stringp f)
      (Ꭶ/mt (format "🤸🏼‍♂️%s" f)) ""))

(defun Ꭶ/acl木(f)
  "F."
  (interactive)
  (if (stringp f)
      (Ꭶ/mt (format "👯(%s)" f)) ""))

(defun Ꭶ/aclら(f)
  "F."
  (interactive)
  (if (stringp f)
      (Ꭶ/mt (format "🎲️(%s)" f)) ""))

(defun Ꭶ/tick-mode-line-colorize (c contents)
  (let* ((foreground (format "#%s" (Ꭶ/hashnurtail 'sha512 6 c)))
         (background (compute-bright-dark-from-color-value foreground (Ꭶ/mode-line-foreground) (Ꭶ/mode-line-background))))
    ;;(debug "(Ꭶ/tick-mode-line-colorize %S %S) => %s %s" c contents foreground background)
    (propertize
     (format "%s" contents)
     'face (list :foreground foreground :background background))))


(defun Ꭶ/tick-mode-line-color (contents)
  (Ꭶ/tick-mode-line-colorize contents contents))

(defun Ꭶ/tick-non-file-buffer()
  "."
  (list (Ꭶ/tick-mode-name) " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t"
        '(:eval (Ꭶ/mark-indicator))))



(defun Ꭶ/tick-mode-name-npptz()
  (format "%s-mode" (replace-regexp-in-string "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$" "\\1" (downcase
                                                                                          (cond
                                                                                           ((listp
                                                                                             mode-name)
                                                                                            (car
                                                                                             mode-name))
                                                                                           ((stringp
                                                                                             mode-name)
                                                                                            mode-name)
                                                                                           ((t
                                                                                             (format
                                                                                              "%S"
                                                                                              mode-name)))) ))))
(defun Ꭶ/tick-mode-name()
  (Ꭶ/tick-mode-line-color (Ꭶ/tick-mode-name-npptz)))
(defun Ꭶ/tick-file-buffer()
  "."
  (list
   '(:eval (Ꭶ/mark-indicator))
   " "
   '(:eval (propertize (Ꭶ/bfan) 'face (list :foreground "#DEDBDC")))
   " " (propertize " ⇒ " 'face (list :background (Ꭶ/mode-line-background)
                                     :foreground "#79B9FF"))
   " "
   '(:eval (Ꭶ/tick-mode-name))
   " "
   '(:eval (Ꭶ/fm))
   " "
   '(:eval (Ꭶ/bchs))
   " " "   𝐗%l 𝐘%c %I ⊲ %i bytes " "%e" "%t"))

(defun Ꭶ/tick-mode-line ()
  "."
  (interactive)
  (let* ((narrow (if (buffer-file-name)
                     (Ꭶ/tick-file-buffer)
                   (Ꭶ/tick-non-file-buffer)))
         (wide (list mode-line-front-space narrow mode-line-end-spaces)))
    (setq mode-line-format wide)
    (force-mode-line-update) wide))



(defun Ꭶ/mode-name()
  (format "%s-mode" (replace-regexp-in-string "^\\([a-z0-9-]+\\)[^A-Za-z0-9-]+.*$" "\\1" (downcase
                                                                                          (cond
                                                                                           ((listp
                                                                                             mode-name)
                                                                                            (car
                                                                                             mode-name))
                                                                                           ((stringp
                                                                                             mode-name)
                                                                                            mode-name)
                                                                                           ((t
                                                                                             (format
                                                                                              "%S"
                                                                                              mode-name))))))))


(defun g/build ()
  (interactive "*")
  (cond ((string= "rust-mode" (Ꭶ/mode-name))
         (Ꭶ/pl/fmt (file-name-concat (getenv "HOME") ".cargo/bin/cargo check")))
        ((string= "typescript-mode" (Ꭶ/mode-name))
         (Ꭶ/pl/fmt/prettier/ts))
        ((string= "javacript-mode" (Ꭶ/mode-name))
         (Ꭶ/pl/fmt/prettier/js))
        ((nil t))))

(defun Ꭶ/base64-encode-region (beg end)
  (interactive "*r")
  (save-excursion (replace-region-contents beg end
                                           (lambda ()
                                             (collapse-string-2 (base64-encode-string
                                                                 (buffer-substring-no-properties
                                                                  beg
                                                                  end)))))))

(defun collapse-string-2 (s)
  "S."
  (replace-regexp-in-string "\\s-+" "" (collapse-string s)))


(defun collapse-lines-region-2 (beg end)
  "."
  (interactive "*r")
  (save-excursion (let ((region
                         (buffer-substring-no-properties
                          beg
                          end)))
                    (replace-region-contents beg end #'(lambda ()
                                                         (collapse-string-2 region))))))


(defun Ꭶ/mt(p)
  "P."
  (interactive)
  (let* ((p (replace-regexp-in-string "[o-t]" "🧾" p))
         (p (replace-regexp-in-string "[s-w]" "🖍️" p))
         (p (replace-regexp-in-string "[xX]" "⚱️" p)))
    p))


(defun Ꭶ/fm ()
  "."
  (interactive)
  (let ((ffb (format "%s" (file-attribute-modes (file-attributes (buffer-file-name))))))
    (let* ((acls (split-string ffb "-+" t "[^a-z]"))
           (aclsl (proper-list-p acls)))
      (cond ((= 1 aclsl)
             (format "%s"     (Ꭶ/aclᎦ (car acls))))
            ((= 2 aclsl)
             (format "%s%s"   (Ꭶ/aclᎦ(car acls)
                                     (Ꭶ/acl木 (elt 1 acls)))))
            ((= 3 aclsl)
             (format "%s%s%s" (Ꭶ/aclᎦ(car acls)
                                     (Ꭶ/acl木 (elt 1 acls))
                                     (Ꭶ/aclら(elt 1 acls)))))))))


(defun Ꭶ/flush-kill-ring () "." (interactive) (setq kill-ring nil) (message "ᎣᏁ ﾘﯓ ŢꝌ ビnd⍤𐐣"))
(defun Ꭶ/ᎮÃϯ (text) "."
       (interactive "sschreibe deine eingabe:")
       (unless (stringp text)
         (user-error "'text aint no string"))
       (let* ((ㆠᵮᵮㄦ (get-buffer-create (format "*figlet*%s*" text)))
              (ຈ𐊐ӈt (format "%s%s" comment-start comment-padding))
              (ᎮĀᏕȐ (save-mark-and-excursion
                      (shell-command (format "figlet -f nancyjg \"%s\"" text) ㆠᵮᵮㄦ (messages-buffer))
                      (set-buffer ㆠᵮᵮㄦ)
                      (format "%s\n" (buffer-substring-no-properties (point-min) (point-max))))))
         (save-mark-and-excursion
           (move-to-window-line 0)
           (move-to-column 0)
           (insert (replace-regexp-in-string "^" ຈ𐊐ӈt ᎮĀᏕȐ)))))


(defun Ꭶ/hashtail (algo hwm contents)
  "HWM inspo https://zeromq.orᎦ/socket-api/#high-water-mark
CONTENTS.
"
  ;; (format "%s:%s"  (symbol-name algo) (Ꭶ/hashnurtail algo hwm contents)))
  (format "%s"  (Ꭶ/hashnurtail algo hwm contents)))
