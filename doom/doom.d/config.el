;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; refresh' after modifying this file!

;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Kevin Ziegler"
      user-mail-address "ziegler.kevin@heb.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
(setq doom-font (font-spec :family "FiraCode Nerd Font" :size 13)
      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13)
      doom-big-font (font-spec :family "Fira Sans" :size 16))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-oceanic-next)

;; TODO: HEB, add projectile default directory

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)

(after! treemacs (setq treemacs-collapse-dirs 7))
(after! plantuml-mode (setq plantuml-default-exec-mode 'executable))

(setq magit-git-executable "/usr/local/bin/git"
      magit-repository-directories
      '(("~/dev" . 2) ("~/.dotfiles" . 0)))

(after! vterm (setq vterm-shell "/usr/local/bin/zsh"))

;; FIXME: after! block?
(add-hook 'sh-mode-hook
          (lambda ()
            (when (string-match "zshrc$" buffer-file-name)
                (sh-set-shell "zsh"))))

;; Set default window size
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 180))

(add-to-list 'auto-mode-alist '("\\.tsx\\'" . typescript-tsx-mode))

;; TODO: Move buffer extras to a module?
(defun switch-to-message-buffer ()
    (interactive)
    (pop-to-buffer "*Messages*"))

(map! :leader
      (:prefix "b"
        :desc "Messages" "m" #'switch-to-message-buffer
        :desc "Copy Buffer" "y" #'copy-whole-buffer))

;; TODO: Add wq command for org-src-mode
;; TODO: 'add' menu for org under SPC m a
;; TODO: Minor mode for plantuml live-reload previews?

;; TODO: Move this hydra to a module
(require 'hydra)
(defhydra hydra-git-timemachine ()
  "Git Time Machine"
  ("b" git-timemachine-blame "Show git blame")
  ("c" git-timemachine-show-commit "Show commit")
  ("p" git-timemachine-show-previous-revision "Previous revision")
  ("n" git-timemachine-show-next-revision "Next revision"))
(add-hook! git-timemachine-mode #'hydra-git-timemachine/body)

(load! "conf.d/lsp")
(load! "conf.d/lsp-java")
(load! "conf.d/heb")
(load! "conf.d/keybinds")
(load! "conf.d/org")

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(safe-local-variable-values
   '((eval add-hook 'java-mode-hook
           (lambda nil
             (setq c-basic-offset 4 tab-width 4 indent-tabs-mode t))))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
