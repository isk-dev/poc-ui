### PoC UI

This folder contains necessary script and file to create deployment pipeline for the UI.

Below is description for the file and script -

1.) AmplifyDeployPipeline.yml

        Description: CloudFormation template containing all necessary resources to create Deployment Pipeline.
        Parameters:
                i.) Branch - Name of the branch CodeBuild should use to build the project.
                ii.) Environment - Environment where Web should get deploy.
                iii.) CostCenter - CostCenter number for Tagging AWS stack and resources respectively.
                iv.) Repository - Github url of the repository.
                v.) Project - Name of the project.
                vi.) Team - Name of the team.

2.) create_stack_using_cloudformation.sh -

        Description: Bash script using AWS CLI commands to create stack in AWS.
        Parameters:
            User Specific:
                i.) ENVIRONMENT - Environment for which stack needs to be created. Supported values are dev or prod.
                ii.) BRANCH - Repository branch name which aws stack should use.
                iii.) REPOSITORY - Github url of the repository.
            Internal:
                i.) S3_TEMPLATE_BUCKET - Name of S3 bucket where CloudFormation template will be stored prior
                                            creating stack.
                ii.) COST_CENTER - CostCenter number used for Tagging AWS stack and resources respectively.
                iii.) PROJECT - Name of the project to be used for Tagging AWS resources and stack
                iv.) TEMPLATE_FILE - Name of the CloudFormation template file.
                v.) TEAM - Name of the team.

Create AWS stack:

A Stack can either be created using AWS Console with AmplifyDeployPipeline.yml or by running bash script from command
line.

To create AWS Stack using script, follow below steps -

1.) Navigate to ./CICD
2.) Run 'create_stack_using_cloudformation.sh dev develop https://github.com/nielsen-analytics/compass-norms-mapping-ui'

The above command will create stack for dev environment using develop branch of the repository.
