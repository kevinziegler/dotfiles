;;; lsp-java-lombok --- Set up Lombok for LSP
;;; Commentary:
;;; Helper library for setting up lombok with LSP-java
;;; Code:
(require 'lsp-java)

(defvar lsp-java-lombok-jar-url
  "https://projectlombok.org/downloads/lombok.jar"
  "Source URL for downloading the Lombok JAR.")

(defvar lsp-java-lombok-jar-path
  (concat doom-etc-dir "lombok.jar")
  "Path on disk for the Lombok jar.")

(defvar lsp-java-lombok-enabled
  nil
  "Indicates the LSP server should be started with Lombok.")

(defun lsp-java-lombok-download-jar ()
  "Download lombok jar for use with LSP."
  (url-copy-file lsp-java-lombok-jar-url lsp-java-lombok-jar-path))

(defun lsp-java-lombok-vmargs ()
  "Create JVM startup args to load Lombok with the LSP server."
  `(,(concat "-javaagent:" lsp-java-lombok-jar-path)
    ,(concat "-Xbootclasspath/a:" lsp-java-lombok-jar-path)))

(defun lsp-java-lombok-set-vmargs ()
  "Apply lombok args to lsp-java-vmargs."
  (setq lsp-java-vmargs (append lsp-java-vmargs (lsp-java-lombok-vmargs))))

(defun lsp-java-lombok-setup ()
  "Download Lombok if it has not been downloaded already."
  (when (not (file-exists-p lsp-java-lombok-jar-path))
    (lsp-java-lombok-download-jar)))

(defun lsp-java-lombok-init ()
  "Initialize lsp-java-lombok."
  (when lsp-java-lombok-enabled
    (lsp-java-lombok-setup)
    (lsp-java-lombok-set-vmargs)))

;;; config.el ends here
