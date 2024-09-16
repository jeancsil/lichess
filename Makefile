IMAGE_NAME = jeancsil/lichess
VERSION = 1.0.0

default: help

##
# Maintainer Targets
##
.PHONY: build # Builds the Docker image
build:
	@docker build -t $(IMAGE_NAME):$(VERSION) .
	@docker tag $(IMAGE_NAME):$(VERSION) $(IMAGE_NAME):latest

.PHONY: publish # Publishes the Docker image
publish: build
	@docker push $(IMAGE_NAME):$(VERSION)
	@docker push $(IMAGE_NAME):latest
	@echo "Docker image published: $(IMAGE_NAME):$(VERSION) and $(IMAGE_NAME):latest"

##
# Developer Targets
##
.PHONY: install # Installs the Docker-based application
install: build
	@mkdir -p ~/.local/bin
	@sed -e 's|{{IMAGE_NAME}}|$(IMAGE_NAME)|g' -e 's|{{VERSION}}|$(VERSION)|g' lichess.sh > ~/.local/bin/lichess
	@chmod +x ~/.local/bin/lichess
	@echo "Installation complete. The 'lichess' command is now available."

.PHONY: uninstall # Uninstalls the Docker-based application
uninstall:
	@rm -f ~/.local/bin/lichess
	@docker rmi $(IMAGE_NAME):$(VERSION) 2>/dev/null || true
	@docker rmi $(IMAGE_NAME):latest 2>/dev/null || true
	@echo "Uninstallation complete. The 'lichess' command has been removed."

##
# Help target
##
.PHONY: help # Shows this help with the descriptions of the targets
help:
	@grep '^.PHONY: .* #' Makefile | sed 's/\.PHONY: \(.*\) # \(.*\)/\1	\2/' | expand -t20
