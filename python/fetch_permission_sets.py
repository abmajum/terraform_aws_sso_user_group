import boto3 
import json
import ast
client = boto3.client('sso-admin')                                                                                                                                                                 

#Fetching the instance ARN for the account. This will be used with all the other sso-admin calls.
instanceArn = client.list_instances().get('Instances')[0]['InstanceArn']

#Fetching list of all the permission sets
pSets = client.list_permission_sets(InstanceArn=instanceArn).get('PermissionSets')
permission_sets = {}

for pSet in pSets: 
    
    response = client.describe_permission_set( 
        InstanceArn=instanceArn, 
        PermissionSetArn=pSet 
    ) 
    # Output terraform import for permissions Set
    print("terraform import \'aws_ssoadmin_permission_set.this[\"",response['PermissionSet']['Name'],"\"]\' ", 
    response['PermissionSet']['PermissionSetArn'] ,",",instanceArn, sep='')
    permission_sets[response['PermissionSet']['Name']]= {'description' : response['PermissionSet'].get('Description')}
    permission_sets[response['PermissionSet']['Name']]['session_duration']=  response['PermissionSet'].get('SessionDuration')

    # Fetch all the managed policies for the particular Permission set
    managedPolicies = client.list_managed_policies_in_permission_set( 
        InstanceArn=instanceArn, 
        PermissionSetArn=pSet 
    ) 
 
    managedPolicy=[]
    for Policy in managedPolicies['AttachedManagedPolicies']:
        managedPolicy.append(Policy['Arn'])

        #output terraform import command for managed policies
        print("terraform import \'aws_ssoadmin_managed_policy_attachment.this[\"",response['PermissionSet']['Name'],".",
        Policy['Arn'],"\"]\' ", Policy['Arn'] ,",",
        response['PermissionSet']['PermissionSetArn'] ,",",instanceArn, sep='')

    permission_sets[response['PermissionSet']['Name']]['managed_policies'] = managedPolicy
    
    # Fetch inline policy attached with the particular permission set
    inlinePolicy = client.get_inline_policy_for_permission_set( 
        InstanceArn=instanceArn, 
        PermissionSetArn=pSet 
    ) 

    if inlinePolicy['InlinePolicy']: 
        permission_sets[response['PermissionSet']['Name']]['inline_policy'] = (inlinePolicy['InlinePolicy'])

        # Output terraform import command for inline policy
        print("terraform import \'aws_ssoadmin_permission_set_inline_policy.this[\"",response['PermissionSet']['Name'],"\"]\' ",
        response['PermissionSet']['PermissionSetArn'] ,",",instanceArn, sep='')

# Identify the variable object to be used in terraform.tfvars
print(json.dumps(permission_sets, indent=4))

