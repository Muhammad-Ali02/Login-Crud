<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <cfinclude template = "bootstrap.cfm">
    <cfinclude  template="header.cfm">
    <title>Form</title>
</head>
<cfoutput>
<cfif structKeyExists(session, 'loggedIn')>
<cfif isDefined('form.edit')>
    <cfif form.edit eq "i">
        <cfquery   name = "conditionQ">
                select *
                from products
                where sku = '#form.sku#' or title = '#form.prod_title#'
        </cfquery>
        <cfif conditionQ.sku eq form.sku>
            <script>
                alert("SKU already exists!");
            </script>
        <cfelseif conditionQ.title eq form.prod_title>
            <script>
                alert("SKU already exists!");
            </script>
        <cfelse>
            <!--- New Product Query --->
            <cfquery   name = "testQ3">
                INSERT INTO products (prod_id, title, sku, vendor, cost, price, stoke_in, added_by, stoke_out)
                VALUES (null , '#prod_title#' , '#sku#' , null , 0 , 0 , 0 , '#session.loggedIn.userName#', 0);
            </cfquery> 
            <script>
                alert("Product Added Succesfully");
            </script>
        </cfif>
    <cfelseif form.edit eq "u">
        <cfquery   name = "testQ6">
                update  products 
                set Title = '#prod_title#', SKU = '#SKU#', price = '#price#'
                where Prod_id = #id#
        </cfquery>
        <cflocation  url="products.cfm">
                
    </cfif>
</cfif>
    <cfif isDefined('url.id')>
        <cfquery   name = "updateQ">
            SELECT * FROM products
            where Prod_id = '#id#'
        </cfquery>
    </cfif>
<center>
                                    <!--- Front End --->
    <table>
        <cfif isDefined('url.id')>
            <form name "products" id = "products" method = "post" action="products.cfm?id=#id#">
                <input type = "text" name = "edit" value = "u" hidden = "true">
        <cfelse>
            <form name "products" id = "products" method = "post" action="products.cfm">
                <input type = "text" name = "edit" value = "i" hidden = "true">
        </cfif>

            <tr>
	            <td>Product Title</td>
                <TD> 
                <input class="form-control" type="text" name="prod_title" placeholder="Product Name" <cfif isDefined('url.id')> value = "#updateQ.title#" <cfelseif isDefined('form.title')> value = "#form.title#" </cfif> >
                </TD>
            </tr>
            <tr>
                <td>SKU</td>
                <td> <input class="form-control" type="text" id = "SKU" name="SKU" placeholder="Stock Keeping Unit" <cfif isDefined('url.id')> value = "#updateQ.sku#" readonly = "true" <cfelseif isDefined('form.SKU')> value = "#form.SKU#"</cfif>>
                </td>
            </tr>
            <cfif isDefined('url.id')>
            <tr>
                <td> Cost Per Item </td>
                <td> <input type = "number" value = "#updateQ.cost#" readonly> 
            </tr>
            <tr>
                <td>Price</td>
                <td>
                <input class="form-control" type="number" name="price" placeholder="Sale Price" <cfif isDefined('url.id')> value = "#updateQ.price#"  <cfelseif isDefined('form.price')> value = "#form.price#" </cfif>>
                </td>
                <td>
                <input  type = "number" name = "id"  value = "#url.id#" hidden = "true"/>
                </td>
            </tr>
            </cfif>
            <tr>
                <td>
                    <input type = "submit" Value = "Save" class = "btn btn-success">
                <td>
             </tr>
    </form>
           
</table>
<a href = "index.cfm"> Goto Dashboard </a>
    </center>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>       
</cfoutput>
</html>