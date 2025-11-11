;;  ___  _   _  _ ___   ___   ___
;; | _ \/_\ | \| |   \ / _ \ / __|
;; |  _/ _ \| .` | |) | (_) | (__
;; |_|/_/ \_\_|\_|___/ \___/ \___|
;;

(defvar history-pandoc-to
  (list)
  "history of choices typed in previous calls to `pandoc-to'")

(defconst pandoc-valid-input-formats
  (list
   "biblatex"
   "bibtex"
   "commonmark"
   "commonmark_x"
   "creole"
   "csljson"
   "csv"
   "docbook"
   "docx"
   "dokuwiki"
   "endnotexml"
   "epub"
   "fb2"
   "gfm"
   "haddock"
   "html"
   "ipynb"
   "jats"
   "jira"
   "json"
   "latex"
   "man"
   "markdown"
   "markdown_github"
   "markdown_mmd"
   "markdown_phpextra"
   "markdown_strict"
   "mediawiki"
   "muse"
   "native"
   "odt"
   "opml"
   "org"
   "ris"
   "rst"
   "rtf"
   "t2t"
   "textile"
   "tikiwiki"
   "tsv"
   "twiki"
   "typst"
   "vimwiki"

   )
  "list of valid pandoc input formats (.i.e.: as listed in shell command \"pandoc --list-input-formats\") ")

(defconst pandoc-valid-output-formats
  (list
   "asciidoc"
   "asciidoc_legacy"
   "asciidoctor"
   "beamer"
   "biblatex"
   "bibtex"
   "chunkedhtml"
   "commonmark"
   "commonmark_x"
   "context"
   "csljson"
   "docbook"
   "docbook4"
   "docbook5"
   "docx"
   "dokuwiki"
   "dzslides"
   "epub"
   "epub2"
   "epub3"
   "fb2"
   "gfm"
   "haddock"
   "html"
   "html4"
   "html5"
   "icml"
   "ipynb"
   "jats"
   "jats_archiving"
   "jats_articleauthoring"
   "jats_publishing"
   "jira"
   "json"
   "latex"
   "man"
   "markdown"
   "markdown_github"
   "markdown_mmd"
   "markdown_phpextra"
   "markdown_strict"
   "markua"
   "mediawiki"
   "ms"
   "muse"
   "native"
   "odt"
   "opendocument"
   "opml"
   "org"
   "pdf"
   "plain"
   "pptx"
   "revealjs"
   "rst"
   "rtf"
   "s5"
   "slideous"
   "slidy"
   "tei"
   "texinfo"
   "textile"
   "typst"
   "xwiki"
   "zimwiki"
   )
  "list of valid pandoc output formats (.i.e.: as listed in shell command \"pandoc --list-output-formats\") ")

validate-extension-to-pandoc-input
validate-extension-to-pandoc-output

(defun pandoc-to(to-extension)
  "converts \"(`buffer-file-name' (`current-buffer'))\"
open in current buffer to the given extension as long as pandoc
accepts file extension of current buffer's filename"
  (interactive
   (let* ((from-filename (buffer-file-name))
          (path-minus-ext (file-name-sans-extension from-filename))
          (from-extension (file-name-extension from-filename))
          (to-extension
           (completing-read "target extension: " acceptable-extensions t t 'history-pandoc-to
                            ) ;; end completing-read
           ) ;;end let variable: to-extension
          (to-filename (let (
                             (from-extension-is-valid (validate-extension-to-pandoc-input 'from-extension))
                             (to-extension-is-valid (validate-extension-to-pandoc-output 'to-extension))
                             (to-filename (file-name-concat path-minus-ext to-extension))
                             (error-prefix (format "cannot convert %s to %s extension" from-filename to-extension))
                             )
                         (or (when (not from-extension-is-valid)
                               (user-error "%s: \"%s\" is an invalid input pandoc extension" error-prefix from-extension ))
                             (when (not to-extension-is-valid)
                               (user-error "%s: \"%s\" is an invalid output pandoc extension" error-prefix to-extension ))
                             )
                         to-filename
                         );; end (to-filename (let...
                       );; end let variable: to-filename
          (pandoc-args (list "-i" from-filename "-o" to-filename))
          (pandoc-result
           (call-program-with-list-args "pandoc" ))
          (pandoc-exit-code (car pandoc-result))
          (pandoc-output (car (cdr pandoc-result)))) ;; end interactive => let*
     (if (= pandoc-exit-code 0) ;;let* => if
         (find-file to-filename) ;;let* => if => then

       ;; let* => if => else
       (let* ((failed-command (format "pandoc %s" (string-join pandoc-args " ")))
              (xml-attr (format "of=\"%s\"" failed-command))
              (output-o-tag (format "<output %s>" xml-attr))
              (output-c-tag (format "</output>"))
              (output (format "%s\n%s\n%s\n" output-o-tag pandoc-output output-c-tag))); end let* varlist
         (user-error "command \"%s\" failed with status %d:\n%s\n" failed-command pandoc-exit-code output)
         ) ;; end if => else => let*
       ) ;; end if => else
     ); end interactive => let*
   ); end interactive
  ); end defun => pandoc-to
