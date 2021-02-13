;;; kdz--lsp-java-lombok --- Helper for loading lombok with LSP
;;;
;;; Commentary:
;;;
;;; This is intended to make sure the right version of
;;; Lombok for that specific project.
;;;
;;; Code:
(defvar kdz--lsp-java-lombok-jar
  ; FIXME: Rename this
  nil
  "The path to the lombok jar to use with lsp-java (set per-project).")

(defvar lsp-java-lombok--group-id
  "org.projectlombok"
  "The maven group ID for the Lombok package.")

(defvar lsp-java-lombok--artifact-id
  "lombok"
  "The maven artifact ID for the lombok package.")

(defvar kdz--lsp-java-mvn-classpath-args
  '("mvn"
    "-B"
    "-DincludeGroupIds=org.projectlombok"
    "-DincludeArtifactIds=lombok"
    "dependency:build-classpath")
  "Args to use when calling mvn dependency:build-classpath to find Lombok.")

(defun lsp-java-lombok/mvn-group-id-arg ()
  "Construct the 'includeGroupIds arg for mvn dependency:build-classpath."
  (concat "-DincludeGroupIds=" lsp-java-lombok--group-id))

(defun lsp-java-lombok/mvn-artifact-id-arg ()
  "Construct the 'includeArtifactIds arg for mvn dependency:build-classpath."
  (concat "-DincludeArtifactIds=" lsp-java-lombok--artifact-id))

(defun lsp-java-lombok/find-lombok-jar ()
  (let ((mvn-outfile (make-temp-file "kdz_lsp_java_lombok"))
        (mvn-args ))))

(defun kdz--lsp-java-find-lombok-jar (project-root)
  "Use Maven to find the Lombok jar for the current project.
PROJECT-ROOT is the directory containing the pom.xml"
  (let ((mvn-outfile (make-temp-file "kdz_lsp_java_lombok"))
        (mvn-args (append kdz--lsp-java-mvn-classpath-args '("-f" mvn-outfile))))
        (apply 'call-process mvn-args)))

(defun kdz--lsp-java-lombok-args ()
  "Generate JVM args to make LSP aware of Lombok."
  (if (boundp 'kdz--lsp-java-lombok-jar)
    `(,(concat "-javaagent:" kdz--lsp-java-lombok-jar)
      ,(concat "-Xbootclasspath/a:" kdz--lsp-java-lombok-jar))
    '()))

(defun kdz--lsp-java-lombok-set-for-project ()
  "Find and cache the value for the lombok jar for the project."
    (when (boundp 'projectile-project-root)
      (add-dir-local-variable
       'lsp-java
       'kdz--lsp-java-lombok-jar
       (kdz--lsp-java-find-lombok-jar (projectile-project-root)))))

(defun kdz--lsp-java-has-cached-lombok-jar ()
  "Check if there is a known cached jar path available for lombok."
  (boundp 'kdz--lsp-java-lombok-jar))

(defun kdz--lsp-java-lomok-set-vmargs ()
  "Append lombok args to lsp-java's vmargs."
  ; Check if lombok is already cached for the project, and attempt to
  ; set it if not.
  (when (not (kdz--lsp-java-has-cached-lombok-jar))
    (kdz--lsp-java-lombok-set-for-project))
  ; If we have a cached lombok (after attempting to set it), then we
  ; use that to apply the relevant jvm args for lsp-java
  (when (and
         (kdz--lsp-java-has-cached-lombok-jar)
         (boundp 'lsp-java-vmargs))
    (setq lsp-java-vmargs
          (append lsp-java-vmargs (kdz--lsp-java-lombok-args)))))

;;; config.el ends here
