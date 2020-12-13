(in-package :awols)

(defparameter *ns-instance*
  "urn:org.not.rdf:aws/instance/#")

(defun introspect ()
  "Introspect link-local AWS EC2 metadata into RDF model"
  (let* ((model (jeannie:make-memory-model))
	 (root (#"createResource" model)))
    (transcribe model (index) root)
    model))

(defun transcribe (model items root)
  (loop :for item :in items
	:if (and (consp item) (not (listp (cdr item))))
	  :do (let ((predicate
		      (car item))
		    (object
		      (cdr item)))
		(let ((p
			(#"createProperty" model *ns-instance* predicate))
		      (o
			(#"createTypedLiteral" model object #"XSDDatatype.XSDstring")))
		  (#"add" model
			  (#"createStatement" model root p o))))
	:else
	  :do (let ((sub-resource
		      (#"createResource" model))
		    (sub-predicate
		      (#"createProperty" model *ns-instance* (first item))))
		(#"add" model
			(#"createStatement" model root sub-predicate sub-resource))
		(transcribe model (rest item) sub-resource))))

		
	


		      
