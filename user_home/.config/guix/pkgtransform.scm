(use-modules
  (guix utils)
  (guix packages))


(define-public (topkg p)
	       (if (string? p)
		 (specification->package p)
		 p))

(define-public (topkgs plist)
	       (map topkg plist))

