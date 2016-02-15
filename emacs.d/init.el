(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))
(add-to-list 'load-path "~/.emacs.d/lisp/")
(setq exec-path (append '("/usr/local/bin") exec-path))

(package-initialize)

(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

(server-start)

(show-paren-mode t)

;;;; macros
(defmacro after (mode &rest body) ;; http://milkbox.net/note/single-file-master-emacs-configuration/
  "`eval-after-load' MODE evaluate BODY."
  (declare (indent defun))
  `(eval-after-load ,mode
     '(progn ,@body)))

;; ;;;; plugin config
;; (after "helm-autoloads"
;;        (require 'helm-config)
;;        (global-set-key (kbd "M-x")                          'undefined)
;;        (global-set-key (kbd "M-x")                          'helm-M-x)
;;        (global-set-key (kbd "C-x r b")                      'helm-filtered-bookmarks)
;;        (global-set-key (kbd "C-x C-f")                      'helm-find-files))

(require 'zoom-frm)

(global-set-key (kbd "s-+") 'zoom-in)
(global-set-key (kbd "s--") 'zoom-out)

