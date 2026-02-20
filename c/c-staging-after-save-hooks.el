(defun rust-delete-cargo-lock-after-saving-cargo-toml()
  (let* (
         (buf-filename-full-path (buffer-file-name))
         (filename (file-name-nondirectory buf-filename-full-path))
         (filename-base (progn
                          (unless (
                          (file-name-base filename)))
         (filename-ext (file-name-extension filename-base))
         )
    )
  )

(add-hook 'after-save-hook 'rust-delete-cargo-lock-after-saving-cargo-toml )
