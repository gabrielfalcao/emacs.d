#!/Applications/Emacs.app/Contents/MacOS/emacs --script -Q -x -Q

(save-mark-and-excursion (save-match-data (while (re-search-forward "\\(?:[$][{]\\([a-z_]+[a-z0-9_]*\\)[}]\\|\\([a-z_]+[a-z0-9_]*\\)[=]\\(.*\\)\\)" nil t))))
