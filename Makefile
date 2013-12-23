# -*- makefile-gmake -*-
# To compile with coq 8.3, run "make VERSION=8.3".  That will prevent using unknown command line options.
VERSION = 8.4
ifeq ("$(VERSION)","8.4")
OTHERFLAGS += -indices-matter
# compiling uu0 takes 32 seconds with sharing and 20 seconds with no-sharing, using a patched coq 8.4
# using Matthieu's polyproj branch, it takes 600 seconds with sharing before it crashes on line 2914, but only 15 seconds without sharing
OTHERFLAGS += -no-sharing
# OTHERFLAGS += -verbose
else
endif
COQDEFS := --language=none -r '/^[[:space:]]*\(Axiom\|Theorem\|Class\|Instance\|Let\|Ltac\|Definition\|Lemma\|Record\|Remark\|Structure\|Fixpoint\|Fact\|Corollary\|Let\|Inductive\|Coinductive\|Proposition\)[[:space:]]+\([[:alnum:]_]+\)/\2/'
include Make.makefile
COQC := time $(COQC)
TAGS : $(VFILES); etags $(COQDEFS) $^
clean:clean2
clean2:
	rm -f TAGS
	find . \( -name \*.o -o -name \*.cmi -o  -name \*.cmx -o -name \*.cmxs -o -name \*.native \) -delete
