#!/usr/bin/env bash
# The terraform state push command is used to manually upload a local state file to remote state. 
# This command also works with local state.
# https://developer.hashicorp.com/terraform/cli/commands/state/push
# 
# $ ORG=org APP=app ENV=env STEP=000-step TFSTATE_FILE=./terraform.tfstate make do-tf-state-push

do_tf_state_push(){

  do_log "INFO START ::: provisioning step ${STEP}"

  TFSTATE_FILE=${TFSTATE_FILE:?}
  
  do_tf_header

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"
  backend_config_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.backend-config.tfvars"

  set -e

  echo "running: "
  set -x

  terraform -chdir=${bin_dir} init -backend-config=$backend_config_path -upgrade
  terraform -chdir=${bin_dir} get -update=true && terraform -chdir=${bin_dir} state push -lock=false ${PRODUCT_DIR}/${TFSTATE_FILE}
  rm -rf ${bin_dir} #&& rm -rf ${modules_tgt_dir}

  set +x
  set +e

  do_simple_log "INFO STOP  ::: provisioning step ${tf_proj}"
  export exit_code=0

}
