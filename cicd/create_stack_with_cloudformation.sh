#!/usr/bin/env bash
#
# Compass Norms Mapping UI Deployment Pipeline stack creation
#

echo "Checking if Environment is set"
if [ -z "$1" ]; then
  echo "ENVIRONMENT argument cannot be empty! Please specify either dev or prod."
  exit 1
fi

echo "Checking if Branch is set"
if [ -z "$2" ]; then
  echo "BRANCH argument cannot be empty! Please specify either dev or prod."
  exit 1
fi

echo "Checking if repository url is set"
if [ -z "$3" ]; then
  echo "REPOSITORY argument cannot be empty! Please specify url of github repository"
  exit 1
fi

ENVIRONMENT="$1"
BRANCH="$2"
REGION="us-east-1"
S3_TEMPLATE_BUCKET="compass-cf-template-deployments-${REGION}-${ENVIRONMENT}"
COST_CENTER="5501968"
BUCKET_FOLDER="CompassNormsWebCicdStack"
TEMPLATE_FILE="AmplifyDeployPipeline.yml"
REPOSITORY="$3"
PROJECT="Norms-Mapping-UI"
TEAM="Compass"

echo "Uploading ${TEMPLATE_FILE} file to S3 bucket - ${S3_TEMPLATE_BUCKET}"
aws s3 cp ${TEMPLATE_FILE} s3://"${S3_TEMPLATE_BUCKET}"/${BUCKET_FOLDER}/

echo "Creating AWS CloudFormation Stack"
aws cloudformation --stack-name "${TEAM}-${PROJECT}-${BRANCH}-Stack" \
                   --template-url "https://s3.amazonaws.com/${S3_TEMPLATE_BUCKET}/${BUCKET_FOLDER}/${TEMPLATE_FILE}" \
                   --parameters ParameterKey=Branch, ParameterValue="${BRANCH}" \
                                ParameterKey=Environment, ParameterValue="${ENVIRONMENT}" \
                                ParameterKey=CostCenter, ParameterValue=${COST_CENTER} \
                                ParameterKey=Repository, ParameterValue=${REPOSITORY} \
                                ParameterKey=Project, ParameterValue=${PROJECT} \
                                ParameterKey=Team, ParameterValue=${TEAM}
                   --tags Key=Team, Value=${TEAM} \
                          Key=Project, Value=${PROJECT} \
                          Key=CostCenter, Value=${COST_CENTER} \
                          Key=Environment, Value="${ENVIRONMENT}"
