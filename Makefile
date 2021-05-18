terraform:
	pip3 install --quiet --upgrade pip
	pip3 install --quiet --upgrade --requirement requirements.txt

	terraform -chdir=tf/ init
	terraform -chdir=tf/ validate

	terraform -chdir=tf/ plan -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars"

	terraform -chdir=tf/ apply -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars" -auto-approve

deploy:
	pip3 install --quiet --upgrade pip
	pip3 install --quiet --upgrade --requirement requirements.txt

	terraform -chdir=tf/ init
	terraform -chdir=tf/ validate

	terraform -chdir=tf/ plan -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars"

	terraform -chdir=tf/ apply -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars" -auto-approve

	ansible-playbook playbook-deploy.yml

backup:
	ansible-playbook playbook-backup.yml

destroy:
	terraform -chdir=tf/ init

	ansible-playbook playbook-destroy.yml

	terraform -chdir=tf/ destroy -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars" -auto-approve

terraform-destroy:
	terraform -chdir=tf/ init

	terraform -chdir=tf/ destroy -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars" -auto-approve

clean:
	rm -Rf tf/.terraform
	rm -f tf/terraform.tfstate
	rm -f tf/terraform.tfstate.backup
	rm -f tf/.terraform.lock.hcl

clean-redeploy:
	pip3 install --quiet --upgrade pip
	pip3 install --quiet --upgrade --requirement requirements.txt

	terraform -chdir=tf/ init

	ansible-playbook playbook-destroy.yml

	terraform -chdir=tf/ destroy -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars" -auto-approve

	rm -Rf tf/.terraform
	rm -f tf/terraform.tfstate
	rm -f tf/terraform.tfstate.backup
	rm -f tf/.terraform.lock.hcl

	terraform -chdir=tf/ init
	terraform -chdir=tf/ validate

	terraform -chdir=tf/ plan -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars"

	terraform -chdir=tf/ apply -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars" -auto-approve

	ansible-playbook playbook-deploy.yml
