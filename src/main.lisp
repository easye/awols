(in-package :awols)

(defparameter *root*
  "http://169.254.169.254/latest/meta-data/")

(defparameter *verbose*
  *standard-output*)

(defun representation-of (uri)
  (handler-case 
      (dex:get uri)
    (dexador.error:http-request-not-found (e)
      (format *verbose* "~a" e)
      :404)
    (t (e)
       (format *verbose* "~a" e)
       :unhandled-error)))

(defun index (&key (uri *root*))
  (let ((endpoints (representation-of uri)))
    (loop :for item :in (split-sequence:split-sequence #\newline endpoints)
	  :if (eq #\/ (char item (1- (length item))))
	    :collect (index :uri (concatenate 'string uri item))
	  :else 
	    :collect `(,item . ,(representation-of (concatenate 'string uri item))))))


						       
    
