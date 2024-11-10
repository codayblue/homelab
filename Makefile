REPO=ssh://git@github.com/codayblue/homelab.git
CLUSTER=homecluster

.PHONY: bootstrap generate
bootstrap: 
	flux bootstrap git \
		--url=$(REPO) \
		--branch=main \
		--private-key-file=secrets/$(CLUSTER) \
		--path=clusters/$(CLUSTER)

generate:
	@echo "Generating cluster keys..."
	mkdir -p secrets
	ssh-keygen -f secrets/$(CLUSTER)
	@echo "Add pub key to github repo for bootstrapping"
	@cat secrets/$(CLUSTER).pub
	
