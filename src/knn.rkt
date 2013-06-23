#lang typed/racket

(require "typed-csv.rkt"
		 "selection.rkt")

(provide euclidean-dist)

(: euclidean-dist ((Listof (Opt Number)) (Listof (Opt Number)) -> (Opt Number)))
(define (euclidean-dist pt0 pt1)
  (let ([lst (map (apply-opt (lambda (x y) (sqr (- x y)))) pt0 pt1)])
	(foldl (apply-opt +) (Some 0) lst)))

(: calc-dists ((Listof (Opt Number)) (Listof Labelled) -> (Listof (Pairof Number Labelled))))
(define (calc-dists u ll)
  '())
