VIDEOWIDTH = 720
BG_HEIGHT  = 1080
BG_QUALITY = 85
COL_WIDTH  = 600

VIDEOS = video/poemeltje.jpg video/poemeltje.mp4
LOGOS = img/logo.png img/logo.ico
ACHTERGRONDEN = bg/handen.jpg bg/astrid-hek.jpg bg/boog.jpg bg/op-bankje.jpg \
		bg/in-gras.jpg bg/radslag.jpg
FOTOS = img/concept-mastery-verandering.jpg img/sm-de.jpg
TEKENINGEN_BREED = img/ezelsbrug.png img/gids.png img/trein.png \
		img/perron.png img/jongen-in-trein.png img/ron-davis.png \
		img/out-of-the-box.png img/peinzende-kinderen.png
ZELFDE_GROOTTE = img/rietje.png img/rechthoek.png img/cirkel.png img/half.png \
		img/breuk.png img/eentweede.png img/nulkommavijf.png \
		img/vijftigprocent.png img/taartje.png
TEKENINGEN = img/kind.png img/sherpa.png img/boot.png img/boot-lang.png \
		img/taal-en-beeld.png img/jongetje-denken.png img/groei.png \
		img/in-de-verte.png \
		$(ZELFDE_GROOTTE) $(TEKENINGEN_BREED)

all: $(VIDEOS) $(LOGOS) $(ACHTERGRONDEN) $(FOTOS) $(TEKENINGEN) tidy.html

video/poemeltje.jpg: originelen/poemeltje.mp4
	ffmpeg -i "$<" -vframes 1 -vf scale=$(VIDEOWIDTH):-2 -q:v 1 "$@"

video/poemeltje.mp4: originelen/poemeltje.mp4
	ffmpeg -i "$<" -c:v libx264 -pix_fmt yuv420p -profile:v baseline -level 3.0 -crf 22 -preset veryslow -vf scale=$(VIDEOWIDTH):-2 -an -movflags +faststart "$@"

img/logo.png: svg/tools2c-logo.svg
	inkscape --without-gui "$<" -w 180 -o "$@"

img/logo.ico: img/logo.png
	convert "$<" -resize x64 -flatten -colors 256 -background transparent "$@"

bg/handen.jpg: originelen/Aerin-handen.jpg
bg/astrid-hek.jpg: originelen/IMG_20200508_174605.jpg
bg/boog.jpg: originelen/IMG_20200508_171320.jpg
bg/op-bankje.jpg: originelen/Aerin-op-bankje.jpg
bg/in-gras.jpg: originelen/Aerin-in-gras.jpg
bg/radslag.jpg: originelen/radslag.jpg
$(ACHTERGRONDEN):
	convert "$<" -resize x$(BG_HEIGHT) -quality $(BG_QUALITY) "$@"

img/concept-mastery-verandering.jpg: originelen/Concept\ Mastery\ Verandering.jpg
img/sm-de.jpg: originelen/Astrid\ Toorop\ SM\ de.jpg
$(FOTOS):
	convert "$<" -resize $(COL_WIDTH)x -quality $(BG_QUALITY) "$@"

img/kind.png: originelen/jongetje\ dun.png
	convert "$<" -scale 100 -quality 91 -depth 4 -colorspace gray "$@"

img/sherpa.png: originelen/sherpa\ dun.png
	convert "$<" -scale 170 -quality 91 -depth 4 -colorspace gray "$@"

img/boot.png: originelen/boot.png
	convert "$<" -scale 270 -quality 91 -depth 4 -colorspace gray "$@"

img/boot-lang.png: originelen/boot\ lang.png
	convert "$<" -scale 330 -quality 91 -depth 4 -colorspace gray "$@"

img/taal-en-beeld.png: originelen/Taal-en-beeld.png
	convert "$<" -scale 300 -quality 91 -depth 4 -colorspace gray "$@"

img/jongetje-denken.png: originelen/jongetje-denken.png
	convert "$<" -scale 300 -quality 91 -depth 4 -colorspace gray "$@"

img/groei.png: originelen/groei.png
	convert "$<" -quality 91 -depth 4 -colorspace gray "$@"

img/in-de-verte.png: originelen/In\ de\ verte\ tekening.png
	convert "$<" -scale 250 -quality 91 -depth 4 -colorspace gray "$@"

img/ezelsbrug.png: originelen/ezelsbrug.png
img/gids.png: originelen/gids.png
img/trein.png: originelen/trein.png
img/perron.png: originelen/perron\ 2.png
img/jongen-in-trein.png: originelen/trein\ jongen.png
img/ron-davis.png: originelen/ron\ davis.jpg
img/out-of-the-box.png: originelen/out\ of\ the\ box.png
img/peinzende-kinderen.png: originelen/peinzende\ kinderen.png
$(TEKENINGEN_BREED):
	convert "$<" -scale $(COL_WIDTH) -quality 91 -depth 4 -colorspace gray "$@"

$(ZELFDE_GROOTTE):
	convert "$(subst img/,originelen/,$@)" -quality 91 -depth 4 -colorspace gray "$@"

tidy: tidy.html
tidy.html: index.html
	tidy --drop-proprietary-attributes no --drop-empty-elements no $< > $@ || true
