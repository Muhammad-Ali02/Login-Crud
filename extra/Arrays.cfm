<!--- Please insert your code here --->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form Result</title>
</head>
<body>
	<!---Explicit Array --->
	<cfset myArray = arrayNew(1) />
	<cfset myArray[1] = 'Red' />
	<cfset myArray[2] = 'Green' />
	<cfset myArray[3] = 'Blue' />
	<cfdump var="#myArray#" label = "Color's Array" >
	<br>
	<!---Implicit Array --->
	<cfset myArray2 = ['Red', 'Green', 'Blue'] />
	<cfdump var="#myArray2#" label = "Color's Array2" />
	<br>
	<!---Printing Length of Array --->
	<h1>The Length of Array is <cfoutput >#arrayLen(myArray)#</cfoutput></h1>
	<!---Printing Array with Loop --->
	<cfoutput >
		<cfloop from="1" to="#arrayLen(myArray)#" index="i">
			<p> Index No. #i# = #myArray[i]# </p>
		</cfloop>
	</cfoutput>
	<!---Appending a new array element on the top --->
	<cfset arrayAppend(myArray, 'Yellow') />
	<cfset arrayPrepend(myArray, 'Orange') />
	<cfdump var="#myArray#" label="After Adding Top and Bottem" >
	<!---Deleting elements of any array --->
	<cfset arrayDeleteAt(myArray,1)>
	<br />
	<cfdump var="#myArray#" label="After Deleting 1st Element" >
</body>
</html>