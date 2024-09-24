IMAGE_NAME = jeancsil/lichess
VERSION = 1.1.0

default: help

##
# Maintainer Targets
##
.PHONY: build # Builds the Docker image
build:
	@if ! docker buildx inspect multiarch-builder > /dev/null; then \
		docker buildx create --use --name multiarch-builder; \
	fi
	@docker buildx inspect --bootstrap
	@docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_NAME):$(VERSION) .

.PHONY: publish # Publishes the Docker image
publish:
	@docker buildx build --platform linux/amd64,linux/arm64 -t $(IMAGE_NAME):$(VERSION) --push .
	@docker buildx imagetools create $(IMAGE_NAME):$(VERSION) -t $(IMAGE_NAME):latest
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
