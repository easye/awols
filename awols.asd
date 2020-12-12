;;; -*- Mode: LISP; Syntax: COMMON-LISP -*-
#-abcl (error "You need the Bear for this one")
(defsystem "awols"
  :version "0.1.0"
  :author "Mark Evenson"
  :license "BSD 2-CLAUSE"
  :depends-on (dexador
	       jeannie)
  :components ((:module package
			:pathname "src/"
		:components ((:file "package")))
	       (:module "src"
		:pathname "src/"
		:depends-on (package)
                :components ((:file "main"))))
  :description "Introspecting AWS endpoints into RDF"
  :in-order-to ((test-op (test-op "awols/t"))))

(defsystem "awols/t"
  :defsystem-depends-on (prove-asdf)
  :depends-on (awols
              prove)
  :components ((:module "t"
                :components
                ((:test-file "main"))))
  :description "Test system for awols"
  :perform (test-op (op c) (symbol-call :prove :run c)))
