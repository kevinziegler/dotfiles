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
(setq doom-font (font-spec :family "Fira Code" :size 11))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. These are the defaults.
(setq doom-theme 'doom-nord)

;; If you intend to use org, it is recommended you change this!
(setq org-directory "~/notes/")

;; TODO: HEB, add projectile default directory

;; If you want to change the style of line numbers, change this to `relative' or
;; `nil' to disable it:
(setq display-line-numbers-type t)

(after! plantuml-mode
  (setq plantuml-default-exec-mode 'executable))


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', where Emacs
;;   looks when you load packages with `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c g k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c g d') to jump to their definition and see how
;; they are implemented.

;; Ported from my Spacemacs config

(setq magit-git-executable "/usr/local/bin/git")
(setq org-hide-emphasis-markers t)
(setq org-journal-dir "~/notes/journal/")
(setq org-default-notes-file "~/notes/random.org")
(setq org-insert-heading-respect-content t)

(setq deft-directory "~/notes")

(evil-ex-define-cmd "W" 'evil-write)
(evil-ex-define-cmd "Wq" 'evil-save-and-close)
(evil-ex-define-cmd "WQ" 'evil-save-and-close)

(after! org
  (add-to-list 'org-capture-templates
               '("f"
                "Jira Feature Ticket Note"
                entry
                (file "~/notes/tickets.org")
                (file "~/.dotfiles/capture-templates/feature-ticket.org.tpl")))

  (add-to-list 'org-capture-templates
               '("b"
                "Jira Bug Ticket Note"
                entry
                (file "~/notes/tickets.org")
                (file "~/.dotfiles/capture-templates/bug-ticket.org.tpl")))

  (add-to-list 'org-capture-templates
               '("d"
                "Technical debt Note"
                entry (file "~/notes/general.org")
                "* TODO Technical debt work: %?\nFound in: [[file:%F][%f]]"))

  (add-to-list 'org-capture-templates
               '("r"
                "Retro thought"
                entry
                (file "~/notes/general.org")
                "* TODO Discuss in next retro: %?")))

(after! lsp-java
  (setq lombok-jar-path
        (expand-file-name
         "~/.m2/repository/org/projectlombok/lombok/1.18.6/lombok-1.18.6.jar"))

  (setq lsp-java-vmargs
        `("-noverify"
          "-Xmx2G"
          "-XX:+UseG1GC"
          "-XX:+UseStringDeduplication"
          ,(concat "-javaagent:" lombok-jar-path)
          ,(concat "-Xbootclasspath/a:" lombok-jar-path))))

(after! dap-java
  (setq dap-java-test-runner (concat doom-local-dir "etc/eclipse.jdt.ls/server/test-runner/junit-platform-console-standalone.jar")))

(setq magit-repository-directories
      '(("~/dev" . 2)
        ("~/.dotfiles" . 0)))

;; FIXME: after! block?
(add-hook 'sh-mode-hook
          (lambda ()
            (if (string-match "zshrc$" buffer-file-name)
                (sh-set-shell "zsh"))))

(after! org
  (require 'ox-gfm nil t)

  (map! :map org-mode-map
        :localleader
        (:prefix ("x" . "Babel/Examples")
        :desc "Demarcate block" "d" #'org-babel-demarcate-block
        :desc "Execute block" "e" #'org-babel-execute-maybe
        :desc "Go to named src block" "g" #'org-babel-goto-named-src-block
        :desc "Insert header arg" "j" #'org-babel-insert-header-arg))

  (map! :map org-mode-map :localleader "s" nil)
  (map! :map org-mode-map
        :localleader
        :desc "Schedule" "S" #'org-schedule)
  (map! :map org-mode-map
        :localleader
        (:prefix ("s" . "Subtrees")
        :desc "Cut subtree" "d" #'org-cut-subtree
        :desc "Promote subtree" "h" #'org-promote-subtree
        :desc "Demote subtree" "l" #'org-demote-subtree
        :desc "Move Subtree Up" "k" #'org-move-subtree-up
        :desc "Move Subtree Down" "j" #'org-move-subtree-down))

  (map! :map org-mode-map :localleader "i" nil)
  (map! :map org-mode-map
        :localleader
        (:prefix ("i" . "Insert")
        :desc "Insert Heading" "h" #'org-insert-heading
        :desc "Insert Subheading" "s" #'org-insert-subheading)))

(map! :leader :desc "Command" "SPC" #'counsel-M-x)
(map! :leader
      (:prefix-map ("a" . "Applications")
        (:prefix-map ("o" . "Org")
          :desc "Capture" "c" #'org-capture
          :desc "Store Link" "l" #'org-store-link)
        :desc "Deft" "n" #'deft))

(map! :leader
      (:prefix ("e" . "Errors")
        :desc "Error List" "l" #'flycheck-list-errors
        :desc "Next Error" "n" #'next-error
        :desc "Previous Error" "p" #'previous-error))

(map! :leader :desc "Change Major Mode" "M" #'counsel-major)

(map! :leader
      (:prefix "c"
        :desc "(Un)comment Lines" "l" #'evilnc-comment-or-uncomment-lines))

(defun switch-to-message-buffer ()
    (interactive)
    (pop-to-buffer "*Messages*"))

(map! :leader
      (:prefix "b"
        :desc "Messages" "m" #'switch-to-message-buffer
        :desc "Copy Buffer" "y" #'copy-whole-buffer))

(map! :leader
      (:prefix "g"
        :desc "Worktrees" "w" #'magit-worktree))

(map! :leader "x" nil)
(map! :leader
      (:prefix ("x" . "Text")
        :desc "Upcase region" "U" #'upcase-region
        :desc "Downcase region" "u" #'downcase-region))

;; Set default window size
(add-to-list 'default-frame-alist '(height . 50))
(add-to-list 'default-frame-alist '(width . 180))

;; (map! :leader
;;       (:prefix ("g")
;;         (:prefix-map ("l" . "Links")
;;           :desc "Copy Commit URL" "C"#'fixme-stub)))

;; TODO: Add wq command for org-src-mode
;; TODO: CTRL-H to kill word, backspace to single char?
;; TODO: 'add' menu for org under SPC m a
;; TODO: Minor mode for plantuml live-reload previews?

(require 'hydra)

(defhydra hydra-git-timemachine ()
  "Git Time Machine"
  ("b" git-timemachine-blame "Show git blame")
  ("c" git-timemachine-show-commit "Show commit")
  ("p" git-timemachine-show-previous-revision "Previous revision")
  ("n" git-timemachine-show-next-revision "Next revision"))

(add-hook! git-timemachine-mode
           #'hydra-git-timemachine/body)

(setq jiralib-url "https://hebecom.atlassian.net/")
