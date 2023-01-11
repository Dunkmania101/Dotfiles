(use-modules
  (gnu)
  (gnu system nss)
  (guix utils)
  (guix transformations)
  (guix packages)
  ((guix licenses) #:prefix license:)
  (guix git-download)
  (guix download)
  (guix build-system copy)
  (guix build-system python)
  (nongnu packages linux)
  (nongnu system linux-initrd)
  (nongnu packages nvidia)
  (nongnu services nvidia))
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
(load "../nvtransform.scm")

(define-public dunk-system-common-nvidia
               (operating-system
                 (inherit dunk-system-common)
                 ;(kernel (nvtransform (operating-system-kernel dunk-system-common)))
                 ;(firmware (nvtransforms (operating-system-firmware dunk-system-common)))
                 ;(firmware (nvtransforms (append (list
                 ;				      nvidia-firmware)
                 ;				      ;)
                 ;				    (operating-system-firmware dunk-system-common))))
                 ; nvidia-module-open 
                 ;    (kernel-loadable-modules (nvtransforms (append (list nvidia-driver) (operating-system-kernel-loadable-modules dunk-system-common))))
                 ;(kernel-loadable-modules (append (list nvidia-module) (operating-system-kernel-loadable-modules dunk-system-common)))

                 ;(kernel-arguments (append 
                 ;                    ;(append 
                 ;                    '(
                 ;                      ;"nvidia-drm.modeset=1"
                 ;                      "modprobe.blacklist=nouveau") ;,nvidia_uvm")
                 ;                    ;(operating-system-user-kernel-arguments dunk-system-common))
                 ;                    %default-kernel-arguments))
                 (packages 
                   (nvtransforms
                     (append
                       (list ;(specification->package "nvidia-module-open")
                             ;(specification->package "nvidia-driver")
                             ;(specification->package "nvidia-firmware")
                             (specification->package "nvidia-exec")
                             ;(specification->package "nvidia-settings")
                             ;(specification->package "mesa")
                             )
                       (operating-system-packages dunk-system-common)))
                   )
                 (services
                   (append (list ;(service kernel-module-loader-service-type
                             ;     				'("nvidia"
                             ;       				  "nvidia_drm"
                             ;       				  "nvidia_uvm"
                             ;       				  "nvidia_modeset"
                             ;			        	  "ipmi_devintf"))
                             (service nvidia-service-type
                                      (nvidia-configuration
                                        (modules (list "nvidia" "nvidia-uvm" "nvidia-drm" "nvidia-modeset" "ipmi-devintf"))
                                        (nvidia-module (list nvidia-module nvidia-module-open))
					))
                             ;(set-xorg-configuration
                             ;  (xorg-configuration
                             ;    (server (nvtransform xorg-server))
                             ;    (drivers '("nvidia"))
                             ;    (modules
                             ;      (cons*
                             ;        ;nvidia-module-open
                             ;        nvidia-driver
                             ;        %default-xorg-modules))))
                           ;   (service slim-service-type
                           ;	    (slim-configuration
                           ;	     (xorg-configuration (xorg-configuration
                           ;				  (modules (cons* nvidia-driver %default-xorg-modules))
                           ;				  (server (nvtransform xorg-server))
                           ;				  (drivers '("nvidia"))))))
                           ;   (simple-service 'my-nvidia-udev-rules udev-service-type (nvtransforms (list
                           ;									   ;nvidia-module-open
                           ;									   nvidia-driver))))
			   )
                           ;(operating-system-user-services dunk-system-common)))))
			   (modify-services (operating-system-user-services dunk-system-common)
					    ;)))))
;(udev-service-type config =>
;                   (udev-configuration
;                    (inherit config)
;                    (rules
;                     (cons* nvidia-module
;                            (udev-configuration-rules config)))))
					;    (gdm-service-type config =>
					;		      (gdm-configuration
					;			(inherit config)
					;			(gdm (nvtransform gdm)))))))))
;								(xorg-configuration (xorg-configuration
;										      (modules (cons*
;												 ;nvidia-module-open
;												 nvidia-driver %default-xorg-modules))
;										      (server (nvtransform xorg-server))
;										      (drivers '("nvidia")))))))))))
    (set-xorg-configuration config =>
			    (xorg-configuration
			      (inherit config)
			      (server (nvtransform xorg-server))
			      (drivers '("nvidia"))
			      (modules
				;(nvtransforms
				(append
				  (list
				    ;nvidia-module-open
				    nvidia-driver)
				  (modules config))))))))));)

