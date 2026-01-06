# ----[ VARIABLES ]---------------------------------------------------------------------------------
OUTDIR     ?= out
SRCDIR     ?= pisnicky

TITLEFILE   = titleidx.sbx
AUTHORFILE  = authidx.sbx

SONGBOOK    = zpevnik

# ----[ TARGETS ]-----------------------------------------------------------------------------------

.PHONY: all clean


all: $(OUTDIR)/$(SONGBOOK).pdf

clean:
	rm -rf $(OUTDIR)


# ----[ TARGETS ]-----------------------------------------------------------------------------------
$(OUTDIR):
	mkdir $@

$(OUTDIR)/$(TITLEFILE) $(OUTDIR)/$(AUTHORFILE) &: $(SRCDIR) | $(OUTDIR)
	python3 ./akordy/maketoc.py $(SRCDIR) $(OUTDIR)/$(TITLEFILE) $(OUTDIR)/$(AUTHORFILE)

$(OUTDIR)/$(SONGBOOK).tex: $(SRCDIR) | $(OUTDIR)
	python3 ./akordy/merge.py $(SRCDIR) $@

$(OUTDIR)/$(SONGBOOK).pdf: $(OUTDIR)/$(SONGBOOK).tex $(OUTDIR)/$(TITLEFILE) $(OUTDIR)/$(AUTHORFILE) | $(OUTDIR)
	cd $(OUTDIR) && latex $(SONGBOOK).tex
	cd $(OUTDIR) && latex $(SONGBOOK).tex
	cd $(OUTDIR) && pdflatex $(SONGBOOK).tex

