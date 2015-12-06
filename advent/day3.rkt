#lang racket

(provide unique-deliveries
         unique-robo-deliveries)

(require racket/match
         racket/cmdline)

(define (next-position current-position direction)
  (match-let ([(cons x y) current-position])
    (match direction
      [#\^ (cons x (+ y 1))]
      [#\v (cons x (- y 1))]
      [#\> (cons (+ x 1) y)]
      [#\< (cons (- x 1) y)]
      [_  current-position])))

(define (delivery-path directions)
  (reverse
   (for/fold ([path '((0 . 0))])
       ([direction (if (list? directions)
                       directions
                       (string->list directions))])
     (cons
      (next-position (car path) direction)
      path))))

(define (unique-deliveries directions)
  (length (remove-duplicates (delivery-path directions))))

(define (split-directions directions)
  (define (loop directions santa robo-santa)
    (match directions
      [(cons direction rest)
       (loop rest (cons direction robo-santa) santa)]
      [_
       (cons santa robo-santa)]))
  (match-let ([(cons santa robo-santa) (loop (string->list directions)
                                             empty
                                             empty)])
    (cons (reverse santa)
          (reverse robo-santa))))

(define (unique-robo-deliveries directions)
  (match-let* ([(cons santa-dirs robo-dirs)
                (split-directions directions)]
               [santa-path (delivery-path santa-dirs)]
               [robo-path (delivery-path robo-dirs)])
    (length (remove-duplicates (append santa-path robo-path)))))

(define filename (command-line
                  #:args ([filename #f])
                  filename))

(when filename
  (let* ([directions (file->string filename)]
         [part1 (unique-deliveries directions)]
         [part2 (unique-robo-deliveries directions)])
    (printf "Part 1: ~a~n" part1)
    (printf "Part 2: ~a~n" part2)))
