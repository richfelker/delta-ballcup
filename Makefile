STLS = ballcupend.stl

OPENSCAD = openscad --export-format binstl

-include config.mak

all: $(STLS)

clean:
	rm -f $(STLS)

%.stl: %.scad
	$(OPENSCAD) -o $@ $<
