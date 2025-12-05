# coding: utf-8

from os.path import splitext
from pathlib import Path


emacs_d = Path("~/.emacs.d").expanduser().absolute()
emacs_d_c = emacs_d.joinpath("c")
emacs_d_c_el = [
    path
    for path in list(emacs_d_c.iterdir())
    if path.is_file() and path.name.endswith(".el")
]
emacs_d_c_el_base_map = dict(
    [(splitext(path.name)[0], path) for path in list(emacs_d_c.iterdir())]
)
emacs_d_c_contents_by_filename = dict(
    [(splitext(path.name)[0], path) for path in list(emacs_d_c.iterdir())]
)

for el in emacs_d_c_el:
    with el.open(mode="rb") as fd:
        emacs_d_c_contents_by_filename[el.name] = fd.read()


functions_el = emacs_d_c_contents_by_filename["functions.el"]
