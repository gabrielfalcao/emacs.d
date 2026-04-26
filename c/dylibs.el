(module-load "/Users/gabrielfalcao/projects/third_party/emacs-module-rs/target/debug/libemacs_rs_module.dylib")
(rs-module/load "/Users/gabrielfalcao/projects/work/poems.codes/tools/emacs-subprocess/target/debug/libemacs_subprocess.dylib")

(require 'greeting)
(greeting-say-hello "Emacs")
