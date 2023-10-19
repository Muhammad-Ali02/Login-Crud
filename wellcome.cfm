<cfinclude  template="bootstrap.cfm">
<cfoutput>
<cfinclude  template="header.cfm">
<div class = "container">
    <cfif structKeyExists(session, 'loggedIn')>
        <h1 class = "text-primary"> Wellcome #session.loggedIn.userName# </h1>
            <cfif session.loggedin.roll eq "administrator">
                <h2 class = "text-success">You are The Admin of Site </h2>
                <h3>You Can Create Any New User.</h3> <br>
                <a href="create_user.cfm"> <button type="button" class="btn btn-outline-success">Create User</button> </a>
                <a href="deleted_records.cfm"> <button type="button" class="btn btn-outline-primary">View Deleted Records</button> </a>
                <h3>You Can view all Users.</h3> <br>
            <cfelse>
                <h2>You are The User of Site </h2>
            </cfif>
        <a href="signup.cfm"> <button type="button" class="btn btn-outline-success">View Data</button> </a>
        <a href="user_login.cfm?logout"> <button type="button" class="btn btn-outline-dark">Logout</button> </a>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>    
</div>  
<cfinclude  template="footer.cfm">
</cfoutput>