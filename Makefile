terraform:
	pip3 install --quiet --upgrade pip
	pip3 install --quiet --upgrade --requirement requirements.txt

	terraform init tf
	terraform validate tf

	terraform plan -var-file="secrets/providers.tfvars" -var-file="secrets/config.tfvars" tf

	terraform apply -var-file="secrets/providers.tfvars" -var-file="secrets/config.tfvars" -auto-approve tf

deploy:
	pip3 install --quiet --upgrade pip
	pip3 install --quiet --upgrade --requirement requirements.txt

	terraform init tf
	terraform validate tf

	terraform plan -var-file="secrets/providers.tfvars" -var-file="secrets/config.tfvars" tf

	terraform apply -var-file="secrets/providers.tfvars" -var-file="secrets/config.tfvars" -auto-approve tf

	ansible-playbook playbook-deploy.yml

backup:
	ansible-playbook playbook-backup.yml

destroy:
	terraform init tf

	ansible-playbook playbook-destroy.yml

	terraform destroy -var-file="secrets/providers.tfvars" -var-file="secrets/config.tfvars" -auto-approve tf

force-destroy:
	terraform init tf

	terraform destroy -var-file="secrets/providers.tfvars" -var-file="secrets/config.tfvars" -auto-approve tf

clean:
	rm -Rf .terraform
	rm -f terraform.tfstate
	rm -f terraform.tfstate.backup
	rm -f .terraform.lock.hcl

clean-redeploy:
	pip3 install --quiet --upgrade pip
	pip3 install --quiet --upgrade --requirement requirements.txt

	terraform init tf

	ansible-playbook playbook-destroy.yml

	terraform destroy -var-file="secrets/providers.tfvars" -var-file="secrets/config.tfvars" -auto-approve tf

	rm -Rf .terraform
	rm -f terraform.tfstate
	rm -f terraform.tfstate.backup
	rm -f .terraform.lock.hcl

	terraform init tf
	terraform validate tf

	terraform plan -var-file="secrets/providers.tfvars" -var-file="secrets/config.tfvars" tf

	terraform apply -var-file="secrets/providers.tfvars" -var-file="secrets/config.tfvars" -auto-approve tf

	ansible-playbook playbook-deploy.yml
