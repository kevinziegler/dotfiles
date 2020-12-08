;;; heb/config.el -*- lexical-binding: t; -*-
(setq projectile-project-search-path
      '("~/dev" "~/dev/das" "~/dev/das/deprecated" "~/dev/ohs" "~/dev/chil"))
;;; Code:
;; (after! org
;;   (setq org-link-abbrev-alist
;;         '(("git.heb" . "https://git.heb.com/")
;;           ("github" . "https://github.com/")
;;           ("jira" . "https://hebecom.atlassian.net/browse/"))))
(after! org
       (map-put org-link-abbrev-alist "git.heb" "https://git.heb.com")
       (map-put org-link-abbrev-alist "github" "https://github.com")
       (map-put org-link-abbrev-alist "jira" "https://hebecom.atlassian.net/browse/"))
