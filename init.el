(require 'package)
(add-to-list 'package-archives
						 '("marmalade" . "http://marmalade-repo.org/packages/") t)
(add-to-list 'package-archives
						 '("melpa" . "http://melpa.milkbox.net/packages/") t)
(package-initialize)

(when (not package-archive-contents)
	(package-refresh-contents))

;; Add in your own as you wish:
(defvar my-packages
	'(starter-kit
		starter-kit-bindings
		starter-kit-lisp
		;; Clojure & friends
		clojure-mode
		clojure-snippets
		cider
		align-cljlet
		clj-refactor
		cider-eval-sexp-fu
		;; Lisps
		rainbow-delimiters
		paxedit
		;; Completion popup
		company
		popup
		;; Project navigation
		projectile
		ack-and-a-half
		;; Misc.
		sass-mode
		markdown-mode
		color-theme-sanityinc-tomorrow
		powerline
		yasnippet
		buffer-move
		color-identifiers-mode
		highlight
		git-link
		expand-region
		avy)
	"A list of packages to ensure are installed at launch.")

;; Automaticaly install any missing packages
(dolist (p my-packages)
	(when (not (package-installed-p p))
		(package-install p)))

;; Load the provided Clojure start kit configurations
(load (concat user-emacs-directory "clojure-starter-kit.el"))

;; Load key bindings.
(load (concat user-emacs-directory "keybinds.el"))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(font-lock-warning-face ((((class color) (min-colors 89)) (:weight bold :foreground "#cc0000"))))
 '(idle-highlight ((t (:inherit region :background "maroon4")))))

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(ansi-color-faces-vector
	 [default bold shadow italic underline bold bold-italic bold])
 '(ansi-color-names-vector
	 (vector "#cccccc" "#f2777a" "#99cc99" "#ffcc66" "#6699cc" "#cc99cc" "#66cccc" "#2d2d2d"))
 '(auto-save-default nil)
 '(backup-inhibited t t)
 '(cider-buffer-name-show-port t)
 '(delete-selection-mode t)
 '(fci-rule-color "#393939")
 '(git-link-open-in-browser t t)
 '(magit-emacsclient-executable "/Applications/Emacs.app/Contents/MacOS/bin/emacsclient")
 '(nrepl-host "localhost")
 '(vc-annotate-background nil)
 '(vc-annotate-color-map
	 (quote
		((20 . "#f2777a")
		 (40 . "#f99157")
		 (60 . "#ffcc66")
		 (80 . "#99cc99")
		 (100 . "#66cccc")
		 (120 . "#6699cc")
		 (140 . "#cc99cc")
		 (160 . "#f2777a")
		 (180 . "#f99157")
		 (200 . "#ffcc66")
		 (220 . "#99cc99")
		 (240 . "#66cccc")
		 (260 . "#6699cc")
		 (280 . "#cc99cc")
		 (300 . "#f2777a")
		 (320 . "#f99157")
		 (340 . "#ffcc66")
		 (360 . "#99cc99"))))
 '(vc-annotate-very-old-color nil))

(split-window-right)

(menu-bar-mode t)

(add-hook 'prog-mode-hook 'hs-minor-mode)

(add-hook 'clojure-mode-hook
					(lambda ()
						(clj-refactor-mode 1)
						(paxedit-mode)
						(cljr-add-keybindings-with-prefix "s-r")))

;; Add an extra newline to separate commit message from git commentary

(defun magit-commit-mode-init ()
	(when (looking-at "\n")
		(open-line 1)))

(add-hook 'git-commit-mode-hook 'magit-commit-mode-init)

(yas-global-mode 1)

(global-company-mode)
(global-color-identifiers-mode)
(global-whitespace-mode)

;; Highlight stuff in whitespace-mode
(setq-default whitespace-line-column 90)

(require 'cider)
(setq cider-known-endpoints '(("nr-t1" "9980")
															("nr-t2" "9981")
															("nr-t3" "9982")
															("nr-t4" "9983")
															("nr-db2" "9995")
															("nr-web1" "9996")
															("nr-web2" "9997")
															("nr-hex" "7888")
															("nr-bcc" "9991")))

(add-hook 'before-save-hook 'whitespace-cleanup)


(eval-when-compile (require 'cl-lib))

(add-hook 'focus-out-hook
	(lambda ()
		(cl-letf (((symbol-function 'message) #'format))
			(save-some-buffers t))))

;;; Turn on expression highlighting

(show-paren-mode 1)
(setq-default blink-matching-paren nil
							show-paren-style 'parenthesis
							show-paren-delay 0)

(require 'cl)
(defadvice save-buffers-kill-emacs (around no-query-kill-emacs activate)
	(flet ((process-list ())) ad-do-it))

(define-clojure-indent
	;; om & om-tools indenting
	(display-name 'defun)
	(init-state 'defun)
	(will-mount 'defun)
	(did-mount 'defun)
	(will-unmount 'defun)
	(render 'defun)
	(render-state 'defun)
	(should-update 'defun)
	(will-update 'defun)
	(will-receive-props 'defun)
	(did-update 'defun)
	;; prismatic plumbing
	(for-map 'defun)
	(letk 'defun)
	(fnk 'defun)
	;; compojure
	(context 'defun)
	;;
	(let-programs 'defun)
	;; component
	(start 'defun)
	(stop 'defun)
	(init 'defun)
	(db 'defun)
	(conn 'defun)
	;; datalog
	(and-join 'defun)
	(or-join 'defun)
	(not-join 'defun)
	)

(font-lock-add-keywords
 nil '(("\\<\\(FIX\\(ME\\)?\\|TODO\\|HACK\\|REFACTOR\\|NOCOMMIT\\)"
				1 font-lock-warning-face t)))
