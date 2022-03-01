(use-modules (gnu))

(load "./systems/dunk-system-biggus.scm")
(define inherited-system dunk-system-biggus)

(define-public configuered-system
               (operating-system
                 (inherit inherited-system)
                 (bootloader
                   (bootloader-configuration
                     (bootloader grub-efi-bootloader)
                     (targets (list "/boot/efi"))
                     (keyboard-layout (operating-system-keyboard-layout inherited-system))))
                     ;; ADD FILESYSTEM / SWAP CONFIG OVERRIDES HERE
                     ))

configured-system
