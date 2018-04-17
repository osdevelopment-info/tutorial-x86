NASM = /usr/bin/nasm
NASM_OPTS = -f bin

all: floppy pdf

floppy: bootloader dummypayload
	cat bootloader dummypayload > floppy
	./makebootfloppy.sh floppy

bootloader.asm: bootloader.nw
	notangle -Rbootloader.asm bootloader.nw > bootloader.asm

bootloader: bootloader.asm
	$(NASM) $(NASM_OPTS) bootloader.asm -l bootloader.lst -o bootloader

dummypayload.asm: bootloader.nw
	notangle -Rdummypayload.asm bootloader.nw > dummypayload.asm

dummypayload: dummypayload.asm
	$(NASM) $(NASM_OPTS) dummypayload.asm -l dummypayload.lst -o dummypayload

pdf: bootloader.nw
	nodefs bootloader.nw | sort -u > bootloader.defs
	noweave -indexfrom bootloader.defs -delay bootloader.nw > bootloader.tex
	xelatex -8bit bootloader
	makeindex bootloader.idx
	makeglossaries bootloader
	xelatex -8bit bootloader
	xelatex -8bit bootloader

clean:
	rm -f dummypayload floppy
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
