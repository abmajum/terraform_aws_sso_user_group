import boto3
import json
import copy
client = boto3.client('identitystore')
IdentityStoreId="d-9f672ca174"
group_list=[]

#Initialising an empty group_map that will contain vaules for a group
group_map={}

#fetching list of all the groups using list_users function
response = client.list_groups( IdentityStoreId=IdentityStoreId)
for group in response['Groups']:
    print("terraform import \'aws_identitystore_group.this[\"",group['DisplayName'],"\"]\' ", IdentityStoreId ,"/",group['GroupId'], sep='')
    #Creating a group map for each group to be used in terraform.vars
    group_map["DisplayName"] = group["DisplayName"]
    group_map["Description"]=group.get('Description')
    #Appending the copy of the group_map to the group list
    group_list.append(copy.deepcopy(group_map))

print(json.dumps(group_list, indent=4))

