import boto3
import json
import copy
client = boto3.client('identitystore')
IdentityStoreId="d-9f672ca174"
user_list=[]

#Initialising an empty user_map that will contain vaules for a user
user_map={}

#fetching list of all the users using list_users function
response = client.list_users( IdentityStoreId=IdentityStoreId)
for user in response['Users']:
    print("terraform import \'aws_identitystore_user.example[\"",user['UserName'],"\"]\'", IdentityStoreId ,"/",user['UserId'], sep='')
    print (user)
    #Creating a user map for each user to be used in terraform.vars
    user_map["UserName"] = user["UserName"]
    user_map["DisplayName"] = user["DisplayName"]
    user_map["FamilyName"]=user['Name']["FamilyName"]
    user_map["GivenName"]=user['Name']["GivenName"]
    user_map["Primary"] =user["Emails"][0].get("Primary")
    user_map["Type"]= user["Emails"][0].get("Type")
    #Appending the copy of the user_map to the user list
    user_list.append(copy.deepcopy(user_map))


print(json.dumps(user_list, indent=4))

