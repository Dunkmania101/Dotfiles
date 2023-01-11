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
  (mapped-devices (list (mapped-device
                          (source (uuid
                                   "9947db9b-3ddf-4aa1-8d58-6bc27c1aed09"))
                          (target "crypthome")
                          (type luks-device-mapping))
                        (mapped-device
                          (source (uuid
                                   "8cf738a7-3fea-46f9-9f0e-753cbcf5a453"))
                          (target "cryptroot")
                          (type luks-device-mapping))))

  ;; The list of file systems that get "mounted".  The unique
  ;; file system identifiers there ("UUIDs") can be obtained
  ;; by running 'blkid' in a terminal.
  (file-systems (cons* (file-system
                         (mount-point "/home")
                         (device "/dev/mapper/crypthome")
                         (type "btrfs")
                         (dependencies mapped-devices))
                       (file-system
                         (mount-point "/")
                         (device "/dev/mapper/cryptroot")
                         (type "btrfs")
                         (dependencies mapped-devices))
                       (file-system
                         (mount-point "/boot/efi")
                         (device (uuid "B294-5BD7"
                                       'fat32))
                         (type "vfat")) %base-file-systems))))

configured-system

