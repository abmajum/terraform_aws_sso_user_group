import boto3
import json

#boto3 client initilization for AWS Orgnizations
orgs = boto3.client('organizations')

#boto3 client initilization for AWS SSO-Admin
sso_admin = boto3.client('sso-admin',region_name="ap-south-1")

#Fetching list of accounts which are parts of AWS Orgnization
response = orgs.list_accounts()
accounts=[i['Id'] for i in response['Accounts']]

#Fetching list of PermissionSets 
response = sso_admin.list_permission_sets(InstanceArn='arn:aws:sso:::instance/ssoins-6595b36b2cbf3a38')
permission_sets = [ psa for psa in response['PermissionSets']]
permission_assignments=[]

#Iterating over each account
for account in accounts:
    #Iterating over each permission set to get AWS account to permission set mapping
    for permission_set in permission_sets:

        #fetching account assignments
        response = sso_admin.list_account_assignments(InstanceArn='arn:aws:sso:::instance/ssoins-6595b36b2cbf3a38',AccountId=account,PermissionSetArn=permission_set)
        for assignment in response['AccountAssignments']:
            permission_assignments.append(assignment)
            #Terraform import command for each account assingment
            print("terraform import \'aws_ssoadmin_account_assignment.example[\""+assignment['AccountId']+"."+assignment['PermissionSetArn']+"."+assignment['PrincipalId']+"\"]\' "+assignment['PrincipalId']+","+assignment['PrincipalType']+","+assignment['AccountId']+",AWS_ACCOUNT,"+assignment['PermissionSetArn']+",arn:aws:sso:::instance/ssoins-6595b36b2cbf3a38")
print(json.dumps(permission_assignments,indent=4))