;;run: sbcl --script palindrome.lsp
;; return "T" or "NIL"
;; "T" means palindrome
;; "NIL" means not palindrome
(defun palindrome (l)
  (equal l (reverse l)))

(format t "palindrome(l) will return T if lst is a palindrome,or returing NIL.~%")
(format t "Enter a list: ~%")

(let ((lst (read)))
    (format t "~A~%" (palindrome lst))
)
;; see the result
;; (format t "~S~%" (palindrome '(cat dog bird bird dog cat)))