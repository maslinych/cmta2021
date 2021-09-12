HOST := cmta
DIR := /var/www/maslinsky/courses/cmta2021/
lectures := $(wildcard slides/*.tex)
slides := $(lectures:.tex=.pdf)

%.pdf: %.tex
	xelatex $<
	xelatex $<


publish: $(slides)
	scp $(slides) $(HOST):$(DIR)/slides
