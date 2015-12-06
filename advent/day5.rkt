#lang racket

(provide is-nice?)

(require srfi/1
         srfi/13
         racket/match)

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
