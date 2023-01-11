(use-modules
  (guix utils)
  (guix profiles)
  (guix packages)
  (gnu packages))


(load "../pkgtransforms.scm")
(load "./dunk-manifest-base.scm")


(define-public rust-zellij
	       (package
		 (name "rust-zellij")
		 (version "0.34.4")
		 (source (origin
			   (method url-fetch)
			   (uri (crate-uri "zellij" version))
			   (file-name (string-append name "-" version ".tar.gz"))
			   (sha256
			     (base32
			       "1lcs2hjvppin340ss9x1499nhdx6j94sasiks5j9vs403163rflf"))))
		 (build-system cargo-build-system)
		 (arguments
		   `(#:cargo-inputs (("rust-anyhow" ,rust-anyhow-1)
				     ("rust-dialoguer" ,rust-dialoguer-0.10)
				     ("rust-log" ,rust-log-0.4)
				     ("rust-miette" ,rust-miette-3)
				     ("rust-names" ,rust-names-0.13)
				     ("rust-suggest" ,rust-suggest-0.4)
				     ("rust-thiserror" ,rust-thiserror-1)
				     ("rust-zellij-client" ,rust-zellij-client-0.34)
				     ("rust-zellij-server" ,rust-zellij-server-0.34)
				     ("rust-zellij-utils" ,rust-zellij-utils-0.34))
		     #:cargo-development-inputs (("rust-insta" ,rust-insta-1)
						 ("rust-rand" ,rust-rand-0.8)
						 ("rust-ssh2" ,rust-ssh2-0.9))))
		 (home-page "https://zellij.dev")
		 (synopsis "A terminal workspace with batteries included")
		 (description
		   "This package provides a terminal workspace with batteries included")
		 (license license:expat)))


(packages->manifest
  (topkgs
    (append (list
	      rust-zellij)
	    (topkgs
	      (append (list "nyxt"
			    "firefox"
			    "xterm"
			    "blender"
			    "nautilus"
			    "rofi"
			    "rofi-pass"
			    "password-store"
			    "keepassxc"
			    "ripgrep"
			    "exa"
			    "bat"
			    "fd"
			    "tmux"
			    "cool-retro-term")
		      (map manifest-entry-name
			   (manifest-entries dunk-manifest-base)))))))

dunk-manifest-main

