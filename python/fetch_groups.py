import boto3
import json
import copy
client = boto3.client('identitystore')
IdentityStoreId="d-9f672ca174"
group_list=[]

group_map={}

response = client.list_groups( IdentityStoreId=IdentityStoreId)
for group in response['Groups']:
    print("terraform import \'aws_identitystore_group.this[\"",group['DisplayName'],"\"]\' ", IdentityStoreId ,"/",group['GroupId'], sep='')
    group_map["DisplayName"] = group["DisplayName"]
    group_map["Description"]=group.get('Description')
    group_list.append(copy.deepcopy(group_map))

print(json.dumps(group_list, indent=4))
