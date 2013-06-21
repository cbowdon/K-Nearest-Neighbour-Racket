#lang typed/racket/base

(require racket/list)

(provide quick-sort1)

(define-type Sort (All (a) ((Listof a) (a a -> Boolean) -> (Listof a))))

(: nth-element Sort)
(define (nth-element lst comp)
  '())

; turns out racket/list has partition, using that instead
(: quick-sort1 (All (a) ((Listof a) (a a -> Boolean) Integer -> (Values (Listof a) (Listof a)))))
(define (quick-sort1 lst comp pivot)
  (let ([p (list-ref lst pivot)])
	(: qs-iter ((Listof a) (Listof a) (Listof a) -> (Values (Listof a) (Listof a))))
	(define (qs-iter in less greater)
	  (cond [(null? in) (values less greater)]
			[(comp (car in) p) (qs-iter (cdr in) (cons (car in) less) greater)]
			[else (qs-iter (cdr in) less (cons (car in) greater))]))
	(qs-iter lst '() '())))
