<cfoutput>
    <cfinclude  template="header.cfm">
    <cfif structKeyExists(session, 'loggedIn')>
    <cfif structKeyExists(form, 'id')>
    <cfif structKeyExists(form, 'id')> <!--- In case of Checking status of PO --->
        <cfquery name = "po"> <!--- Query to get PO Data from database ---> 
            select * 
            from po_num
            where PO_Num = '#form.id#'
        </cfquery>
        <cfif Po.PO_status eq "pending">
        <cfquery name = "vender">
            select * 
            from vendors
            where vender_name = '#po.PO_vendor#'
        </cfquery>
        <cfquery name = "po_products">
            select * , count(Prod_title) as no_of_Products
            from po_products
            where po_num = '#form.id#'
            group by prod_title
        </cfquery>
        <cfquery name = "count"> <!--- This Query will get the number of Products --->
            select count(prod_title) as no_of_Products
            from po_products
            where po_num = '#form.id#'
        </cfquery>
        <cfquery name = "products">
            select *
            from products
            where title = any (
                select prod_title
                from po_products
                where po_num = '#form.id#'
            )
        </cfquery>
        <cfelseif Po.PO_status eq "Added"> <!--- Already Added PO Can't be add again --->
            <h1> PO Already Added to Stock </h1>
            <a href="index.cfm"><input type = "button" value = "Dashboard" class = "btn btn-primary"> </a>
            <cfabort>
        <cfelse>
            <h1> PO Not Found Or Not Saved. Please Check in Drafts </h1> <!--- in case of wrong PO no. --->
            <a href="index.cfm"><input type = "button" value = "Dashboard" class = "btn btn-primary"> </a>
            <cfabort>
        </cfif>
    </cfif>
    <p>Vendor Detail:</p>
    <form name = "po_preview" action = "po_detail.cfm" method = "post">
    <table>
        <cfloop query="vender">
            <tr>
                <td>ID :  </td>    <td><input name = "vender_id" value = "#vender_id#" readonly = "true" </td>
            </tr>
            <tr>
                <td>Name :  </td>    <td><input name = "vender_name" value = "#Vender_name#" readonly = "true"</td>
            </tr>
            <tr>
                <td>Contact :  </td>    <td><input name = "vender_contact" value = "#vender_contact#" readonly = "true"</td>
            </tr>
            <tr>
                <td>Address :  </td>    <td><input name = "vender_address" value = "#vender_address#" readonly = "true" </td>
            </tr>  
        </cfloop>
        </table>
        <hr>
    <p> Customer Detail: </p>
    <table>
        <tr>
            <td>Name:</td>
            <td><input type = "text" name = "cus_Name" value = "BJS Soft"></td>
        </tr>
        <tr>
            <td>Address:</td>
            <td><input type = "text" name = "cus_Address" value = "Main Cantt Shami Road Near Fortress Stadium Lahore"></td>
        </tr>
        <tr>
            <td> Contact: </td>
            <td><input type = "text" name = "cus_Contact" value =  "+92 345 1234567"> <td>
        </tr>
    </table>
    <hr>
    <p> Products Detail: </p>
    <table>
        <tr>
           <th> Prod_id </th>
           <th> Prod_title </th>
           <th> SKU </th>
           <th> Current Stock </th>
        </tr>
        <cfloop query="products">
            <tr>
                <td><input type = "number" name = "prod_id" value = "#prod_id#" readonly = "true" > </td>
                <td><input type = "text" name = "Prod_title" value = "#title#" readonly = "true"> </td>
                <td><input type = "text" name = "prod_SKU" value = "#sku#" readonly = "true"> </td>
                <cfset current_stoke = #stoke_in# - #stoke_out#>
                <td><input type = "number" name = "prod_stock" value = "#current_stoke#" readonly = "true"></td>
            </tr>
        </cfloop>
    </table>
    </form>
    <hr>
    <p> Order Details: </p>
    <table>
    <!---form to update stock --->
    <form name = "po_preview" action = "generate_po.cfm" method = "post">
        <tr>
           <th> Prod_title </th>
           <th> Item Quantity </th>
           <th> Order Amount </th>
           <th> index </th>
        </tr>
<!---         query="po_products" --->
        <cfset loop_index = "#count.no_of_products#">
        Total SKU: #loop_index#
            <cfloop from = "1" to = "1"  index = "i">
            <cfloop query = "po_products">
            <tr>
                <td><input type = "text" name = "Prod_title#i#" value = "#po_products.prod_title#" readonly = "true"> </td>
                <td><input type = "number" name = "order_quantity#i#" value = "#po_products.Prod_Quantity#" readonly = "true"> </td>
                <td><input type = "Number" name = "order_amount#i#" required> </td>
                <td> #i# </td>
                <cfset i = i + 1>
            </tr>
            </cfloop>
            </cfloop>
    </table>
    <hr>
    <input type = "hidden" name = "Vender_name" value = "#vender.Vender_name#">
    <input type = "hidden" id = "status" name = "status" value = "Added">
    <input type = "hidden" name = "prod_sku" value = "#products.sku#">
    <input type = "hidden" name = "po_id" value = "#form.id#" >
    <input type = "hidden" name = "no_of_products" value = "#count.no_of_products#">
    <input type = "submit" class = "btn btn-success" value = "Add to Stock">
    </form>
    <!--- Return PO --->
    <form action = "">
    <input class = "btn btn-danger" type = "submit" value = "Return PO">
    </form>
    <a href = "index.cfm"><button class = "btn btn-secondary"> Back to Dashboard </button></a>
    <cfelse>
    <h1 class = "text-danger"> You Can't Enter this page without any valid data </h1>
    <a href = "index.cfm"><button class = "btn btn-secondary"> Back to Dashboard </button></a>
    </cfif>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
</cfoutput>