(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default default default italic underline success warning error])
 '(ansi-term-color-vector
   [unspecified "#101010" "#7c7c7c" "#8e8e8e" "#a0a0a0" "#686868" "#747474" "#686868" "#b9b9b9"])
 '(column-number-mode t)
 '(custom-enabled-themes (quote (cyberpunk)))
 '(custom-safe-themes
   (quote
	("dcbe22bc74153257f412183dd14ab9652197f59adf65646e618c2577e7cca34d" "a0feb1322de9e26a4d209d1cfa236deaf64662bb604fa513cca6a057ddf0ef64" "7356632cebc6a11a87bc5fcffaa49bae528026a78637acd03cae57c091afd9b9" "fa2b58bb98b62c3b8cf3b6f02f058ef7827a8e497125de0254f56e373abee088" "bffa9739ce0752a37d9b1eee78fc00ba159748f50dc328af4be661484848e476" "ad950f1b1bf65682e390f3547d479fd35d8c66cafa2b8aa28179d78122faa947" "4f5bb895d88b6fe6a983e63429f154b8d939b4a8c581956493783b2515e22d6d" "12b4427ae6e0eef8b870b450e59e75122d5080016a9061c9696959e50d578057" "b4ec581daad15aa7020b722523dc6bcea850bfbdbe31bfeb11c45ea51899bd75" "03e3e79fb2b344e41a7df897818b7969ca51a15a67dc0c30ebbdeb9ea2cd4492" "59ca830d4df5e79503b79103485d28c6a578ca14d526ffc6a43596808daf1282" "16d6e7f87846801e17e0c8abc331cf6fa55bec73185a86a431aca6bec5d28a0a" "6916fa929b497ab630e23f2a4785b3b72ce9877640ae52088c65c00f8897d67f" "e681c4fc684a543ce97c2d55082c6585182c0089f605dc9a5fe193870f03edc6" "82cbb553a225b75ee49901fa06562941fbfe5e6fed24cda985e7ea59af7ddc80" "ad68cb14359254795c6b96d76334aaacb739c04f64a4a8567964d4a20aa723d2" "e24679edfdea016519c0e2d4a5e57157a11f928b7ef4361d00c23a7fe54b8e01" "0b6645497e51d80eda1d337d6cabe31814d6c381e69491931a688836c16137ed" "d43120398682953ef18fd7e11e69c94e44d39bb2ab450c4e64815311542acbff" "91fba9a99f7b64390e1f56319c3dbbaed22de1b9676b3c73d935bf62277b799c" "d1a42ed39a15a843cccadf107ee0242b5f78bfbb5b70ba3ce19f3ea9fda8f52d" "8e3f020f1ce69cfa0c1ebee4e198feb28dd7eb31b7d77927e9c790819210c654" "db9feb330fd7cb170b01b8c3c6ecdc5179fc321f1a4824da6c53609b033b2810" "1462969067f2ff901993b313085d47e16badeec58b63b9ed67fa660cebaaddae" "e2e4e109357cfcebccb17961950da6b84f72187ade0920a4494013489df648fe" "75c0b9f9f90d95ac03f8647c75a91ec68437c12ff598e2abb22418cd4b255af0" "bf81a86f9cfa079a7bb9841bc6ecf9a2e8999b85e4ae1a4d0138975921315713" "d69a0f6d860eeff5ca5f229d0373690782a99aee2410a3eed8a31332a7101f1e" "b6db49cec08652adf1ff2341ce32c7303be313b0de38c621676122f255ee46db" "cdfb22711f64d0e665f40b2607879fcf2607764b2b70d672ddaa26d2da13049f" "e8e42d57f58d48b48b5a3f428d046087d655955999f476ffc3732cf92f67891e" default)))
 '(default-frame-alist
	(quote
	 ((top . 20)
	  (left . 20)
	  (width . 100)
	  (height . 60)
	  (vertical-scroll-bars))))
 '(diary-entry-marker (quote font-lock-variable-name-face))
 '(flx-ido-mode t)
 '(frame-background-mode (quote dark))
 '(global-hl-line-mode t)
 '(global-hl-line-sticky-flag nil)
 '(global-visual-line-mode t)
 '(gnus-logo-colors (quote ("#528d8d" "#c0c0c0")) t)
 '(ido-enable-flex-matching t)
 '(ido-everywhere t)
 '(ido-mode (quote both) nil (ido))
 '(ido-ubiquitous-mode t)
 '(ido-vertical-mode t)
 '(markdown-open-command "open")
 '(package-archive-priorities (quote (("melpa-stable" . 2) ("melpa" . 1) ("gnu" . 0))))
 '(package-archives
   (quote
	(("gnu" . "http://elpa.gnu.org/packages/")
	 ("melpa" . "https://melpa.org/packages/")
	 ("melpa-stable" . "https://stable.melpa.org/packages/"))))
 '(package-selected-packages
   (quote
	(ace-link abyss-theme alect-themes ample-zen-theme cyberpunk-theme spacemacs-theme ample-theme ace-jump-mode evil-indent-textobject evil-matchit evil-org evil-paredit evil-surround evil-textobj-anyblock smex ido-ubiquitous ido-vertical-mode multi-term evil-magit magit magit-filenotify ggtags evil expand-region sx flx-ido slim-mode paredit password-store dockerfile-mode draft-mode adoc-mode sicp smooth-scrolling projectile rainbow-delimiters helm helm-ag markdown-mode)))
 '(ring-bell-function
   (lambda nil
	 (invert-face
	  (quote mode-line))
	 (run-with-timer 0.1 nil
					 (quote invert-face)
					 (quote mode-line))))
 '(smex-save-file "~/.emacs.d/smex-items")
 '(tab-width 4)
 '(vc-annotate-background "#222222")
 '(vc-annotate-color-map
   (quote
	((20 . "#fa5151")
	 (40 . "#ea3838")
	 (60 . "#f8ffa0")
	 (80 . "#e8e815")
	 (100 . "#fe8b04")
	 (120 . "#e5c900")
	 (140 . "#32cd32")
	 (160 . "#8ce096")
	 (180 . "#7fb07f")
	 (200 . "#3cb370")
	 (220 . "#099709")
	 (240 . "#2fdbde")
	 (260 . "#1fb3b3")
	 (280 . "#8cf1f1")
	 (300 . "#94bff3")
	 (320 . "#62b6ea")
	 (340 . "#00aff5")
	 (360 . "#e353b9"))))
 '(vc-annotate-very-old-color "#e353b9")
 '(visible-bell t)
 '(visual-line-fringe-indicators (quote (left-curly-arrow right-curly-arrow))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ace-jump-face-foreground ((t (:foreground "orange"))))
 '(font-lock-comment-delimiter-face ((t (:foreground "#75715e")))))
