# python-local-dev-setup
A dockerized local-dev setup for python environment.

## USAGE 
Run the following command to build the docker img and the container:
```bash
make clean-install-python-dev-setup
```

wait for the logs to complete & attach to the container, and you will have already set up virtual anvironment and poetry installed.
```bash
docker exec -it python-local-dev-setup-python-local-dev-setup-con /bin/bash
```
