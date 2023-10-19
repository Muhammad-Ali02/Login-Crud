<cfoutput>
    <cfinclude  template="header.cfm">
    <cfif structKeyExists(session, 'loggedIn')>
    <cfif structKeyExists(form, 'create')>
        <cfif form.create eq 1> 
        <cfquery name = "generate"> <!--- In case of generation New PO --->
            insert into pending_po (PO_ID, Prod_SKU, Order_Quantity, Order_Amount, delivery_address, customer, Vendor_Name, PO_status)
            values(null , '#form.prod_SKU#', '#form.order_quantity#', null , '#form.order_delivery#' , '#form.cus_Name#', '#form.vender_name#', '#form.status#')
        </cfquery>
        <cfquery name = "search">
            select *
            from pending_po
            order by PO_ID desc
            limit 1
        </cfquery>
        <h1 class = "text-success" style = "text-align : center"> *PO Created with PO No. #search.po_id#</h1>
        <cfelse>
            <cfquery name = "products"> <!--- in case of Adding PO to stock --->
                select *
                from products
                where sku = "#form.prod_sku#"
            </cfquery>
            <cfset cost_per_item = #form.order_amount# / #form.order_quantity#>
            <cfset stoke_import = #form.order_quantity# + #products.stoke_in#>
            <cfquery name = "update_stock">
                update products
                set vendor = '#form.vender_name#', cost = '#cost_per_item#', stoke_in = '#stoke_import#'
                where sku = "#form.prod_SKU#"
            </cfquery>
            <cfquery name = "update_status">
                update pending_po
                set Order_amount = '#form.order_amount#', PO_status = '#form.status#'
                where po_id = '#form.po_id#'
            </cfquery>
            <h1> Stock Added Successfully </h1>
        </cfif>
        <cfinclude  template="create_po.cfm">
        <a href = "index.cfm"> <button type = "button" class = "btn btn-secondary">Goto Dashboard </button> </a>
    <cfelse>
    <h1> Please Enter a valid Data </h1>
    <a href="index.cfm"><input type = "button" value = "Dashboard" class = "btn btn-primary"> </a>
    </cfif>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
</cfoutput>