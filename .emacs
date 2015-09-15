;(setq package-archives 
;  '(("gnu" . "http://elpa.gnu.org/packages/")
;("marmalade" . "http://marmalade-repo.org/packages/")
;("melpa" . "http://melpa.org/packages/")))

; start package.el whith emacs
(require 'package)
; add MELPA to repository list
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
; initialize package.el
(package-initialize)

					; Yasnippet 代码块
(add-to-list 'load-path  
	     "~/.emacs.d/plugins/yasnippet")
(setq yas/root-directory "~/.emacs.d/plugins/yasnippet/snippets")
(require 'yasnippet)
(yas/global-mode 1)

					; auto-complete
(add-to-list 'load-path "~/.emacs.d/plugins/auto-complete")
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d//ac-dict")
(ac-config-default)

;;-------------个人配置

;;设置打开文件的缺省路径
(setq default-directory "~/")

;;ido配置
(ido-mode t)
(setq ido-save-directory-list-file nil)
;;Ido模式中部保存目录列表,解决退出emacs时ido要询问编码问题



;;关闭错误提示音
(setq visible-bell t)

;;将yes/no 改为 y/n
(fset 'yes-or-no-p 'y-or-n-p)

;; 语法高亮。除 shell-mode 和 text-mode 之外的模式中使用语法高亮。
;;(setq font-lock-maximum-decoration t)
;;(setq font-lock-global-modes '(not shell-mode text-mode))
;;(setq font-lock-verbose t)
;;(setq font-lock-maximum-size '((t . 1048576) (vm-mode . 5250000)))

;;显示行列号
(setq column-number-mode t)
(global-linum-mode t)

;;允许emacs和外部其他程序的粘贴
(setq x-select-enable-clipboard t)

(setq track-eol t)
;; 当光标在行尾上下移动的时候，始终保持在行尾。

;;--------------窗口界面设置------------------

;;(set-foreground-color "grey")
;;(set-background-color "black")
;;(set-cursor-color "gold1")
;;(set-mouse-color "gold1")

;; 设置另外一些颜色：语法高亮显示的背景和主题，区域选择的背景和主题，二次选择的背景和选择
;;(set-face-foreground 'highlight "white")
;;(set-face-background 'highlight "blue")
;;(set-face-foreground 'region "cyan")
;;(set-face-background 'region "blue")
;;(set-face-foreground 'secondary-selection "skyblue")
;;(set-face-background 'secondary-selection "darkblue")

;;------------窗口界面设置结束-----------------

;;------------显示时间设置------------------------------

(display-time-mode 1);;启用时间显示设置，在minibuffer上面的那个杠上
(setq display-time-24hr-format t);;时间使用24小时制
(setq display-time-day-and-date t);;时间显示包括日期和具体时间
;;(setq display-time-use-mail-icon t);;时间栏旁边启用邮件设置
(setq display-time-interval 10);;时间的变化频率，单位多少来着？

;;------------显示时间设置结束--------------

;;------------开发配置-------------------

;;在C语言头文件添加ifndef 和 endif

(defun get-include-guard ()
   "Return a string suitable for use in a C/C++ include guard"
   (let* ((fname (buffer-file-name (current-buffer)))
          (fbasename (replace-regexp-in-string ".*/" "" fname))
          (inc-guard-base (replace-regexp-in-string "[.-]"
                                                    "_"
                                                    fbasename)))
     (concat (upcase inc-guard-base) "_")))
 
 (add-hook 'find-file-not-found-hooks
           '(lambda ()
              (let ((file-name (buffer-file-name (current-buffer))))
                (when (string= ".h" (substring file-name -2))
                  (let ((include-guard (get-include-guard)))
                    (insert "#ifndef " include-guard)
                    (newline)
                    (insert "#define " include-guard)
                    (newline 4)
                    (insert "#endif")
                    (newline)
                    (previous-line 3)
                    (set-buffer-modified-p nil))))))

;;h和cpp之间转换
(defun next-file-with-basename ()
 "Cycles between files with the same basename as the given file.
  Usefull for cycling between header .h/.cpp/.hpp files etc."
 (interactive)
 (let* ((buf-file-name (replace-regexp-in-string
                        "^.*/" ""
                        (buffer-file-name)))
        (current-dir (replace-regexp-in-string
                      "[a-zA-Z0-9._-]+$" ""
                      (buffer-file-name)))
        (no-basename (equal ?. (aref buf-file-name 0)))
        (has-extension (find ?. buf-file-name)))
   ;; If the file is a .dot-file or it doesn't have an
   ;; extension, then there's nothing to do here.
   (unless (or no-basename (not has-extension))
     (let* ((basename (replace-regexp-in-string
                       "\\..*" ""
                       buf-file-name))
            (files-with-basename (directory-files
                                  current-dir f
                                  (concat "^" basename "\\."))))
       ;; If there's only 1 file with this basename, nothing to
       ;; do
       (unless (= (length files-with-basename) 1)
         ;; By making the list circular, we're guaranteed that
         ;; there will always be a next list element (ie. no
         ;; need for special case when file is at the end of
         ;; the list).
         (setf (cdr (last files-with-basename))
               files-with-basename)
         (find-file (cadr (member (buffer-file-name)
                                  files-with-basename))))))))
