<cfoutput>
<cfinclude  template="bootstrap.cfm">
<div Class = "container">
    <div Class = "container">
<div class = "row bg-danger">
    <div class = "col-2">
    <a href = "view.cfm" > <button class = "btn btn-success" style = "margin: 14px;"> Home </button> </a>
    </div>
    <div class = "col-6">
    <center><h2 class = "text-light" style = "height: 60px;"> Inventory Manangement System </h2></center>
    </div>
    <div class = "col-2">
        <cfif structKeyExists(session, 'loggedIn')>
        <a href="user_login.cfm?logout"> <button type="button" class="btn btn-dark" style = "margin: 14px;">Logout</button> </a>
        </cfif>
    </div>
    </div>
</div>
</div>
</cfoutput>