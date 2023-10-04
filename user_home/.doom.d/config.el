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
;(setq doom-theme 'doom-one)
;(setq doom-theme 'doom-snazzy)
(setq doom-theme 'doom-gruvbox)
;(setq doom-theme 'gruvbox-dark-medium)

(setq superdrive-directory (concat (getenv "HOME") "/superdrive-ln"))

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory (concat superdrive-directory "/.private/Notes/org")
      org-roam-directory org-directory)
(setq projectile-project-search-path (list (concat superdrive-directory "/Programming/")))

(setq org-startup-indented t
       org-pretty-entities t
       org-hide-emphasis-markers t
       org-startup-with-inline-images t
       org-image-actual-width '(300))

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
;(setq display-line-numbers-type 'relative)
(setq display-line-numbers-type 'visual)

(after!
  (setq minimap-recreate-window t
        minimap-automatically-delete-window nil)
  (minimap-mode))

(after! centaur-tabs
  (setq centaur-tabs-set-bar 'over
        centaur-tabs-height 30))
;(defun tdr/fix-centaur-tabs ()
;(centaur-tabs-mode -1)
;(centaur-tabs-mode)
;(centaur-tabs-headline-match)
;
;)
;(if (daemonp)
;(add-hook 'after-make-frame-functions
;(lambda (frame)
;(with-selected-frame frame
;(tdr/fix-centaur-tabs)))
;(tdr/fix-centaur-tabs))
;)

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

(after! elfeed-tube
  (elfeed-tube-setup)
  (elfeed-tube-mpv-follow-mode 1))
(after! mpv
  (setq mpv-default-options (append mpv-default-options '("--script=/home/dunk/.guix-profile/lib/mpris.so" "--no-keepaspect-window"))))

(setf ement-save-sessions t)
(map! :leader
      (:prefix ("1" . "Communication")
       :desc "Connect To Matrix Session For Ement" "c" #'ement-connect
       :desc "List Ement Rooms" "e" #'ement-list-rooms)
      (:prefix ("2" . "Media")
        (:prefix ("t" . "Elfeed-tube")
         :desc "Connect Elfeed-tube to MPV" "m" #'elfeed-tube-mpv
         :desc "Follow/Unfollow Elfeed-tube with MPV" "f" #'elfeed-tube-mpv-follow-mode
         :desc "Search with Elfeed-tube" "o" #'elfeed-tube-add-feeds
         :desc "Fetch with Elfeed-tube" "i" #'elfeed-tube-fetch)
        :desc "Play/Pause MPV" "m" #'mpv-pause))

(map! :leader
      (:prefix ("c")
       :desc "Comment line(s)" ";" #'comment-line)
      (:prefix ("TAB")
       :desc "Swap current workspace left" "j" #'+workspace/swap-left
       :desc "Swap current workspace right" "k" #'+workspace/swap-right))

(map! "M-&" #'with-editor-async-shell-command)

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

(setq
   lsp-java-jdt-download-url "https://download.eclipse.org/jdtls/snapshots/jdt-language-server-latest.tar.gz")


(defvar poweroff-cmd "poweroff"
  "Command to power the hardware system off.")
(defvar reboot-cmd "reboot"
  "Command to reboot the hardware system.")
(defvar monitors-off-cmd "sleep 0.5; xset dpms force standby"
  "Command to turn the hardware system's monitors off.")
(defvar lock-session-cmd "loginctl lock-session"
  "Command to lock the user session.")


(after! exwm
  (progn
    (require 'exwm-config)
    (require 'exwm-randr)
    (require 'exwm-systemtray)
    (setq display-time-default-load-average nil)
    (display-time-mode t)
    ;(ido-mode 1)
    ;(exwm-config-ido)
    (setq exwm-workspace-number 4)
    (add-hook 'exwm-update-class-hook
              (lambda ()
                (unless (or (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                            (string= "gimp" exwm-instance-name))
                  (exwm-workspace-rename-buffer exwm-class-name))))
    (add-hook 'exwm-update-title-hook
              (lambda ()
                (when (or (not exwm-instance-name)
                          (string-prefix-p "sun-awt-X11-" exwm-instance-name)
                          (string= "gimp" exwm-instance-name))
                  (exwm-workspace-rename-buffer exwm-title))))
    (setq exwm-input-global-keys
          `(
            ;; Bind "s-r" to exit char-mode and fullscreen mode.
            ([?\s-r] . exwm-reset)
            ;; Bind "s-r" to exit char-mode and fullscreen mode.
            ([?\s-R] . exwm-restart)
            ;; Bind "s-w" to switch workspace interactively.
            ([?\s-w] . exwm-workspace-switch)
            ;; Bind "s-0" to "s-9" to switch to a workspace by its index.
            ,@(mapcar (lambda (i)
                        `(,(kbd (format "s-%d" i)) .
                          (lambda ()
                            (interactive)
                            (exwm-workspace-switch-create ,i))))
                      (number-sequence 0 9))
            ;; Bind "s-&" to launch applications ('M-&' also works if the output
            ;; buffer does not bother you).
                                        ;([?\s-C- ] . (lambda (command)
                                        ;           (interactive (list (read-shell-command "$ ")))
                                        ;           (start-process-shell-command command nil command)))
                                        ;
            ([?\s-c] . exwm-input-toggle-keyboard)
            ;; Apps
            ([?\s- ] . (lambda (command)
                         (interactive (list (read-shell-command "$ ")))
                         (start-process-shell-command command nil command)))
                         ;(interactive)
                         ;(app-launcher-run-app)))
            ([?\s-e] . (lambda ()
                         (interactive)
                         (split-window)
                                        ;(start-process "" nil "/usr/bin/pcmanfm")))
                         (start-process-shell-command "" nil "nautilus")))
            ([s-return] . (lambda ()
                         (interactive)
                         (split-window)
                         (+vterm/here t)))
                         ;;(with-temp-buffer-window "vterm" nil nil
                         ;;  (progn
                         ;;    (split)
                         ;;    (+vterm/here t)))))
            ([?\s-b] . (lambda ()
                         (interactive)
                         (split-window)
                         ;;(start-process "" nil "/usr/bin/firefox-developer-edition")))
                         (start-process-shell-command "" nil "librewolf")))
            ;; Navigation
            ([?\s-h] . (lambda ()
                         (interactive)
                         (evil-window-left 1)))
            ([?\s-j] . (lambda ()
                         (interactive)
                         (evil-window-down 1)))
            ([?\s-k] . (lambda ()
                         (interactive)
                         (evil-window-up 1)))
            ([?\s-l] . (lambda ()
                         (interactive)
                         (evil-window-right 1)))
            ;; System
            ([?\s-q] . (lambda ()
                       (interactive)
                       (let ((options '(("Lock + Monitor Off" . (lambda () (start-process-shell-command "monitorsoff" nil monitors-off-cmd) (start-process-shell-command "lock" nil lock-session-cmd))) ("Lock" . (lambda () (start-process-shell-command "lock" nil lock-session-cmd))) ("Monitors Off" . (lambda () (start-process-shell-command "monitorsoff" nil monitors-off-cmd))) ("Reboot" . (lambda () (start-process-shell-command "reboot" nil reboot-cmd))) ("Poweoff" . (lambda () (start-process-shell-command "poweroff" nil poweroff-cmd))))))
                         (funcall (alist-get (completing-read "Power/Session Menu: " options) options (lambda () (print "Selection Aborted!")) nil 'equal)))))
            ([s-backspace] . (lambda ()
                        (interactive)
                        (start-process "" nil "loginctl" "lock-session")))))
    (define-key exwm-mode-map [?\C-q] #'exwm-input-send-next-key)
    (setq exwm-input-simulation-keys
          '(
            ;; movement
            ([?\C-b] . [left])
            ([?\M-b] . [C-left])
            ([?\C-f] . [right])
            ([?\M-f] . [C-right])
            ([?\C-p] . [up])
            ([?\C-n] . [down])
            ([?\C-a] . [home])
            ([?\C-e] . [end])
            ([?\M-v] . [prior])
            ([?\C-v] . [next])
            ([?\C-d] . [delete])
            ([?\C-k] . [S-end delete])
            ([?\C-g] . [C-d])
            ;; cut/paste.
            ([?\C-w] . [?\C-x])
            ([?\M-w] . [?\C-c])
            ([?\C-y] . [?\C-v])
            ;; search
            ([?\C-s] . [?\C-f])))
    ;;(setq exwm-randr-workspace-output-plist '(0 "DP-0" 1 "DVI-D-0"))
    ;;(setq exwm-randr-workspace-output-plist '(0 "eDP1"))
    ;;(setq exwm-randr-workspace-monitor-plist '(0 "HDMI1" 1 "eDP1"))
    (setq exwm-randr-workspace-monitor-plist '(0 "HDMI-1" 1 "eDP-1"))
    (add-hook 'exwm-randr-screen-change-hook
              (lambda ()
                (progn
                  (mapc (lambda (cmd)
                          (start-process-shell-command cmd nil cmd))
                        ;;"xrandr" nil "xrandr --output DVI-D-0 --left-of DP-0 --auto")))
                        ;;"xrandr" nil "xrandr --output eDP1 --auto")))
                        ;;"xrandr" nil "xrandr --output DP-0 --auto")))
                        '("xrandr --output HDMI1 --right-of eDP1  --primary --auto"))
                  ;(exwm-systemtray--refresh-all)
                  )))
    (add-hook 'exwm-init-hook
              (lambda ()
                (mapc (lambda (cmd) (start-process-shell-command cmd nil cmd))
                      '("xsetroot -cursor_name left_ptr"
                        "xset b off"
                        "xset r rate 280 40"
                        ;;"xset 1800"
                        "xss-lock -l -- i3lock --ignore-empty-password --color=2c2826 --bar-indicator --bar-color=3c3836 &"
                        "picom --config ~/.config/picom/picom.conf &"
                        ))))
    ;;(add-hook 'exwm-exit-hook
    ;;          (lambda ()))
    (exwm-systemtray-enable)
    (exwm-randr-enable)))

(load! ".private/private-config" doom-user-dir 1)

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
