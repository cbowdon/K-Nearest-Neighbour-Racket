#lang typed/racket/base

(require racket/file)
(require racket/list)
(require racket/function)

(provide csv->cells
		 Opt
		 None
		 Some
		 string->opt-num
		 print-opt
		 Labelled
		 LabelFix
		 make-labelled
		 print-labelled)

(: csv->cells (Path [#:sep String] -> (Listof (Listof String))))
(define (csv->cells data-file #:sep [sep ","])
	(map (curry regexp-split sep)
		 (file->lines data-file)))

;; Option type
(struct: None ())
(struct: (a) Some ([value : a]))
(define-type (Opt a) (U None (Some a)))

(: string->opt-num (String -> (Opt Number)))
(define (string->opt-num str)
  (let ([x (string->number str)])
	(cond [(number? x) (Some x)]
		  [else (None)])))

(: print-opt (All (a) ((Opt a) -> Void)))
(define (print-opt opt)
  (cond [(None? opt) (printf "None\n")]
		[(Some? opt) (printf "Some ~a\n" (Some-value opt))]))

;; Labelled type
(struct: Labelled ([label : String] [data : (Listof (Opt Number))]))

(define-type LabelFix (U 'pre 'post))

(: make-labelled ((Listof String) [#:fix LabelFix] -> Labelled))
(define (make-labelled lstr #:fix [fix 'pre])
  (cond [(eq? fix 'pre) 
		 (Labelled (car lstr) 
				   (map string->opt-num (cdr lstr)))]
		[(eq? fix 'post) 
		 (let ([len (- (length lstr) 1)])
		   (Labelled (list-ref lstr len)
					 (map string->opt-num (take lstr len))))]))

(: print-labelled (Labelled -> Void))
(define (print-labelled lab)
  (printf "Labelled [~s ~a]\n" (Labelled-label lab) (Labelled-data lab))) 
