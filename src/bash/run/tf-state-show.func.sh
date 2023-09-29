#!/usr/bin/env bash
#
# The terraform state show command is used to show the attributes of a single resource in the Terraform state.
# https://developer.hashicorp.com/terraform/cli/commands/state/show
#
# $ ORG=org APP=app ENV=env STEP=000-step TARGET=packet_device.worker make do-tf-state-show
#
# packet_device.worker:
# resource "packet_device" "worker" {
#     billing_cycle = "hourly"
#     created       = "2015-12-17T00:06:56Z"
#     facility      = "ewr1"
#     hostname      = "prod-xyz01"
#     id            = "6015bg2b-b8c4-4925-aad2-f0671d5d3b13"
#     locked        = false
# }

do_tf_state_show(){

  do_log "INFO START ::: tf state show - step ${STEP}"

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
      terraform -chdir=${bin_dir} get -update=true && terraform -chdir=${bin_dir} state show ${target}
    done
  done <<< "$TARGET"

  rm -rf ${bin_dir} #&& rm -rf ${modules_tgt_dir}

  set +x
  set +e

  do_simple_log "INFO STOP  ::: tf state show - step ${tf_proj}"
  export exit_code=0

}
