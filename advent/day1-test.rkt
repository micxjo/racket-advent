#lang racket

(require rackunit
         rackunit/text-ui
         "day1.rkt")

(define tests
  (test-suite
   "Day1 Tests"

   (test-case
    "Part 1: santa-floor"
    (let ([floor-cases '(("" . 0)
                         ("abc" . 0)
                         ("(" . 1)
                         (")" . -1)
                         ("(())" . 0)
                         ("()()" . 0)
                         ("(((" . 3)
                         ("(()(()(" . 3)
                         ("))(((((" . 3)
                         ("())" . -1)
                         (")))" . -3)
                         (")())())" . -3))])
      (for ([case floor-cases])
        (check-equal? (santa-floor (car case)) (cdr case)))))

   (test-case
    "Part 2: first-basement"
    (let ([basement-cases '(("" . #f)
                            ("abc" . #f)
                            (")" . 1)
                            ("(" . #f)
                            ("()())" . 5))])
      (for ([case basement-cases])
        (check-equal? (first-basement (car case)) (cdr case)))))))

(run-tests tests)
