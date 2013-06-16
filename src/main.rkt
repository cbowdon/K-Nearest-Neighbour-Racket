#lang typed/racket/base

(require "typed-csv.rkt")
(require "knn.rkt")

(printf "K Nearest Neighbour\n")

(: str-data (Listof (Listof String)))
(define str-data (csv->cells (string->path "data/classified.csv")))
