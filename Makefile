default: help
##
# Project Targets
##
.PHONY: install # Builds and installs symbolic link to the binary
install: build
	@mkdir -p ~/.local/bin
	@ln -sf $(PWD)/app/lichess ~/.local/bin/lichess

build: 
	@./gradlew --warning-mode none shadowJar

##
# Help target
##
.PHONY: help # Shows this help with the descriptions of the targets
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
