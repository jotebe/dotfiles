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

(require 'zoom-frm)

(global-set-key (kbd "s-+") 'zoom-in)
(global-set-key (kbd "s--") 'zoom-out)

(add-hook 'sh-mode-hook (lambda () ((setq indent-tabs-mode t)
                                    (setq-default tab-width 4))))

(require 'flx-ido)
(flx-ido-mode 1) 

(setq gc-cons-threshold 20000000)
