<cfoutput>
    <cfinclude  template="header.cfm">
    <cfif structKeyExists(form, 'create_bill')>
        <cfquery name = "invoice_update">
            update invoice
            set amount = "#form.total_amount#", discount = "#form.discount#", payable = "#form.payable#", status = "Paid"
            where Invoice_id = '#form.invoice_id#'
        </cfquery>
        <cfquery name = "invoice_products"> <!--- working Ok --->
            select *
            from invoice_products
            where Invoice_id = '#form.invoice_id#'
        </cfquery> 
        <cfquery name = "products"> <!---  query return all products in invoice --->
            select * 
            from products
            where title in (
                select product_title
                from invoice_products
                where invoice_id = "#form.invoice_id#"
            )
        </cfquery>
        <cfquery name = "selecting"> <!--- query will return prodcuts of Invoice with current stock in --->
            select invoice_products.product_title as title, products.stoke_out as stock, invoice_products.product_quantity as quantity
            from invoice_products, products
            where invoice_products.product_title = products.title and invoice_products.invoice_id = "#form.invoice_id#"
        </cfquery>
        <cfloop query ="selecting">
        <cfquery name = "update_products">
            update products
            set stoke_out = "#selecting.stock#" + "#selecting.quantity#"
            where title = "#selecting.title#"
        </cfquery>
        </cfloop>
        <h1> Stock Updated </h1>
    <cfelseif structKeyExists(url, 'discard')> <!--- Delete Invoice --->
            <cfquery>
                delete from invoice where invoice_id = '#url.discard#' 
            </cfquery>
            <h1> Invoice Deleted </h1>
    <cfelseif structKeyExists(url, 'return')> <!--- Invoice Quantity Will be Returned to Stock ---> 
            <cfquery name = "update_invoice">
                update invoice 
                set status = "Returned"
                where invoice_id = "#url.return#"
            </cfquery>
            <cfquery name = "get_products"> <!--- query will return invoice products and current stock in --->
                select a.title as title, a.stoke_in as stock, b.product_quantity as quantity
                from products a, invoice_products b 
                where b.invoice_id = "#url.return#" and a.title = b.product_title
            </cfquery>
            <cfloop query = "get_products" > 
                <cfquery name = "update_stock"> <!--- query will update stock in --->
                    update products
                    set stoke_in = '#get_products.stock#' + '#get_products.quantity#'
                    where title = '#get_products.title#'
                </cfquery>
            </cfloop>
            <h1> Invoice Returned and Stock Updated </h1>
    <cfelse>
    <h1> Data Not Found </h1> <!--- if this page directly hit without any data --->
    </cfif>
    <a href = "index.cfm"> Dashboard </a>
</cfoutput>