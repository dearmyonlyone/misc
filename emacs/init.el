;;
(setq load-path (cons "~/.emacs.d/elisp" load-path))

;; 日本語 IM を設定
(setq default-input-method "MacOSX")

;; 日本語の設定
(set-language-environment 'Japanese)
(prefer-coding-system 'utf-8)

;; Mavericks用デフォルトディレクトリを"~/"にする
(setq inhibit-splash-screen t)
(defun cd-to-homedir-all-buffers ()
  "Change every current directory of all buffers to the home directory."
  (mapc
   (lambda (buf) (set-buffer buf) (cd (expand-file-name "~"))) (buffer-list)))
(add-hook 'after-init-hook 'cd-to-homedir-all-buffers)

;; '¥' を入力したら '\' となるように
(define-key global-map [?¥] [?\\])

;; 警告音もフラッシュも全て無効
(setq ring-bell-function 'ignore)

;; 現在行を目立たせる
(global-hl-line-mode)

;; バックアップファイルを作らないようにする
(setq make-backup-files nil)
;;; 終了時にオートセーブファイルを消す
(setq delete-auto-save-files t)

(line-number-mode t)

;; load environment value
(load-file (expand-file-name "~/.emacs.d/shellenv.el"))
(dolist (path (reverse (split-string (getenv "PATH")":")))
  (add-to-list 'exec-path path))

;; package
(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.milkbox.net/packages/"))
(add-to-list 'package-archives  '("marmalade" . "http://marmalade-repo.org/packages/"))
(package-initialize)

;; helm
(require 'helm-config)
(require 'helm-files)
;;(require 'helm-aliases)
;;(helm-mode 1)

(define-key helm-read-file-map (kbd "TAB") 'helm-execute-persistent-action)
(define-key helm-find-files-map (kbd "TAB") 'helm-execute-persistent-action)

(global-set-key (kbd "M-x") 'helm-M-x)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "C-x C-r") 'helm-recentf)
(global-set-key (kbd "M-y") 'helm-show-kill-ring)
(global-set-key (kbd "C-c i") 'helm-imenu)
(global-set-key (kbd "C-x b") 'helm-buffers-list)

(define-key helm-read-file-map (kbd "C-h") 'delete-backward-char)
(define-key helm-read-file-map (kbd "<tab>") 'helm-execute-persistent-action)
;; ディレイは0.2秒
(setq helm-input-idle-delay 0.02)

;; 候補のディレクトリが一つしかない場合に、自動的に展開しない
(setq helm-ff-auto-update-initial-value nil)

;; ggtags
(add-hook 'ggtags-mode-hook
  (lambda ()
    (define-key ggtags-mode-map (kbd "M-t") 'ggtags-find-definition)
    (define-key ggtags-mode-map (kbd "M-r") 'ggtags-find-reference)
    (define-key ggtags-mode-map (kbd "M-s") 'ggtags-find-other-symbol)
    (define-key ggtags-mode-map (kbd "M-]") 'nil)
    (define-key ggtags-mode-map (kbd "M-[") 'beginning-of-defun)
    (define-key ggtags-mode-map (kbd "M-]") 'end-of-defun)
    (define-key ggtags-mode-map (kbd "C-^") 'pop-tag-mark)))

;; font
;; 英語
(set-face-attribute 'default nil
  :family "Menlo" ;; font
  :height 120)    ;; font size

;; 日本語
(set-fontset-font
  nil 'japanese-jisx0208
  (font-spec :family "Hiragino Kaku Gothic ProN")) ;; font

;; 半角と全角の比を1:2にしたければ
(setq face-font-rescale-alist
  '((".*Hiragino_Kaku_Gothic_ProN.*" . 1.2)));;

;; 色
(set-background-color "#98bc98") ;; background color
(set-foreground-color "black")   ;; font color

;; 起動時に ggtags を有効化
(add-hook 'c-mode-common-hook
          '(lambda()
             (ggtags-mode 1)))
