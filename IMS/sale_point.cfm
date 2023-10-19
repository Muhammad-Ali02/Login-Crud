<cfoutput>
<cfinclude  template="header.cfm">
<cfif structKeyExists(url, 'id') >
    <cfset form.invoice_id = url.id>
    <cfquery name = "invoice_detail">
        select * from invoice where invoice_id = '#url.id#'
    </cfquery>
    <cfif invoice_detail.status eq "paid">
        <p> Customer Name : #invoice_detail.customer_name# </p>
        <p> Created Date and Time: #invoice_detail.created_date# </p>
    </cfif>
</cfif>
<cfquery name = "products">
    select * from products
</cfquery>
<cfif structKeyExists(form, "create")>
    <cfquery name = "create_invoice">
        insert into invoice (invoice_id, customer_name, amount, discount, payable, status)
        values (null, "Unknown", 0, 0, 0, "Draft")
    </cfquery>
</cfif>
    <cfquery name = "invoice">
        select * from invoice
        order by invoice_id desc
        limit 1
    </cfquery>
<cfif structKeyExists(form, 'add')>
    <cfquery name = "one_product"> <!--- This query will return a product , we'll use its price and cost --->
    select * from products
    where title = "#form.products#"
    </cfquery>
<!---     <cfif invoice_products.product_title eq form.products> <!--- condition to check duplicate product title 
        <cfset quantity_update = #form.product_quantity# + #invoice_products.product_quantity# >
        <cfquery name = "add_products"> <!--- update quantity if product already in invoice --->
            update invoice_products
            set  product_quantity = '#quantity_update#'
            where product_title = '#form.products#'
        </cfquery>
    <cfelse> <!--- update or insert ---> ---> --->
    <cfquery name = "get_invoice_products">
        select * from invoice_products
        where invoice_id = "#form.invoice_id#" and product_title = "#form.products#"
    </cfquery>
