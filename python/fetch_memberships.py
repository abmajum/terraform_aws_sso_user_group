import boto3
import json
import copy
client = boto3.client('identitystore')
IdentityStoreId="d-9f672ca174"

#fetching list of all the users
Users = client.list_users( IdentityStoreId=IdentityStoreId) 
user_map={}
for user in Users['Users']:
    #Creating a map in for {user_id: username}. 
    #This map will be used to fetch username from the user-id when creating the terraform import command
    user_map[user['UserId']] = user["UserName"]

#Fetching list of all the groups
response = client.list_groups( IdentityStoreId=IdentityStoreId)

#This will contain the final group membership, with the list of all the users within a particular group
user_in_group=[]
#Group memberships can only be fetched using groupId, hence we are iterating over each group
for group in response['Groups']:
    #Initialising an empty membership map for each group. 
    #It will contain the group name and list of all the users in that group
    m_map={"group": group['DisplayName'], "description": group.get('Description'), "users": []}
    #Fetching group membership for each group
    membership=client.list_group_memberships(IdentityStoreId=IdentityStoreId,GroupId=group['GroupId'])
    #list_group_membership returns list of memberships, where each member of the list represents one user in that group
    #Iterating over each item in Group Membership
    for gm in membership['GroupMemberships']:
        # Creating terraform import command using in format [username.groupname] identity-id/membership-id
        print("terraform import \'aws_identitystore_group_membership.example[\"",user_map[gm['MemberId']['UserId']],".",group['DisplayName'],"\"]\' ", IdentityStoreId ,"/",gm['MembershipId'], sep='')
        # Appending each user in the user list for a particular group
        m_map["users"].append(user_map[gm['MemberId']['UserId']])
    # Appending every group membership map to the final user_in_group listing
    user_in_group.append(m_map)

#Printing user_in_group mapping to be used in terraform.tfvars
print(json.dumps(user_in_group,indent=4))
        

