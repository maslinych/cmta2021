HOST := cmta
DIR := /var/www/maslinsky/courses/cmta2021/
lectures := $(wildcard slides/*.tex)
slides := $(lectures:.tex=.pdf)
scripts := $(wildcard scripts/*.Rmd)

.ONESHELL:
%.pdf: %.tex
	cd $(@D)
	xelatex $(notdir $<)
	xelatex $(notdir $<)


publish: $(slides) $(scripts)
	scp $(slides) $(HOST):$(DIR)/slides
	scp $(scripts) $(HOST):$(DIR)/scripts
