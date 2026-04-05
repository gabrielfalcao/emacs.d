ack -l --el 'erase-buffer-by-name' | xargs -Ieachel sed -E 's,erase-buffer-by-name,erase-buffer-by-buffer-or-name,g' -i 'eachel'
