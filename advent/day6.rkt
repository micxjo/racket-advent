#lang racket

(provide run-script-part1
         run-script-part2)

(require racket/match
         racket/unsafe/ops
         racket/cmdline)

(define (to-position x)
  (cons (quotient x 1000) (remainder x 1000)))

(define (in-box? index p1 p2)
  (match-let* ([(cons x y) (to-position index)]
               [(cons a b) p1]
               [(cons a2 b2) p2])
    (and (>= x a)
         (<= x a2)
         (>= y b)
         (<= y b2))))

(define (make-box p1 p2)
  (filter (lambda (i) (in-box? i p1 p2))
          (range 0 (* 1000 1000))))

(define (modify! vec box f)
  (for ([i box])
    (unsafe-vector-set! vec i (f (unsafe-vector-ref vec i)))))

(define (run-script! grid lines f1 f2 f3)
  (define (make-pos s1 s2) (cons (string->number s1) (string->number s2)))
  (for ([line lines])
    (match-let* ([(list _ cmd x1 y1 x2 y2)
                  (regexp-match #px"(turn on |turn off |toggle )(\\d+),(\\d+) through (\\d+),(\\d+)" line)]
                 [p1 (make-pos x1 y1)]
                 [p2 (make-pos x2 y2)]
                 [box (make-box p1 p2)])
      (cond
       [(string=? cmd "turn on ")
        (printf "Turning on ~a through ~a~n" p1 p2)
        (modify! grid box f1)]
       [(string=? cmd "turn off ")
        (printf "Turning off ~a through ~a~n" p1 p2)
        (modify! grid box f2)]
       [#t
        (printf "Toggling ~a through ~a~n" p1 p2)
        (modify! grid box f3)]))))

(define (run-script-part1 lines)
  (define grid (make-vector (* 1000 1000) #f))
  (run-script! grid
               lines
               (const #t)
               (const #f)
               not)
  (vector-length (vector-filter identity grid)))

(define (run-script-part2 lines)
  (define grid (make-vector (* 1000 1000) 0))
  (run-script! grid
               lines
               (lambda (x) (+ x 1))
               (lambda (x) (max (- x 1) 0))
               (lambda (x) (+ x 2)))
  (foldl + 0 (vector->list grid)))

(define filename (command-line
                  #:args ([filename #f])
                  filename))

(when filename
  (let* ([lines (file->lines filename)]
         [part1 (run-script-part1 lines)]
         [part2 (run-script-part2 lines)])
    (printf "~nPart 1: ~a~nPart 2: ~a~n" part1 part2)))
