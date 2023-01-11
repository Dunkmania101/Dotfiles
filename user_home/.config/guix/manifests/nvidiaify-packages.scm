(use-modules
 (guix utils)
 (guix packages)
 (gnu packages gl)
 (nongnu packages nvidia))


(load "../nvtransform.scm")
(load "../topkg.scm")

(packages->manifest
  ;(nvtransforms
  (topgks
    (map manifest-entry-name
         (manifest-entries
           (profile-manifest %current-profile)))))

