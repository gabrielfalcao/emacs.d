OUTPUT
======


The output from this command is designed to be used as a commit
template comment. The default, long format, is designed to be human
readable, verbose and descriptive. Its contents and format are subject
to change at any time.

The paths mentioned in the output, unlike many other Git commands, are
made relative to the current directory if you are working in a
subdirectory (this is on purpose, to help cutting and pasting). See
the status.relativePaths config option below.

Short Format
------------


In the short-format, the status of each path is shown as one of these
forms

::

    XY PATH
    XY ORIG_PATH ``->`` PATH

where ORIG_PATH is where the renamed/copied contents came
from. ORIG_PATH is only shown when the entry is renamed or copied. The
XY is a two-letter status code.

The fields (including the ``->``) are separated from each other by a
single space. If a filename contains whitespace or other nonprintable
characters, that field will be quoted in the manner of a C string
literal: surrounded by ASCII double quote (34) characters, and with
interior special characters backslash-escaped.

There are three different types of states that are shown using this
format, and each one uses the XY syntax differently:

• When a merge is occurring and the merge was successful, or outside
of a merge situation, X shows the status of the index and Y shows the
status of the working tree.

• When a merge conflict has occurred and has not yet been resolved, X and Y show the state introduced by each head of the merge, relative
to the common ancestor. These paths are said to be unmerged.

• When a path is untracked, X and Y are always the same, since they are unknown to the index.  ??  is used for untracked paths. Ignored
files are not listed unless --ignored is used; if it is, ignored files are indicated by !!.

Note that the term merge here also includes rebases using the
default --merge strategy, cherry-picks, and anything else using the
merge machinery.

In the following table, these three classes are shown in separate
sections, and these characters are used for X and Y fields for the
first two sections that show tracked paths:

• ' ' = unmodified

• ``M`` = modified

• T = file type changed (regular file, symbolic link or submodule)

• A = added

• D = deleted

• R = renamed

• C = copied (if config option status.renames is set to "copies")

• U = updated but unmerged

::

    X          Y     Meaning
    -------------------------------------------------
             [AMD]   not updated
    ``M``        [ MTD]  updated in index
    T        [ MTD]  type changed in index
    A        [ MTD]  added to index
    D                deleted from index
    R        [ MTD]  renamed in index
    C        [ MTD]  copied in index
    [MTARC]          index and work tree matches
    [ MTARC]    ``M``    work tree changed since index
    [ MTARC]    T    type changed in work tree since index
    [ MTARC]    D    deleted in work tree
                R    renamed in work tree
                C    copied in work tree
    -------------------------------------------------
    D           D    unmerged, both deleted
    A           U    unmerged, added by us
    U           D    unmerged, deleted by them
    U           A    unmerged, added by them
    D           U    unmerged, deleted by us
    A           A    unmerged, both added
    U           U    unmerged, both modified
    -------------------------------------------------
    ?           ?    untracked
    !           !    ignored
    -------------------------------------------------

Submodules have more state and instead report ``M`` the submodule has a different HEAD than recorded in the index ``m`` the submodule has modified
content ? the submodule has untracked files since modified content or untracked files in a submodule cannot be added via git add in the
superproject to prepare a commit.

``m`` and ? are applied recursively. For example if a nested submodule in a submodule contains an untracked file, this is reported as ? as
well.

If -b is used the short-format status is preceded by a line

::
   ## branchname tracking info


Porcelain Format Version 1
--------------------------

Version 1 porcelain format is similar to the short format, but is
guaranteed not to change in a backwards-incompatible way between Git
versions or based on user configuration. This makes it ideal for
parsing by scripts. The description of the short format above also
describes the porcelain format, with a few exceptions:

1. The user’s color.status configuration is not respected; color will
   always be off.

2. The user’s status.relativePaths configuration is not respected;
   paths shown will always be relative to the repository root.

There is also an alternate -z format recommended for machine
parsing. In that format, the status field is the same, but some other
things change.

First, the ``->`` is omitted from rename entries and the field order is
reversed (e.g from ``->`` to becomes to from).

Second, a NUL (ASCII 0) follows each filename, replacing space as a
field separator and the terminating newline (but a space still
separates the status field from the first filename).

Third, filenames containing special characters are not specially
formatted; no quoting or backslash-escaping is performed.

Any submodule changes are reported as modified ``M`` instead of ``m`` or single ``?``.
