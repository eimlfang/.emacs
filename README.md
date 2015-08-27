# emacs配置
# 需要安装auto-complete
# 安装yasnippet

;(setq package-archives 
;  '(("gnu" . "http://elpa.gnu.org/packages/")
;("marmalade" . "http://marmalade-repo.org/packages/")
;("melpa" . "http://melpa.org/packages/")))

; start package.el whith emacs
(require 'package)
; add MELPA to repository list
;(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
; initialize package.el
;(package-initialize)
; Yasnippet 代码块
(add-to-list 'load-path  
"~/.emacs.d/plugins/yasnippet")  
(require 'yasnippet)
(yas/global-mode 1)
					; auto-complete
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)
