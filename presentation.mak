
# where FORMAT is either s5, slidy, slideous, dzslides, or revealjs.
WEB_FORMAT = slidy

build: .FORCE clean presentation_dir html

presentation_dir: .FORCE
	mkdir -p presentation

html: .FORCE
	pandoc -V lang=en -s -t $(WEB_FORMAT) presentation.md -o presentation/index.html
	git add presentation/index.html

pdf: .FORCE
	pandoc -V lang=en -s -t beamer newt-presentation.md -o presentation/presentation.pdf

pptx: .FORCE
	pandoc -V lang=en -s presentation.md -o presentation/presentation.pptx

clean: .FORCE
	if [ -f presentation/index.html ]; then rm presentation/*.html; fi
	if [ -f presentation/presentation.pdf ]; then rm presentation/*.pdf; fi
	if [ -f presentation/presentation.pptx ]; then rm presentation/*.pptx; fi

.FORCE:
