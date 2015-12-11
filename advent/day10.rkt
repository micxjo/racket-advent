#lang racket

(provide look-and-say
         iterative-look-and-say)

(require srfi/1
         srfi/13)

(define (group lst)
  (define (loop lst groups)
    (match lst
      [(list el more ...)
       (let ([eq-el (lambda (e) (eqv? e el))])
         (loop (drop-while eq-el lst)
               (cons (take-while eq-el lst) groups)))]
      ['() groups]))
  (reverse (loop lst '())))

(define (look-and-say-group lst)
  (string-append (number->string (length lst))
                 (make-string 1 (car lst))))

(define (look-and-say str)
  (string-concatenate
   (map look-and-say-group (group (string->list str)))))

(define (iterate f input n)
  (if (= n 0)
      input
      (iterate f (f input) (- n 1))))

(define (iterative-look-and-say str n)
  (string-length (iterate look-and-say str n)))

(define input (command-line
               #:args ([input #f])
               input))

(when input
  (printf "Part 1: ~a~n" (iterative-look-and-say input 40))
  (printf "Part 2: ~a~n" (iterative-look-and-say input 50)))
