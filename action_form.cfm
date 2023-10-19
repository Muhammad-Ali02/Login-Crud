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
   
   <!--- 			output of the form --->
   
   <cfoutput>

        <cfquery datasource = "myDb" name = "testQ1">
        INSERT INTO empDetail (Name, Salary)
        VALUES ('#empName#' , '#Salary#');
        </cfquery>

		<cfquery datasource = "myDb" name = "testQ2">
 			SELECT * 
            FROM empDetail
		</cfquery>

        <cfloop query="testQ2" >
            Employee Name : #Name# <br> 
            Salary #Salary# <br>
        </cfloop>

   </cfoutput>
    
</body>
</html>