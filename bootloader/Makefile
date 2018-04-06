NASM = /usr/bin/nasm
NASM_OPTS = -f bin

all: bootloader pdf

bootloader.asm: bootloader.nw
	notangle -Rbootloader.asm bootloader.nw > bootloader.asm

bootloader: bootloader.asm
	$(NASM) $(NASM_OPTS) bootloader.asm -l bootloader.lst -o bootloader

pdf: bootloader.nw
	nodefs bootloader.nw | sort -u > bootloader.defs
	noweave -indexfrom bootloader.defs -delay bootloader.nw > bootloader.tex
	xelatex -8bit bootloader
	makeindex bootloader.idx
	makeglossaries bootloader
	xelatex -8bit bootloader
	xelatex -8bit bootloader

clean:
	rm -f *.acn
	rm -f *.acr
	rm -f *.alg
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
	rm -f *.tex
	rm -f *.toc
	rm -f *.lst