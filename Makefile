HOST := cmta
DIR := /var/www/maslinsky/courses/cmta2021
lectures := $(wildcard slides/*.tex)
slides := $(lectures:.tex=.pdf)
scripts := $(shell git ls-files scripts/*.Rmd)
reader := denny2017preprocessing.pdf The_language_of_Macbeth.pdf bamman2014gender.pdf rule2015shifts.pdf
labs := lab1.pdf lab2.pdf
data := data/topics-data.csv data/diag300.xml
SERVER := rstudio
SERVERDIR := /var/lib/rstudio-server/data/cmta2021


.ONESHELL:
%.pdf: %.tex
	cd $(@D)
	xelatex $(notdir $<)
	xelatex $(notdir $<)


publish: $(slides) $(scripts) $(labs)
	scp $(slides) $(HOST):$(DIR)/slides
	scp $(scripts) $(HOST):$(DIR)/scripts
	scp $(patsubst %,reader/%,$(reader)) $(HOST):$(DIR)/reader
	scp $(labs) $(HOST):$(DIR)/

upload: $(scripts)
	scp $(scripts) $(SERVER):$(SERVERDIR)/scripts/
	scp $(data) $(SERVER):$(SERVERDIR)/data/
