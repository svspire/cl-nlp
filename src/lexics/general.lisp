;;; (c) 2015-2016 Vsevolod Dyomkin

(in-package #:nlp.lexics)
(named-readtables:in-readtable rutilsx-readtable)


;;; Basic classes

(defclass dict ()
  ()
  (:documentation
   "A dictionary."))

(defclass stemmer ()
  ()
  (:documentation
   "A generic stemmer."))

(defclass lemmatizer ()
  ()
  (:documentation
   "A generic lemmatizer."))


;;; Core API

(defgeneric lookup (dict word)
  (:documentation
   "Lookup WORD in DICT.")
  (:method ((dict hash-table) word)
    (get# word dict)))

(defgeneric pos-tags (dict word)
  (:documentation
   "Get WORD pos tags from DICT.")
  (:method (dict word)
    (error 'not-implemented-error)))

(defgeneric stem (stemmer word)
  (:documentation
   "Stemmize WORD string with a STEMMER."))

(defgeneric lemmatize (lemmatizer word &optional pos)
  (:documentation
   "Lemmatize WORD (with optionally specified POS tag) string with a LEMMATIZER."))

(defun morph (lemmatizer word pos)
  "Change WORD form to a desired POS tag using LEMMATIZER."
  (when (lookup @lemmatizer.dict word)
    (if (member pos (pos-tags word))
        word
        (lemmatize lemmatizer (lemmatize lemmatizer word) pos))))

;;; utilities

(defun word/pos (word &optional pos)
  "Stringify WORD with its POS tag."
  (fmt "~A~@[/~{~A~^:~}~]" word (mklist pos)))
