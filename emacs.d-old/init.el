(set-language-environment "UTF-8")
(set-default-coding-systems 'utf-8)

;; tweak GC settings (mostly for flx-ido)
(setq gc-cons-threshold 20000000)

;; disable scroll and tool bars asap to prevent flash of them on startup
(when (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(when (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(when (fboundp 'scroll-bar-mode) (scroll-bar-mode -1))

;; make non-package lisp files available to require
(add-to-list 'load-path "~/.emacs.d/lisp/")

;; add homebrew bin path to exec-path so things like GPG are available as the versions I'm used to
(setq exec-path (append '("/usr/local/bin") exec-path))

(package-initialize)

;; load custom-file only after package-initialize, as many of the customizations depend on packages (the theme, for one)
(setq custom-file "~/.emacs.d/custom.el")
(load custom-file)

;; always try to run the server from this process (will fail noisily if another is running -- this is good)
(server-start)

;; always highlight the matching paren/paired symbol
(show-paren-mode t)
;; always highlight the line containing the point
(global-hl-line-mode t)

;; set up Cmd-+/Cmd-= and Cmd-- for Zoom (scale text size across whole frame, mimic iTerm)
(autoload 'zoom-in "zoom-frm" "zoom-frm/zoom-in" t)
(autoload 'zoom-out "zoom-frm" "zoom-frm/zoom-out" t)
(global-set-key (kbd "s-+") 'zoom-in)
(global-set-key (kbd "s-=") 'zoom-in)
(global-set-key (kbd "s--") 'zoom-out)

;; language-specific hooks and config
(add-hook 'sh-mode-hook (lambda ()
                          (setq indent-tabs-mode t)
                          (setq tab-width 2)
                          (setq sh-basic-offset 2)))

(add-hook 'css-mode-hook (lambda ()
                           (setq indent-tabs-mode f)
                           (setq tab-width 2)
                           (setq sh-basic-offset 2)))

(add-hook 'ruby-mode-hook (lambda ()
                            (setq indent-tabs-mode f)
                            (setq tab-width 2)
                            (setq sh-basic-offset 2)))

(add-hook 'js-mode-hook (lambda ()
                          (setq indent-tabs-mode f)
                          (setq tab-width 2)
                          (setq sh-basic-offset 2)
                          (rainbow-delimiters-mode)))

(add-hook 'prog-mode-hook (lambda ()
                            (rainbow-delimiters-mode)))


;; fix handling of 'word-chars'
(with-eval-after-load 'evil
    (defalias #'forward-evil-word #'forward-evil-symbol))

(global-set-key (kbd "C-@") 'er/expand-region)

;; use ZSH for multi-term shells
(eval-after-load 'multi-term
  '(progn
     (setq multi-term-program "/usr/local/bin/zsh")))


(require 'smartparens-config)

(setq lispy-modes '(clojure-mode-hook
                    emacs-lisp-mode-hook
                    eval-expression-minibuffer-setup-hook
                    ielm-mode-hook
                    lisp-mode-hook
                    scheme-mode-hook))

(mapc (lambda (hook)
        (add-hook hook #'smartparens-strict-mode)
        (add-hook hook #'evil-smartparens-mode)
        )
      lispy-modes)

(projectile-global-mode)

(defalias 'yes-or-no-p 'y-or-n-p)

(require 'smex)
(eval-after-load 'smex '(progn
						  (smex-initialize)
						  (global-set-key (kbd "M-x") 'smex)
						  (global-set-key (kbd "M-X") 'smex-major-mode-commands)
						  ;; Just in case, keep original M-x bound to something
						  (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)))

(require 'ace-jump-mode)
(define-key evil-normal-state-map (kbd "SPC") 'ace-jump-mode)

(ace-link-setup-default)

(global-evil-surround-mode 1)

(add-hook 'before-save-hook 'delete-trailing-whitespace)

(add-hook 'flyspell-mode
          (lambda ()
            (define-key evil-normal-state-map (kbd "] s") 'flyspell-goto-next-error)))

(add-to-list 'auto-mode-alist '("\\.rb$" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.rake$" . enh-ruby-mode))
(add-to-list 'interpreter-mode-alist '("ruby" . enh-ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ace$" . slim-mode))
(add-to-list 'auto-mode-alist '("\\.json$" . json-mode))
(add-to-list 'auto-mode-alist '("\\.template$" . json-mode))

(setq
   backup-by-copying t      ; don't clobber symlinks
   backup-directory-alist '(("." . "~/.saves"))    ; don't litter my fs tree
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)       ; use versioned backups

; disable asking to follow symlinks
(setq vc-follow-symlinks nil)

;; Set font used for unicode chars like emoji
(when (member "Menlo" (font-family-list))
  (set-fontset-font t 'unicode "Menlo" nil 'prepend))

(require 'epa-file)
(epa-file-enable)

;; this must happen after all other packages have been loaded, so it correctly auto-detects other packages and installs its own maps on top of them
(evil-mode 1)
