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
 ;(rosenthal packages linux)
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

(define %xorg-libinput-config
  "Section \"InputClass\"
  Identifier \"Touchpads\"
  Driver \"libinput\"
  MatchDevicePath \"/dev/input/event*\"
  MatchIsTouchpad \"on\"
  Option \"Tapping\" \"on\"
  Option \"TappingDrag\" \"on\"
  Option \"DisableWhileTyping\" \"on\"
  Option \"MiddleEmulation\" \"on\"
  Option \"ScrollMethod\" \"twofinger\"
EndSection
Section \"InputClass\"
  Identifier \"Keyboards\"
  Driver \"libinput\"
  MatchDevicePath \"/dev/input/event*\"
  MatchIsKeyboard \"on\"
EndSection
")

(define %backlight-udev-rule
  (udev-rule
   "90-backlight.rules"
   (string-append "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                  "RUN+=\"/run/current-system/profile/bin/chgrp video /sys/class/backlight/%k/brightness\""
                  "\n"
                  "ACTION==\"add\", SUBSYSTEM==\"backlight\", "
                  "RUN+=\"/run/current-system/profile/bin/chmod g+w /sys/class/backlight/%k/brightness\"")))

(define-public dunk-system-common
  (operating-system
   ;(kernel linux-rosenthal)
   (kernel linux)
   (kernel-arguments
    (append
     (list "nomodeset")
     %default-kernel-arguments))
   (firmware (list linux-firmware))
   (initrd microcode-initrd)
   (host-name "dummy")
   (timezone "America/Indiana/Indianapolis")
   (keyboard-layout (keyboard-layout "us"))
   (groups
    (cons*
     (user-group
      (system? #t)
      (name "realtime"))
     %base-groups))
   (users
    (cons*
     (user-account
      (name "dunk")
      (comment "Dunk")
      (group "users")
      (home-directory "/home/dunk")
      (shell
       (file-append fish "/bin/fish"))
      (supplementary-groups
       '("lp" "kvm" "tty" "realtime" "input" "wheel" "netdev" "audio" "video")))
     %base-user-accounts))
   (packages
     (append
      (list
                                        ;  (package
                                        ;    (name "linux-run")
                                        ;    (version "1.0.0")
                                        ;    (source (origin
                                        ;              (method git-fetch)
                                        ;              (uri (git-reference
                                        ;                    (url "https://tildegit.org/solene/guix-linux-run")
                                        ;                    (commit version)))
                                        ;              (file-name (git-file-name name version))
                                        ;              (sha256
                                        ;               (base32
                                        ;                "0prh4i68xw6r8vkzz3g7njfgsj32i1viw17rbrhds25dr64zi070"))))
                                        ;    (build-system copy-build-system)
                                        ;    (arguments
                                        ;     '(#:install-plan
                                        ;       '(("linux-run" "bin/"))))
                                        ;    (propagated-inputs
                                        ;     `(("gtk+" ,gtk+)
                                        ;       ("gcc-objc++:lib" ,gcc-objc++ "lib")))
                                        ;    (home-page "https://tildegit.org/solene/guix-linux-run")
                                        ;    (synopsis "Wrapper to run Linux binaries that are not from Guix")
                                        ;    (description "This package provides a shell wrapper that will redefine
                                        ;the environment to use Guix libraries for running a Linux binary.")
                                        ;    (license license:bsd-2))
       (package
        (inherit qtile)
        (version "0.22.1")
        (source
         (origin
          (method url-fetch)
          (uri (pypi-uri "qtile" version))
          (sha256
           (base32 "12wg8y33xgb0x0gd9xfylxss97p97dy1cy52yln64493fi6wphr7"))))
        (arguments
         (substitute-keyword-arguments (package-arguments qtile)
                                       ((#:phases phases)
                                        `(modify-phases ,phases
                                                        (add-after 'install 'install-xsession
                                                                   (lambda* (#:key outputs #:allow-other-keys)
                                                                     (let* ((out (assoc-ref outputs "out"))
                                                                            (xsessions (string-append out "/share/xsessions")))
                                                                       (mkdir-p xsessions)
                                                                       (call-with-output-file
                                                                           (string-append xsessions "/qtile.desktop")
                                                                         (lambda (port)
                                                                           (format port "~
                     [Desktop Entry]~@
                     Name=qtile~@
                     Comment=Hackable tiling window manager written and configured in Python~@
                     Exec=~a/bin/qtile start~@
                     Type=XSession~%" out)))
                                                                       #t))))))))
       (specification->package "fish")
       (specification->package "bash")
       (specification->package "zsh")
       (specification->package "flatpak")
       (specification->package "chrony")
       (specification->package "ncurses")
       (specification->package "network-manager")
       (specification->package "dmenu")
       (specification->package "nix")
       (specification->package "st")
       (specification->package "xterm")
       (specification->package "tlp")
       (specification->package "stow")
       (specification->package "python")
       (specification->package "neovim")
       (specification->package "vim")
       (specification->package "stow")
       (specification->package "pipewire")
       (specification->package "xdotool")
       (specification->package "xcb-util-cursor")
       (specification->package "xf86-input-libinput")
       (specification->package "bluez-alsa")
       (specification->package "bluez")
       (specification->package "gvfs")
       (specification->package "fuse")
       (specification->package "git")
       (specification->package "searx")
       (specification->package "acpi")
       (specification->package "v4l2loopback-linux-module")
       (specification->package "emacs-next-pgtk")
       (specification->package "nss-certs"))
      %base-packages))
   (services (append
              (list
               ;; (simple-service 'ratbagd dbus-root-service-type (list libratbag))
                                        ;(service gnome-desktop-service-type)
                                        ;(service xfce-desktop-service-type)
               (service openssh-service-type)
               (service tor-service-type)
               (service cups-service-type)
               (service libvirt-service-type)
               (extra-special-file "/usr/bin/env"
                                   (file-append coreutils "/bin/env"))
               (service tlp-service-type
                        (tlp-configuration
                         (cpu-boost-on-ac? #t)
                         (wifi-pwr-on-bat? #t)))
               (pam-limits-service ;; This enables JACK to enter realtime mode
                (list
                 (pam-limits-entry "@realtime" 'both 'rtprio 99)
                 (pam-limits-entry "@realtime" 'both 'memlock 'unlimited)))
               (service nix-service-type)
               ;; (service transmission-daemon-service-type
                        ;; (transmission-daemon-configuration
                         ;; (peer-port-random-on-start? #t)
                         ;; Restrict access to the RPC ("control") interface
                         ;; (rpc-authentication-required? #t)
                         ;; (rpc-username "transmission")
                         ;; (rpc-password
                         ;;  (transmission-password-hash
                         ;;   "transmission" ; desired password
                         ;;   transmission-random-salt))   ; arbitrary salt value

                         ;; Accept requests from this and other hosts on the
                         ;; local network
                         ;; (rpc-whitelist-enabled? #t)
                         ;; (rpc-whitelist '("::1" "127.0.0.1" "192.168.0.*"))

                         ;; Limit bandwidth use during work hours
                         ;; (alt-speed-down (* 1024 2)) ;   2 MB/s
                         ;; (alt-speed-up 512)          ; 512 kB/s

                         ;; (alt-speed-time-enabled? #t)
                         ;; (alt-speed-time-day 'weekdays)
                         ;; (alt-speed-time-begin
                          ;; (+ (* 60 8) 30))           ; 8:30 am
                         ;; (alt-speed-time-end
                          ;; (+ (* 60 (+ 12 5)) 30))))  ; 5:30 pm
                          ;; ))
               (set-xorg-configuration
                (xorg-configuration
                 (keyboard-layout keyboard-layout)
                 ;(server xorg-server)
                 ;(modules
                 ; (cons*
                 ;  %default-xorg-modules))
                 (extra-config
                  (list %xorg-libinput-config))))
              (simple-service 'searx-start-job mcron-service-type (list
                              #~(job '(next-minute (range 0 60 1)) (string-append "pgrep searx || " #$(file-append searx "/bin/searx-run & disown")))))
              (extra-special-file "/etc/searx/settings.yml"
                (plain-file "settings.yml" (string-append "
                                                           use_default_settings: True
                                                           general:
                                                               instance_name : \"searx\" # displayed name
                                                           server:
                                                               bind_address : \"0.0.0.0\"      # address to listen on
                                                               secret_key : \"" (transmission-random-salt) (transmission-random-salt) (transmission-random-salt) (transmission-random-salt) "\"
                                                           "))))
              (modify-services %desktop-services
                               (elogind-service-type config =>
                                                     (elogind-configuration
                                                      (inherit config)
                                                      (handle-lid-switch-external-power 'suspend)))
                               (udev-service-type config =>
                                                  (udev-configuration
                                                   (inherit config)
                                                   (rules
                                                    (cons* %backlight-udev-rule
                                                           (udev-configuration-rules config)))))
                               (network-manager-service-type config =>
                                                             (network-manager-configuration
                                                              (inherit config)
                                                              (vpn-plugins
                                                               (list network-manager-openvpn))))
                                        (gdm-service-type config =>
                                         (gdm-configuration
                                          (inherit config)
                                          (gnome-shell-assets (list materia-theme))))
                               (guix-service-type config =>
                                                  (guix-configuration
                                                   (inherit config)
                                                   (substitute-urls
                                                    (append (list "https://substitutes.nonguix.org")
                                                            %default-substitute-urls))
                                                   (authorized-keys
                                                    (append (list (plain-file "non-guix.pub"
                                                                              "(public-key
                                                       (ecc
                                                         (curve Ed25519)
                                                         (q #C1FD53E5D4CE971933EC50C9F307AE2171A2D3B52C804642A7A35F84F3A4EA98#)
                                                         )
                                                       )"))
                                                            %default-authorized-guix-keys)))))))
   (bootloader
    (bootloader-configuration
     (bootloader grub-efi-bootloader)
     (targets (list "/boot/efi"))
     (keyboard-layout keyboard-layout)))
   (file-systems
     (cons*
       (file-system
	 (mount-point "/")
         (device "/dev/mapper/crypthome")
	 (type "ext4"))
    %base-file-systems)))) ;; THIS SHOULD BE OVERRIDDEN IN THE MAIN SYSTEM-CONFIG.SCM FILE
;; (name-service-switch %mdns-host-lookup-nss)

