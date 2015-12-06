#lang racket

(require rackunit
         rackunit/text-ui
         "day3.rkt")

(define tests
  (test-suite
   "Day3 Tests"

   (test-case
    "Part 1: unique-deliveries"
    (check-equal? (unique-deliveries "") 1)
    (check-equal? (unique-deliveries ">") 2)
    (check-equal? (unique-deliveries "^>v<") 4)
    (check-equal? (unique-deliveries "^v^v^v^v^v") 2))

   (test-case
    "Part 2: unique-robo-deliveries"
    (check-equal? (unique-robo-deliveries "") 1)
    (check-equal? (unique-robo-deliveries "^>") 3)
    (check-equal? (unique-robo-deliveries "^>b<") 3)
    (check-equal? (unique-robo-deliveries "^v^v^v^v^v") 11))))

(run-tests tests)
