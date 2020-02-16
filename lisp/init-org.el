;;添加 Org-mode 文本内语法高亮
;;(require 'org)
(with-eval-after-load 'org
  ;; Org 模式相关设定
  ;; 设置默认 Org Agenda 文件目录
  (setq org-agenda-files '("~/.emacs.d"))

  (setq org-src-fontify-natively t)

  (setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/.emacs.d/gtd.org" "工作安排")
	 "* TODO [#B] %?\n  %i\n"
	 :empty-lines 1)))
  )


(provide 'init-org)
