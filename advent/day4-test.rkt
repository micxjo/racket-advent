#lang racket

(require rackunit
         rackunit/text-ui
         "day4.rkt")

(define tests
  (test-suite
   "Day4 Tests"

   (test-case
    "Part 1"
    (check-equal? (first-hash "abcdef" "00000") 609043)
    (check-equal? (first-hash "pqrstuv" "00000") 1048970))))

(run-tests tests)
