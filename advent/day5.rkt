#lang racket

(provide is-nice?
         is-nice-2?)

(require srfi/1
         srfi/13
         racket/match
         racket/cmdline)

(define (is-vowel? c)
  (find (lambda (x) (eqv? x c))
        '(#\a #\e #\i #\o #\u)))

(define (bigrams lst)
  (define (loop lst acc)
    (match lst
      [(cons a (cons b rest))
       (loop (cons b rest)
             (cons (cons a b) acc))]
      [_ acc]))
  (reverse (loop lst empty)))

(define (trigrams lst)
  (define (loop lst acc)
    (match lst
      [(cons a (cons b (cons c rest)))
       (loop (cons b (cons c rest))
             (cons (list a b c) acc))]
      [_ acc]))
  (reverse (loop lst empty)))

(define (is-nice? str)
  (let* ([lst (string->list str)]
         [vowel-count (length (filter is-vowel? lst))]
         [has-good-bigram (ormap (lambda (b) (eqv? (car b) (cdr b)))
                                 (bigrams lst))]
         [bad-strings '("ab" "cd" "pq" "xy")]
         [has-bad-string (ormap (lambda (s) (string-contains str s))
                                bad-strings)])
    (and (>= vowel-count 3)
         has-good-bigram
         (not has-bad-string))))

(define (is-good-trigram? lst)
  (match lst
    [(list a _ a) #t]
    [_ #f]))

(define (is-nice-2? str)
  (let* ([lst (string->list str)]
         [has-good-bigram (regexp-match #px"(..).*\\1" str)]
         [has-good-trigram (ormap is-good-trigram?
                                  (trigrams lst))])
    (and has-good-bigram has-good-trigram)))

(define filename (command-line
                  #:args ([filename #f])
                  filename))

(when filename
  (let* ([lines (file->lines filename)]
         [part1 (length (filter is-nice? lines))]
         [part2 (length (filter is-nice-2? lines))])
    (printf "Part 1: ~a~nPart 2: ~a~n" part1 part2)))
