#lang racket

(require rackunit)
(require "selection.rkt")

; quick-sort1 (partition) tests
(test-case
  "1 iteration of quick-sort"
  (let-values ([(lt eq gt) (quick-sort1 (list 2.0 3.0 5.0 8.0 4.0 1.0 9.0 0.1 4.0) 4 identity)])
	(check-equal? eq (list 4.0 4.0))
	(check-equal? lt (list 2.0 3.0 1.0 0.1) "Order should be same as original list.")
	(check-equal? gt (list 5.0 8.0 9.0) "Order should be same as original list.")))

(test-case
  "quick-sort1 on a 1-element list"
  (let-values ([(lt eq gt) (quick-sort1 (list 1.0) 0 identity)])
	(check-equal? eq (list 1.0))
	(check-equal? lt '())
	(check-equal? gt '())))

(test-case
  "partition from racket/list - just for interest"
  (let-values ([(lss gtr) (partition (lambda (x) (< x 4.0)) (list 2.0 3.0 5.0 8.0 4.0 1.0 9.0 0.1 4.0))])
	(check-equal? lss (list 2.0 3.0 1.0 0.1))
	(check-equal? gtr (list 5.0 8.0 4.0 9.0 4.0))))

; quick-select tests
(test-case
  "already correct list"
  (let ([result (quick-select (list 1 2 3 4 5 6 7) 2 identity)])
	(check-equal? (list-ref result 2) 3)
	(check-equal? result (list 1 2 3 4 5 6 7) "List should not be modified")))

(test-case
  "move the 3"
  (let ([result (quick-select (list 3 2 1 4 5 6 7) 2 identity)])
	(check-equal? (list-ref result 2) 3 "2nd element should be 3")
	(check-true (andmap (lambda (x) (< x 3)) (take result 2)) "Everything before 2nd element should be less than 3")
	(check-true (andmap (lambda (x) (> x 3)) (drop result 3)) "Everything after 2nd element should be more than 3")))

(test-case
  "all equal list"
  (let ([result (quick-select (list 3 3 3 3 3 3 3) 2 identity)])
	(check-equal? (list-ref result 2) 3)
	(check-equal? result (list 3 3 3 3 3 3 3) "List should be same as put in.")))

(test-case
  "list with some duplicates"
  (let ([result (quick-select (list 9 1 3 3 4 4 3) 2 identity)])
	(check-equal? (list-ref result 2) 3 "2nd element should be 3.")
	(check-true (andmap (lambda (x) (<= x 3)) (take result 2)) "Everything before 2nd element should be less than or equal to 3")
	(check-true (andmap (lambda (x) (>= x 3)) (drop result 3)) "Everything after 2nd element should be greater than or equal to 3")))
