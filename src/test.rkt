#lang racket

(require rackunit)
(require "selection.rkt")

(test-case
  "1 iteration of quick-sort"
  (let-values ([(lt gt) (quick-sort1 (list 2.0 3.0 5.0 8.0 4.0 1.0 9.0 0.1 4.0) < 4)])
	(check-equal? (car gt) 4.0)
	(check-equal? lt (list 0.1 1.0 3.0 2.0))
	(check-equal? gt (list 4.0 9.0 4.0 8.0 5.0))))

(test-case
  "quick-sort1 on a 1-element list"
  (let-values ([(lt gt) (quick-sort1 (list 1.0) < 0)])
	(check-equal? lt '())
	(check-equal? gt (list 1.0))))

(test-case
  "partition from racket/list - just for interest"
  (let-values ([(lss gtr) (partition (lambda (x) (< x 4.0)) (list 2.0 3.0 5.0 8.0 4.0 1.0 9.0 0.1 4.0))])
	(check-equal? lss (list 2.0 3.0 1.0 0.1))
	(check-equal? gtr (list 5.0 8.0 4.0 9.0 4.0))))
