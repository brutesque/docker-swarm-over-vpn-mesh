deploy:
	pip3 install --upgrade pip
	pip3 install --upgrade -r requirements.txt

	terraform init
	terraform validate

	terraform plan \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}"

	terraform apply \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}" \
		-auto-approve

	ansible \
		--forks 1 \
		--module-name ping \
		all

	ansible-playbook playbook.yml

destroy:
	terraform init

	terraform destroy \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}" \
		-auto-approve

clean:
	rm -Rf .terraform fetch terraform.tfstate terraform.tfstate.backup
