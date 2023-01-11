(use-modules
  (guix utils)
  (guix profiles)
  (guix packages)
  (gnu packages))



(define-public dunk-manifest-base
	       (packages->manifest
		 (list (specification->package "vim")
		       (specification->package "neovim")
		       (specification->package "wget")
		       (specification->package "curl")
		       (specification->package "git")
		       (specification->package "binutils")
		       (specification->package "rsync")
		       (specification->package "ncurses")
		       (specification->package "btop"))))

dunk-manifest-base
