#lang racket

(require rackunit
         rackunit/text-ui
         "day2.rkt")

(define tests
  (test-suite
   "Day2 Tests"

   (test-case
    "Part 1: wrapping-paper"
    (check-equal? (wrapping-paper 2 3 4) 58)
    (check-equal? (wrapping-paper 1 1 10) 43))

   (test-case
    "Part 2: ribbon"
    (check-equal? (ribbon 2 3 4) 34)
    (check-equal? (ribbon 1 1 10) 14))))

(run-tests tests)
