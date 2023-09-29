#!/usr/bin/env bash
#
# The terraform state list command is used to list resources within a Terraform state.
# https://developer.hashicorp.com/terraform/cli/commands/state/list
# 
# $ ORG=org APP=app ENV=env STEP=000-step make do-tf-state-list
# aws_instance.foo
# aws_instance.bar[0]
# aws_instance.bar[1]
# module.elb.aws_elb.main

do_tf_state_list(){

  do_log "INFO START ::: provisioning step ${STEP}"

  do_tf_header

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"
  backend_config_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.backend-config.tfvars"

  set -e ; echo "running: " ; set -x

  terraform -chdir=${bin_dir} init -backend-config=$backend_config_path -upgrade
  terraform -chdir=${bin_dir} get -update=true && terraform -chdir=${bin_dir} state list

  rm -rf ${bin_dir} #&& rm -rf ${modules_tgt_dir}
  set +x
  set +e

  do_simple_log "INFO STOP  ::: provisioning step ${tf_proj}"
  export exit_code=0

}
