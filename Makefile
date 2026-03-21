EMACS ?= emacs

.PHONY: compile test

compile:
	$(EMACS) -Q --batch -L . -f batch-byte-compile emacs-batteries.el emacs-batteries-early-init.el

test:
	$(EMACS) -Q --batch -L . -L test -l test/emacs-batteries-test.el -f ert-run-tests-batch-and-exit
