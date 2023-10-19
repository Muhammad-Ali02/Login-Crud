<!--- Please insert your code here --->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>CFML Variables</title>
</head>
<body>
   <!--- Variable in CFML --->
   <cfset myNum = 10 />
   <cfoutput >
   	<p>
   	The Value of My Number Variable is #myNum#
   	</p>
   </cfoutput>
   <cfset myNum = myNum + 10>
   <cfoutput >
   	<p>
   	The Value of My Number Variable is #myNum#
   	</p>
   </cfoutput>
   <cfset myName = 'Muhamamd Umar'>
   <cfoutput >
   	<p>
   	The Value of My Name is #myName#
   	</p>
   </cfoutput>
</body>
</html>