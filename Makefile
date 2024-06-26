.PHONY: all

datapack_files := $(shell find datapack/)

all: soulcart.zip

soulcart.zip: $(datapack_files)
	cd datapack && zip -r ../$@ *
