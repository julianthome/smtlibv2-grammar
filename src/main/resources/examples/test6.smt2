; https://es-static.fbk.eu/people/griggio/misc/smtlib2parser.html
(declare-sort S 1)
(define-sort SB () (S Bool))
(declare-fun A () (S Bool))
(declare-fun B () SB)
(assert (= A B)) 
(check-sat)
(exit)