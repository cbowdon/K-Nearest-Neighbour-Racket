#lang racket

(require rackunit
		 "typed-csv.rkt"
		 "knn.rkt")

(test-case
  "euclidean-dist 2D"
  (let* ([p0 (map Some (list 0 0))]
		 [p1 (map Some (list 3 4))]
		 [q (euclidean-dist p0 p1)])
	(check-equal? (Some-value q) 25)))

(test-case
  "euclidean-dist 4D"
  (let* ([p0 (map Some (list 1 2 3 4))]
		 [p1 (map Some (list 4 3 2 1))]
		 [q (euclidean-dist p0 p1)]
		 [r (+ (sqr (- 1 4))
			   (sqr (- 2 3))
			   (sqr (- 3 2))
			   (sqr (- 4 1)))])
	(check-equal? (Some-value q) r)))
