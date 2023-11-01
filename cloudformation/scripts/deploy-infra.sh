#!/bin/bash

STACK_NAME=jenkins-aws-tutorial
REGION=us-west-2
AWS_CLI_PROFILE=similoluwaokunowo
KEY_PAIR_NAME=jenkins
EC2_INSTANCE_TYPE=t2.micro

# Setup
echo -e "\n\n========== Deploying 'setup.yml' template ==========\n\n"
aws cloudformation deploy \
    --region $REGION \
    --profile $AWS_CLI_PROFILE \
    --stack-name ${STACK_NAME}-setup \
    --template-file cloudformation/setup.yml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides KeyName=$KEY_PAIR_NAME

# EC2 Instance 
echo -e "\n\n========== Deploying 'deploy-ec2.yml' template ==========\n\n"
aws cloudformation deploy \
    --region $REGION \
    --profile $AWS_CLI_PROFILE \
    --stack-name ${STACK_NAME} \
    --template-file cloudformation/deploy-ec2.yml \
    --capabilities CAPABILITY_NAMED_IAM \
    --parameter-overrides KeyName=$KEY_PAIR_NAME \
        InstanceType=$EC2_INSTANCE_TYPE

# If the deploy succeeded, show the public IP of the created EC2 instance
if [ $? -eq 0 ]; then 
    aws cloudformation list-exports \
        --profile $AWS_CLI_PROFILE \
        --query "Exports[?starts_with(Name, 'JenkinsEC2InstancePublicIP')].Value" \
        --region $REGION 
fi