#lang racket

(require rackunit)
(require "selection.rkt")

(test-case
  "1 iteration of quick-sort"
  (let ([result (quick-sort1 (list 2.0 3.0 5.0 8.0 4.0 1.0 9.0 0.1 4.0) < 4)])
	(check-equal?
	  (list-ref result 4)
	  4.0)
	(check-equal?
	  (take result 4)
	  (list 0.1 1.0 3.0 2.0))
	(check-equal?
	  (drop result 5)
	  (list 4.0 9.0 4.0 8.0 5.0))))
