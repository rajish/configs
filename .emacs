(setq noerror t)
(add-to-list 'load-path
     (expand-file-name "~/.emacs.d/plugins")
     "/usr/lib/xemacs/site-lisp")
(global-auto-revert-mode 1)

; ============ CEDET ============
;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
;; (load-file "~/.emacs.d/plugins/cedet-1.1/common/cedet.el")

;; ;; EDE
;; (global-ede-mode 1)
;; (ede-enable-generic-projects)
;; (semantic-load-enable-code-helpers)
;; (semantic-load-enable-excessive-code-helpers)

;; ;; select which submodes we want to activate
;; (add-to-list 'semantic-default-submodes 'global-semantic-mru-bookmark-mode)
;; (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-idle-scheduler-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-stickyfunc-mode)
;; (add-to-list 'semantic-default-submodes 'global-cedet-m3-minor-mode)
;; (add-to-list 'semantic-default-submodes 'global-semantic-highlight-func-mode)
;; (add-to-list 'semantic-default-submodes 'global-semanticdb-minor-mode)

;; ;; Activate semantic
;; (require 'semantic)
;; (require 'semanticdb)
;; ;;(semantic-mode 1)

;; ;; load contrib library
;; (require 'eassist)

;; ;; customisation of modes
;; (defun alexott/cedet-hook ()
;;   (local-set-key [(control return)] 'semantic-ia-complete-symbol-menu)
;;   (local-set-key "\C-c?" 'semantic-ia-complete-symbol)
;;   ;;
;;   (local-set-key "\C-c>" 'semantic-complete-analyze-inline)
;;   (local-set-key "\C-c=" 'semantic-decoration-include-visit)

;;   (local-set-key "\C-cj" 'semantic-ia-fast-jump)
;;   (local-set-key "\C-cq" 'semantic-ia-show-doc)
;;   (local-set-key "\C-cs" 'semantic-ia-show-summary)
;;   (local-set-key "\C-cp" 'semantic-analyze-proto-impl-toggle)
;;   )
;; (add-hook 'c-mode-common-hook 'alexott/cedet-hook)
;; (add-hook 'lisp-mode-hook 'alexott/cedet-hook)
;; (add-hook 'scheme-mode-hook 'alexott/cedet-hook)
;; (add-hook 'emacs-lisp-mode-hook 'alexott/cedet-hook)
;; (add-hook 'erlang-mode-hook 'alexott/cedet-hook)

;; (require 'eieio)
;; (require 'eieio-load)

;; (defun alexott/c-mode-cedet-hook ()
;;   (local-set-key "\C-ct" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-xt" 'eassist-switch-h-cpp)
;;   (local-set-key "\C-ce" 'eassist-list-methods)
;;   (local-set-key "\C-c\C-r" 'semantic-symref)
;;   )
;; (add-hook 'c-mode-common-hook 'alexott/c-mode-cedet-hook)

;; (semanticdb-enable-gnu-global-databases 'c-mode t)
;; (semanticdb-enable-gnu-global-databases 'c++-mode t)

;; (when (cedet-ectag-version-check t)
;;   (semantic-load-enable-primary-ectags-support))

;; ;; SRecode
;; (require 'srecode)
;; (global-srecode-minor-mode 1)

;; (require 'cogre)
;; (require 'cedet-contrib)

;; ================ Window size ==========================
;; (defun set-frame-size-according-to-resolution ()
;;   (interactive)
;;   (if window-system
;;       (progn
;;         ;; use 120 char wide window for largeish displays
;;         ;; and smaller 80 column windows for smaller displays
;;         ;; pick whatever numbers make sense for you
;;         (if (> (x-display-pixel-width) 1280)
;;             (add-to-list 'default-frame-alist (cons 'width 120))
;;           (add-to-list 'default-frame-alist (cons 'width 80)))
;;         ;; for the height, subtract a couple hundred pixels
;;         ;; from the screen height (for panels, menubars and
;;         ;; whatnot), then divide by the height of a char to
;;         ;; get the height we want
;;         (add-to-list 'default-frame-alist
;;                      (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

;; (set-frame-size-according-to-resolution)

;; =========== INFO =================
(when (require 'info nil 'noerror)
  (setq Info-directory-list
        (cons (expand-file-name "/usr/share/info/emacs-23")
              Info-directory-list)))


;; Filladapt
(when (require 'filladapt nil 'noerror)
  (setq-default filladapt-mode t))

;; Session
(when (require 'session nil 'noerror)
  (add-hook 'after-init-hook 'session-initialize))

;; yasnippet
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/yasnippet"))
(when (require 'yasnippet nil 'noerror)
  (yas/global-mode 1)
  (setq yas/my-directory (expand-file-name "~/.emacs.d/plugins/scala-mode/contrib/yasnippet/snippets"))
  (yas/load-directory yas/my-directory))

;;(require 'newcomment nil 'noerror)
(when (require 'ibuffer nil 'noerror)
  (define-key global-map "\C-x\C-b" 'ibuffer))
(define-key global-map "\M-;" 'comment-dwim)
(define-key global-map "\C-T" 'transpose-lines)
(define-key global-map [(control tab)] 'next-multiframe-window)
(define-key global-map [(control shift iso-lefttab)] 'previous-multiframe-window)
  ;;(define-key global-map "\M-/" 'hippie-expand)
(defun toggle-fullscreen ()
  "Toggle full screen on X11"
  (interactive)
  (when (eq window-system 'x)
    (set-frame-parameter
     nil 'fullscreen
     (when (not (frame-parameter nil 'fullscreen)) 'fullboth))))

(global-set-key [f11] 'toggle-fullscreen)

; ============= cc-mode ===============
(require 'cc-mode)
(add-hook 'c-mode-common-hook (lambda ()
                                (c-toggle-auto-hungry-state t)
                                (subword-mode t)))
(define-key global-map "\C-c\C-t" 'c-toggle-auto-hungry-state)
(add-hook 'c-mode-common-hook (lambda () (font-lock-mode t)))
;; (add-hook 'c-mode-common-hook 'hs-minor-mode)
;; (c-add-style "ivo"
;;              ("stroustrup"))
;============ DOXY(GEN)MACS ==============
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/doxymacs/lisp"))
(when (require 'doxymacs nil 'noerror)
  (add-hook 'c-mode-common-hook 'doxymacs-mode)

  (defun my-doxymacs-font-lock-hook ()
    (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
        (doxymacs-font-lock)))
  (add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook))

(when (require 'tempo nil 'noerror)
  ;(defvar my-doxy-tempo-tags)
  (add-hook 'c-mode-common-hook '(lambda () (tempo-use-tag-list 'my-doxy-tempo-tags)))
  (tempo-define-template "single-line" '("/** " r > " */") "single-line" "Insert single line Doxygen comment")
  (tempo-define-template "group-start" '("/******************************************************************************" > n
                                         " * " > n
                                         " * " > n
                                         " * " (doxymacs-doxygen-command-char) "defgroup" p > n
                                         " * " (doxymacs-doxygen-command-char) "{" > n
                                         "*/" > n)
                         "group-start" "Insert group start Doxygen comment")

  (tempo-define-template "group-end" '("/** " (doxymacs-doxygen-command-char) "}*/" > n)
                         "group-end" "Insert group end Doxygen comment")

  (tempo-define-template "function-comment" '((let ((next-func (doxymacs-find-next-func)))
                                                (if next-func
                                                    (list
                                                     'l
                                                     "/**" 'p '> 'n
                                                     "  * " '> 'n
                                                     (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
                                                     (unless (string-match
                                                              (regexp-quote (cdr (assoc 'return next-func)))
                                                              doxymacs-void-types)
                                                       '(l "  * " > n "  * " "\\return " (p "Returns: ") > n))
                                                     " */" '> 'n)
                                                  (progn
                                                    (error "Can't find next function declaration.")
                                                    nil))))
                         "function-comment"
                         "Insert function description comment"))

; ============ DOS2UNIX line ends ===========
(defun dos2unix (buffer)
      "Automate M-% C-q C-m RET C-q C-j RET"
      (interactive "*b")
      (save-excursion
        (goto-char (point-min))
        (while (search-forward (string ?\C-m) nil t)
          (replace-match (string ) nil t))))

; ============= Version control ================
;;(require 'pcl-cvs nil 'noerror)
(require 'psvn nil 'noerror)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/magit"))
(require 'magit nil 'noerror)
(require 'magit-svn nil 'noerror)

; ==============  modes hooking to file extensions =========
;;(remove-alist 'auto-mode-alist "\\.[ch]\\'")
(setq auto-mode-alist
      (append  '(("\\.tcf\\'" . c-mode)
                 ("\\.[ch]\\'" . c++\-mode)
                 ("\\.inc\\'" . c-mode)
                 ("Makefile\\.*". makefile-mode)
                 ("\\.mkf\\'" . makefile-mode))
               auto-mode-alist))

;=========== ANSI color =============
(when (require 'ansi-color nil 'noerror)
  (defun colorize-compilation-buffer ()
    (toggle-read-only)
    (ansi-color-apply-on-region (point-min) (point-max))
    (toggle-read-only))
  (add-hook 'compilation-filter-hook 'colorize-compilation-buffer)
  (add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on))

; ============ desktop ============

(when (require 'desktop nil 'noerror)
  (add-hook 'desktop-after-read-hook
            '(lambda ()
               ;; desktop-remove clears desktop-dirname
               (setq desktop-dirname-tmp desktop-dirname)
               (desktop-remove)
               (setq desktop-dirname desktop-dirname-tmp))))
;;(desktop-save-mode 1)
;;(desktop-load-default)
;;(desktop-read)


;; ============== CSCOPE ==================
(when (require 'xcscope nil 'noerror)
  ;;(define-key global-map [(control f3)]  'cscope-set-initial-directory)
  ;;(define-key global-map [(control f4)]  'cscope-unset-initial-directory)
  (define-key global-map "\M-."  'cscope-find-this-symbol)
  ;;(define-key global-map [(control f6)]  'cscope-find-global-definition)
  ;;(define-key global-map [(control f7)]
  ;;  'cscope-find-global-definition-no-prompting)
  (define-key global-map [(meta *)]  'cscope-pop-mark)
  ;;(define-key global-map [(control f9)]  'cscope-next-symbol)
  ;;(define-key global-map [(control f10)] 'cscope-next-file)
  ;;(define-key global-map [(control f11)] 'cscope-prev-symbol)
  ;;(define-key global-map [(control f12)] 'cscope-prev-file)
  ;;      (define-key global-map [(meta f9)]  'cscope-display-buffer)
  ;;      (defin-ekey global-map [(meta f10)] 'cscope-display-buffer-toggle)

  (setq  cscope-database-regexps
         '(
           ("^/home/rajish/proj/net-snmp-5.4.1"
            (t)
            ("/home/rajish/proj/net-snmp-5.4.1"))
           )
         ))

;;; ============ Abbrevs ================
(defun jump-to-column (arg)
  (debug)
  (princ arg))

(defun insert-dbgexr()
  (interactive)
  (insert "dbgex(\"")
  (setq nocolor-startpoint (current-column))
  (insert "\\x1b[1;31m ")
  (setq color-point (current-column))
  (insert "\\x1b[0m")
  (setq nocolor-endpoint (current-column))
  (insert "\\r\\n\");")
  (move-to-column (- color-point 1))
  (indent-according-to-mode))

(defun insert-dbgex()
  (interactive)
  (insert "dbgex(\"")
  ;;(insert (read-string "Comment: "))
  (setq color-point (current-column))
  (insert "\\r\\n\");")
  (move-to-column color-point)
  (indent-according-to-mode)
  ;;(delete-backward-char)
  )

(defun insert-redstring()
  (interactive)
  (insert "\"\\x1b[1;31m ")
  (setq color-point (current-column))
  (insert "\\x1b[0m\"")
  (move-to-column (- color-point 1))
  (indent-according-to-mode))

; (read-abbrev-file "~/.emacs.d/abbrevs")

;=========================================
; Doppke's hack for following the cursor in the compile window
;

(defadvice compile (after put-point-at-end activate)
  "Puts the point at the end of the compilation buffer."
  (let ((win (get-buffer-window "*compilation*"))
        (curwindow (selected-window)))
    (if win
        (progn
          (select-window win)
          (goto-char (point-max))
          (select-window curwindow)))))
(if (featurep 'compile)
    (ad-activate 'compile)
  (eval-after-load 'compile '(ad-activate 'compile)))

;=========== docbook =============
(add-hook 'docbook-mode-hook 'turn-on-font-lock)

;=========== JDE ==============
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/jdee/dist/jdee-2.4.1/lisp"))
(require 'jde nil 'noerror)

(require 'compile nil 'noerror)

(defvar mvn-command-history nil
  "Maven command history variable")

(defun mvn(&optional args)
  "Runs maven in the current project. Starting at the directoy where the file being vsisited resides, a search is
   made for pom.xml recsurively. A maven command is made from the first directory where the pom.xml file is found is then displayed
  in the minibuffer. The command can be edited as needed and then executed. Errors are navigate to as in any other compile mode"
  (interactive)
  (let ((fn (buffer-file-name)))
    (let ((dir (file-name-directory fn)))
      (while (and (not (file-exists-p (concat dir "/pom.xml")))
                  (not (equal dir (file-truename (concat dir "/..")))))
        (setf dir (file-truename (concat dir "/.."))))
      (if (not (file-exists-p (concat dir "/pom.xml")))
          (message "No pom.xml found")
        (compile (read-from-minibuffer "Command: "
                                       (concat "mvn -f " dir "/pom.xml test") nil nil 'mvn-command-history))))))

;; String pattern for locating errors in maven output. This assumes a Windows drive letter at the beginning
(add-to-list
 'compilation-error-regexp-alist
 '("^\\([a-zA-Z]:.*\\):\\[\\([0-9]+\\),\\([0-9]+\\)\\]" 1 2 3))

; (load-file (expand-file-name "~/.emacs.d/plugins/jde-int/jde-int.el"))
(c-add-style "java"
              '(
              (c-basic-offset . 4)
              (c-comment-only-line-offset 0 . 0)
                (c-hanging-braces-alist
                 (inline-open after)
                 (substatement-open after)
                 (block-close . c-snug-do-while)
                 (extern-lang-open after)
                 (inexpr-class-open after)
                 (inexpr-class-close before))
              (c-cleanup-list)
              (c-offsets-alist
               (inline-open . 0)
               (topmost-intro-cont . +)
               (statement-block-intro . +)
               (knr-argdecl-intro . 5)
               (substatement-open . +)
               (substatement-label . +)
               (label . +)
               (statement-case-open . +)
               (statement-cont . +)
               (arglist-intro . c-lineup-arglist-intro-after-paren)
               (arglist-close . c-lineup-arglist)
               (access-label . 0)
               (inher-cont . c-lineup-java-inher)
               (func-decl-cont . c-lineup-java-throws))))
;;================= emacs-wiki ===================================
;;(require 'emacs-wik
(when (require 'wikipedia-mode  nil 'noerror)
  (add-to-list 'auto-mode-alist
               '("\\.wiki\\'" . wikipedia-mode))
  (add-to-list 'auto-mode-alist
               '("itsalltext.*\\.txt$" . wikipedia-mode)))

;;(require 'wikipediafs nil 'noerror)
;;================= emacs server =================================
(server-start)
;;===================== w3m ======================================
(when (require 'w3m-browse-url nil 'noerror)
  (setq browse-url-browser-function 'w3m-browse-url)
  ;; optional keyboard short-cut
  (global-set-key "\C-xm" 'browse-url-at-point))

;;===================== RectangleAdd =============================
;; From http://www.emacswiki.org/emacs/RectangleAdd

(defun rectangle-add (start end)
  "Add all the lines in the region-rectangle and put the result in the
        kill ring."
  (interactive "r")
  (let ((sum 0))
    (mapc (lambda (line)
            (setq sum (+ sum (rectangle-add-make-number line))))
          (extract-rectangle start end))
    (kill-new (number-to-string sum))
    (message "%s" sum)))

(defun rectangle-add-make-number (n)
  "Turn a string into a number, being tolerant of commas and even other 'junk'.
    When I started programming, my numeric input routines translated l
    (lowercase ell) into 'one', as many users had learnt their
      keyboarding on manual typewriters which typically lacked
      a separate key for the digit 1. Am I old, or what?"
  (while (string-match "[^0-9.]" n)
    (setq n (replace-match "" nil nil n)))
  (string-to-number n))

(when (require 'po-mode nil 'noerror)
  (defun po-wrap ()
    "Filter current po-mode buffer through `msgcat' tool to wrap all lines."
    (interactive)
    (if (eq major-mode 'po-mode)
        (let ((tmp-file (make-temp-file "po-wrap."))
              (tmp-buf (generate-new-buffer "*temp*")))
          (unwind-protect
              (progn
                (write-region (point-min) (point-max) tmp-file nil 1)
                (if (zerop
                     (call-process
                      "msgcat" nil tmp-buf t (shell-quote-argument tmp-file)))
                    (let ((saved (point))
                          (inhibit-read-only t))
                      (delete-region (point-min) (point-max))
                      (insert-buffer tmp-buf)
                      (goto-char (min saved (point-max))))
                  (with-current-buffer tmp-buf
                    (error (buffer-string)))))
            (kill-buffer tmp-buf)
            (delete-file tmp-file)))))

  (add-hook 'po-subedit-mode-hook (lambda ()
                                    (ispell-change-dictionary "pl")
                                    (flyspell-mode)
                                    (longlines-mode 1)))
  (add-hook 'po-subedit-exit-hook (lambda ()
                                    (longlines-mode 0)
                                    (po-wrap))))

;;(require 'frame-cmds nil 'noerror)
(setq my-hostname
      (replace-regexp-in-string "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" ;; like perl chomp()
                                (with-output-to-string
                                  (call-process "/bin/hostname" nil standard-output nil))))
(setq my-username (getenv "USERNAME"))
(setq frame-title-format '("%f - " my-username "@" my-hostname))

;;===================== ethan-wspace =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/ethan-wspace/lisp"))
(when (require 'ethan-wspace nil 'noerror)
  (global-ethan-wspace-mode 1))
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'c-mode-common-hook
          (lambda()
            (add-hook 'before-save-hook
                      'delete-trailing-whitespace nil t)))
(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 4)
            (setq indent-tabs-mode t)
            (ethan-wspace-type-deactivate 'tabs)))
;;            (flyspell-prog-mode 1)))

(global-set-key (kbd "C-c p")
                (lambda()(interactive)
                  (ispell-change-dictionary "polish")
                  (flyspell-buffer)))
;;===================== auto-complete =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/auto-complete/bin"))
(when (require 'auto-complete-config nil 'noerror)
  (add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/bin/ac-dict")
  (ac-config-default))
;;===================== js2-mode =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/js2-mode"))
(when (autoload 'js3-mode "js3-mode" nil t)
  (add-to-list 'auto-mode-alist '("\\.js$" . js3-mode)))
;; ;;===================== multi-web-mode =============================
;; (add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/multi-web-mode"))
;; (when (require 'multi-web-mode nil 'noerror)
;;   (setq mweb-default-major-mode 'html-mode)
;;   (setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
;;                     (js-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
;;                     (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")
;;                     (java-mode "${[^}]*" "}")
;;                     (c++-mode "\%{[^}]*" "}\%")
;;                     ))
;;   (setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
;;   (multi-web-global-mode 1))
;;===================== develock =============================
;;(require 'develock nil 'noerror)
(global-font-lock-mode 1)
(require 'scss-mode nil 'noerror)

;;===================== yaml-mode =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/yaml-mode"))
(when (require 'yaml-mode nil 'noerror)
  (add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode)))

;;===================== deft-mode and markdown =============================
;; http://jblevins.org/projects/deft/
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/deft"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/markdown-mode"))
(when (and (require 'deft nil 'noerror) (require 'markdown-mode nil 'noerror))
   (setq
      deft-extension "md"
      deft-directory "~/.deft/"
      deft-text-mode 'markdown-mode
      deft-use-filename-as-title t)
   (global-set-key (kbd "<f9>") 'deft)
   ;; (add-hook 'markdown-mode (lambda ()
   ;;                            (ethan-wspace-clean-all-modes)
   ;;                            (ethan-wspace-clean-eol-mode-disable-highlight)))
   (setq auto-mode-alist
         (append '(("\\.text" . markdown-mode)
                   ("\\.md" . markdown-mode)) auto-mode-alist)))
;;===================== scala-mode + ensime =======================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/ensime/elisp"))
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/scala-mode"))
(when (require 'scala-mode-auto nil 'noerror)
  (add-to-list 'auto-mode-alist '("\\.scala.html$" . web-mode))
  (when  (require 'ensime nil 'noerror)
    (add-hook 'scala-mode-hook 'ensime-scala-mode-hook)
    (add-to-list 'ensime-doc-lookup-map '("^play\\.api\\." . make-play-doc-url)))
  (add-hook 'scala-mode-hook '(lambda ()
                              (yas/minor-mode-on))))

(when (require 'web-mode nil 'noerror)
  (add-to-list 'auto-mode-alist
               '("\\.html$" . web-mode)
               '("\\.hbs$" . web-mode))
  (add-hook 'web-mode-hook
          (lambda()
            (setq sgml-basic-offset 4)
            (setq indent-tabs-mode t)
            (ethan-wspace-type-deactivate 'tabs))))

(setq ensime-sem-high-faces
      '(
        (var . (:foreground "#ff2222"))
        (val . (:foreground "#aaaaaa"))
        (varField . (:foreground "#ff6666"))
        (valField . (:foreground "#666666"))
        (functionCall . (:foreground "#84BEE3"))
        (param . (:foreground "#bbaabb"))
        (class . font-lock-type-face)
        (trait . (:foreground "#084EA8"))
        (object . (:foreground "#026DF7"))
        (package . font-lock-preprocessor-face)))

(defun make-play-doc-url (type &optional member)
  (ensime-make-java-doc-url-helper
    "file:///home/rajish/bin/play2/documentation/api/scala/" type member))

(add-to-list 'auto-mode-alist '("\\.xsd$" . nxml-mode))
;;===================== js-beautifier =============================
(require 'js-beautify nil 'noerror)

;;===================== coffee-mode =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/coffee-mode"))
(when (require 'coffee-mode nil 'noerror)
  (add-to-list 'auto-mode-alist '("\\.coffee$" . coffee-mode))
  (add-to-list 'auto-mode-alist '("Cakefile" . coffee-mode)))

;;===================== coffee-mode =============================
(when (require 'less-css-mode nil 'noerror)
  (add-to-list 'auto-mode-alist '("\\.less$" . less-css-mode)))

;;===================== my functions =============================

(defun align-after-char (beg end c)
  (interactive "r\nsSeparation string: ")
  (align-regexp beg end (concat c "\\(\\s-*\\)") 1 1 t))

(defun align-before-char (beg end c)
  (interactive "r\nsSeparation string: ")
  (align-regexp beg end (concat "\\(\\s-*\\)" c) 1 1 t))


(setq exec-path (append exec-path
                        (list
                         (expand-file-name "~/bin/" )
                         (expand-file-name "~/bin/play2" ))))
;================== CUSTOMIZATIONS ===============================

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(Buffer-menu-buffer+size-width 46)
 '(Info-additional-directory-list (quote ("/usr/share/info")))
 '(ac-modes (quote (emacs-lisp-mode lisp-mode lisp-interaction-mode slime-repl-mode c-mode cc-mode c++-mode java-mode malabar-mode clojure-mode scala-mode scheme-mode ocaml-mode tuareg-mode haskell-mode perl-mode cperl-mode python-mode ruby-mode ecmascript-mode javascript-mode js-mode js2-mode php-mode css-mode scss-mode makefile-mode sh-mode fortran-mode f90-mode ada-mode xml-mode sgml-mode)))
 '(ansi-color-for-comint-mode t)
 '(backward-delete-char-untabify-method (quote hungry))
 '(browse-url-browser-function (quote browse-url-firefox))
 '(c-default-style (quote ((c-mode . "stroustrup") (c++-mode . "stroustrup") (java-mode . "java") (other . "stroustrup"))))
 '(coffee-cygwin-mode nil)
 '(coffee-tab-width 4)
 '(column-number-mode t)
 '(comment-column 80)
 '(comment-fill-column 180)
 '(compilation-scroll-output t)
 '(compilation-window-height 16)
 '(compile-command "make -j5 ")
 '(cpp-config-file "~/configs/.cpp.el")
 '(delete-old-versions t)
 '(desktop-modes-not-to-save (quote (tags-table-mode cscope)))
 '(desktop-save-mode t)
 '(develock-html-font-lock-keywords (quote ((develock-find-long-lines (1 (quote develock-long-line-1) t nil) (2 (quote develock-long-line-2) t nil)) (develock-find-tab-or-long-space (1 (quote develock-whitespace-2)) (2 (quote develock-whitespace-3) nil t)) ("[^
 ]\\([   ]+\\)$" (1 (quote develock-whitespace-1) t nil)) ("\\( +\\)\\( +\\)" (1 (quote develock-whitespace-1) t nil) (2 (quote develock-whitespace-2) t nil)) ("\\(    \\)     " (1 (quote develock-whitespace-2) append nil)) ("^[     ]+$" (0 (quote develock-whitespace-2) append nil)) ((lambda (limit) (let (case-fold-search) (re-search-forward "</?\\([A-Z]+\\)" limit t))) (1 (quote develock-upper-case-tag) t nil)) ((lambda (limit) (let (case-fold-search) (re-search-forward "<[a-zA-Z]+[         ]+\\([A-Z]+\\)[         ]*=" limit t))) (1 (quote develock-upper-case-attribute) t nil)) ("#{\\([/.a-zA-Z]+\\)\\([^}]*\\)}" (0 (quote font-lock-type-face) t nil) (1 (quote font-lock-keyword-face) prepend nil)) ("\\(@+\\|&\\|$\\|%\\){[^}]*}" 0 (quote font-lock-type-face) t nil))))
 '(develock-max-column-plist (quote (emacs-lisp-mode 100 lisp-interaction-mode w change-log-mode t texinfo-mode t c-mode 100 c++-mode 100 java-mode 100 jde-mode 100 html-mode 180 html-helper-mode 100 cperl-mode 100 perl-mode 100 mail-mode t message-mode t cmail-mail-mode t tcl-mode 100 ruby-mode 100)))
 '(diff-switches "-c -b -B")
 '(doxymacs-blank-singleline-comment-template tempo-template-single-line)
 '(doxymacs-command-character "\\")
 '(doxymacs-doxygen-style "JavaDoc")
 '(doxymacs-function-comment-template tempo-template-function-comment)
 '(doxymacs-member-comment-end " */")
 '(doxymacs-member-comment-start "/**<  ")
 '(ede-project-directories (quote ("/home/rajish/proj/sicl")))
 '(ensime-default-server-cmd "~/.emacs.d/plugins/ensime/bin/server")
 '(font-lock-verbose nil)
 '(frame-background-mode (quote dark))
 '(hippie-expand-dabbrev-as-symbol nil)
 '(ibuffer-formats (quote ((mark modified read-only " " (name 46 -1) " " (size 6 -1 :right) " " (mode 16 16 :right) " " filename) (mark " " (name 46 -1) " " filename))))
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries (quote ((t . right) (top . left))))
 '(indicate-empty-lines t)
 '(ispell-silently-savep t)
 '(jde-compile-option-classpath nil)
 '(jde-global-classpath (quote ("/usr/lib/jvm/java-6-sun-1.6.0.26/jre/lib" "~/bin/play/framework" "~/bin/play/framework/lib")))
 '(jde-help-docsets (quote (("JDK API" "http://docs.oracle.com/javase/6/docs/api" nil) ("Play! Framework API" "/home/rajish/bin/play/documentation/api" nil))))
 '(jde-imenu-sort (quote asc))
 '(jde-jdk (quote ("1.6.0")))
 '(jde-jdk-registry (quote (("1.5.0" . "/opt/sun-jdk-1.5.0.15") ("1.4.2" . "/opt/sun-jdk-1.4.2.17") ("1.6.0" . "/usr/lib/jvm/java-6-sun") ("1.6.0" . "/opt/sun-jdk-1.6.0.16"))))
 '(js-beautify-path "~/proj/js-beautify/python/js-beautify")
 '(js-expr-indent-offset 4)
 '(js2-auto-indent-p t)
 '(js2-bounce-indent-p t)
 '(js2-mirror-mode t)
 '(kill-whole-line t)
 '(longlines-show-hard-newlines t)
 '(longlines-wrap-follows-window-size t)
 '(markdown-command "pandoc")
 '(mode-require-final-newline nil)
 '(nxml-auto-insert-xml-declaration-flag t)
 '(nxml-slash-auto-complete-flag t)
 '(package-archives (quote (("gnu" . "http://elpa.gnu.org/packages/") ("melpa" . "http://melpa.milkbox.net/packages/"))))
 '(pydb-many-windows t)
 '(safe-local-variable-values (quote ((c-style . whitesmith))))
 '(save-place t nil (saveplace))
 '(scala-mode-feature:speedbar-open nil)
 '(scroll-bar-mode (quote right))
 '(select-active-regions t)
 '(session-use-package t nil (session))
 '(show-paren-mode t)
 '(show-trailing-whitespace nil)
 '(size-indication-mode t)
 '(tab-width 4)
 '(text-mode-hook (quote (text-mode-hook-identify)))
 '(tool-bar-mode nil)
 '(truncate-lines t)
 '(uniquify-buffer-name-style (quote forward) nil (uniquify))
 '(version-control never)
 '(w3m-pop-up-windows t)
 '(x-select-enable-clipboard t))
;; ================= Faces ====================
(defface play-mode-tag-face
  '((((class color) (min-colors 88) (background light)) :foreground "blue3"))
  "Face highlighting a tag in a play! framework template"
  :group 'font-lock-faces)

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:stipple nil :background "#000000" :foreground "#ffffff" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 90 :width normal :foundry "xos4" :family "Terminus"))))
 '(cursor ((t (:background "brown"))))
 '(develock-long-line-2 ((t (:background "#feff97" :foreground "Red"))))
 '(develock-whitespace-1 ((t (:background "#ffffaa00aa00"))))
 '(develock-whitespace-2 ((t (:background "#ffda97"))))
 '(develock-whitespace-3 ((t (:background "#feff97"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88)) (:foreground "firebrick"))))
 '(font-lock-comment-face ((t (:foreground "#54ab80" :slant italic))))
 '(font-lock-constant-face ((((class color) (min-colors 88)) (:foreground "saddle brown" :weight bold))))
 '(font-lock-keyword-face ((t (:foreground "#742828" :weight bold))))
 '(font-lock-negation-char-face ((t (:weight bold))))
 '(font-lock-string-face ((nil (:foreground "#bada55"))))
 '(font-lock-type-face ((((class color) (background light dark)) (:foreground "#742828" :weight semi-light))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light dark)) (:foreground "red3"))))
 '(jde-java-font-lock-doc-tag-face ((((class color)) (:foreground "green4" :weight bold))))
 '(jde-java-font-lock-modifier-face ((((class color)) (:foreground "Orchid4" :weight bold))))
 '(jde-java-font-lock-number-face ((((class color)) (:foreground "RosyBrown4"))))
 '(semantic-decoration-on-unparsed-includes ((t (:background "#333300"))))
 '(semantic-highlight-func-current-tag-face ((t (:background "gray15")))))


(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)

;;(set-frame-parameter (selected-frame) 'alpha '(<active> [<inactive>]))
(set-frame-parameter (selected-frame) 'alpha '(85 75))
(add-to-list 'default-frame-alist '(alpha 85 75))
