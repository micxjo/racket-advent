#lang racket

(require rackunit
         rackunit/text-ui
         "day10.rkt")

(define tests
  (test-suite
   "Day10 Tests"

   (test-case
    "Part 1: look-and-say"
    (check-equal? (look-and-say "1") "11")
    (check-equal? (look-and-say "11") "21")
    (check-equal? (look-and-say "21") "1211")
    (check-equal? (look-and-say "1211") "111221")
    (check-equal? (look-and-say "111221") "312211")
    (check-equal? (iterative-look-and-say "1" 5) 6))))

(run-tests tests)