<!---     <cfset discount_per_item = (#Product_price# / 100 * #form.discount#) * #product_quantity#> --->
    <!--- if Product already selected only quantity will be updated --->
        <cfif get_invoice_products.product_title eq #form.products#>
            <cfset update_quantity = #form.product_quantity# + #get_invoice_products.product_quantity#>
            <cfset discount_per_item = get_invoice_products.product_price / 100 * #form.discount# * #form.product_quantity#>
            <cfset price = #get_invoice_products.product_price# * #update_quantity#>
            <cfquery name = "update_products">
                update invoice_products
                set product_quantity = "#update_quantity#", discount = '#discount_per_item#', total_price = "#price#"
                where product_title = "#form.products#"
            </cfquery>
        <cfelse>
        <cfquery name = "add_products"> <!--- inserting Products to invoice ---> 
            insert into invoice_products (id, product_title, product_price, product_cost, invoice_id, product_quantity, total_price, discount)
            values (null, '#form.products#', '#one_product.price#', '#one_product.cost#', '#form.invoice_id#', '#form.product_quantity#', 0, 0)
        </cfquery>
        
            <cfquery name = "discount">
        select * from invoice_products
        where invoice_id = "#form.invoice_id#"
    </cfquery>  
                <cfloop query= "discount">
                <cfset discount_per_item = discount.product_price / 100 * #form.discount# * #discount.product_quantity#>
                <cfset price_total = #form.product_quantity# * #product_price#>
                <cfquery name = "update_discount">
                    update invoice_products
                    set discount = "#discount_per_item#", total_price = "#price_total#"
                    where product_title = '#form.products#' and invoice_id = '#form.invoice_id#'
                </cfquery>
                </cfloop>
        </cfif>
        <cfquery name = "update_customer">
            update invoice
            set customer_name = "#form.customer#", created_date = now(), status = "Draft"
            where invoice_id = "#form.invoice_id#"
        </cfquery>
<!---     </cfif> --->
</cfif>
<cfif structKeyExists(form, 'add') or structKeyExists(form, "create") or invoice_detail.status eq "draft">
    <!--- Front End of Invoice --->
    <table>
        <tr> 
            <td>   
                <tr>
                    <form name = "invoice" id = "invoice" Action = "sale_point.cfm" Method = "post">
                    <td><select class="form-select" name = "products">
                            <option disabled="disabled" > Products </option>
                            <cfloop query = "products">
                                <option value = "#title#"> #title# </option>
                            </cfloop>
                        </select>
                    </td> 
                    <td> <input type = "text" name = "customer" placeholder = "Customer Name" class = "form-control" required = "true" <cfif structKeyExists(form, 'customer')> value = "#form.customer#" readonly <cfelseif structKeyExists(url, 'id')> <cfif invoice_detail.status eq "draft"> value = "#invoice_detail.customer_name#"</cfif> </cfif>>
                    <td><input type = "number" name = "product_quantity" placeholder = "Product Quantity" class = "form-control" required = "true"> </td>
                    <td>Discount:</td> <td> <input type = "number" name = "discount" placeholder = "Discount in percentage" class = "form-control" required = "true" <cfif structKeyExists(form, 'discount')> value = "#form.discount#" <cfelse> value = 0> </cfif> </td>
                    <input type = "hidden" name = "add" value = "true"> 
                    <input type = "hidden" name = "invoice_id" value = "#invoice.invoice_id#">
                    <td><input type = "submit" value = "Add Product" class = "btn btn-info"> </td>
                    </form>
                </tr>
            </td>
        </tr>
    </table>
</cfif>
<!--- After Product Added to Invoice --->
<cfif structKeyExists(form, 'invoice_id') or structKeyExists(form, 'add')> <!--- If product added by upper button will be shown below --->
    
    <cfquery name = "invoice_products"> <!--- Query Will print All Products of Bill --->
        select *
        from invoice_products
        where invoice_id = "#form.invoice_id#"
    </cfquery>
        <table class = "table">
            <tr>
                <th> Title </th>
                <th> Quantity </th>
                <th> Discount </th>
                <th> Price per Item  </th>
                <th> Total Price</th>
            </tr>
        <cfloop query = "invoice_products"> 
        <form action = "print_bill.cfm" method = "post">
            <tr>
                <td> <input value = "#Product_title#" name = "product_title" readonly> </td>
                <td> <input value = "#Product_quantity#" name = "product_quantity" readonly </td>
<!---                <cfset discount_per_item = (#Product_price# / 100 * #form.discount#) * #product_quantity#> --->
                <td> #discount# </td>
                <td> <input value = "#Product_price#" readonly > </td>
                <td> <input value = "#total_price#" readonly> </td>
            </tr>
        </cfloop>
            <cfquery name = "total_amount"> <!--- Query Will return the total Amount of All Products ---> 
                select sum(total_price) as total, sum(discount) as total_discount
                from invoice_products
                where invoice_id = "#form.invoice_id#" 
            </cfquery>
            <tr>
                <td> Bill Amount </td>
                <td> </td>
                <td> </td>
                <td> </td>
                <td> <input name = "total_amount" value = "#total_amount.total#" readonly> </td>
            </tr>
            <tr>
            <cfset discount = #total_amount.total_discount#> <!--- discount amount --->
                <td> Discount Amount </td>
                <td> </td>
                <td> </td>
                <td> </td>
                <td> <input name = "discount" value = "#discount#" readonly </td>
            </tr>
            <tr>
            <cfset payable = #total_amount.total# - #discount#>
                <td> Payable Amount </td>
                <td> </td>
                <td> </td>
                <td> </td>
                <td> <input name = "payable" value = "#payable#" readonly </td>
            </tr>
        </table>
            <input type = "hidden" name = "create_bill" value = "true">
            <input type = "hidden" name = "invoice_id" value = "#form.invoice_id#">
            <cfif not structKeyExists(url, 'id')>
            <input type = "submit" value = "Submit" class = "btn btn-success"> <!--- this button will save Invoice --->
            <a href = "print_bill.cfm?discard=#invoice.invoice_id#"> <button type = "button" class ="btn btn-danger"> Discard </button></a>
            <cfelseif invoice_detail.status eq "paid">
            <a href = "view.cfm"> <button type = "button" class = "btn btn-success">Home</button> </a>
            <a href = "print_bill.cfm?return=#url.id#"> <button type = "button" class = "btn btn-danger"> Return Invoice </button> </a>
            <cfelse>
            <input type = "submit" value = "Submit" class = "btn btn-success">
            <a href = "print_bill.cfm?discard=#url.id#"> <button type = "button" class ="btn btn-danger"> Discard </button></a>
            </cfif>
        </form>
        <a href = "index.cfm" > Dashboard </a>
    </cfif>
</cfoutput>