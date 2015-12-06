#lang racket

(provide first-hash)

(require openssl/md5)

(define (my-string-prefix? str prefix)
  (regexp-match (regexp (string-append "^" prefix)) str))

(define (hash str num)
  (md5 (open-input-string (string-append str (number->string num)))))

(define (first-hash prefix search-prefix)
  (define (loop num)
    (if (my-string-prefix? (hash prefix num) search-prefix)
        num
        (loop (+ num 1))))
  (loop 1))

(define prefix (command-line
                #:args ([prefix #f])
                prefix))

(when prefix
  (printf "Part 1: ~a~n" (first-hash prefix "00000"))
  (printf "Part 2: ~a~n" (first-hash prefix "000000")))
