REPO=ssh://git@github.com/codayblue/homelab.git
TYPE=clusters
CLUSTER=homecluster
LOCAL_CONTEXT=rancher-desktop

.PHONY: bootstrap generate local
bootstrap: 
	flux bootstrap git \
		--url=$(REPO) \
		--branch=main \
		--private-key-file=secrets/$(CLUSTER) \
		--path=$(TYPE)/$(CLUSTER)

generate:
	@echo "Generating cluster keys..."
	mkdir -p secrets
	ssh-keygen -f secrets/$(CLUSTER)
	@echo "Add pub key to github repo for bootstrapping"
	@cat secrets/$(CLUSTER).pub

local:
	@flux install --context $(LOCAL_CONTEXT)
