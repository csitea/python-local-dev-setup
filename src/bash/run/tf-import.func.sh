#!/usr/bin/env bash
#
# Terraform can import existing infrastructure resources. This functionality 
# lets you bring existing resources under Terraform management.
# https://developer.hashicorp.com/terraform/cli/import
#
# $ ORG=org APP=app ENV=env STEP=000-step \
#    RESOURCE_ADDRESS=aws_s3_bucket.bucket \
#    ID=bucket-name \
#    make do-tf-import

do_tf_import(){

  do_log "INFO START ::: importing step ${STEP}"

  # the RESOURCE_ADDRESS inside terraform objects
  do_require_var RESOURCE_ADDRESS "${RESOURCE_ADDRESS:?}"
  # the RESOURCE_IDENTIFIER - usually specified at the end of terraform documentation
  # for given resource. This changes by resource and does not follow any pattern.
  # Check the documentation.
  do_require_var ID "${ID:?}"

  do_tf_header

  # do_backup_region_dynamo_db_tables "$AWS_PROFILE" "$AWS_REGION"

  vars_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.vars.tfvars"
  backend_config_path="$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV/tf/$tf_proj.backend-config.tfvars"

  set -e

  echo "running: "
  set -x

  terraform -chdir=${bin_dir} init -backend-config=$backend_config_path -upgrade
  terraform -chdir=${bin_dir} import -var-file=$vars_path -lock=false ${RESOURCE_ADDRESS} ${ID}

  rm -rf ${bin_dir} #&& rm -rf ${modules_tgt_dir}

  set +x
  set +e

  do_simple_log "INFO STOP  ::: provisioning step ${tf_proj}"
  export exit_code=0

}
