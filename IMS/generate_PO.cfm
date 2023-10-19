<cfoutput>
    <cfinclude  template="bootstrap.cfm">
    <cfinclude  template="header.cfm">
    <cfif structKeyExists(session, 'loggedIn')> <!--- Alow only Logged in Users --->
    <cfquery name = "products">
        select * 
        from products
    </cfquery>
    <cfquery name = "vendors">
        select *
        from vendors
    </cfquery>
            <cfif structKeyExists(form, 'status')>
            <cfif form.status eq "added">
             <!--- Check here --->
            <cfloop from = "1" to = "#form.no_of_products#" index = "i">
            <cfset Amount = #Evaluate("Form.order_amount#i#")#> <!--- concatinate name of variable by value of i---> 
            <cfset title = #Evaluate("Form.prod_title#i#")#>
            <cfset quantity = #Evaluate("Form.order_quantity#i#")#>
            <cfquery name = "update_po_products">
                update po_products
                set Prod_amount = "#amount#"
                where  PO_Num = "#form.po_id#" and prod_title = "#title#"
             </cfquery>
            <cfquery name = "products"> <!--- in case of Adding PO to stock--->
                select *
                from products
                where title = "#title#"
            </cfquery>
            <cfset cost_per_item = #amount# / #quantity# >
            <cfset stock_in = #quantity# + #products.stoke_in#>
            <cfquery name = update_stock>
                update products
                set vendor = "#form.Vender_name#" , cost = "#cost_per_item#" , stoke_in = "#stock_in#"
                where title = "#title#"
            </cfquery>
             <cfdump  var="#amount#">
             <cfset i = i + 1>
             </cfloop>

    <!---        <cfquery name = "update_stock">
                update products
                set vendor = '#form.vender_name#', cost = '#cost_per_item#', stoke_in = '#stoke_import#'
                where sku = "#form.prod_SKU#"
            </cfquery> --->
            <cfquery name = "update_status">
                update po_num
                set  PO_status = '#form.status#'
                where PO_num = '#form.po_id#'
            </cfquery>
            <h1> Stock Added Successfully </h1>
            </cfif>
             </cfif>
    <!--- Save PO --->
    <cfif structKeyExists(form, 'save_Po')>
        <cfquery name = "save_po">
            update po_num 
            set po_status = "Pending"
            where PO_num = '#form.po_id#'
        </cfquery>
        <h1 class = "text-success"> PO Saved Successfully! With PO Number #form.po_id#  </h1>
    </cfif>
    <hr>
    <cfif structKeyExists(form, 'Generate')> <!--- Generate a PO if Generate button Clicked --->
    <cfquery name = generate_PO> 
        insert into po_num (PO_Num, PO_Name, PO_Status, Delivery_Address, PO_vendor)
        values (null, "PO", "Draft", "BJS Soft Lahore", '#form.vendor#')
    </cfquery>
    </cfif>
        <cfquery name = "po_number">
        select * from po_num
        order by po_num desc
        limit 1
    </cfquery>
    <cfif structKeyExists(form, 'add')> <!--- will add each product into one po --->
        <cfquery name = addProduct>
            insert into po_products (id , prod_title, prod_quantity, Prod_amount, prod_vendor, Po_num)
            values (null, '#form.product#', '#form.quantity#', 0 , '#form.vendor#' , '#form.PO_num#')
        </cfquery>
    </cfif>
    <center>
<cfif structKeyExists(form, 'generate') or structKeyExists(form, 'add')> <!--- alow only when generate button hit ---> 
    <table>
        <tr> 
            <td>   
                <tr>
                    <form name = "PO" id = "PO" Action = "generate_po.cfm" Method = "post">
                    <td>
                        <input type = "text" name = "vendor" value = "#form.vendor#" readonly class = "form-control">
                    </td>
<!---          <td><input type = "text" name = "vendor" placeholder = "Vender Name" class = "form-control" required = "true"> </td> --->
                    <td>    <select class="form-select" name = "product">
                                <option disabled="disabled" > Product </option>
                            <cfloop query = "products">
                                <option value = "#title#"> #title# </option>
                            </cfloop>
                        </select>
                    </td>  
<!---                     <td><input type = "text" name = "Product" placeholder = "Product SKU" class = "form-control" required = "true"> </td> --->
                        
                    <td><input type = "Number" name = "Quantity" placeholder = "Product Quantity" class = "form-control" required = "true"> </td>
                    <input type = "hidden" name = "add" value = "true"> 
                    <input type = "hidden" name = "PO_num" value = "#po_number.PO_num#">
                    <td><input type = "submit" value = "Add Product" class = "btn btn-primary"> </td>
                    </form>
                </tr>
            </td>
        </tr>
    </table>
    </center>
    </cfif>
    <cfif structKeyExists(form, 'po_num')> <!--- If product added by upper button will be shown below --->
        <cfquery name = "po_products"> <!--- Query Will print All Products in One PO --->
            select PO_products.Prod_title, PO_products.Prod_Quantity 
            from po_products
            where po_num = "#form.po_num#"
        </cfquery>
        <table class = "table">
            <tr>
                <th> Title </th>
                <th> Quantity </th>
            </tr>
        <cfloop query = "po_products">
            <tr>
                <td> #Prod_title# </td>
                <td> #prod_Quantity# </td>
            </tr>
        </cfloop>
        </table>
        <form action = "generate_PO.cfm" method = "post">
            <input type = "hidden" name = "save_Po" value = "true">
            <input type = "hidden" name = "po_id" value = "#form.po_num#">
            <input type = "submit" value = "Save PO" class = "btn btn-success"> <!--- this button will save PO --->
        </form>
    </cfif>
    <a href = "index.cfm"> Goto Dashboard </a>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
</cfoutput>