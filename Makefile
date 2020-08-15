.PHONY: all

datapack_files := $(shell find datapack/)

all: faster-carts.zip

faster-carts.zip: $(datapack_files)
	cd datapack && zip -r ../$@ *
