;;; Welcome screen ausschalten
(setq inhibit-startup-message t) 

;;; tippe "y"/"n" anstatt von "yes"/"no"
(fset 'yes-or-no-p 'y-or-n-p)

;;; Datum und Uhrzeit immer anzeigen
(setq display-time-day-and-date t)
(display-time)

;;; Menü-Zeile ein-/ausschalten
(menu-bar-mode t) ; ein

;;; Icon-Toolbar ein-/ausschalten
(tool-bar-mode nil) ; aus natürlich

;;; Scroll-Leiste ein-/ausschalten
(toggle-scroll-bar t) ; ein

;;; UTF-8 ist das Beste :P
(set-language-environment "UTF-8")
(prefer-coding-system 'utf-8)

;;; Ganzer Bildschirm
;;;(require 'fullscreen)

;;; Buffer-Verhalten ... Windows vertikal teilen
;;; (setq split-height-threshold nil)
;;; (setq split-width-threshold 0)

;;; Replace "sbcl" with the path to your implementation
(setq inferior-lisp-program "sbcl")

;;;(add-to-list 'load-path "/usr/share/emacs/site-lisp/slime/")
(add-to-list 'load-path "~/.emacs-erweiterung/")
(add-to-list 'load-path "~/quicklisp/dists/quicklisp/software/slime-20120703-cvs/")
(require 'slime-autoloads)
(slime-setup '(slime-repl slime-scratch slime-editing-commands slime-autodoc slime-references slime-fancy))

;;; Das Nachfolgende umschifft den "verschiedene Versionen" Bug
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

;(setq slime-net-coding-system 'utf-8-unix)

;; "quicklisp-slime-helper"
(load (expand-file-name "~/quicklisp/slime-helper.el"))


;; emacs-color-theme
;(require 'color-theme)
;(color-theme-initialize)
;(color-theme-parus)
;(color-theme-blue-mood)
;(color-theme-solarized 'light)
;(load-theme solarized-dark t)

;; w3m-browser
(require 'w3m-load)
;; für SEMI MUAs wie wanderlust
;(require 'mime-w3m)

;;; Org-Mode-Einstellungen
(add-to-list 'auto-mode-alist '("\\.or\\'" . org-mode))
(add-hook 'org-mode-hook 'turn-on-font-lock)
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)

;; Folgt im Org-Mode dem Link:
(setq org-return-follows-link t)

;; Fenster rückwärts springen
(defun other-window-backward (n)
"Select Nth previous window."
  (interactive "p")
  (other-window (- n)))

(global-set-key [(shift down)] 'other-window)

(global-set-key [(shift up)] 'other-window-backward)

 ;; Buffer wechseln wie click auf modeline, aber mit
 ;; tasten...
 (defun ska-previous-buffer ()
       "Hmm, to be frank, this is just the same as bury-buffer.
     Used to wander through the buffer stack with the keyboard."
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

;;; Um Slime automatisch zu starten, auskommentieren
; (slime)


