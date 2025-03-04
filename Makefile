SRC := $(wildcard /replays/*.wowsreplay)
MP4 := $(SRC:.wowsreplay=.mp4)

all: $(MP4)

%.mp4: %.wowsreplay
	@echo "Converting $< to $@"
	@python -m render --replay $<
