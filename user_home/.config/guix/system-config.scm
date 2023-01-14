(use-modules (gnu))

(load "./systems/dunk-system-biggus.scm")
(define inherited-system dunk-system-biggus)

(define-public configured-system
               (operating-system
                 (inherit inherited-system)
                 (bootloader
                   (bootloader-configuration
                     (bootloader grub-efi-bootloader) ; This might need to be grub-bootloader on older systems
                     (targets (list "/boot/efi")) ; This might need to be /dev/sda on older systems
                     (keyboard-layout (operating-system-keyboard-layout inherited-system))))
                     ;; ADD FILESYSTEM / SWAP CONFIG OVERRIDES HERE
                     ))

configured-system

