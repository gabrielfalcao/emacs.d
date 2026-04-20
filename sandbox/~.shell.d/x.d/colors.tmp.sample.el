;;;
;;;
;;;add_color \
;;;    "yellow light" \
;;;    "#FCE94F" \
;;;    "252;233;79m" \
;;;    "22;22;22m"
;;;

(defconst colors-el-replace-regexp-regexp-pattern-read-syntax
  "^\\s-*add_color\\(?:\\([[:space:]]\\|[\n]\\|[\\]\\s-*$\\)+\\)\\(\x22\\([^\x22]+\\)\x22\\)\\(?:\\([[:space:]]\\|[\n]\\|[\\]\\s-*$\\)+\\)\\(\x22\\([^\x22]+\\)\x22\\)\\(?:\\([[:space:]]\\|[\n]\\|[\\]\\s-*$\\)+\\)\\(\x22\\([^\x22]+\\)\x22\\)\\(?:\\([[:space:]]\\|[\n]\\|[\\]\\s-*$\\)+\\)\\(\x22\\([^\x22]+\\)\x22\\)"
  "regexp to match lines such as below:

add_color \
    \x22yellow light\x22 \
    \x22#FCE94F\x22 \
    \x22252;233;79m\x22 \
    \x2222;22;22m\x22

add_color \x22aluminum dark dark\x22 \
    \x22#2E3436\x22 \
    \x2246;52;54m\x22 \
    \x22200;200;220m\x22
")

(defconst colors-el-replace-regexp-regexp-pattern-read-syntax
  "^\s-*add_color\(?:\([[:space:]]\|[
]\|[\]\s-*$\)+\)\(\x22\([^\x22]+\)\x22\)\(?:\([[:space:]]\|[
]\|[\]\s-*$\)+\)\(\x22\([^\x22]+\)\x22\)\(?:\([[:space:]]\|[
]\|[\]\s-*$\)+\)\(\x22\([^\x22]+\)\x22\)\(?:\([[:space:]]\|[
                                                   ]\|[\]\s-*$\)+\)\(\x22\([^\x22]+\)\x22\)"
  "same as `colors-el-replace-regexp-regexp-pattern-read-syntax' but in `re-builder''s \"string\" syntax"
)
(defun colors-el-replace-regexp-to-string ()
  "for use in the `TO-STRING' argument in interactive call to `replace-regexp'"
  (let* ((color-name \1)
         (rgb-rex \4)
         (ansi-rgb-color-suffix \5)
         (ansi-rgb-contrast-suffix \6)
         (color-slug
          (string-trim
           (save-match
            (replace-regexp-in-string "[^a-zA-Z0-9]+" "-" color-name)
            "[_-]+" "[_-]+")))
         (slug-sym
          (let ((color-slug-sym (intern color-slug)))
            (put color-slug-sym 'color-name color-name)
            (put color-slug-sym 'color-slug color-slug)
            (put color-slug-sym 'color-slug-or-symbol-name color-slug)
            (put color-slug-sym 'ansi-rgb-suffix ansi-rgb-suffix)
            (put color-slug-sym 'ansi-rgb-contrast-suffix ansi-rgb-contrast-suffix)
            (put color-slug-sym 'rgb-hex rgb-hex)
            color-slug-sym))
         (name-sym
          (let ((color-name-sym (intern color-name)))
            (put color-name-sym 'color-name color-name)
            (put color-name-sym 'color-slug color-slug)
            (put color-name-sym 'color-slug-or-symbol-name color-slug)
            (put color-name-sym 'ansi-rgb-suffix ansi-rgb-suffix)
            (put color-name-sym 'ansi-rgb-contrast-suffix ansi-rgb-contrast-suffix)
            (put color-name-sym 'rgb-hex rgb-hex)
            color-name-sym))
         )  ; end (let* (...) ...) varlist
    ;; <effective body of colors-el-replace-regexp-to-string>
    ;; </effective body of colors-el-replace-regexp-to-string>
    ) ; end (let* ...)
  ); end (defun colors-el-replace-regexp-to-string() ...)
