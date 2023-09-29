#!/usr/bin/env bash
#
# The terraform state pull command is used to manually download and output 
# the state from remote state. This command also works with local state.
# https://developer.hashicorp.com/terraform/cli/commands/state/pull
#
# $ ORG=org APP=app ENV=env STEP=000-step make do-tf-state-pull

do_tf_state_pull() {

  do_log "INFO START ::: provisioning step ${STEP}"

  do_tf_header

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"
  backend_config_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.backend-config.tfvars"

  set -e

  echo "running: "
  set -x

  mkdir -p $PRODUCT_DIR/dat/tmp/
  terraform -chdir=${bin_dir} init -backend-config=$backend_config_path -upgrade
  terraform -chdir=${bin_dir} get -update=true && terraform -chdir=${bin_dir} state pull > $PRODUCT_DIR/dat/tmp/${ORG}-${APP}-${ENV}-${tf_proj}-terraform.tfstate
  # rm -rf ${bin_dir} #&& rm -rf ${modules_tgt_dir}

  set +x
  set +e

  do_log "INFO saving terraform state into $PRODUCT_DIR/dat/tmp/${ORG}-${APP}-${ENV}-${tf_proj}-terraform.tfstate"
  do_simple_log "INFO STOP  ::: provisioning step ${tf_proj}"
  export exit_code=0

}
