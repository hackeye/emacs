(setq ring-bell-function 'ignore)

(global-auto-revert-mode t)

(global-linum-mode t)

(abbrev-mode t)
;;(define-abbrev-table 'global-abbrev-table '(
;;					    ;; signature
;;					    ("8zl" "zilongshanren")
;;					    ))

;;禁止自动备份
(setq make-backup-files nil)

;;禁止自动保存
(setq auto-save-default nil)

(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)

(add-hook 'emacs-lisp-mode-hook 'show-paren-mode)

(delete-selection-mode t)

;; 更改显示字体大小 16pt
;; http://stackoverflow.com/questions/294664/how-to-set-the-font-size-in-emacs
(set-face-attribute 'default nil :height 160)

(provide 'init-better-defaults)
