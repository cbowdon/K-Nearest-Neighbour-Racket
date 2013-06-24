#lang typed/racket

(require "typed-csv.rkt"
		 "selection.rkt")

(provide euclidean-dist
		 calc-dists
		 k-closest
		 selector
		 knn)

(: euclidean-dist ((Listof (Opt Number)) (Listof (Opt Number)) -> (Opt Number)))
(define (euclidean-dist pt0 pt1)
  (let ([lst (map (apply-opt (lambda (x y) (sqr (- x y)))) pt0 pt1)])
	(foldl (apply-opt +) (Some 0) lst)))

(: calc-dists ((Listof (Opt Number)) (Listof Labelled) -> (Listof (Pairof (Opt Number) Labelled))))
(define (calc-dists u ll)
  (map (lambda: ([x : Labelled]) (cons (euclidean-dist u (Labelled-data x)) x)) ll))

(: k-closest ((Listof (Pairof (Opt Number) Labelled)) Index -> (Listof (Pairof (Opt Number) Labelled))))
(define (k-closest dists k)
  (: sel ((Pairof (Opt Number) Labelled) -> Real))
  (define (sel x)
	(match (car x)
		   [(Some a) (cast a Real)]
		   [(None) 0]))
  (take (nth-element dists k sel) k))

(: selector ((Pairof (Opt Number) Labelled) -> String))
(define (selector x)
  (Labelled-label (cdr x)))

(: knn ((Listof (Opt Number)) (Listof Labelled) Index -> String))
(define (knn unclassified classified-list k)
	(modal (k-closest (calc-dists unclassified 
								  classified-list) 
					  k)
		   selector))
