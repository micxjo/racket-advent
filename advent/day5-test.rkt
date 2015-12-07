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
    (check-false (is-nice? "dvszwmarrgswjxmb")))

   (test-case
    "Part 2: is-nice-2?"
    (check-pred is-nice-2? "qjhvhtzxzqqjkmpb")
    (check-pred is-nice-2? "xxyxx")
    (check-false (is-nice? "uurcxstgmygtbstg"))
    (check-false (is-nice? "ieodomkazucvgmuy")))))

(run-tests tests)
