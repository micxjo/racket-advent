#lang racket

(provide santa-floor
         first-basement)

(require srfi/1
         racket/cmdline)

(define (santa-floor str)
  (for/sum ([c (string->list str)])
    (cond
     [(eqv? c #\() 1]
     [(eqv? c #\)) -1]
     [#t 0])))

(define (inits str)
  (for/list ([len (range 0 (+ 1 (string-length str)))])
    (substring str 0 len)))

(define (first-basement str)
  (list-index negative?
              (map santa-floor (inits str))))

(define filename (command-line
                  #:args ([filename #f])
                  filename))

(when filename
  (let ([str (file->string filename)])
    (printf "Part 1: ~a~n" (santa-floor str))
    (printf "Part 2: ~a~n" (first-basement str))))
