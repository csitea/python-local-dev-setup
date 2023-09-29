#!/bin/bash

do_empty_bucket(){

  do_require_var BUCKET "${BUCKET:-}"
  do_require_var AWS_PROFILE "${AWS_PROFILE:-}"

  do_log INFO check bucket: $BUCKET before the delete
  aws s3 ls --profile $AWS_PROFILE $BUCKET

  echo running :
  echo aws s3api --profile $AWS_PROFILE list-object-versions \
   --bucket "${BUCKET}" \
   --output=json \
   --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}'
  aws s3api --profile $AWS_PROFILE list-object-versions \
   --bucket "${BUCKET}" \
   --output=json \
   --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}'

  echo aws s3api delete-objects --profile 'rtr_adm' --bucket ${BUCKET}  \
   --delete "$(aws s3api --profile $AWS_PROFILE list-object-versions \
   --bucket "${BUCKET}" \
   --output=json \
   --query='{Objects: Versions[].{Key:Key,VersionId:VersionId}}')"


  export exit_code="0"

}
