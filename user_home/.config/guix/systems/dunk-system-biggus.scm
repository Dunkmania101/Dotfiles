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


;(load "./dunk-system-common-nvidia-GTX_1650.scm")
;(load "./dunk-system-common-nvidia.scm")
(load "./system-mutations.scm")
(load "./dunk-system-common.scm")

(define-public dunk-system-biggus
  (operating-system
   (inherit (nvidiaify-system-gtx1650 (get-dunk-system-common (nvidiaify-xorg-conf (xorg-configuration)) "xrandr --setprovideroffloadsink 1 0")))
   ;(inherit dunk-system-common-nvidia-GTX_1650)
   ;(inherit dunk-system-common-nvidia)
   (host-name "bigguscomputicus")))

