<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <cfinclude  template="bootstrap.cfm">
        <title>All Users</title>
    </head>
<body>
<cfoutput>
    <cfinclude  template="header.cfm">
    <cfif structKeyExists(session, 'loggedIn')>
        <cfif not session.loggedin.roll eq "administrator">
        <!--- <cfif #session.loggedIn.userName# eq tesQ4.created_by> --->
        <!--- </cfif> --->
            <h1 class = "text-danger"> You Entered These Records </h1>
            <cfquery datasource = "myDb" name = "testQ4">
                SELECT * 
                FROM sign_up
                where created_by = '#session.loggedin.username#'
            </cfquery>
        <cfelse>
            <cfquery datasource = "myDb" name = "testQ4">
                SELECT * 
                FROM sign_up
            </cfquery>
        </cfif>
        <table class="table table-hover table-striped table-secondary">
            <tr>
                <th> Name </th>
                <th> Father Name </th>
                <th> CNIC </th>
                <th> Address </th>
                <th> Contact No. </th>
                <th> Gender </th>
                <th> Edit </th>
                <th> Dell </th>
            <tr>
        <cfloop query="testQ4">
            <tr>
                <td>#User_Name# </td> 
                <td>#Father_Name# </td>
                <td>#CNIC# </td>
                <td>#Address# </td>
                <td>#Contact_no# </td>
                <td>#Gender# </td>
                <td>  
                    <a href="sign_up.cfm?id=#id#" > <button class = "btn btn-info"> edit </button> </a>
                </td>
                <td>  
                    <a href="delete.cfm?id=#id#" >  <button class = "btn btn-danger"> delete </button> </a>
                </td>
            </tr>
        </cfloop>
        </table>
                <br>
            <a href = "sign_up.cfm"> <button class ="btn btn-success"> Add New Data </button> </a>
            <a href = "wellcome.cfm" > <button class = "btn btn-danger"> Main Page </button> </a>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
    <cfinclude  template="footer.cfm">
</cfoutput>

</body>