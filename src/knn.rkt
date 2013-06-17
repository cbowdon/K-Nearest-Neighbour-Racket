#lang typed/racket/base

(require "typed-csv.rkt")

(: euclidean-dist ((Listof (Opt Number)) (Listof (Opt Number)) -> (Opt Number)))
(define (euclidean-dist pt0 pt1)
  (None))

(: calc-dists ((Listof (Opt Number)) (Listof Labelled) -> (Listof (Pairof Number Labelled))))
(define (calc-dists u ll)
  '())
