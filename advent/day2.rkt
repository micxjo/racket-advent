#lang racket

(provide wrapping-paper
         ribbon)

(require racket/cmdline)

(define (sum lst)
  (foldl + 0 lst))

(define (wrapping-paper l w h)
  (let* ([sides (list (* l w) (* w h) (* h l))]
         [area (for/sum ([side sides]) (* side 2))]
         [smallest-side (apply min sides)])
    (+ area smallest-side)))

(define (ribbon l w h)
  (let* ([perimeters (list (+ l l w w)
                           (+ w w h h)
                           (+ h h l l))]
         [min-perimeter (apply min perimeters)]
         [volume (* l w h)])
    (+ min-perimeter volume)))

(define filename (command-line
                  #:args ([filename #f])
                  filename))

(define (split-dimensions line)
  (map string->number (string-split line "x")))

(when filename
  (let* ([lines (file->lines filename)]
         [line-dimensions (map split-dimensions lines)]
         [part1 (for/sum ([dimensions line-dimensions])
                  (apply wrapping-paper dimensions))]
         [part2 (for/sum ([dimensions line-dimensions])
                  (apply ribbon dimensions))])
    (printf "Part 1: ~a~n" part1)
    (printf "Part 2: ~a~n" part2)))
