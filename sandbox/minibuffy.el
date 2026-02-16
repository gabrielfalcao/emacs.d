(progn
  (erase-c-messages)
  (c-message-open "")
  (c-message "minibuffer-history-symbol is a %s of value: %S" (type-of 'minibuffer-history-symbol)
             'minibuffer-history-symbol))
