#!/usr/bin/env bash
#
# The terraform taint command informs Terraform that a particular object has
#  become degraded or damaged. Terraform represents this by marking the object 
# as "tainted" in the Terraform state, and Terraform will propose to replace it 
# in the next plan you create.
# https://developer.hashicorp.com/terraform/cli/commands/taint

do_tf_taint_target(){

  do_log "INFO START ::: provisioning step ${STEP}"
  
  TARGET=${TARGET:?}

  do_tf_header

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"
  backend_config_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.backend-config.tfvars"

  set -e

  echo "running: "
  set -x

  terraform -chdir=${bin_dir} init -backend-config=$backend_config_path -upgrade

  while IFS=',' read -ra TARGETS; do
    for target in "${TARGETS[@]}"; do
      terraform -chdir=${bin_dir} taint -lock=false -allow-missing $target
    done
  done <<< "$TARGET"

  rm -rf ${bin_dir} #&& rm -rf ${modules_tgt_dir}
  set +x

  set +e

  do_simple_log "INFO STOP  ::: provisioning step ${tf_proj}"
  export exit_code=0

}
