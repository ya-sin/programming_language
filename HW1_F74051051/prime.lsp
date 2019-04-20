;;run: sbcl --script prime.lsp
;; return "true" or "false"
;; "true" means a prime
;; "false" means not a prime
(defvar i)
(defun prime (n)
  (setq i 5)
  (cond
    ((<= n 1) (return-from prime "false"))
    ((<= n 3) (return-from prime "true"))
    ((or (= (rem n 2) 0) (= (rem n 3) 0)) (return-from prime "false"))
  )
  (do ((i 5 (+ 6 i))) ((> (* i i ) n))
        (if (or (= (rem n i) 0) (= (rem n (+ i 2)) 0))
            (return-from prime "false")
            ))
  (return-from prime "true")

)
(format t "prime(n) will return true if n is a prime,or returning false.~%")
(format t "Enter an integer: ~%")

(let ((n (read)))
    (format t "~A~%" (prime n))
)
;; see the result
;; (format t "~S~%" (prime 999))

;; (write(prime 2))
;; (write(prime 239))
;; (write(prime 999))
;; (write(prime 17))
