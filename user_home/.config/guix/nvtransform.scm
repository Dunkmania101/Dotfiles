(use-modules
  (guix utils)
  (guix transformations)
  (guix packages)
  (gnu packages gl)
  (nongnu packages nvidia))


(load "./pkgtransform.scm")

;(define-public nvtransform-pkg
;	       (options->transformation
;		 '((with-graft . "mesa=nvda"))))
(define-public (nvtransform-pkg p)
               (replace-mesa p))

(define-public (nvtransform p)
	       (nvtransform-pkg (topkg p)))
(define-public (nvtransforms plist)
	       (map nvtransform plist))

