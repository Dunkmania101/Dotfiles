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
 (nongnu system linux-initrd)
 (nongnu packages nvidia))
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

(load "./dunk-system-common.scm")

(define-public dunk-system-common-nvidia
  (operating-system
   (inherit dunk-system-common)
   (kernel-loadable-modules nvidia-module)
   (kernel-arguments (list
                      "nvidia-drm.modeset=1"
                      "modprobe.blacklist=nouveau,nvidia_uvm"))
   (packages (append
       (list (specification->package "nvidia-libs")
             (specification->package "nvidia-exec")
             (specification->package "nvidia-settings"))
       (operating-system-packages dunk-system-common)))
   (services (append
              (list
               (simple-service
                'my-nvidia-udev-rules udev-service-type
                (list nvidia-udev))
               (service kernel-module-loader-service-type
                        '("nvidia"
                          "nvidia_modeset"
                          "ipmi_devintf"
                          ))
               (set-xorg-configuration
                (xorg-configuration
                 (keyboard-layout keyboard-layout)
                 (server xorg-server)
                 (drivers '("nvidia"))
                 (modules
                  (cons*
                    nvidia-libs
                   %default-xorg-modules))
                 (extra-config
                  (list %xorg-libinput-config)))))
              (services dunk-system-common)))))

