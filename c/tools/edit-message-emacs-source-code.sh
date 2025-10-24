#!/usr/bin/env bash

set -e
set -o pipefail
set -u

cd ~/projects/third_party/emacs/src

emc editfns.c +3189 # DEFUN("message") -- elisp definition calls message3(LispObject)
emc xdisp.c +12411 # message3(LispObject)
emc xdisp.c +12179 # message_dolog(const char *, ptrdiff_t, bool, bool);
emc frame.h +1188 # macro definition of FRAME_MINIBUF_WINDOW
