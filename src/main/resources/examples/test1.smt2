; https://es-static.fbk.eu/people/griggio/misc/smtlib2parser.html
(declare-fun A () Bool)
;;(set-option :print-success false)
(declare-sort U 0)
(declare-fun B (U) Bool)
(declare-fun x () U)
(assert (= A (B x)))
(assert ( not A ))
