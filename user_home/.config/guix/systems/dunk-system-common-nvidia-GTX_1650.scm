(use-modules
 (gnu)
 (gnu system nss)
 (guix utils)
 (guix packages)
 ((guix licenses) #:prefix license:)
 (guix git-download)
 (guix download)
 (guix build-system copy)
 (guix build-system python)
 (nongnu packages linux)
 (nongnu system linux-initrd))
(use-package-modules
 gtk
 xorg
 gcc
 shells
 search
 mtools
 gnome
 gnome-xyz
 wm)
(use-service-modules
 linux
 mcron
 cups
 desktop
 networking
 file-sharing
 ssh
 xorg
 pm
 virtualization
 nix)


(load "./system-mutations.scm")
(load "./dunk-system-common.scm")

(define %xorg-config
  "Section \"Device\"
      Identifier     \"Device0\"
      Driver         \"nvidia\"
      VendorName     \"NVIDIA Corporation\"
      BoardName      \"GeForce GTX 1650\"
  EndSection")

(define-public dunk-system-common-nvidia-GTX_1650
  (operating-system
   (inherit (nvidiaify-system dunk-system-common))
   (services
	   (modify-services (operating-system-user-services dunk-system-common-nvidia)
			    (set-xorg-configuration config =>
						    (set-xorg-configuration
	        				        (xorg-configuration
					        	  (inherit config)
							  (extra-config (list %xorg-config)))))))))

