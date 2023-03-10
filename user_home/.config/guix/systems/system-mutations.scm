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
  lightdm
  networking
  file-sharing
  ssh
  xorg
  pm
  virtualization
  nix)


(load "../nvtransform.scm")

(define-public (nvidiaify-xorg-config xcfg)
 (xorg-configuration
   (inherit xcfg)
   (server (nvtransform (server xcfg)))
   (drivers '("nvidia"))
   (modules
     (cons*
       nvidia-driver
       (modules xcfg)))))

(define-public (nvidiaify-system base-system)
               (operating-system
                 (inherit base-system)
                 ;(kernel linux-lts)
                 ;(kernel (nvtransform (operating-system-kernel base-system)))
                 ;(firmware (nvtransforms (operating-system-firmware base-system)))
                 ;(firmware (nvtransforms (append (list
                 ;				      nvidia-firmware)
                 ;				      ;)
                 ;				    (operating-system-firmware base-system))))
                 ; nvidia-module-open 
                 ;    (kernel-loadable-modules (nvtransforms (append (list nvidia-module nvidia-module-open) (operating-system-kernel-loadable-modules base-system))))
                 ;(kernel-loadable-modules (nvtransforms (append (list nvidia-module nvidia-module-open) (operating-system-kernel-loadable-modules base-system))))
                 ;(kernel-loadable-modules (append (list nvidia-module nvidia-module-open) (operating-system-kernel-loadable-modules base-system)))
                 ;(kernel-loadable-modules (list nvidia-module-open nvidia-module))
                 (kernel-loadable-modules (list nvidia-module))
                 ;(kernel-loadable-modules (list nvidia-module-open))
                 (kernel-arguments (append 
                                     (append 
                                     (list
                                       ;"nvidia-drm.modeset=1"
                                       "modprobe.blacklist=nouveau") ;,nvidia_uvm")
                                     (operating-system-user-kernel-arguments base-system))
                                     %default-kernel-arguments)
                                     )
                 (packages 
                   (nvtransforms
                     (append
                       (list ;(specification->package "nvidia-module-open")
                             (specification->package "nvidia-module")
                             (specification->package "nvidia-driver")
                             ;(specification->package "nvidia-firmware")
                             (specification->package "nvidia-exec")
                             (specification->package "nvidia-settings")
                             ;(specification->package "mesa")
                             (specification->package "mesa-utils")
                             )
                       (operating-system-packages base-system)))
                   )
                 (services
                   (append (list ;(service kernel-module-loader-service-type
                             ;     				'("nvidia"
                             ;       				  "nvidia_drm"
                             ;       				  "nvidia_uvm"
                             ;       				  "nvidia_modeset"
                             ;			        	  "ipmi_devintf"))
                             (service nvidia-service-type;)
                                      ;(nvidia-configuration
                                        ;(modules (list "nvidia" "nvidia-uvm" "nvidia-drm" "nvidia-modeset" "ipmi-devintf"))
                                        ;(modules (list))
                                        ;(nvidia-module (list nvidia-module nvidia-module-open))
                                        ;(nvidia-module (list nvidia-module-open))
                                        ;(nvidia-module (list nvidia-module))
                                        ;)
                                      )
                             (set-xorg-configuration
                               (nvidiaify-xorg-config (xorg-configuration))
			       lightdm-service-type)
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
                           ;(operating-system-user-services base-system)))))
			   (modify-services (operating-system-user-services base-system)
					    ;)))))
                        (lightdm-service-type config =>
                                              (lightdm-configuration
                                                (inherit config)
                                                (lightdm (nvtransform (lightdm config)))))
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
    ;(set-xorg-configuration config =>
    ;        (set-xorg-configuration
	;		    (inherit config)
	;		    (xorg-configuration
	;		      (inherit (xorg-config config))
	;		      ;(server (nvtransform xorg-server))
	;		      (drivers '("nvidia"))
	;		      (modules
    ;                ;(nvtransforms
    ;                (append
    ;                  (list
    ;                    ;nvidia-module-open
    ;                    nvidia-driver)
    ;                  (modules (xorg-config config))))))))))));)
    )))))

;(define %xorg-config-nvidia-gtx1650
;  "Section \"Device\"
;      Identifier     \"Device0\"
;      Driver         \"nvidia\"
;      VendorName     \"NVIDIA Corporation\"
;      BoardName      \"GeForce GTX 1650\"
;  EndSection")
(define %xorg-config-nvidia
  "Section \"Device\"
      Identifier     \"Device-nvidia\"
      Driver         \"nvidia\"
      VendorName     \"NVIDIA Corporation\"
      Option \"RegistryDwords\" \"EnableBrightnessControl=1\"
   EndSection
   Section \"Screen\"
       Identifier \"nvidia\"
       Device \"nvidia\"
       Option \"AllowEmptyInitialConfiguration\"
   EndSection")

(define %xorg-config-nvidia-replace-intel
    "Section \"ServerLayout\"
        Identifier \"layout\"
        Screen 0 \"nvidia\"
        Inactive \"intel\"
    EndSection
    
    Section \"Device\"
        Identifier \"nvidia\"
        Driver \"nvidia\"
        BusID \"01:00:0\"
        Option \"RegistryDwords\" \"EnableBrightnessControl=1\"
    EndSection
    
    Section \"Screen\"
        Identifier \"nvidia\"
        Device \"nvidia\"
        Option \"AllowEmptyInitialConfiguration\"
    EndSection
    
    Section \"Device\"
        Identifier \"intel\"
        Driver \"modesetting\"
    EndSection
    
    Section \"Screen\"
        Identifier \"intel\"
        Device \"intel\"
    EndSection")

(define-public (nvidiaify-system-gtx1650 base-system)
  (operating-system
   (inherit (nvidiaify-system base-system))
   ;(services
   ;    (modify-services (operating-system-user-services (nvidiaify-system base-system))
   ; 		    (set-xorg-configuration config =>
   ; 					    (set-xorg-configuration
   ; 				        	  (inherit config)
   ;         				        (xorg-configuration
   ; 				        	  (inherit (xorg-config config))
   ; 						  (extra-config (list %xorg-config-nvidia-gtx1650)))))))
   ))

