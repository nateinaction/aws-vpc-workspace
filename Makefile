WORKDIR := /workspace
DOCKER_RUN := docker run --rm -it -w $(WORKDIR)

TERRAFORM_IMAGE := hashicorp/terraform:0.12.23
TERRAFORM_CLOUD_VARS := -v $(HOME)/.terraformrc:/.terraformrc -e "TF_CLI_CONFIG_FILE=/.terraformrc"
TERRAFORM_RUN := $(DOCKER_RUN) -v `pwd`/infrastructure:$(WORKDIR):delegated $(TERRAFORM_CLOUD_VARS) $(TERRAFORM_IMAGE)
INFRASTRUCTURE_ENV ?= dev
TERRAFORM_ENV_PATH := environments/$(INFRASTRUCTURE_ENV)

PACKER_IMAGE := hashicorp/packer:light
AWS_VAULT_ENV_VARS := -e AWS_VAULT -e AWS_DEFAULT_REGION -e AWS_REGION -e AWS_ACCESS_KEY_ID -e AWS_SECRET_ACCESS_KEY -e AWS_SESSION_TOKEN -e AWS_SECURITY_TOKEN
PACKER_RUN := $(DOCKER_RUN) -v `pwd`/image:$(WORKDIR):delegated $(AWS_VAULT_ENV_VARS) $(PACKER_IMAGE)

all: lint setup plan

lint: validate_image_templates lint_terraform

lint_terraform:
	$(TERRAFORM_RUN) fmt

setup:
	$(TERRAFORM_RUN) init $(TERRAFORM_ENV_PATH)

plan:
	$(TERRAFORM_RUN) plan $(TERRAFORM_ENV_PATH)

deploy:
	$(TERRAFORM_RUN) apply $(TERRAFORM_ENV_PATH)

test_ssh_connection:
	ssh -q $(SSH_USERNAME)@$(SSH_DOMAIN) exit

destroy:
	$(TERRAFORM_RUN) destroy $(TERRAFORM_ENV_PATH)

validate_image_templates:
	$(PACKER_RUN) validate base.json
	$(PACKER_RUN) validate workspace.json

build_images: build_image_base build_image_workspace

build_image_base:
	aws-vault exec worldpeace -- $(PACKER_RUN) build base.json

build_image_workspace:
	aws-vault exec worldpeace -- $(PACKER_RUN) build workspace.json
