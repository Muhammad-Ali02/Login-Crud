<cfoutput>
<cfinclude  template="bootstrap.cfm">
<cfinclude  template="header.cfm">
<div class = "container">
    <cfif structKeyExists(session, 'loggedIn')>
            <cfif session.loggedin.roll eq "administrator">
                <center> <h2 class = "text-success">Admin Dashboard </h2> </center>
                <br>
            <cfinclude  template="create_po.cfm">
            <hr>
            <h1> Vendors: </h1>
<!---                 <a href="create_user.cfm"> <button type="button" class="btn btn-outline-success">Create User</button> </a> --->
<!---                 <a href="deleted_records.cfm"> <button type="button" class="btn btn-outline-primary">View Deleted Records</button> </a> --->
             <p>Create New Vender: <a href="vendors.cfm"> <button type = "button" class = "btn btn-success"> Create </button> </a> 
             View Existing Venders: <a href="view_vendors.cfm"> <button type = "button" class = "btn btn-warning"> view </button> </a> </p>
                <hr>
            <cfelse>
                <h2 style = "text-align : center">Wellcome to Point of Sale </h2>
            </cfif>
        <hr>
            <h1> Products: </h1>
        <a href="view_products.cfm"> <button type="button" class="btn btn-outline-Primary">All Products</button> </a>
        <hr>
            <h1> POS: </h1>
            <form action = "sale_point.cfm" method = "post">
            <input type = "hidden" name = "create" value = "true" >
            <input type="submit" class="btn btn-outline-dark" value = "Create Invoice">
            </form>
            <a href = "all_invoices.cfm"> <button type = "button" class="btn btn-outline-primary"> All Invoices </button></a> 
        <hr>
            <h1> Reports: </h1>
            <a href= "sales_report.cfm"> <button> Sales Report </button> </a>
            <a href= "customer_report.cfm"> <button> Customer Report </button> </a>
            <a href= "stock_report.cfm"> <button> Stock Report </button> </a>

    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>    
</div>
</cfoutput>