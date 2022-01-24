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
    '("ddg" "https://duckduckgo.com?q=~a" "https://duckduckgo.com")))

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


(define-configuration buffer
  ((search-engines (append %slot-default%
                           (mapcar (lambda (engine) (apply 'make-search-engine engine))
                                   *my-search-engines*)))))

(define-configuration browser
    ((session-restore-prompt :never-restore)))

(define-configuration buffer
                      ((default-modes (append '(dark-mode vi-normal-mode reduce-tracking-mode blocker-mode) %slot-default%))))

(define-configuration prompt-buffer
    ((default-modes (append '(vi-insert-mode) %slot-default%))))

(define-configuration web-buffer
    ((default-new-buffer-url "about:blank")))

(setf (uiop:getenv "WEBKIT_DISABLE_COMPOSITING_MODE") "1")


;; ------------ ;;
;; - Profiles - ;;
;; ------------ ;;


;; Base Path Methods
(defmethod nyxt:expand-data-path ((profile data-profile) (path data-path))
  "Path for general data."
  (expand-default-path (make-instance (class-name (class-of path))
                                      :basename (basename path)
                                      :dirname (str:concat main-data-path (name profile) "/data/"))))

(defmethod nyxt:expand-data-path ((profile data-profile) (path history-data-path))
  "Path for history."
  (expand-default-path (make-instance (class-name (class-of path))
                                      :basename (basename path)
                                      :dirname (str:concat main-data-path (name profile) "/history/"))))

(defmethod nyxt:expand-data-path ((profile data-profile) (path bookmarks-data-path))
  "Path for bookmarks."
  (expand-default-path (make-instance (class-name (class-of path))
                                      :basename (basename path)
                                      :dirname (str:concat main-profiles-path (name profile) "/bookmarks/"))))

;; Profiles
;; Personal profile
(define-class personal-data-profile (data-profile)
   ((name :initform "personal"))
   (:documentation "Personal profile."))

;; Personal profile 2
(define-class personal2-data-profile (data-profile)
   ((name :initform "personal2"))
   (:documentation "Personal profile 2."))

;; Work profile
(define-class work-data-profile (data-profile)
   ((name :initform "work"))
   (:documentation "Work profile."))

;; Work profile 2
(define-class work2-data-profile (data-profile)
   ((name :initform "work2"))
   (:documentation "Work profile 2."))

;; Set default profile
(define-configuration buffer
 ((data-profile (make-instance (or (find-data-profile (getf *options* :data-profile))
                                   'personal-data-profile)))))


;; ---------- ;;
;; - Themes - ;;
;; ---------- ;;


; Dunk-Gruvbox-dark

;;configure status buffer area with only tabs and modes section
;(defun my-format-status (window)
;  (let ((buffer (current-buffer window)))
;    (markup:markup
;     (:div :id "container"
;           (:div :id "tabs"
;                 (markup:raw (format-status-tabs)))
;           (:div :id "modes"
;                 (markup:raw
;                  (format-status-load-status buffer)
;                  (format-status-modes buffer window)))))))

;(define-configuration window
;  ((status-formatter #'my-format-status)))

;configuration window
(define-configuration window
  ((message-buffer-style
    (str:concat
     %slot-default%
     (cl-css:css
      '((body
         :background-color "#2c2826"
         :color "d4be98")))))))

; buffer
(define-configuration buffer
  ((style
    (str:concat
     %slot-default%
     (cl-css:css
      '((title
         :color "d4be98")
        (body
         :background-color "2c2826"
         :color "d4be98")
        (hr
         :color "d4be98")
        (a
         :color "d4be98")
        (.button
         :color "d4be98"
         :background-color "2c2826")))))))

; internal buffer
(define-configuration internal-buffer
  ((style
    (str:concat
     %slot-default%
     (cl-css:css
      '((title
         :color "d4be98")
        (body
         :background-color "2c2826"
         :color "d4be98")
        (hr
         :color "d4be98")
        (a
         :color "d4be98")
        (.button
         :color "d4be98"
         :background-color "2c2826")))))))

;prompt buffer
(define-configuration prompt-buffer
  ((style (str:concat
           %slot-default%
           (cl-css:css
            '((body
               :background-color "#2c2826"
               :color "#d4be98")
              ("#prompt-area"
               :background-color "#1c1816")
              ("#input"
               :background-color "#2c2826"
               :color "#d4be98")
              (".source-name"
               :background-color "#1c1816"
               :color "d4be98")
              (".source-content"
               :background-color "2c2826")
              (".source-content th"
               :background-color "2c2826"
               :font-weight "bold")
              ("#selection"
               :background-color "#1c1816"
               :color "#d8a657"
              (.marked :background-color "1c1816"
                       :font-weight "bold"
                       :color "d8a657")
              (.selected :background-color "1c1816"
                         :color "d4be98"))))))))

;history tree
(define-configuration nyxt/history-tree-mode:history-tree-mode
  ((nyxt/history-tree-mode::style
    (str:concat
     %slot-default%
     (cl-css:css
      '((body
         :background-color "2c2826"
         :color "d4be98")
        (hr
         :color "d4be98")
        (a
         :color "d4be98")
        ("ul li::before"
         :background-color "d4be98")
        ("ul li::after"
         :background-color "d4be98")
        ("ul li:only-child::before"
         :background-color "d4be98")))))))

;highlight boxes
(define-configuration nyxt/web-mode:web-mode
  ((nyxt/web-mode:highlighted-box-style
    (cl-css:css
     '((".nyxt-hint.nyxt-highlight-hint"
        :background "#d8a657")))
    :documentation "The style of highlighted boxes, e.g. link hints.")))

;status buffer
(define-configuration status-buffer
  ((style (str:concat
           %slot-default%
           (cl-css:css
            '(("#container"
                :grid-template-columns "90% 10%")
              ("#modes"
               :background-color "2c2826"
               :border-top "1px solid d4be98")
              (".button:hover" :color "d4be98")
              ("#tabs"
               :background-color "#1c1816"
               :color "d4be98"
               :border-top "1px solid d4be98")
              (".tab:hover" :color "d8a657")))))))
