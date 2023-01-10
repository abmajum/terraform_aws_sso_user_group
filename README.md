# AWS SSO Terraform
----
This module helps in the creation and management of aws identitystore users, groups, permission-sets.
- This repository contains 3 directories which are as follows:
1. ```import_script```: It contains the bash scripts to import the existing terraform resources in the infrastructure.

2. ```python```: It contains the boto3 scripts to get the data, genrate terraform import commands and genrate variables.

3. ```terraform```: It contains terraform resources to manage the resources.

## Pre-requisites
----
Before this module can be used, please ensure that the following pre-requisites are met:

- Enable AWS Control Tower or AWS Organizations and add AWS Accounts you want to be managed by SSO.
- Enable AWS SSO if you are using AWS Organizations.
- Ensure that Terraform is using a role with permissions required for AWS SSO management or have admintrator privileges.

## Usage
----
Follow [Managing Identity Store resources with Terraform](https://github.com/abhi-aws15/identitystore_user_group/blob/master/terraform/README.md) guide to setup variables and create,destroy & manage resources.