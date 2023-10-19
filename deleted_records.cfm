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
    <cfif structKeyExists(session, 'loggedIn') and session.loggedin.roll eq "administrator">
            <cfquery name = "testQ4">
                SELECT * 
                FROM deleted_records
            </cfquery>
        <h1> Deleted Records </h1>
        <table class="table table-striped table-dark table-bordered table-hover">
            <tr>
                <th> Name </th>
                <th> Father Name </th>
                <th> CNIC </th>
                <th> Address </th>
                <th> Contact No. </th>
                <th> Gender </th>
                <th> Deleted Time </th>
                <th> Deleted By </th>
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
                <td>#deleted_time# </td>
                <td>#deleted_by#</td>
                <td>  
                    <a href="delete.cfm?del_id=#id#" > <button class = "btn btn-danger"> Permanent delete </button> </a>
                </td>
            </tr>
        </cfloop>
        </table>
        <br>
            <a href = "wellcome.cfm" > <button class = "btn btn-danger"> Main Page </button> </a>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First by an Admin Account </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
<cfinclude  template="footer.cfm">
</cfoutput>

</body>