import boto3 
import json
import ast
client = boto3.client('sso-admin')                                                                                                                                                                 

instanceArn = client.list_instances().get('Instances')[0]['InstanceArn']

pSets = client.list_permission_sets(InstanceArn=instanceArn).get('PermissionSets')
permission_sets = {}

for pSet in pSets: 

    #print("terraform import \'aws_identitystore_user.example[\"",user['UserName'],"\"]\' ", IdentityStoreId ,"/",user['UserId'], sep='')
   
    #['Name']['description'] = pSet['PermissionSet'].get('Description')
    
    response = client.describe_permission_set( 
        InstanceArn=instanceArn, 
        PermissionSetArn=pSet 
    ) 
    #print(response) 
    print("terraform import \'aws_ssoadmin_permission_set.this[\"",response['PermissionSet']['Name'],"\"]\' ", 
    response['PermissionSet']['PermissionSetArn'] ,",",instanceArn, sep='')
    permission_sets[response['PermissionSet']['Name']]= {'description' : response['PermissionSet'].get('Description')}
    permission_sets[response['PermissionSet']['Name']]['session_duration']=  response['PermissionSet'].get('SessionDuration')

    managedPolicies = client.list_managed_policies_in_permission_set( 
        InstanceArn=instanceArn, 
        PermissionSetArn=pSet 
    ) 
    #print(response) 
    managedPolicy=[]
    for Policy in managedPolicies['AttachedManagedPolicies']:
        managedPolicy.append(Policy['Arn'])
        print("terraform import \'aws_ssoadmin_managed_policy_attachment.this[\"",response['PermissionSet']['Name'],".",
        Policy['Arn'],"\"]\' ", Policy['Arn'] ,",",
        response['PermissionSet']['PermissionSetArn'] ,",",instanceArn, sep='')
    permission_sets[response['PermissionSet']['Name']]['managed_policies'] = managedPolicy
    
    inlinePolicy = client.get_inline_policy_for_permission_set( 
        InstanceArn=instanceArn, 
        PermissionSetArn=pSet 
    ) 

    if inlinePolicy['InlinePolicy']: 
        permission_sets[response['PermissionSet']['Name']]['inline_policy'] = (inlinePolicy['InlinePolicy'])
    
        print("terraform import \'aws_ssoadmin_permission_set_inline_policy.this[\"",response['PermissionSet']['Name'],"\"]\' ",
        response['PermissionSet']['PermissionSetArn'] ,",",instanceArn, sep='')
    # else:
    #     permission_sets[response['PermissionSet']['Name']]['inline_policy'] = None

print(json.dumps(permission_sets, indent=4))

