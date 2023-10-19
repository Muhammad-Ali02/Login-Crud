<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <cfinclude template = "bootstrap.cfm">
    <title>Form</title>
</head>
<body>
<cfoutput>
    <form action = "login.cfm" method = "post">
        <input class = "form-control" type = "number" id = "contact_no" name = "contact_no" Placeholder = "Enter your Contact Number" required = "true"/>
    <br> <br>
        <input class = "form-control" type = "password" id = "Password" name = "Password" Placeholder = "Enter Your Password"  required = "true"/>
        <!--- If User Name and Password Incorrect Show Error Massage --->
            <cfif isDefined('form.contact_no')>
                <cfquery name = "LoginQ" >
                    select * 
                    from sign_up
                    where contact_no = '#form.contact_no#'
                </cfquery>
                    <cfif #form.Password# eq #LoginQ.Password#>
                        <cflocation  url="home.cfm">
                    <cfelse>
                        <h1 class = "text-danger"> Incorrect User name or Password </h1>
                    </cfif>
            </cfif>
        <br> <br>
        <input type = "submit" value = "Login" class = "btn btn-primary">
    </form> <br>
        <a href = "sign_up.cfm"> <button class = "btn btn-success"> Sign Up </button> </a>
<!---     <h1> The Value of Application Variable is #session.testVar# &nbsp; #newVar#</h1> --->
</cfoutput>
</body>
</html>