ALLSRC := $(wildcard $(REPLAYDIR)/*.wowsreplay)
ALLMP4 := $(ALLSRC:.wowsreplay=.mp4)
TMPSRC := $(REPLAYDIR)/tmp.wowsreplay
TMPMP4 := $(TMPSRC:.wowsreplay=.mp4)

pipe: $(TMPMP4)
	@cat $<

all: $(ALLMP4)

$(TMPSRC):
	@cat -> $@

%.mp4: %.wowsreplay
	@echo "Converting $< to $@" 1>&2
	@python -m render --replay $<
