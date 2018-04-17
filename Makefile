NASM = /usr/bin/nasm
NASM_OPTS = -f bin

all: pdf

pdf: tutorial.nw
	nodefs tutorial.nw | sort -u > tutorial.defs
	noweave -indexfrom tutorial.defs -delay tutorial.nw > tutorial.tex
	xelatex -8bit tutorial
	#makeindex -o tutorial.ind tutorial.idx
	#makeindex -o ins.ind ins.idx
	splitindex tutorial.idx
	makeglossaries tutorial
	xelatex -8bit tutorial
	xelatex -8bit tutorial

clean:
	rm -f *~
	rm -f *.acn
	rm -f *.acr
	rm -f *.alg
	rm -f *.asm
	rm -f *.aux
	rm -f *.defs
	rm -f *.glg
	rm -f *.glo
	rm -f *.gls
	rm -f *.glsdefs
	rm -f *.idx
	rm -f *.ilg
	rm -f *.ind
	rm -f *.ins-glg
	rm -f *.ins-glo
	rm -f *.ins-gls
	rm -f *.ist
	rm -f *.log
	rm -f *.out
	rm -f *.pdf
	rm -f *.tex
	rm -f *.toc
	rm -f *.lst
