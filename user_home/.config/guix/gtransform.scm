(use-modules
 (guix packages)
 (gnu packages gl)
 (guix utils)
 (nvidiachannel nvidia)
 (nvidiachannel glvnd))

;; OPTIONAL: version of extra-cmake-modules that doesn't depend on qt
(use-modules (gnu packages kde-frameworks))
(define-public nonstupid-extra-cmake-modules
  (package/inherit extra-cmake-modules
                   (native-inputs '())
                   (arguments
                    (substitute-keyword-arguments (package-arguments extra-cmake-modules)
                                                  ((#:tests? flags ''())
                                                   #f)))))

;; define a procedure to transform a package object to use libglvnd.
;; the default transformation list is included in `glvnd-transformations-list-graft'
;; and we also add the cmake-modules transformation, which is optional.
(define gtransform
  (package-input-rewriting
   (append
    glvnd-transformations-list-graft
    `((,extra-cmake-modules . ,nonstupid-extra-cmake-modules)))))

;; define two procedures:
;; fixpkg p
;;      transform package object
;; fixpkgs p
;;      transform list of package objects
;;
;; there are also a few fancy features in fixpkg, like support for package names instead of objects

(define (topkg p)
  (if (string? p)
      (specification->package p)
      p))
(define (fixpkg p)
  (cond
   ((list? p)
    (if (eq? (car p) 'raw)
        (let ((d (cdr p)))
          (if (not (null? (cdr d)))
              (cons (fixpkg (car p)) (cdr p)) ;; with specific output
              (topkg (car d)))) ;; just a package
        (cons (fixpkg (car p)) (cdr p))))
   (else (gtransform (topkg p)))))
(define (fixpkgs plist)
  (map fixpkg plist))
