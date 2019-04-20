(defvar in)
(defvar in2)
(defvar list1)
(defvar list2)

(setq list1 ())
(setq list2 ())

(setq in (open "./file2.txt"))
(setq in2 (open "./file1.txt"))

(loop for line = (read-line in nil nil)
  while line
  do (push line list1))

(loop for line = (read-line in2 nil nil)
  while line
  do (push line list2))

(setq list1 (reverse list1))
(setq list2 (reverse list2))

;; (print list1)
;; (print list2)
(defvar plus)
(setq plus ())
(defvar traversal)
(defvar list_same)
(defvar list2_print)
(setq list2_print ())
(defvar compare)
(defvar compare_str)
(setq compare_str nil)
(do
    ((traversal (pop list1) (pop list1)))
    ((null traversal))
    (setq compare 0)
    (loop
        (setq compare_str (nth compare list2))
        (when (eq compare_str nil)  (return nil))
        (when (equal compare_str traversal) (return nil))
        (when (not (equal compare_str traversal)) (push compare_str list2_print))
        (when (<= compare (length list2)) (setq compare (+ compare 1)))
    )

    (setq list2_print (reverse list2_print))

    (when (and (not (null list2_print)) (equal compare_str traversal))
      (loop for print_str in list2_print do (format t "-~a~%" print_str))
      (when (not (null plus))
      (setq plus (reverse plus))
      (loop for print_str in plus do (format t "+~a~%" print_str))
      (setq plus ())
      ))
    (when (not (equal compare_str traversal)) (push traversal plus))
    (setq list2_print ())
    (when (equal compare_str traversal) (format t "~a~%" traversal)
      (setq list2 (append list2_print (nthcdr (+ compare 1) list2))));刪除list2
)
(when (not (null list2))
    (loop for print_str in list2 do (format t "-~a~%" print_str))
)