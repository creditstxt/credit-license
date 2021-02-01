format=fmt -u -w60
remove_comments=fgrep -v "<!--"

all: build/license.md build/add-on.md build/license.pdf build/add-on.pdf

build/license.md: license.md | build
	$(remove_comments) $< | $(format) > $@

build/add-on.md: add-on-header.md license.md | build
	cp add-on-header.md $@
	awk '/Start Extraction/,/End Extraction/' license.md | $(remove_comments) | $(format) >> $@

build/%.pdf: build/%.md
	pandoc -V fontsize=12pt -o $@ $<

build:
	mkdir -p build

.PHONY: clean

clean:
	rm -rf build
