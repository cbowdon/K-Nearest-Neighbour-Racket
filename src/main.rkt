#lang typed/racket

(require "typed-csv.rkt"
		 "selection.rkt"
		 "knn.rkt")

(printf "K Nearest Neighbour\n")

; Preparing data
(: str-cl (Listof (Listof String)))
(define str-cl (csv->cells (string->path "data/classified.csv")))

(: classified (Listof Labelled))
(define classified (map (lambda: ([x : (Listof String)]) (make-labelled x #:fix 'post)) str-cl))

(: str-ul (Listof (Listof String)))
(define str-ul (csv->cells (string->path "data/unclassified.csv")))

(: str->opt-list ((Listof String) -> (Listof (Opt Number))))
(define (str->opt-list x)
  (filter Some? (map string->opt-num x)))

(: unclassified (Listof (Listof (Opt Number))))
(define unclassified (map str->opt-list str-ul))

; Apply algorithm to data
(: k Index)
(define k 5)

(define results
  (map (lambda: ([x : (Listof (Opt Number))]) (knn x classified k))
	   unclassified))

; display
(displayln "Actual:")
(for-each displayln str-ul)
(displayln "Estimated:")
(for-each displayln results)
