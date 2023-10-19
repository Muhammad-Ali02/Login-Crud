<cfoutput>
<cfinclude  template="bootstrap.cfm">
<cfinclude  template="header.cfm">
    <cfif structKeyExists(URL, 'logout')>
    <cfset createObject("component", '\components.user_authentication').user_logout() />
    </cfif>
<cfif not structKeyExists(session, 'loggedIn')>
    <div class="container">  
<form action = "user_login.cfm" method = "post">
    <input class = "form-control"type = "text" name="user_name" required = "true" placeholder = "Enter Your Login User Name "><br>
    <input class = "form-control" type = "password" name = "user_password" required = "true" placeholder = "Enter Your Login Password "> <br>
    <input class = "btn btn-success" type = "submit" name="login" value = "login">
</form>
</div>
    <cfif isDefined('form.user_name')>
                    <cfquery name = "showError" >
                        select * 
                        from user_rolls
                        where user_name = '#form.user_name#'
                    </cfquery>
                        <cfif #form.user_password# eq #showError.password#>
                            <cfif structKeyExists(form, 'login')>
                                <cfset user_authentication = createObject("component", '\components.user_authentication')>
                                <!--- login processing --->
                                <cfset isUserlogin = user_authentication.user_login(form.user_name, form.user_password)>
                                <cfif structKeyExists(session, 'loggedIn')>
                                    <cfoutput>
                                        <cflocation  url="index.cfm">
                                    </cfoutput>
                                </cfif>
                            </cfif>
                        <cfelse>
                            <h1 class = "text-light bg-danger "> Incorrect User name or Password </h1>
                        </cfif>
    </cfif>
<cfelse>
    <cflocation  url="index.cfm">
</cfif>
</cfoutput>
