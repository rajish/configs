
(add-to-list 'load-path
     (expand-file-name "~/.emacs.d/plugins")
     "/usr/lib/xemacs/site-lisp")


;; ================ Window size ==========================
(defun set-frame-size-according-to-resolution ()
  (interactive)
  (if window-system
      (progn
        ;; use 120 char wide window for largeish displays
        ;; and smaller 80 column windows for smaller displays
        ;; pick whatever numbers make sense for you
        (if (> (x-display-pixel-width) 1280)
            (add-to-list 'default-frame-alist (cons 'width 120))
          (add-to-list 'default-frame-alist (cons 'width 80)))
        ;; for the height, subtract a couple hundred pixels
        ;; from the screen height (for panels, menubars and
        ;; whatnot), then divide by the height of a char to
        ;; get the height we want
        (add-to-list 'default-frame-alist
                     (cons 'height (/ (- (x-display-pixel-height) 200) (frame-char-height)))))))

(set-frame-size-according-to-resolution)

;; =========== INFO =================
(require 'info)
(setq Info-directory-list
      (cons (expand-file-name "/usr/share/info/emacs-23")
            Info-directory-list))


;; Filladapt
(require 'filladapt)
(setq-default filladapt-mode t)

;; Session
(require 'session)
(add-hook 'after-init-hook 'session-initialize)

;; yasnippet
(require 'yasnippet-bundle)

;;(require 'newcomment)
(require 'ibuffer) ;"/usr/share/emacs/site-lisp/ibuffer/ibuffer.elc")
(define-key global-map "\C-x\C-b" 'ibuffer)
(define-key global-map "\M-;" 'comment-dwim)
(define-key global-map "\C-T" 'transpose-lines)
;;(define-key global-map "\M-/" 'hippie-expand)

; ============= cc-mode ===============
(add-hook 'c-mode-common-hook (lambda ()
                                (c-toggle-auto-hungry-state t)
                                (c-subword-mode t)))
(define-key global-map "\C-c\C-t" 'c-toggle-auto-hungry-state)

;============ DOXY(GEN)MACS ==============
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/doxymacs/lisp"))
(require 'doxymacs)
(add-hook 'c-mode-common-hook 'doxymacs-mode)
;; (add-hook 'c-mode-common-hook 'hs-minor-mode)
(add-hook 'c-mode-common-hook (lambda () (font-lock-mode t)))

(defun my-doxymacs-font-lock-hook ()
   (if (or (eq major-mode 'c-mode) (eq major-mode 'c++-mode))
       (doxymacs-font-lock)))
(add-hook 'font-lock-mode-hook 'my-doxymacs-font-lock-hook)
(require 'tempo)
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
                                                   "/*!" '> 'n
                                                   " * \\brief " 'p '> 'n
                                                   " * " '> 'n
                                                   (doxymacs-parm-tempo-element (cdr (assoc 'args next-func)))
                                                   (unless (string-match
                                                            (regexp-quote (cdr (assoc 'return next-func)))
                                                            doxymacs-void-types)
                                                     '(l " * " > n " * "
                                                         "\\return " (p "Returns: ") > n))
                                                   " *" '> 'n
                                                   " * \\author " (user-login-name) '> 'n
                                                   " * \\date " (format-time-string "%d-%m-%Y") '> 'n
                                                   " */" '> 'n)
                                                (progn
                                                  (error "Can't find next function declaration.")
                                                  nil))))
                       "function-comment"
                       "Insert function description comment")

; ============ DOS2UNIX line ends ===========
(defun dos2unix (buffer)
      "Automate M-% C-q C-m RET C-q C-j RET"
      (interactive "*b")
      (save-excursion
        (goto-char (point-min))
        (while (search-forward (string ?\C-m) nil t)
          (replace-match (string ) nil t))))

; ============= Version control ================
;;(require 'pcl-cvs)
(require 'psvn)
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/magit"))
(require 'magit)
(require 'magit-svn)

; ==============  modes hooking to file extensions =========
;;(remove-alist 'auto-mode-alist "\\.[ch]\\'")
(setq auto-mode-alist
      (append  '(("\\.tcf\\'" . c-mode)
                 ("\\.[ch]\\'" . c-mode)
                 ("\\.inc\\'" . c-mode)
                 ("Makefile\\.*". makefile-mode)
                 ("\\.mkf\\'" . makefile-mode))
               auto-mode-alist))


; ================== CODE STYLES ==================
;;;;;; Vertel (3-space indents)
(let* ((offsets
        '((c-basic-offset             . 3)
          (c-comment-only-line-offset . (0 . 0))
          (c-offsets-alist            . ((statement-block-intro . +)
                                         (statement-cont       . 0)
                                         (statement-case-intro . 0)
                                         (statement-case-intro . 3)
                                         (statement-case-open  . 3)
                                         (access-label         . -)
                                         (label                . +)
                                         (case-label           . +)
                                         (substatement         . +)
                                         (inclass              . ++)
                                         (substatement-open    . 0)
                                         (topmost-intro        . 0)
                                         (topmost-intro-cont   . +)
                                         (brace-list-open      . +)
                                         (brace-list-entry     . 0)
                                         )))))
  (c-add-style "vertel" offsets nil))

;;;;; HTQ (2-space indents)
(let* ((offsets
        '((c-basic-offset             . 2)
          (c-comment-only-line-offset . (0 . 0))
          (c-offsets-alist            . ((statement-block-intro . +)
                                         (statement-cont       . 0)
                                         (statement-case-intro . 0)
                                         (statement-case-intro . 2)
                                         (statement-case-open  . 2)
                                         (access-label         . -)
                                         (label                . +)
                                         (case-label           . +)
                                         (substatement         . +)
                                         (inclass              . ++)
                                         (substatement-open    . 0)
                                         (topmost-intro        . 0)
                                         (topmost-intro-cont   . +)
                                         (brace-list-open      . +)
                                         (brace-list-entry     . 0)
                                         )))))
  (c-add-style "htq" offsets nil))


;=========== ANSI color =============
(require 'ansi-color)

(add-hook 'compilation-mode-hook 'ansi-color-for-comint-mode-on)

; ============ desktop ============

;;(require 'desktop)
;;(desktop-save-mode 1)
;;(desktop-load-default)
(desktop-read)

; ============ CEDET ============
;; Load CEDET.
;; See cedet/common/cedet.info for configuration details.
(load-file "~/.emacs.d/plugins/cedet-1.0/common/cedet.el")


;; Enable EDE (Project Management) features
(global-ede-mode 1)

;; Enable EDE for a pre-existing C++ project
;; (ede-cpp-root-project "NAME" :file "~/myproject/Makefile")


;; Enabling Semantic (code-parsing, smart completion) features
;; Select one of the following:

;; * This enables the database and idle reparse engines
(semantic-load-enable-minimum-features)

;; * This enables some tools useful for coding, such as summary mode
;;   imenu support, and the semantic navigator
(semantic-load-enable-code-helpers)

;; * This enables even more coding tools such as intellisense mode
;;   decoration mode, and stickyfunc mode (plus regular code helpers)
;; (semantic-load-enable-gaudy-code-helpers)

;; * This enables the use of Exuberent ctags if you have it installed.
;;   If you use C++ templates or boost, you should NOT enable it.
;; (semantic-load-enable-all-exuberent-ctags-support)
;;   Or, use one of these two types of support.
;;   Add support for new languges only via ctags.
;; (semantic-load-enable-primary-exuberent-ctags-support)
;;   Add support for using ctags as a backup parser.
;; (semantic-load-enable-secondary-exuberent-ctags-support)

;; Enable SRecode (Template management) minor-mode.
(global-srecode-minor-mode 1)


;; ============== CSCOPE ==================
;; (require 'xcscope)
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
)

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

(read-abbrev-file "~/.emacs.d/abbrevs")

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
  (eval-when (WHEN load) '(ad-activate 'compile)))

;=========== docbook =============
(add-hook 'docbook-mode-hook 'turn-on-font-lock)

;=========== JDE ==============
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/jdee/dist/jdee-2.4.1/lisp"))
(require 'jde)

(require 'compile)

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

(load-file (expand-file-name "~/.emacs.d/plugins/jde-int/jde-int.el"))

;========= Emacs customized layout ===============================

;; (setq special-display-function 'my-display-buffer)
;; (setq special-display-regexps '(".*"))

;; (defun display-special-buffer (buf)
;;   "put the special buffers in the right spot (bottom rigt)"
;;   (let ((target-window (window-at (- (frame-width) 4) (- (frame-height) 4)))
;;         (pop-up-windows t))
;;     (set-window-buffer target-window buf)
;;     target-window))

;; (defun my-display-buffer (buf)
;;   "put all buffers in a window other than the one in the bottom right"
;;   (message (buffer-name  buf))
;;   (if (member (buffer-name buf) special-display-buffer-names)
;;       (display-special-buffer buf)
;;     (progn
;;       (let ((pop-up-windows t)
;;             (windows (delete (window-at (- (frame-width) 4) (- (frame-height) 4))
;;                              (delete (minibuffer-window) (window-list)))))
;;         (message (buffer-name (window-buffer (car windows))))
;;         (set-window-buffer (car (cdr windows)) buf)
;;         (car (cdr windows))))))

;;================= emacs-wiki ===================================
;;(require 'emacs-wik
(autoload 'wikipedia-mode "wikipedia-mode.el" "Major mode for editing documents in Wikipedia markup." t)
(add-to-list 'auto-mode-alist
             '("\\.wiki\\'" . wikipedia-mode))
(add-to-list 'auto-mode-alist
             '("itsalltext.*\\.txt$" . wikipedia-mode))

;;(require 'wikipediafs)
;;================= emacs server =================================
(server-start)
;;===================== w3m ======================================
(setq browse-url-browser-function 'w3m-browse-url)
(autoload 'w3m-browse-url "w3m" "Ask a WWW browser to show a URL." t)
 ;; optional keyboard short-cut
(global-set-key "\C-xm" 'browse-url-at-point)

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

(autoload 'po-mode "po-mode+"
  "Major mode for translators to edit PO files" t)

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
                                  (po-wrap)))

;;(require 'frame-cmds)
(setq my-hostname
      (replace-regexp-in-string "\\(^[[:space:]\n]*\\|[[:space:]\n]*$\\)" "" ;; like perl chomp()
                                (with-output-to-string
                                  (call-process "/bin/hostname" nil standard-output nil))))
(setq my-username (getenv "USERNAME"))
(setq frame-title-format '("%f - " my-username "@" my-hostname))

;;===================== ethan-wspace =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/ethan-wspace/lisp"))
(require 'ethan-wspace)
(global-ethan-wspace-mode 1)
;;(add-hook 'before-save-hook 'delete-trailing-whitespace)
(add-hook 'c-mode-common-hook
          (lambda()
            (add-hook 'before-save-hook
                      'delete-trailing-whitespace nil t)))
(add-hook 'html-mode-hook
          (lambda()
            (setq sgml-basic-offset 4)
            (setq indent-tabs-mode t)))
;;===================== auto-complete =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/auto-complete/bin"))
(require 'auto-complete-config)
(add-to-list 'ac-dictionary-directories "~/.emacs.d/plugins/auto-complete/bin/ac-dict")
(ac-config-default)
;;===================== js2-mode =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/js2-mode"))
(autoload 'js2-mode "js2-mode" nil t)
(add-to-list 'auto-mode-alist '("\\.js$" . js2-mode))
;;===================== multi-web-mode =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/multi-web-mode"))
(require 'multi-web-mode)
(setq mweb-default-major-mode 'html-mode)
(setq mweb-tags '((php-mode "<\\?php\\|<\\? \\|<\\?=" "\\?>")
                  (js2-mode "<script +\\(type=\"text/javascript\"\\|language=\"javascript\"\\)[^>]*>" "</script>")
                  (css-mode "<style +type=\"text/css\"[^>]*>" "</style>")
                  (java-mode "${[^}]*" "}")
                  (java-mode "%{[^}]*" "}%")))
(setq mweb-filename-extensions '("php" "htm" "html" "ctp" "phtml" "php4" "php5"))
(multi-web-global-mode 1)
;;===================== develock =============================
(require 'develock)
(global-font-lock-mode 1)
(require 'scss-mode)

;;===================== yaml-mode =============================
(add-to-list 'load-path (expand-file-name "~/.emacs.d/plugins/yaml-mode"))
(require 'yaml-mode)
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))

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
 '(column-number-mode t)
 '(comment-column 80)
 '(comment-fill-column 180)
 '(compilation-scroll-output t)
 '(compilation-window-height 16)
 '(compile-command "make -j5 ")
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
 '(font-lock-verbose nil)
 '(hippie-expand-dabbrev-as-symbol nil)
 '(ibuffer-formats (quote ((mark modified read-only " " (name 46 -1) " " (size 6 -1 :right) " " (mode 16 16 :right) " " filename) (mark " " (name 46 -1) " " filename))))
 '(indent-tabs-mode nil)
 '(indicate-buffer-boundaries (quote ((t . right) (top . left))))
 '(indicate-empty-lines t)
 '(ispell-silently-savep t)
 '(jde-compile-option-classpath nil)
 '(jde-global-classpath (quote ("/usr/lib/jvm/java-6-sun-1.6.0.26/jre/lib" "~/bin/play/framework" "~/bin/play/framework/lib")))
 '(jde-help-docsets (quote (("JDK API" "/usr/share/doc/java-sdk-docs-1.6.0.10/html/api" nil))))
 '(jde-imenu-sort (quote asc))
 '(jde-jdk (quote ("1.6.0")))
 '(jde-jdk-registry (quote (("1.5.0" . "/opt/sun-jdk-1.5.0.15") ("1.4.2" . "/opt/sun-jdk-1.4.2.17") ("1.6.0" . "/opt/sun-jdk-1.6.0.16"))))
 '(js-expr-indent-offset 4)
 '(kill-whole-line t)
 '(longlines-show-hard-newlines t)
 '(longlines-wrap-follows-window-size t)
 '(nxml-auto-insert-xml-declaration-flag t)
 '(nxml-slash-auto-complete-flag t)
 '(pydb-many-windows t)
 '(safe-local-variable-values (quote ((c-style . whitesmith))))
 '(save-place t nil (saveplace))
 '(scroll-bar-mode (quote right))
 '(select-active-regions t)
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
 '(default ((t (:stipple nil :background "#ffffff" :foreground "#000000" :inverse-video nil :box nil :strike-through nil :overline nil :underline nil :slant normal :weight normal :height 100 :width normal :foundry "misc" :family "fixed"))))
 '(develock-long-line-2 ((t (:background "#feff97" :foreground "Red"))))
 '(develock-whitespace-1 ((t (:background "#ffffaa00aa00"))))
 '(develock-whitespace-2 ((t (:background "#ffda97"))))
 '(develock-whitespace-3 ((t (:background "#feff97"))))
 '(font-lock-builtin-face ((((class color) (min-colors 88) (background light)) (:foreground "#04027a"))))
 '(font-lock-comment-face ((t (:foreground "#54ab80" :slant italic))))
 '(font-lock-constant-face ((((class color) (min-colors 88) (background light)) (:weight ultra-bold))))
 '(font-lock-keyword-face ((t (:foreground "#742828" :weight bold))))
 '(font-lock-negation-char-face ((t (:weight bold))))
 '(font-lock-string-face ((((class color) (min-colors 88) (background light)) (:foreground "#02620d"))))
 '(font-lock-type-face ((((class color) (min-colors 88) (background light)) (:foreground "#742828" :weight semi-light))))
 '(font-lock-variable-name-face ((((class color) (min-colors 88) (background light)) (:foreground "red3"))))
 '(jde-java-font-lock-doc-tag-face ((((class color) (background light)) (:foreground "green4" :weight bold))))
 '(jde-java-font-lock-modifier-face ((((class color) (background light)) (:foreground "Orchid4" :weight bold))))
 '(jde-java-font-lock-number-face ((((class color) (background light)) (:foreground "RosyBrown4")))))


(put 'upcase-region 'disabled nil)

(put 'downcase-region 'disabled nil)
