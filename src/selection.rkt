#lang typed/racket/base

(require racket/list
		 racket/function)

(provide quick-sort1
		 ;quick-select
		 nth-element)

(: nth-element (All (a) ((Listof a) Index (a a -> Boolean) -> (Listof a))))
(define (nth-element lst n comp)
  '())

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
	(define pivot-new-index (length lt))
	(cond [(= pivot-new-index n)
		   (begin
			 (printf "equal\n")
			 (append lt eq gt))]
		  [(> pivot-new-index n)
		   (begin
			 (printf "lt\n")
			 (qs-iter lt lower (append eq gt higher)))]
		  [else
		   (begin
			 (printf "gt\n")
			 (qs-iter (append eq gt) (append lower lt) higher))]))
  '())

; nth element is index 2
; should be 3
(: n Real)
(define n 2)

(: data (Listof Real))
(define data (list 3 2 1 6 5 7 8 4 9))

(: ident (All (a) (a -> Real)))
(define (ident x) (cast x Real))

(define-values (lt eq gt) (quick-sort1 data 4 ident))

;(partition (lambda: ([x : Real]) (< x (list-ref data 4))) data)

; 4th element is in its correct place - as head of gt list
(define pivot-new-index (length lt))

(printf "~a ~a ~a\n" lt eq gt)


(cond [(= pivot-new-index n)
	   (begin
		 (printf "equal\n")
		 (values lt eq gt))]
	  [(> pivot-new-index n)
	   (begin
		 (printf "lt\n")
		 (quick-sort1 lt 2 ident))]
	  [else
	   (begin
		 (printf "gt\n")
		 (quick-sort1 (append eq gt) 6 ident))])
