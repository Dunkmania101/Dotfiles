;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


(setenv "PATH" (concat (getenv "PATH") ":" (getenv "HOME") "/.fnm/aliases/default/bin"))


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Dunkmania101"
      user-mail-address "50186904+Dunkmania101@users.noreply.github.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;;(setq doom-theme 'doom-one)
;;(setq doom-theme 'doom-snazzy)
(setq doom-theme 'doom-gruvbox)
;;(setq doom-theme 'gruvbox-dark-medium)

(setq superdrive-directory (concat (getenv "HOME") "/superdrive-ln"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory (concat superdrive-directory "/.private/Notes/org")
      org-roam-directory org-directory)

(setq projectile-project-search-path (list (concat superdrive-directory "/Programming/")))

;(after! org
;  (setq org-priority-faces '((65 :foreground "#cd0000")
;                             (66 :foreground "#ff8c00")
;                             (67 :foreground "#006400")))
;  (map! :map org-mode-map
;        :n "M-j" #'org-metadown
;        :n "M-k" #'org-metaup))

(setq deft-directory (concat superdrive-directory "/.private/Notes")
      deft-extensions '("org" "md" "txt")
      deft-recursive t)


;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

(setq minimap-recreate-window t
      minimap-automatically-delete-window nil)
(minimap-mode)

(setq evil-split-window-below t
      evil-vsplit-window-right t)

(after! doom-themes
  (setq doom-themes-enable-bold t
        doom-themes-enable-italic t))

(setq treemacs-width-is-initially-locked nil
      treemacs-width 50)

(add-to-list 'default-frame-alist '(inhibit-double-buffering . t))

(setq doom-font (font-spec :family "Iosevka" :size 12 :weight 'regular)
      doom-variable-pitch-font (font-spec :family "Iosevka" :size 13))

(custom-set-faces!
  '(font-lock-comment-face :slant italic)
  '(font-lock-keyword-face :slant italic))

(after! evil-collection-webkit
  (evil-collection-xwidget-setup))

(after! empv
  (setq empv-invidious-instance "https://vid.puffyan.us/api/v1")
  (mapc (lambda (a) (add-to-list 'empv-mpv-args a)) '("--ytdl-format=best" "--force-window" "--no-keepaspect-window" "--loop"))
  (mapc (lambda (a) (delete a empv-mpv-args)) '("--no-video")))

(setf ement-save-sessions t)
(map! :leader
      (:prefix ("1" . "General Keys")
       :desc "Connect To Matrix Session For Ement" "c" #'ement-connect
       :desc "List Ement Rooms" "e" #'ement-list-rooms))

(map! :leader
      (:prefix ("c")
       :desc "Comment line(s)" ";" #'comment-line))

;(after! eaf
;  ((require 'eaf-evil)
;
;   (define-key key-translation-map (kbd "SPC")
;    (lambda (prompt)
;      (if (derived-mode-p 'eaf-mode)
;          (pcase eaf--buffer-app-name
;            ("browser" (if  (string= (eaf-call-sync "call_function" eaf--buffer-id "is_focus") "True")
;                           (kbd "SPC")
;                         (kbd eaf-evil-leader-key)))
;            ("pdf-viewer" (kbd eaf-evil-leader-key))
;            ("image-viewer" (kbd eaf-evil-leader-key))
;            (_  (kbd "SPC")))
;        (kbd "SPC"))))))

(setq company-idle-delay nil)
(setq +lsp-prompt-to-install-server 'quiet
      lsp-enable-file-watchers nil)

(setq org-journal-file-format "%Y-%m-%d.org")

;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.
