# coding: utf-8
from fnmatch import fnmatch, fnmatchcase
from os.path import splitext
from pathlib import Path
from itertools import chain


emacs_d = Path("~/.emacs.d").expanduser().absolute()
emacs_d_subdirs = list(filter(lambda p: p.is_dir(), emacs_d.iterdir()))
emacs_d_c = emacs_d.joinpath("c")
# elisp_file_paths = list(filter(lambda path: not fnmatch(path, "*/{}"), emacs_d.glob("**/*.el")))
patterns = [
    "*.el",
]
patterns.extend([f"{subdir.name}/*.el" for subdir in emacs_d_subdirs
                 if 'elpa' not in str(subdir) and str(subdir) not in ['3pty', '.git', 'socket'] or len(list(subdir.iterdir())) == 0])
elisp_file_paths = list(chain(*[emacs_d.glob(pat) for pat in patterns]))
for el in elisp_file_paths:
    with el.open('rb') as fd:
        contents = fd.read()
    new = contents.replace(b'\r', b'\n')
    with el.open('wb') as fd:
        fd.write(new)

# elisp_file_paths_b = list(emacs_d.glob("{*.el,c/*.el}"))
# elisp_file_paths_f = list(emacs_d.glob("{*.el,c/*.el,sandbox/*.el}"))


# emacs_d_c_el = [
#     path
#     for path in list(emacs_d_c.iterdir())
#     if path.is_file() and path.name.endswith(".el")
# ]
#emacs_d_c_el_base_map = dict(
#    [(splitext(path.name)[0], path) for path in list(emacs_d_c.iterdir())]
#)
#emacs_d_c_contents_by_filename = dict(
#    [(splitext(path.name)[0], path) for path in list(emacs_d_c.iterdir())]
#)
#
# for el in emacs_d_c_el:
#     with el.open(mode="rb") as fd:
#         emacs_d_c_contents_by_filename[el.name] = fd.read()
#
# functions_el = emacs_d_c_contents_by_filename["functions.el"]
