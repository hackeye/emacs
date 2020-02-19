;;  (when (>= emacs-major-version 24)
;;      (require 'package)
;;      (package-initialize)
;;      (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
;; 		      ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

;; ;; 注意 elpa.emacs-china.org 是 Emacs China 中文社区在国内搭建的一个 ELPA 镜像

;;  ;; cl - Common Lisp Extension
;; (require 'cl)

;;  ;; Add Packages
;;  (defvar my/packages '(
;; 		;; --- Auto-completion ---
;; 		company
;; 		;; --- Better Editor ---
;; 		hungry-delete
;; 		swiper
;; 		counsel
;; 		smartparens
;; 		;; --- Major Mode ---
;; 		js2-mode
;; 		;; --- Minor Mode ---
;; 		nodejs-repl
;; 		exec-path-from-shell
;; 		;; --- Themes ---
;; 		;;monokai-theme
;; 		solarized-theme
;; 		popwin
;; 		reveal-in-osx-finder
;; 		web-mode
;; 		;;major mode for editing web templates
;; 		js2-refactor
;; 		;;A JavaScript refactoring library for emacs
;; 		expand-region
;; 		;;Increase selected region by semantic units
;; 		iedit
;; 		;;Edit multiple regions in the same way simultaneously
;; 		org-pomodoro
;; 		helm-ag
;; 		;;the silver searcher with helm interface
;; 		flycheck
;; 		;;On-the-fly syntax checking
;; 		auto-yasnippet
;; 		;;Quickly create disposable yasnippets
;; 		evil
;; 		;;Extensible Vi layer for Emacs
;; 		evil-leader
;; 		evil-surround
;; 		evil-nerd-commenter
;; 		window-numbering
;; 		powerline-evil
;; 		which-key
;; 		pallet
;; 		;;A package management tool for Emacs, using Cask
;; 		) "Default packages")

;;  (setq package-selected-packages my/packages)

;;  (defun my/packages-installed-p ()
;;      (loop for pkg in my/packages
;; 	   when (not (package-installed-p pkg)) do (return nil)
;; 	   finally (return t)))

;;  (unless (my/packages-installed-p)
;;      (message "%s" "Refreshing package database...")
;;      (package-refresh-contents)
;;      (dolist (pkg my/packages)
;;        (when (not (package-installed-p pkg))
;; 	 (package-install pkg))))

 ;; Find Executable Path on OS X
 (when (memq window-system '(mac ns))
   (exec-path-from-shell-initialize))

(global-hungry-delete-mode)

(require 'smartparens-config)
;;(add-hook 'js-mode-hook #'smartparens-mode)
(smartparens-global-mode t)
;;(sp-local-pair 'emacs-lisp-mode "'" nil :actions nil)
;;(sp-local-pair 'lisp-interaction-mode "'" nil :actions nil)

;; 也可以把上面两句合起来
;;(sp-local-pair '(emacs-lisp-mode lisp-interaction-mode) "'" nil :actions nil)


(ivy-mode 1)
(setq ivy-use-virtual-buffers t)

;;config js2-mode for js files
(setq auto-mode-alist
      (append
       '(("\\.js\\'" . js2-mode)
	 ("\\.html\\'" . web-mode))
       auto-mode-alist))

(global-company-mode t)

;;config for web mode
(defun my-web-mode-indent-setup ()
  (setq web-mode-markup-indent-offset 2) ; web-mode, html tag in html file
  (setq web-mode-css-indent-offset 2)    ; web-mode, css in html file
  (setq web-mode-code-indent-offset 2)   ; web-mode, js code in html file
  )
(add-hook 'web-mode-hook 'my-web-mode-indent-setup)

(defun my-toggle-web-indent ()
  (interactive)
  ;; web development
  (if (or (eq major-mode 'js-mode) (eq major-mode 'js2-mode))
      (progn
	(setq js-indent-level (if (= js-indent-level 2) 4 2))
	(setq js2-basic-offset (if (= js2-basic-offset 2) 4 2))))

  (if (eq major-mode 'web-mode)
      (progn (setq web-mode-markup-indent-offset (if (= web-mode-markup-indent-offset 2) 4 2))
	     (setq web-mode-css-indent-offset (if (= web-mode-css-indent-offset 2) 4 2))
	     (setq web-mode-code-indent-offset (if (= web-mode-code-indent-offset 2) 4 2))))
  (if (eq major-mode 'css-mode)
      (setq css-indent-offset (if (= css-indent-offset 2) 4 2)))

  (setq indent-tabs-mode nil))

;;config for js2-refactor
(add-hook 'js2-mode-hook #'js2-refactor-mode)

(defun js2-imenu-make-index ()
      (interactive)
      (save-excursion
	;; (setq imenu-generic-expression '((nil "describe\\(\"\\(.+\\)\"" 1)))
	(imenu--generic-function '(("describe" "\\s-*describe\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("it" "\\s-*it\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("test" "\\s-*test\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("before" "\\s-*before\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("after" "\\s-*after\\s-*(\\s-*[\"']\\(.+\\)[\"']\\s-*,.*" 1)
				   ("Function" "function[ \t]+\\([a-zA-Z0-9_$.]+\\)[ \t]*(" 1)
				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
				   ("Function" "^var[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*=[ \t]*function[ \t]*(" 1)
				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*()[ \t]*{" 1)
				   ("Function" "^[ \t]*\\([a-zA-Z0-9_$.]+\\)[ \t]*:[ \t]*function[ \t]*(" 1)
				   ("Task" "[. \t]task([ \t]*['\"]\\([^'\"]+\\)" 1)))))
(add-hook 'js2-mode-hook
	      (lambda ()
		(setq imenu-create-index-function 'js2-imenu-make-index)))

;;安装主题
;;(add-to-list 'my/packages 'monokai-theme)
;;(load-theme 'monokai 1)
;;(load-theme 'solarized-light t)
(load-theme 'solarized-dark t)
;; make the fringe stand out from the background
(setq solarized-distinct-fringe-background t)

;; Don't change the font for some headings and titles
(setq solarized-use-variable-pitch nil)

;; make the modeline high contrast
(setq solarized-high-contrast-mode-line t)

;; Use less bolding
(setq solarized-use-less-bold t)

;; Use more italics
(setq solarized-use-more-italic t)

;; Use less colors for indicators such as git:gutter, flycheck and similar
(setq solarized-emphasize-indicators nil)

;; Don't change size of org-mode headlines (but keep other size-changes)
(setq solarized-scale-org-headlines nil)

;; Avoid all font-size changes
(setq solarized-height-minus-1 1.0)
(setq solarized-height-plus-1 1.0)
(setq solarized-height-plus-2 1.0)
(setq solarized-height-plus-3 1.0)
(setq solarized-height-plus-4 1.0)
(setq x-underline-at-descent-line t)
 
(require 'popwin)
(popwin-mode t)

(require 'expand-region)

(add-to-list 'load-path "~/dir/to/your/iedit")
(require 'iedit)
(global-set-key (kbd "M-s e") 'iedit-mode)

(require 'org-pomodoro)

;;(global-flycheck-mode t)
(add-hook 'js2-mode-hook 'flycheck-mode)

(require 'yasnippet)
(yas-reload-all)
(add-hook 'prog-mode-hook #'yas-minor-mode)

(evil-mode 1)
(setcdr evil-insert-state-map nil)
(define-key evil-insert-state-map [escape] 'evil-normal-state)

(global-evil-leader-mode)
(evil-leader/set-key
  "ff" 'find-file
  "fr" 'recentf-open-files
  "bb" 'switch-to-buffer
  "bk" 'kill-buffer
  "pf" 'counsel-git
  "ps" 'helm-do-ag-project-root
  "0"  'select-window-0
  "1"  'select-window-1
  "2"  'select-window-2
  "3"  'select-window-3
  "w/" 'split-window-right
  "w-" 'split-window-below
  ":"  'counsel-M-x
  "wM" 'delete-other-windows
  "qq" 'save-buffers-kill-terminal
  )



(window-numbering-mode 1)
(require 'powerline-evil)

(require 'evil-surround)
(global-evil-surround-mode 1)

(evilnc-default-hotkeys)
(define-key evil-normal-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)
(define-key evil-visual-state-map (kbd ",/") 'evilnc-comment-or-uncomment-lines)

(dolist (mode '(ag-mode
		flycheck-error-list-mode
		occur-mode
		git-rebase-mode))
  (add-to-list 'evil-emacs-state-modes mode))
(add-hook 'occur-mode-hook
	  (lambda ()
	    (evil-add-hjkl-bindings occur-mode-map 'emacs
	      (kbd "/")       'evil-search-forward
	      (kbd "n")       'evil-search-next
	      (kbd "N")       'evil-search-previous
	      (kbd "C-d")     'evil-scroll-down
	      (kbd "C-u")     'evil-scroll-up)
	    ))

(which-key-mode 1)
(setq which-key-side-window-location 'right)

;;Enable helm-follow-mode by default
;;(custom-set-variables
;; '(helm-follow-mode-persistent t))

;; 文件末尾
(provide 'init-packages)
