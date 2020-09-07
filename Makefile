deploy:
	pip3 install --quiet --upgrade pip
	pip3 install --quiet --upgrade --requirement requirements.txt

	terraform init
	terraform validate

	terraform plan \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}"

	terraform apply \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}" \
		-auto-approve

	sleep 20

	ansible \
		--forks 1 \
		--module-name ping \
		all

	ansible-playbook deploy.yml

destroy:
	terraform init

	ansible-playbook destroy.yml

	terraform destroy \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}" \
		-auto-approve

force-destroy:
	terraform init

	terraform destroy \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}" \
		-auto-approve

clean:
	rm -Rf .terraform
	rm -Rf fetch
	rm -f terraform.tfstate
	rm -f terraform.tfstate.backup

clean-rebuild:
	terraform init

	ansible-playbook destroy.yml

	terraform destroy \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}" \
		-auto-approve

	rm -Rf .terraform
	rm -Rf fetch
	rm -f terraform.tfstate
	rm -f terraform.tfstate.backup

	pip3 install --quiet --upgrade pip
	pip3 install --quiet --upgrade --requirement requirements.txt

	terraform init
	terraform validate

	terraform plan \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}"

	terraform apply \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}" \
		-auto-approve

	sleep 10

	ansible \
		--forks 1 \
		--module-name ping \
		all

	ansible-playbook deploy.yml
