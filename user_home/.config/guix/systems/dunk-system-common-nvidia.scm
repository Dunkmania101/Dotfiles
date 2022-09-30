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
 (nvidiachannel nvidia)
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

(load "../gtransform.scm")
(load "./dunk-system-common.scm")

;(define nversion "510.54")
;(define nsha (base32 "0qai6dsmd1b0iqgdq6l3vzd4y0pr0siqjs8fznnlgqrzmv6dw82c"))
(define nversion "495.46")
(define nsha (base32 "1xb23kimlfsailpwy7kv4l217id5jpmdc4svm9kldid0gp8pffyq"))

(define-public dunk-system-common-nvidia
  (operating-system
   (inherit dunk-system-common)
   (kernel-loadable-modules (fixpkgs (list (gen-nvidia-module nversion nsha))))
   (kernel-arguments (list
                      "nvidia-drm.modeset=1"
                      "modprobe.blacklist=nouveau,nvidia_uvm"))
   (packages
     (fixpkgs
        (append
          (list (gen-nvidia-libs-minimal nversion nsha)
                (specification->package "nvidia-settings"))
          (packages dunk-system-common))))
   (services (append
              (list
               (simple-service
                'my-nvidia-udev-rules udev-service-type
                (list (fixpkg nvidia-udev)))
               (service kernel-module-loader-service-type
                        '("nvidia"
                          "nvidia_modeset"
                          "ipmi_devintf"
                          ))
               (set-xorg-configuration
                (xorg-configuration
                 (keyboard-layout keyboard-layout)
                 (server (fixpkg xorg-server))
                 (drivers '("nvidia"))
                 (modules
                  (cons*
                   (fixpkg (gen-nvidia-libs-minimal nversion nsha))
                   %default-xorg-modules))
                 (extra-config
                  (list %xorg-libinput-config)))))
              (services dunk-system-common)))))

