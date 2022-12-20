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


(load "./dunk-system-common-nvidia-GTX_1650.scm")

(define-public dunk-system-biggusporteus
  (operating-system
   (inherit dunk-system-common-nvidia-GTX_1650)
   (host-name "biggusporteuscomputicus")))

