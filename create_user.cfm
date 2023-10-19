<!DOCTYPE html>
<html lang="en">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <cfinclude  template="bootstrap.cfm">
    <title>Create User</title>
</head>
<body>
<cfoutput>
    <cfinclude  template="header.cfm">
    <div class = "container">
    <cfif structKeyExists(session, 'loggedIn')>
    <form action = "create_user.cfm" method = "post">
        <input type = "text" name = "cu_username" placeholder = "Enter a Unique User Name " class = "form-control" />
        <br>
        <input type = "Password" name = "cu_password" placeholder = "Create a Password" class = "form-control">
        <br>
        <label for = "Admin">Admin </label>
        <input type = "radio" name = "sel_role" value = "administrator" />
        <label for = "User">User</label>
        <input type = "radio" name = "sel_role" value = "user" /> <br>
        <input type = "hidden" name = "create" value = "Create" />
        <input type = "submit" value = "Create" class = "btn btn-success">
    </form>
        <br>
        <a href = "wellcome.cfm" > <button class = "btn btn-danger"> Back </button> </a>
        <cfif isDefined('form.Create')>
            <cfquery name = "check_userQ">
                select *
                from user_rolls
                where user_name = '#form.cu_username#'
            </cfquery>
                <cfif check_userQ.user_name eq form.cu_username>
                    <script>
                        alert("User already exists!");
                    </script>
                <cfelse>
                    <!--- Create User Query --->
                    <cfquery   name = "createuserQ">
                        INSERT INTO user_rolls (User_Name, password, level, roll_id)
                        VALUES ('#cu_username#' ,  '#cu_password#' , '#sel_role#' , null);
                    </cfquery>
                        <script>
                            alert("User Created Succesfully! ")
                        </script>
                </cfif>
        </cfif>
     <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif> 
    </div>
<cfinclude  template="footer.cfm">
</cfoutput>
</body>
</html>