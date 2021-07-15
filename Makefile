terraform-deploy:
	pip3 install --quiet --upgrade pip
	pip3 install --quiet --upgrade --requirement requirements.txt

	terraform -chdir=tf/ init
	terraform -chdir=tf/ validate

	# Terraform create instances first
	terraform -chdir=tf/ plan -out="tfplan" -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars" \
		-target="module.digitalocean" \
		-target="module.onpremise" \
		-target="module.oraclecloud" \
		-target="module.transip" \
		-target="module.vultr"
	terraform -chdir=tf/ apply tfplan

	# Terraform finish
	terraform -chdir=tf/ plan -out="tfplan" -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars"
	terraform -chdir=tf/ apply tfplan

terraform-destroy:
	terraform -chdir=tf/ init
	terraform -chdir=tf/ destroy -auto-approve -var-file="../secrets/credentials.tfvars" -var-file="../secrets/config.tfvars"

terraform-clean:
	rm -Rf tf/.terraform
	rm -f tf/terraform.tfstate
	rm -f tf/terraform.tfstate.backup
	rm -f tf/.terraform.lock.hcl
	rm -f tf/tfplan

terraform: terraform-deploy

ansible-deploy:
	ansible-playbook playbook-deploy.yml

ansible-destroy:
	ansible-playbook playbook-destroy.yml

ansible: ansible-deploy

deploy: terraform-deploy ansible-deploy

backup:
	ansible-playbook playbook-backup.yml

destroy: ansible-destroy terraform-destroy

clean: terraform-clean

full-redeploy: destroy clean deploy
