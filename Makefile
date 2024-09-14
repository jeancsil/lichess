default: help
##
# Project Targets
##
.PHONY: build # Build the full project: Runs mvn-clean mvn-build docker-build and docker-up
build: 
	@./gradlew --warning-mode none shadowJar

##
# Help target
##
.PHONY: help # Shows this help with the descriptions of the targets
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
