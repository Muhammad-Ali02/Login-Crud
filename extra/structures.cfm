<!--- Please insert your code here --->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Structures</title>
</head>
<body>
	<!---explicit structure --->
   <cfset structUser = structNew() />
   <cfset structUser.firstName = 'Muhammad' />
   <cfset structUser.lastName = 'Umar' />
   <cfset structUser.age = 21 />
   <cfdump var= "#structUser#" label = "User Information">
   <!---implicit Structure --->
    <cfset structUser2 = {firstName = 'Muhammad', lastName = 'Umar', age = 21} />
    <br>
    <cfdump var= "#structUser2#" label = "User Information 2" />
    <br>
    <!---Using of structDelete --->
    <cfset structDelete(structUser,'age') />
    <cfdump var= "#structUser#" label = "User Information -age">
    <!---Deleting structure --->
    <cfset structClear(structUser) />
    <br>
    <cfdump var= "#structUser#" label = "Empty" />
    <br>
    <!---Counting the Keys of Structure --->
    <p>The Number of Keys in User2 Structure are <cfoutput >#structCount(structUser2)#</cfoutput>. </p>
</body>
</html>