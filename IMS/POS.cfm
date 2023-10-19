<cfinclude  template="header.cfm">
<cfoutput>
    <cfif structKeyExists(session, 'loggedIn')>
    <cfquery name = "searchQ">
        select * from products
    </cfquery>
        <cfif structKeyExists(form, 'customer_name')>
            <cfquery name = "searchQ">
                select * from products
                where title = "#form.product_title#"
            </cfquery>
            <cfset profit = ((#form.payable# - (#form.cost#  * #form.quantity#)))>
            <cfset stoke_out = #searchQ.stoke_out# + #form.quantity#>
            <cfquery name = "update_stoke">
                update products
                set stoke_out = '#stoke_out#'
                where title = "#form.product_title#"
            </cfquery>
            <cfquery name = "insert_sale">
                insert into sales (id, Customer_name, Product_title, Product_Price, Bill_amount, Discount_amount, payable_bill, profit, sale_date, sold_by)
                values (null, '#form.customer_name#', '#form.product_title#', '#form.product_price#', '#form.bill#', '#form.discount#', '#form.payable#' , '#profit#', now() , '#session.loggedIn.userName#')
            </cfquery>
            <p class = "text-success"> <strong> Inventory Updated </strong> </p>
            <a href="POS.cfm" > New Bill </a>
        <cfelseif structKeyExists(form, 'product')>
            <cfquery name = "billQ">
                select * from products
                where title = '#form.product#'
            </cfquery>
            <cfset bill = "#form.quantity#" * "#billQ.price#">
            <cfset discount = '#bill#' / 100 * '#form.discount#'>
            <cfset payable = "#bill#" - "#discount#">
            <!--- form --->
            <form action = "POS.cfm" method = "post">
            <cfset date1 = "#now()#">
            Date: #DateTimeFormat(Date1,"mmm-dd-yyyy")# <br>
            Customer Name: <input value = "#form.customer#" name = "customer_name"> <br>
            Product Title: <input value = "#billQ.title#" readonly name = "product_title"> <br>
            Product Price: <input value = "#billQ.Price#" readonly name = "product_price"> <br>
            Product Quantity: <input name = "quantity" type = "number" value = "#form.quantity#" readonly> <br>
            Bill Amount: <input value = "#bill#" readonly name = "bill"> <br>
            Discount Amount:<input value = "#discount#" readonly name = "discount"> <br>
            Payable: <input value = "#payable#" readonly name = "payable"><br>
            <input type = "number" name = "cost" value = "#searchQ.cost#" hidden = "true">
            <input name = "button" type = "submit" value = "Print Bill">
    <cfelse>  
    <form action = "POS.cfm" method = "post">
    <select class="form-select" name = "product">
            <option disabled="disabled" > Product </option>
            <cfloop query = "searchQ">
                <option value = "#title#"> #title# </option>
            </cfloop>
    </select>
    <input name = "quantity" type = "number" placeholder = "Quantity" class = "form-control">
    <input name = "customer" type = "Text" placeholder = "Customer Name" class = "form-control">
    <input name = "discount" type = "number" placeholder = "Discount in Percentage" class = "form-control">
    <input type = "submit" value = "Add">
    </form>
    </cfif>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
</cfoutput>