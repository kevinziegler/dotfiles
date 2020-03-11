;;; ~/.doom.d/scratch.el -*- lexical-binding: t; -*-

(setq items '("foo" "bar" "baz"))
(setq counts (mapcar (lambda (word) (length word)) items))
