
(define-library (chibi edit-distance)
  (export edit-distance)
  (import (scheme base) (srfi 130))
  (begin
    ;; levenshtein (quadratic time, linear memory)
    (define (edit-distance s1 s2)
      (let* ((len1 (string-length s1))
             (len2 (string-length s2))
             (vec (make-vector (+ len1 1) 0)))
        (do ((i 0 (+ i 1)))
            ((> i len1))
          (vector-set! vec i i))
        (do ((i 1 (+ i 1))
             (sc2 (string-cursor-start s2) (string-cursor-next s2 sc2)))
            ((> i len2)
             (vector-ref vec len1))
          (vector-set! vec 0 i)
          (let ((ch2 (string-ref/cursor s2 sc2)))
            (let lp ((j 1)
                     (sc1 (string-cursor-start s1))
                     (last-diag (- i 1)))
              (when (<= j len1)
                (let ((old-diag (vector-ref vec j))
                      (ch1 (string-ref/cursor s1 sc1)))
                  (vector-set! vec j (min (+ (vector-ref vec j) 1)
                                          (+ (vector-ref vec (- j 1)) 1)
                                          (+ last-diag
                                             (if (eqv? ch1 ch2) 0 1))))
                  (lp (+ j 1)
                      (string-cursor-next s1 sc1)
                      old-diag))))))))))