<cfoutput>
    <cfinclude  template="Header.cfm">
    <h1 style = "text-align: center; color: red"> Sales Report </h1>
    <cfquery name = "sale_report">
        select products.product_title title, sum(products.product_quantity) as products_count, sum(products.total_price) as sale_price, 
        sum(products.discount) as discount, sum(products.product_cost) as cost
        from invoice_products products, invoice
        where invoice.status = "Paid"
        group by title
    </cfquery>
    <table class = "table table-info table-striped table-hover">
        <tr>
            <th> Product Name </th>
            <th> Sold Products </th>
            <th> Cost Per Item </th>
            <th> Total Cost </th>
            <th> Sale Price </th> 
            <th> Discount </th>
            <th> Profit </th>
        </tr>
        <cfloop query = "sale_report">
        <tr> 
            <td> #title# </td>
            <td> #products_count# </td>
            <td> #cost# </td>
            <cfset total_cost = #cost# * #Products_count#>
            <td> #total_cost# </td>
            <td> #sale_price# </td>
            <td> #discount# </td>
            <cfset profit = #sale_price# - #total_cost# - #discount#>
            <td> #profit# </td>
        </tr>
        </cfloop>
    </table>
    <a href = "view.cfm"> <button class = "btn btn-success"> Home </button> </a> 
    <a href = "index.cfm"> <button class = "btn btn-primary"> Dashboard </button> </a>
</cfoutput>