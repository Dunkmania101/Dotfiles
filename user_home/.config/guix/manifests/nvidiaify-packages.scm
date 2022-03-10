(load "../gtransform.scm")

(packages->manifest
  (fixpkgs
    (map manifest-entry-name
         (manifest-entries
           (profile-manifest %current-profile)))))

