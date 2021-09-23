HOST := cmta
DIR := /var/www/maslinsky/courses/cmta2021
lectures := $(wildcard slides/*.tex)
slides := $(lectures:.tex=.pdf)
scripts := $(shell git ls-files scripts/*.Rmd)
reader := denny2017preprocessing.pdf
SERVER := rstudio
SERVERDIR := /var/lib/rstudio-server/data/cmta2021

.ONESHELL:
%.pdf: %.tex
	cd $(@D)
	xelatex $(notdir $<)
	xelatex $(notdir $<)


publish: $(slides) $(scripts)
	scp $(slides) $(HOST):$(DIR)/slides
	scp $(scripts) $(HOST):$(DIR)/scripts
	scp $(patsubst %,reader/%,$(reader)) $(HOST):$(DIR)/reader

upload: $(scripts)
	scp $(scripts) $(SERVER):$(SERVERDIR)/scripts/
