#lang racket

(require rackunit
         rackunit/text-ui
         "day5.rkt")

(define tests
  (test-suite
   "Day5 Tests"

   (test-case
    "Part 1: is-nice?"
    (check-pred is-nice? "ugknbfddgicrmopn")
    (check-pred is-nice? "aaa")
    (check-false (is-nice? "jchzalrnumimnmhp"))
    (check-false (is-nice? "haegwjzuvuyypxyu"))
    (check-false (is-nice? "dvszwmarrgswjxmb")))))

(run-tests tests)
