.PHONY: do-generate-docker-tasks ## @-> run the generate-docker-provisioning-tasks task
do-generate-docker-tasks:
	docker exec ${PRODUCT}-tf-runner-con ./run -a do_generate_docker_tasks