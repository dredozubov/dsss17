all: nix

nix:
	nix-build

shell: nix
	./result/bin/load-env-dsss17

install:
	nix-env -iA nixpkgs.dsss17.options.build

pull:
	docker pull jwiegley/dsss17

run:
	docker run -v $(PWD)/work:/home/nix/work -ti jwiegley/dsss17

build:
	docker build -t jwiegley/dsss17 .

push: build
	docker push jwiegley/dsss17

pierce: nix
	for d in SF/lf SF/vfa compiler vminus Stlc; do \
	  ./result/bin/load-env-dsss17 make -C work/pierce/$$d; \
	done
