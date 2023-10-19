<!DOCTYPE html>
<html lang="en">
    <head>
        <meta charset="UTF-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <cfinclude  template="bootstrap.cfm">
        <title>All Products</title>
    </head>
<body>
<cfoutput>
    <cfinclude  template="header.cfm">
    <cfif structKeyExists(session, 'loggedIn')>
        <cfif not session.loggedin.roll eq "administrator">
        <!--- <cfif #session.loggedIn.userName# eq tesQ4.created_by> --->
        <!--- </cfif> --->
            <h1 class = "text-danger"> You Entered These Records </h1>
            <cfquery name = "testQ4">
                SELECT * 
                FROM products
                where created_by = '#session.loggedin.username#'
            </cfquery>
        <cfelse>
            <cfquery name = "testQ4">
                SELECT * 
                FROM products
            </cfquery>
        </cfif>
        <table class="table table-hover table-striped table-primary">
            <tr>
                <th> Title </th>
                <th> Vendor </th>
                <th> SKU </th>
                <th> Cost </th>
                <th> Price </th>
                <th> Stock In </th>
                <th> Stock Out </th>
                <th> Current Stock </th>
                <th> Edit </th>
                <th> Dell </th>
            <tr>
        <cfloop query="testQ4">
            <tr>
                <td>#title# </td>
                <td>#vendor# </td>
                <td>#sku# </td>
                <td>#Cost# </td>
                <td>#Price# </td>
                <td>#Stoke_in# </td>
                <td>#stoke_out# </td>
                <td><cfset stoke = #stoke_in# - #stoke_out# > #stoke# </td>
                <td>  
                    <a href="products.cfm?id=#prod_id#" > <button class = "btn btn-info"> edit </button> </a>
                </td>
                <td>  
                    <a href="del_products.cfm?id=#prod_id#" >  <button class = "btn btn-danger"> delete </button> </a>
                </td>
            </tr>
        </cfloop>
        </table>
            <br>
            <a href = "products.cfm"> <button class ="btn btn-success"> Add New Product </button> </a>
            <a href = "index.cfm" > <button class = "btn btn-primary"> Dashboard </button> </a>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
</cfoutput>

</body>