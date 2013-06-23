#lang typed/racket

(require "typed-csv.rkt")
(require "knn.rkt")

(printf "K Nearest Neighbour\n")

(: str-data (Listof (Listof String)))
(define str-data (csv->cells (string->path "data/classified.csv")))

(: data (Listof Labelled))
(define data (map (lambda: ([x : (Listof String)]) (make-labelled x #:fix 'post)) str-data))

;(for-each print-labelled data)
