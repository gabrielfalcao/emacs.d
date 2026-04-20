(defun colors-el-get-sh-input ()
  (let ((input-lines
         (format "

add_color \
    \x22yellow light\x22 \
    \x22#FCE94F\x22 \
    \x22252;233;79m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22yellow medium\x22 \
    \x22#EDD400\x22 \
    \x22237;212;0m\x22 \
    \x2266;66;66m\x22

add_color \
    \x22yellow dark\x22 \
    \x22#C4A000\x22 \
    \x22196;160;0m\x22 \
    \x22200;200;220m\x22

add_color \
    \x22orange light\x22 \
    \x22#FCAF3E\x22 \
    \x22252;175;62m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22orange medium\x22 \
    \x22#F57900\x22 \
    \x22245;121;0m\x22 \
    \x2266;66;66m\x22

add_color \
    \x22orange dark\x22 \
    \x22#CE5C00\x22 \
    \x22206;92;0m\x22 \
    \x22200;200;220m\x22

add_color \
    \x22chocolate light\x22 \
    \x22#E9B96E\x22 \
    \x22233;185;110m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22chocolate medium\x22 \
    \x22#C17D11\x22 \
    \x22193;125;17m\x22 \
    \x2266;66;66m\x22

add_color \
    \x22chocolate dark\x22 \
    \x22#8F5902\x22 \
    \x22143;89;2m\x22 \
    \x22200;200;220m\x22

add_color \
    \x22brown light\x22 \
    \x22#E9B96E\x22 \
    \x22233;185;110m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22brown medium\x22 \
    \x22#C17D11\x22 \
    \x22193;125;17m\x22 \
    \x2266;66;66m\x22

add_color \
    \x22brown dark\x22 \
    \x22#8F5902\x22 \
    \x22143;89;2m\x22 \
    \x22200;200;220m\x22

add_color \
    \x22green light\x22 \
    \x22#8AE234\x22 \
    \x22138;226;52m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22green medium\x22 \
    \x22#73D216\x22 \
    \x22115;210;22m\x22 \
    \x2266;66;66m\x22

add_color \
    \x22green dark\x22 \
    \x22#4E9A06\x22 \
    \x2278;154;6m\x22 \
    \x22200;200;220m\x22

add_color \
    \x22sky blue light\x22 \
    \x22#729FCF\x22 \
    \x22114;159;207m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22sky blue medium\x22 \
    \x22#3465A4\x22 \
    \x2252;101;164m\x22 \
    \x2266;66;66m\x22

add_color \
    \x22sky blue dark\x22 \
    \x22#204A87\x22 \
    \x2232;74;135m\x22 \
    \x22200;200;220m\x22

add_color \
    \x22purple light\x22 \
    \x22#AD7FA8\x22 \
    \x22173;127;168m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22purple medium\x22 \
    \x22#75507B\x22 \
    \x22117;80;123m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22purple dark\x22 \
    \x22#5C3566\x22 \
    \x2292;53;102m\x22 \
    \x22200;200;220m\x22

add_color \
    \x22scarlet red light\x22 \
    \x22#EF2929\x22 \
    \x22239;41;41m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22scarlet red medium\x22 \
    \x22#CC0000\x22 \
    \x22204;0;0m\x22 \
    \x2266;66;66m\x22

add_color \
    \x22scarlet red dark\x22 \
    \x22#A40000\x22 \
    \x22164;0;0m\x22 \
    \x22200;200;220m\x22

add_color \
    \x22active light\x22 \
    \x22#EEEEEC\x22 \
    \x22238;238;236m\x22 \
    \x2222;22;22m\x22

add_color \
    \x22active medium\x22 \
    \x22#D3D7CF\x22 \
    \x22211;215;207m\x22 \
    \x2266;66;66m\x22

add_color \x22aluminum light light\x22 \
    \x22#EEEEEC\x22 \
    \x22238;238;236m\x22 \
    \x2222;22;22m\x22

add_color \x22aluminum light medium\x22 \
    \x22#D3D7CF\x22 \
    \x22211;215;207m\x22 \
    \x2266;66;66m\x22

add_color \x22aluminum light dark\x22 \
    \x22#BABDB6\x22 \
    \x22186;189;182m\x22 \
    \x22200;200;220m\x22

add_color \x22aluminum dark light\x22 \
    \x22#888A85\x22 \
    \x22136;138;133m\x22 \
    \x2222;22;22m\x22

add_color \x22aluminum dark medium\x22 \
    \x22#555753\x22 \
    \x2285;87;83m\x22 \
    \x2266;66;66m\x22

add_color \x22aluminum dark dark\x22 \
    \x22#2E3436\x22 \
    \x2246;52;54m\x22 \
    \x22200;200;220m\x22

add_color \
    \x22active dark\x22 \
    \x22#BABDB6\x22 \
    \x22186;189;182m\x22 \
    \x22200;200;220m\x22

add_color \x22inactive light\x22 \
    \x22#888A85\x22 \
    \x22136;138;133m\x22 \
    \x2222;22;22m\x22

add_color \x22inactive medium\x22 \
    \x22#555753\x22 \
    \x2285;87;83m\x22 \
    \x2266;66;66m\x22

add_color \x22inactive dark\x22 \
    \x22#2E3436\x22 \
    \x2246;52;54m\x22 \
    \x22200;200;220m\x22

    " ))
        ) ;end (let (...) ...) varlist
    input-lines
    ) ;end (let ...)

  ) ;end (defun


(defconst colors-el-replace-regexp-regexp-pattern-read-syntax
  "^\\s-*add_color\\(?:\\([[:space:]]\\|[\n]\\|[\\]\\s-*$\\)+\\)\\(\x22\\([^\x22]+\\)\x22\\)\\(?:\\([[:space:]]\\|[\n]\\|[\\]\\s-*$\\)+\\)\\(\x22\\([^\x22]+\\)\x22\\)\\(?:\\([[:space:]]\\|[\n]\\|[\\]\\s-*$\\)+\\)\\(\x22\\([^\x22]+\\)\x22\\)\\(?:\\([[:space:]]\\|[\n]\\|[\\]\\s-*$\\)+\\)\\(\x22\\([^\x22]+\\)\x22\\)"
  "regexp to match lines such returned by `colors-el-get-sh-input'")

(defconst colors-el-replace-regexp-regexp-pattern-read-syntax
  "^\s-*add_color\(?:\([[:space:]]\|[
]\|[\\]\s-*$\)+\)\(\x22\([^\x22]+\)\x22\)\(?:\([[:space:]]\|[
]\|[\\]\s-*$\)+\)\(\x22\([^\x22]+\)\x22\)\(?:\([[:space:]]\|[
]\|[\\]\s-*$\)+\)\(\x22\([^\x22]+\)\x22\)\(?:\([[:space:]]\|[
]\|[\\]\s-*$\)+\)\(\x22\([^\x22]+\)\x22\)"
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
