#!/bin/bash
do_generate_admin_aws_credentials_file(){

    do_require_var ORG "${ORG:-}"
    do_require_var APP "${APP:-}"
    do_require_var ENV "${ENV:-}"

    out_file=~/Desktop/do_generate_admin_aws_credentials_file.log
    # test -f $out_file && rm -v $out_file

    do_export_json_section_vars "$PRODUCT_DIR/cnf/env/$ORG/$APP/$ENV.env.json" ".env.aws"

    set -e
    do_log "INFO fetching AWS non-root accounts for ORG=${ORG} APP=${APP} ENV=${ENV}"
    aws_accounts=`AWS_SHARED_CREDENTIALS_FILE=${AWS_SHARED_CREDENTIALS_FILE} aws organizations list-accounts --profile rtr_adm | jq -c '.Accounts[]'`
    for account in ${aws_accounts}; do
        account_name=`echo ${account} | jq -c '.Name' | sed s/\"//g`
        acc_name=$(echo ${account_name} | sed s/-/_/g)
        account_id=`echo ${account} | jq -c '.Id' | sed s/\"//g`
        if [[ ${account_name} = "${ORG}-${APP}-${ENV}-"* ]]; then
            cat << EOF  | tee -a $out_file
[$acc_name]
# switch from AWS root account to $account_name admin role
source_profile = rtr_adm
role_arn = arn:aws:iam::${account_id}:role/${ENV}_iam_role_root_admin
region = $AWS_REGION
output = json
EOF
        fi
    done
    set +e

    export exit_code=0
}

