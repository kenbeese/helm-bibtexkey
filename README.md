helm-bibtexkey
==============

helm source of bibtexkey.

Sample setting
==============

Please install `pybtex`.
For example, `sudo easy_install pybtex`.

Moreover, please write following setting to your `~/.emacs`

```lisp
(add-to-list 'load-path "/path/to/this/filedirectory")
(require 'helm-bibtexkey)
(setq helm-bibtexkey-filelist '("/path/to/bibtexfile1" "/path/to/bibtexfile2"))
```

Please type `M-x helm-bibtexkey`. Enjoy!
