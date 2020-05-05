
deploy:
	pip3 install --upgrade pip
	pip3 install --upgrade -r requirements.txt

	terraform init
	terraform validate

	terraform plan \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}" \
		-var "pub_key=$HOME/.ssh/id_rsa.pub" \
		-var "pvt_key=$HOME/.ssh/id_rsa"

	terraform apply \
		-var "do_token=${DO_TOKEN}" \
		-var "vultr_token=${VULTR_TOKEN}" \
		-var "pub_key=$HOME/.ssh/id_rsa.pub" \
		-var "pvt_key=$HOME/.ssh/id_rsa" \
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
		-var "pub_key=$HOME/.ssh/id_rsa.pub" \
		-var "pvt_key=$HOME/.ssh/id_rsa" \
		-auto-approve
