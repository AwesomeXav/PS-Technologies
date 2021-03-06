﻿# Active Directory
## Installing a domain

You shouldn’t automate tasks that you only do very occasionally. But just in case you would want to automate installing a domain: it’s done like this.
* Get all available windows features. Select the one that refers to AD Domain Services.
* Install that feature with all sub features and management tools.
* Wait for the installation to finish. Rebooting isn’t required.
* List all available modules. Two new ones should show up.
* Check all cmdlets that are present in the ADDSDeployment-module.
* Load that module, and perform Install-ADDSForest. Don’t use any parameters, and check what a minimum install for a domain would look like.


[Solution](Solutions/Installing_a_domain_1.ps1)
## Creating an OU, users and copying users
* Create an OU with your name under “Acme”
* Create ten users, called “your first name 1..10”
* Copy all users whose name starts with the same letter as yours
* Create a new global group
* Try to find as many ways as possible to add all your users to this global group
* Set the profilepath for all you users:
	* Set it to the same path for all users (“c:\temp”)
	* Give one user a different path (“c:\otherTemp”)
* Use the “-remove” parameter with Set-ADUser to remove this profilepath
* Use the “-clear” parameter with Set-ADUser to remove this profilepath

[Solution](Solutions/Creating_an_OU,_users_and_copying_users_1.ps1)

## Group membership
* Create groups
	* Three Domain Local groups
	* Another global group (next to the one you created earlier)
* Adjust the membership
	* Make sure some users are member of the second Global group
	* Make sure the Global groups are members of some Domain Local groups
* Show the memberOf-property for all your users
* Get the “distinguished name” for one of your groups
* Show all users that are a member of this group using the –RecursiveMatch comparison operator
* Now show all users that are a member of one a Domain Local-group you select
* And finally, show all groups a user is member of, even if this is through membership of another group


[Solution](Solutions/Group_membership_1.ps1)
## Fine Grained Password Policies

Create three new fine grained password polices. Apply them to the groups shown in the table:

|Name |	Precedence|	Min nr of chars|	Complexity|	Applies to|
|:---|:---:|:---:|:---:|:---|
|Difficult|	10|	6|	FALSE|	Domain Admins|
|Medium|	50|	5|	FALSE|	 |
|Simple|	100|	4|	FALSE|	Domain Users|

Show name, minimum nr of characters and applies-to for all FGPP’s in a table, ordered by the precedence.


[Solution](Solutions/Fine_Grained_Password_Policies_1.ps1)
## _User properties

Pager property
## _Enable recycle bin
