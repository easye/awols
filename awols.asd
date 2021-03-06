;;; -*- Mode: LISP; Syntax: COMMON-LISP -*-
(defsystem awols
  :version "0.1.1"
  :author "Mark Evenson"
  :license "BSD 2-CLAUSE"
  :depends-on (dexador)	       
  :components ((:module package
			:pathname "src/"
		:components ((:file "package")))
	       (:module "src"
		:pathname "src/"
		:depends-on (package)
                :components ((:file "main"))))
  :description "Introspecting AWS endpoints."
  :in-order-to ((test-op (test-op "awols/t"))))

;;; This part needs ABCL to use Apache JENA
(defsystem awols/rdf
  :depends-on (awols
	       jeannie) ;; <git+https://github.com/easye/jeannie.git>
  :components ((:module main
		:pathname "src/"
		:components ((:file "rdf")))))

(defsystem awols/t
  :defsystem-depends-on (prove-asdf)
  :depends-on (awols
	       #+abcl
	       awols/rdf
               prove)
  :components ((:module "t"
                :components ((:test-file "main")
			     #+abcl
			     (:test-file "model"))))

  :description "Test system for awols"
  :perform (test-op (op c) (symbol-call :prove :run c)))
