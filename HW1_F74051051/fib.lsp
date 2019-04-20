;;run: sbcl --script fib.lsp
(defun fib1 (n)
  (if (< n 2)
  n
  (+ (fib1 (- n 1)) (fib1 (- n 2)))))

(defun fib2 (n)
  (fib-tr n 1 0))

(defun fib-tr (n next result)
  (cond ((= n 0) result)
        (t (fib-tr (- n 1) (+ next result) next))))

; main function
(trace fib1)
(trace fib2)
(format t "Enter an integer: ~%")

(let ((n (read)))
    (format t "fib1(~A)=~A~%~%" n (fib1 n))
    (format t "fib2(~A)=~A~%~%" n (fib2 n))
)
;; see the result
;; (format t "~S~%~S~%" (fib1 6) (fib2 6))


