;; -*- lisp -*-

;; Pfade
(add-to-list 'load-path "~/.emacs-erweiterung/")

;; Verschiedene Paketarchive für packages.el
(setq package-archives '(("gnu" . "http://elpa.gnu.org/packages/")
                         ("marmalade" . "http://marmalade-repo.org/packages/")
						 ("org" . "http://orgmode.org/elpa/")
						 ("melpa" . "http://melpa.org/packages/")))
(add-to-list 'custom-theme-load-path "~/.emacs.d/themes/")
(add-to-list 'load-path "~/.emacs.d/themes/color-theme-sanityinc-solarized")

;; M-x package-refresh-content um zu aktualisieren
(defun byte-recompile ()
  (interactive)
  (byte-recompile-directory "~/.emacs.d" 0)
  (byte-recompile-directory "~/.emacs-erweiterung" 0))

;; Meine sensiblen Informationen
(load "~/.emacs.geheimnisse" t)
;;(load "~/.emacs.erc" t)

;; Backup alter Dateien
(setq backup-directory-alist '(("." . "~/.emacs.d/backups")))
(setq delete-old-versions -1)
(setq version-control t)
(setq vc-make-backup-files t)
(setq auto-save-file-name-transforms '((".*" "~/.emacs.d/auto-save-list/" t)))

;; History
(setq savehist-file "~/.emacs.d/savehist")
(savehist-mode 1)
(setq history-length t)
(setq history-delete-duplicates t)
(setq savehist-save-minibuffer-history 1)
(setq savehist-additional-variables
      '(kill-ring
        search-ring
        regexp-search-ring))

;; Setting up the default text mode
(setq default-major-mode 'text-mode)
(add-hook 'text-mode-hook 'turn-on-auto-fill)

;; Welcome screen ausschalten
(setq inhibit-startup-message t) 

;; tippe "y"/"n" anstatt von "yes"/"no"
(fset 'yes-or-no-p 'y-or-n-p)

;; Datum und Uhrzeit immer anzeigen
(setq display-time-day-and-date t)
(display-time)

;; Menü-Zeile ein-/ausschalten
(tooltip-mode t)
(tool-bar-mode nil) ; aus natürlich
(menu-bar-mode t) ; ein
(scroll-bar-mode nil)

;; Sätze Enden mit einem Leerzeichen
(setq sentence-end-double-space nil)

;; UTF-8 ist das Beste :P
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;; Slime
(load (expand-file-name "~/quicklisp/slime-helper.el"))
(setq slime-lisp-implementations '((sbcl ("sbcl"))
				   (ccl ("ccl"))))
;; Das Nachfolgende umschifft den "verschiedene Versionen" Bug
(setq slime-protocol-version 'ignore)
(global-set-key "\C-cs" 'slime-selector)
(add-hook 'slime-mode-hook
	  (lambda ()
	    (unless (slime-connected-p)
	      (save-excursion (slime)))))
(global-font-lock-mode t)
(show-paren-mode 1)
(add-hook 'lisp-mode-hook '(lambda ()
			     (local-set-key (kbd "RET") 'newline-and-indent)))
(add-hook 'slime-connected-hook 'delete-other-windows)

;; ParEdit
;(autoload 'enable-paredit-mode "paredit" "Turn on pseudo-structural editing of Lisp code." t)
;(add-hook 'emacs-lisp-mode-hook       #'enable-paredit-mode)
;(add-hook 'eval-expression-minibuffer-setup-hook #'enable-paredit-mode)
;(add-hook 'ielm-mode-hook             #'enable-paredit-mode)
;(add-hook 'lisp-mode-hook             #'enable-paredit-mode)
;(add-hook 'lisp-interaction-mode-hook #'enable-paredit-mode)
;(add-hook 'scheme-mode-hook           #'enable-paredit-mode)
;(add-hook 'slime-repl-mode-hook (lambda () (paredit-mode +1)))
;; Stop SLIME's REPL from grabbing DEL, which is annoying
;; when backspacing over a '('
;(defun override-slime-repl-bindings-with-paredit ()
;(define-key slime-repl-mode-map
;    (read-kbd-macro paredit-backward-delete-key) nil))
;(add-hook 'slime-repl-mode-hook 'override-slime-repl-bindings-with-paredit)


;; C / C++ Programmierung
(require 'cc-mode)
(setq-default c-basic-offset 4
                  tab-width 4
                  indent-tabs-mode t)
(define-key c-mode-base-map (kbd "RET") 'newline-and-indent)

;; w3m-browser
;;(require 'w3m-load)
;; für SEMI MUAs wie wanderlust
;; (require 'mime-w3m)
;;(setq browse-url-browser-function 'w3m-browse-url)
;;(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
;;(global-set-key "\C-xm" 'browse-url-at-point)

;; Fenster rückwärts springen
(defun other-window-backward (n)
"Select Nth previous window."
  (interactive "p")
  (other-window (- n)))

(global-set-key [(shift down)] 'other-window)

(global-set-key [(shift up)] 'other-window-backward)

;; Buffer wechseln wie click auf modeline, aber mit Tasten
(defun ska-previous-buffer ()
  "Hmm, to be frank, this is just the same as bury-buffer. Used to wander through the buffer stack with the keyboard."
  (interactive)
  (bury-buffer))

(defun ska-next-buffer ()
  "Cycle to the next buffer with keyboard."
  (interactive)
  (let* ((bufs (buffer-list))
		 (entry (1- (length bufs)))
		 val)
	(while (not (setq val (nth entry bufs)
					  val (and (/= (aref (buffer-name val) 0)
								   ? )
							   val)))
	  (setq entry (1- entry)))
	(switch-to-buffer val)))
 
;; Buffer cycling like on modeline
(define-key global-map [(shift right)]
         'ska-next-buffer)
       
(define-key global-map [(shift left)]
         'ska-previous-buffer)

;; define function to shutdown emacs server instance
(defun server-shutdown ()
  "Save buffers, Quit, and Shutdown (kill) server"
  (interactive)
  (save-some-buffers)
  (kill-emacs))

(require 'clhs)
(require 'cl)
;(require 'color-theme-sanityinc-solarized)

(require 'package)
(package-initialize)

;; Ruby-Programmierung
(require 'ruby-mode)
(setq-default tab-width 2
			  ruby-indent-level 2
			  indent-tabs-mode nil)

(unless (package-installed-p 'inf-ruby)
  (package-install 'inf-ruby)) 
(require 'inf-ruby)
(autoload 'inf-ruby-minor-mode "inf-ruby" "Run an inferior Ruby process" t)
(add-hook 'ruby-mode-hook 'inf-ruby-minor-mode)
(add-hook 'after-init-hook 'inf-ruby-switch-setup)
(add-to-list 'auto-mode-alist '("\\.\\(?:gemspec\\|irbrc\\|gemrc\\|rake\\|rb\\|ru\\|thor\\)\\'" . ruby-mode))
  (add-to-list 'auto-mode-alist '("\\(Capfile\\|Gemfile\\(?:\\.[a-zäöüßA-ZÄÖÜ0-9._-]+\\)?\\|[rR]akefile\\)\\'" . ruby-mode))

(unless (package-installed-p 'smartparens)
  (package-install 'smartparens))
(require 'smartparens-config)
(package-initialize)
(smartparens-global-mode t)

(unless (package-installed-p 'yari)
  (package-install 'yari))
(require 'yari)

(unless (package-installed-p 'ruby-tools)
  (package-install 'ruby-tools))
(require 'ruby-tools)

(unless (package-installed-p 'flycheck)
  (package-install 'flycheck))
(require 'flycheck)

(unless (package-installed-p 'rubocop)
  (package-install 'rubocop))
(require 'rubocop)

;--------------------------------------------------------------

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
   [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
   ["#2e3436" "#a40000" "#4e9a06" "#c4a000" "#204a87" "#5c3566" "#729fcf" "#eeeeec"])
 '(background-color "#002b36")
 '(background-mode dark)
 '(blink-cursor-mode nil)
 '(compilation-message-face (quote default))
 '(cursor-color "#839496")
 '(custom-enabled-themes (quote (sanityinc-solarized-light)))
 '(custom-safe-themes
   (quote
    ("8b1257c6d21640200bb54286cf81db326026f54b2d03a4830f240f667b6b274b" "f0a99f53cbf7b004ba0c1760aa14fd70f2eabafe4e62a2b3cf5cabae8203113b" "06f0b439b62164c6f8f84fdda32b62fb50b6d00e8b01c2208e55543a6337433a" "628278136f88aa1a151bb2d6c8a86bf2b7631fbea5f0f76cba2a0079cd910f7d" "bb08c73af94ee74453c90422485b29e5643b73b05e8de029a6909af6a3fb3f58" "1b8d67b43ff1723960eb5e0cba512a2c7a2ad544ddb2533a90101fd1852b426e" "82d2cac368ccdec2fcc7573f24c3f79654b78bf133096f9b40c20d97ec1d8016" "4cf3221feff536e2b3385209e9b9dc4c2e0818a69a1cdb4b522756bcdf4e00a4" "4aee8551b53a43a883cb0b7f3255d6859d766b6c5e14bcb01bed572fcbef4328" "d6c030bf73acaf5501109fc1b6822b46dc4001b66001bb43a510e35169a2b939" "301f218fa2357b2aa2a433e049f87e059c5ba2ad8b161634d758fbf007bf1d0a" "be7eadb2971d1057396c20e2eebaa08ec4bfd1efe9382c12917c6fe24352b7c1" "71efabb175ea1cf5c9768f10dad62bb2606f41d110152f4ace675325d28df8bd" "5fd32db7a8d9f642f9b9d1bf14014a96d2d1bef04041cbc2590afebb944d81ba" "a705d91a43f7fb73751de9e5f901aeaccbf0b55c92c2a4698104befbed2c5074" "c246918325fbb0faa1767a669175cb225a3fc4da8f98b7644c3febaba7a637a1" "fc5fcb6f1f1c1bc01305694c59a1a861b008c534cae8d0e48e4d5e81ad718bc6" "1e7e097ec8cb1f8c3a912d7e1e0331caeed49fef6cff220be63bd2a6ba4cc365" default)))
 '(display-time-mode t)
 '(fci-rule-color "#383838")
 '(foreground-color "#839496")
 '(highlight-changes-colors (quote ("#FD5FF0" "#AE81FF")))
 '(highlight-tail-colors
   (quote
    (("#49483E" . 0)
     ("#67930F" . 20)
     ("#349B8D" . 30)
     ("#21889B" . 50)
     ("#968B26" . 60)
     ("#A45E0A" . 70)
     ("#A41F99" . 85)
     ("#49483E" . 100))))
 '(magit-diff-use-overlays nil)
 '(python-shell-interpreter "ipython3")
 '(show-paren-mode t)
 '(syslog-debug-face
   (quote
    ((t :background unspecified :foreground "#A1EFE4" :weight bold))))
 '(syslog-error-face
   (quote
    ((t :background unspecified :foreground "#F92672" :weight bold))))
 '(syslog-hour-face (quote ((t :background unspecified :foreground "#A6E22E"))))
 '(syslog-info-face
   (quote
    ((t :background unspecified :foreground "#66D9EF" :weight bold))))
 '(syslog-ip-face (quote ((t :background unspecified :foreground "#E6DB74"))))
 '(syslog-su-face (quote ((t :background unspecified :foreground "#FD5FF0"))))
 '(syslog-warn-face
   (quote
    ((t :background unspecified :foreground "#FD971F" :weight bold))))
 '(tab-width 4)
 '(tool-bar-mode nil)
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
   (quote
    ((20 . "#dc322f")
     (40 . "#cb4b16")
     (60 . "#b58900")
     (80 . "#859900")
     (100 . "#2aa198")
     (120 . "#268bd2")
     (140 . "#d33682")
     (160 . "#6c71c4")
     (180 . "#dc322f")
     (200 . "#cb4b16")
     (220 . "#b58900")
     (240 . "#859900")
     (260 . "#2aa198")
     (280 . "#268bd2")
     (300 . "#d33682")
     (320 . "#6c71c4")
     (340 . "#dc322f")
     (360 . "#cb4b16"))))
 '(vc-annotate-very-old-color nil)
 '(weechat-color-list
   (quote
    (unspecified "#272822" "#49483E" "#A20C41" "#F92672" "#67930F" "#A6E22E" "#968B26" "#E6DB74" "#21889B" "#66D9EF" "#A41F99" "#FD5FF0" "#349B8D" "#A1EFE4" "#F8F8F2" "#F8F8F0"))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Meslo LG S" :foundry "bitstream" :slant normal :weight normal :height 113 :width normal)))))

