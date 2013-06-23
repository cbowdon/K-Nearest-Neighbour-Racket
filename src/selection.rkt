#lang typed/racket

(provide quick-sort1
		 quick-select
		 nth-element)

(: nth-element (All (a) ((Listof a) Index (a -> Real) -> (Listof a))))
(define (nth-element lst n sel)
  (quick-select lst n sel))

(: quick-sort1 (All (a) ((Listof a) Index (a -> Real) -> (Values (Listof a) (Listof a) (Listof a)))))
(define (quick-sort1 lst pivot sel)
  (let ([p (list-ref lst pivot)])
	(: qs-iter ((Listof a) (Listof a) (Listof a) (Listof a) -> (Values (Listof a) (Listof a) (Listof a))))
	(define (qs-iter in less eq greater)
	  (cond [(null? in) (values (reverse less) eq (reverse greater))]
			[(< (sel (car in)) (sel p)) 
			 (qs-iter (cdr in) (cons (car in) less) eq greater)]
			[(> (sel (car in)) (sel p))
			 (qs-iter (cdr in) less eq (cons (car in) greater))]
			[else 
			  (qs-iter (cdr in) less (cons (car in) eq) greater)]))
	(qs-iter lst '() '() '())))

(: quick-select (All (a) ((Listof a) Index (a -> Real) -> (Listof a))))
(define (quick-select lst n sel)
  (: qs-iter ((Listof a) (Listof a) (Listof a) -> (Listof a)))
  (define (qs-iter working lower higher)
	(define p (quotient (length working) 2))
	(define-values (lt eq gt) (quick-sort1 working p sel))
	(define pivot-new-index (+ (length lt) (length lower)))
	(cond [(= pivot-new-index n)
		   (append lower lt eq gt higher)]
		  [(> pivot-new-index n)
		   (qs-iter lt lower (append eq gt higher))]
		  [(> (+ pivot-new-index (length eq)) n)
		   (append lower lt eq gt higher)]
		  [else (qs-iter (append eq gt) (append lower lt) higher)]))
  (qs-iter lst '() '()))
