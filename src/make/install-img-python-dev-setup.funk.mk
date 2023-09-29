# src/make/clean-install-dockers.func.mk
# Keep all (clean and regular) docker install functions in here.

.PHONY: clean-install-python-dev-setup  ## @-> setup the whole local python-dev-setup environment for python no cache
clean-install-python-dev-setup:
	$(call build-img,python-dev-setup,--no-cache,)
	make start-python-dev-setup

.PHONY: install-python-dev-setup  ## @-> setup the whole local python-dev-setup environment for python
install-python-dev-setup:
	$(call build-img,python-dev-setup,,)
	make start-python-dev-setup

.PHONY: build-python-dev-setup  ## @-> setup the whole local python-dev-setup environment for python no cache
build-python-dev-setup:
	$(call build-img,python-dev-setup,--no-cache,)

.PHONY: start-python-dev-setup  ## @-> setup the whole local python-dev-setup environment for python no cache
start-python-dev-setup:
	$(call start-img,python-dev-setup,--no-cache,)

.PHONY: stop-python-dev-setup
stop-python-dev-setup:
	CONTAINER_NAME=python-dev-setup
	$(call stop-and-remove-docker-container)