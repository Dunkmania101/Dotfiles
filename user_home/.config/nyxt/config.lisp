(in-package #:nyxt-user)


;; ------------------------------ ;;
;; - Dunkmania101's Nyxt Config - ;;
;; ------------------------------ ;;


;; -------- ;;
;; - Vars - ;;
;; -------- ;;


; Paths
(defvar main-data-path "~/.private/data/web/nyxt/profiles/")
(defvar main-profiles-path "~/.private/copy/web/nyxt/profiles/")

; Search Engines
(defvar *my-search-engines*
  (list
    '("qw" "https://www.qwant.com?theme=1&hc=0&vt=1&s=0&b=0&q=~a" "https://www.qwant.com?theme=1&hc=0&vt=1&s=0&b=0")
    '("cfm" "https://www.curseforge.com/minecraft/mc-mods/search?search=~a")
    '("ddg" "https://duckduckgo.com/?q=~a" "https://duckduckgo.com")
    '("gh" "https://github.com/search?q=~a" "https://github.com")
    '("srx" "http://localhost:8888/search?q=~a" "http://localhost:8888/")))

(define-configuration context-buffer
  Go through the search engines above and make-search-engine out of them.
  ((search-engines
    (append
     (mapcar (lambda (engine) (apply 'make-search-engine engine))
             *my-search-engines*)
     %slot-default%))))


;; Color Codes
;(defmethod main-bg-color () (str "#212121"))
;(defmethod main-fg-color () (str "#232321"))


;; ------------ ;;
;; - Commands - ;;
;; ------------ ;;


;;Show current time
(define-command-global current-time ()
  "Show the current time."
  (echo "~a" (local-time:now)))

;;Show the weather
(define-command-global show-weather ()
  "Show the weather for current location in message area."
  (echo (uiop:run-program "curl wttr.in/?format=3" :output :string)))


;; ------------ ;;
;; - Defaults - ;;
;; ------------ ;;

(defmethod customize-instance ((browser browser) &key)
  (setf (slot-value browser 'theme) theme:+dark-theme+))
(defmethod customize-instance ((input-buffer input-buffer) &key)
  (disable-modes* 'nyxt/mode/emacs:emacs-mode input-buffer)
  (enable-modes* 'nyxt/mode/vi:vi-normal-mode input-buffer)
  (disable-modes* 'nyxt/mode/emacs:emacs-mode input-buffer)
  (enable-modes* 'nyxt/mode/vi:vi-normal-mode input-buffer))
(setf (uiop/os:getenv "WEBKIT_DISABLE_COMPOSITING_MODE") "1")
(define-configuration browser
  ((restore-session-on-startup-p nil)))
;(define-configuration browser
;  ((default-new-buffer-url
;    (quri.uri:uri "about:blank"))))

;(define-configuration password:keepassxc-interface
;                      ((password:password-file (str:concat main-data-path "kpxc-ln.kdbx"))))


(define-configuration buffer
  ((search-engines (append %slot-default%
                           (mapcar (lambda (engine) (apply 'make-search-engine engine))
                                   *my-search-engines*)))))


(define-configuration buffer
                      (;(password-interface (make-instance 'password:user-keepassxc-interface))
                       (default-modes (append '(vi-normal-mode reduce-tracking-mode dark-mode blocker-mode) %slot-default%))))

(define-configuration prompt-buffer
    ((default-modes (append '(vi-insert-mode) %slot-default%))))

;(define-configuration web-buffer
;    ((default-new-buffer-url "about:blank")))

;(setf (uiop:getenv "WEBKIT_DISABLE_COMPOSITING_MODE") "1")



;; --------- ;;
;; - Modes - ;;
;; --------- ;;



;; --------- ;;
;; - Keybinds - ;;
;; --------- ;;


(define-configuration base-mode
  ((keyscheme-map
    (define-keyscheme-map "my-base" (list :import %slot-value%)
                          nyxt/keyscheme:vi-normal
                          (list
                            "J" 'switch-buffer-next
                            "K" 'switch-buffer-previous)))))



;; ------------ ;;
;; - Profiles - ;;
;; ------------ ;;


;; Base Path Methods
;(defmethod nyxt:expand-data-path ((profile data-profile) (path data-path))
;  "Path for general data."
;  (expand-default-path (make-instance (class-name (class-of path))
;                                      :basename (basename path)
;                                      :dirname (str:concat main-data-path (name profile) "/data/"))))
;
;(defmethod nyxt:expand-data-path ((profile data-profile) (path history-data-path))
;  "Path for history."
;  (expand-default-path (make-instance (class-name (class-of path))
;                                      :basename (basename path)
;                                      :dirname (str:concat main-data-path (name profile) "/history/"))))
;
;(defmethod nyxt:expand-data-path ((profile data-profile) (path bookmarks-data-path))
;  "Path for bookmarks."
;  (expand-default-path (make-instance (class-name (class-of path))
;                                      :basename (basename path)
;                                      :dirname (str:concat main-profiles-path (name profile) "/bookmarks/"))))
;
;;; Profiles
;;; Personal profile
;(define-class personal-data-profile (data-profile)
;   ((name :initform "personal"))
;   (:documentation "Personal profile."))
;
;;; Personal profile 2
;(define-class personal2-data-profile (data-profile)
;   ((name :initform "personal2"))
;   (:documentation "Personal profile 2."))
;
;;; Work profile
;(define-class work-data-profile (data-profile)
;   ((name :initform "work"))
;   (:documentation "Work profile."))
;
;;; Work profile 2
;(define-class work2-data-profile (data-profile)
;   ((name :initform "work2"))
;   (:documentation "Work profile 2."))
;
;;; Set default profile
;(define-configuration buffer
; ((data-profile (make-instance (or (find-data-profile (getf *options* :data-profile))
;                                   'personal-data-profile)))))


;; ---------- ;;
;; - Themes - ;;
;; ---------- ;;


; Dunk-Gruvbox-dark

