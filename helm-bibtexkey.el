;;; helm-bibtexkey.el --- Bibtexkey source for helm

;; Copyright (C) 2014  TAKAGI Kentaro <kentaro0910@gmail.com>

;; Author: TAKAGI Kentaro <kentaro0910@gmail.com>
;; URL: https://github.com/kenbeese/helm-bibtexkey
;; Package-Requires: ((helm "1.5.8"))
;; Keywords: bib, tex

;; This program is free software; you can redistribute it and/or
;; modify it under the terms of the GNU General Public License
;; as published by the Free Software Foundation; either version 3
;; of the License, or (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with this program. If not, see <http://www.gnu.org/licenses/>.

;;; Commentary:
;;
;;; Code:

(require 'helm)

(defvar helm-bibtexkey-parser
  "/path/to/bibtexkey_source.py"
  "Bibtexkey parser path")

(defvar helm-bibtexkey-filelist
  '()
  "List of bibtexkey filepath.")

(setq helm-source-bibtexkey
  '((name . "bibtexkey")
    (candidates . helm-bibtexkey-candidates)
    (candidate-transformer . helm-bibtexkey-candidates-transformer)
    (action . (("Insert" . insert)))))

(defun helm-bibtexkey-candidates ()
  (let ((command (concat helm-bibtexkey-parser " "
                         (mapconcat 'identity helm-bibtexkey-filelist " "))))
    (split-string (shell-command-to-string command) "\n")))

(defun helm-bibtexkey-candidates-transformer (candidates)
  (mapcar 'helm-bibtexkey-split-to-bibkey-and-description
          candidates))

(defun helm-bibtexkey-split-to-bibkey-and-description (arg)
  (let ((re "^\\([^, ]*\\)[, ]*\\(.*\\)$")
        key
        description)
    (string-match re arg)
    (setq key (match-string 1 arg))
    (setq description (match-string 2 arg))
    (cons description key)))

(defun helm-bibtexkey ()
  (interactive)
  (helm-other-buffer '(helm-source-bibtexkey) "*helm-bibtex*"))

(provide 'helm-bibtexkey)
;;; helm-bibtexkey.el ends here
