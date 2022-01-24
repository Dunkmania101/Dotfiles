;; -*- no-byte-compile: t; -*-
;;; $DOOMDIR/packages.el

;; To install a package with Doom you must declare them here and run 'doom sync'
;; on the command line, then restart Emacs for the changes to take effect -- or
;; use 'M-x doom/reload'.


;; To install SOME-PACKAGE from MELPA, ELPA or emacsmirror:
;(package! some-package)

;; To install a package directly from a remote git repo, you must specify a
;; `:recipe'. You'll find documentation on what `:recipe' accepts here:
;; https://github.com/raxod502/straight.el#the-recipe-format
;(package! another-package
;  :recipe (:host github :repo "username/repo"))

;; If the package you are trying to install does not contain a PACKAGENAME.el
;; file, or is located in a subdirectory of the repo, you'll need to specify
;; `:files' in the `:recipe':
;(package! this-package
;  :recipe (:host github :repo "username/repo"
;           :files ("some-file.el" "src/lisp/*.el")))

;(package! webkit
;  :recipe (:host github :repo "akirakyle/emacs-webkit"
;           :files (:defaults "*.js" "*.css" "*.so")
;           :pre-build ("make")))
(defun webkit--display-progress (progress)
  (setq webkit--progress-formatted
        (if (equal progress 100.0)
            ""
          (format "%s%.0f%%  " (all-the-icons-faicon "spinner") progress)))
  (force-mode-line-update))
(setq webkit-download-action-alist '(("\\.pdf\\'" . webkit-download-open)
                                     ("\\.png\\'" . webkit-download-save)
                                     (".*" . webkit-download-default)))
(setq webkit-search-prefix "https://duckduckgo.com/search?q=")
(setq webkit-history-file "~/.private/web/history/emacs-webkit")
(setq webkit-cookie-file "~/.private/web/cookies/emacs-webkit")
(setq browse-url-browser-function 'webkit-browse-url)
(setq webkit-browse-url-force-new t)
(setq webkit-dark-mode t)
(package! evil-collection-webkit
          :recipe (:host github :repo "akirakyle/emacs-webkit"
          :files ("evil-collection-webkit.el")))

(package! plz
 :recipe (:host github :repo "alphapapa/plz.el"))
(package! ement
 :recipe (:host github :repo "alphapapa/ement.el"))

(package! gruvbox-theme)

(package! crux)

(package! ytdious)

(package! screenshot)

(package! guix)

;(package! eaf
;  :recipe (:host github :repo "emacs-eaf/emacs-application-framework"
;                 :files (:defaults "*.js" "*.css" "*.so" "*.py" ".json" "core" "extension" "app")
;                 :pre-build ("python" "install-eaf.py" "--install-all-apps" "--ignore-sys-deps" "--ignore-py-deps")))
(after! eaf (
(require 'eaf-airshare)
(require 'eaf-browser)
(require 'eaf-camera)
(require 'eaf-demo)
(require 'eaf-file-browser)
(require 'eaf-file-manager)
(require 'eaf-file-sender)
(require 'eaf-image-viewer)
(require 'eaf-jupyter)
(require 'eaf-markdown-previewer)
(require 'eaf-mermaid)
(require 'eaf-mindmap)
(require 'eaf-music-player)
(require 'eaf-org-previewer)
(require 'eaf-pdf-viewer)
(require 'eaf-system-monitor)
(require 'eaf-terminal)
(require 'eaf-video-player)
(require 'eaf-vue-demo)
(require 'eaf-netease-cloud-music)
(require 'eaf-rss-reader)))

(unpin! lsp-java)
(unpin! treemacs)
;(unpin! t)

;; If you'd like to disable a package included with Doom, you can do so here
;; with the `:disable' property:
;(package! builtin-package :disable t)

;; You can override the recipe of a built in package without having to specify
;; all the properties for `:recipe'. These will inherit the rest of its recipe
;; from Doom or MELPA/ELPA/Emacsmirror:
;(package! builtin-package :recipe (:nonrecursive t))
;(package! builtin-package-2 :recipe (:repo "myfork/package"))

;; Specify a `:branch' to install a package from a particular branch or tag.
;; This is required for some packages whose default branch isn't 'master' (which
;; our package manager can't deal with; see raxod502/straight.el#279)
;(package! builtin-package :recipe (:branch "develop"))

;; Use `:pin' to specify a particular commit to install.
;(package! builtin-package :pin "1a2b3c4d5e")


;; Doom's packages are pinned to a specific commit and updated from release to
;; release. The `unpin!' macro allows you to unpin single packages...
;(unpin! pinned-package)
;; ...or multiple packages
;(unpin! pinned-package another-pinned-package)
;; ...Or *all* packages (NOT RECOMMENDED; will likely break things)
;(unpin! t)
