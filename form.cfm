<!--- Please insert your code here --->
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Coldfusion Form</title>
</head>
<body>
    <form id="firstForm" name ="firstForm" method = "post" action="action_form.cfm">
    	<p>
    		<label for="firstName">
    			Employee Name : 
    		</label>
    		<input type="text" name="empName" id="firstName" >
    	</p>
    	<p>
    		<label for="age"> Salary : </label>
    		<input type="text" name="Salary" id="salary" >
    	</p>
    	<p>
    		<input type="submit" name="submit" id="submit" >
    	</p>
    <!---	<cfdump var="#cgi#" >
    	<cfdump var="#server#" >--->
    </form>


</body>
</html>