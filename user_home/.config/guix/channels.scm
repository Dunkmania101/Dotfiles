(cons*
  ;(channel
  ;  (name 'dunk-guixchan)
  ;  (url "file:///home/dunk/ProgramFiles/dunk-guixchan"))
  ;(channel
  ;  (name 'flat)
  ;  (url "https://github.com/flatwhatson/guix-channel.git")
  ;  (introduction
  ;    (make-channel-introduction
  ;      "33f86a4b48205c0dc19d7c036c85393f0766f806"
  ;      (openpgp-fingerprint
  ;        "736A C00E 1254 378B A982  7AF6 9DBE 8265 81B6 4490"))))
  (channel
    (name 'rde)
    (url "https://git.sr.ht/~abcdw/rde")
    (introduction
      (make-channel-introduction
        "257cebd587b66e4d865b3537a9a88cccd7107c95"
        (openpgp-fingerprint
          "2841 9AC6 5038 7440 C7E9  2FFA 2208 D209 58C1 DEB0"))))
  (channel
    (name 'home-service-dwl-guile)
    (url "https://github.com/engstrand-config/home-service-dwl-guile")
    (branch "main")
    (introduction
      (make-channel-introduction
        "314453a87634d67e914cfdf51d357638902dd9fe"
        (openpgp-fingerprint
          "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C"))))
  (channel
    (name 'nvidiachannel)
    (url "https://gitlab.com/squarerectangle/nvidiachannel.git")
    (branch "master"))
  ;        (introduction
  ;          (make-channel-introduction
  ;            "314453a87634d67e914cfdf51d357638902dd9fe"
  ;            (openpgp-fingerprint
  ;              "C9BE B8A0 4458 FDDF 1268 1B39 029D 8EB7 7E18 D68C"))))
  (channel
    (name 'guix-gaming-games)
    (url "https://gitlab.com/guix-gaming-channels/games.git")
    ;; Enable signature verification:
    (introduction
      (make-channel-introduction
        "c23d64f1b8cc086659f8781b27ab6c7314c5cca5"
        (openpgp-fingerprint
          "50F3 3E2E 5B0C 3D90 0424  ABE8 9BDC F497 A4BB CC7F"))))
  (channel
    (name 'nonguix)
    (url "https://gitlab.com/nonguix/nonguix")
    (introduction
      (make-channel-introduction
        "897c1a470da759236cc11798f4e0a5f7d4d59fbc"
        (openpgp-fingerprint
          "2A39 3FFF 68F4 EF7A 3D29  12AF 6F51 20A0 22FB B2D5"))))
  %default-channels)
