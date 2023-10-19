<cfoutput>
<cfinclude  template="header.cfm">
<h1 style = "text-align: center; color: red"> Stock Report </h1>
    <cfquery name = "stock_report">
        select *
        from products
    </cfquery>
    <table class = "table table-info table-striped table-hover">
    <tr>
        <th> ID </th>
        <th> Title </th>
        <th> SKU </th>
        <th> Vendor </th>
        <th> Current Stock </th>
    </tr>
    <cfloop query = "stock_report">
    <tr>
        <td> #prod_id# </td>
        <td> #title# </td>
        <td> #sku# </td>
        <td> #vendor# </td>
        <cfset current_stock = #stoke_in# - #stoke_out#>
        <td <cfif current_stock lt 10 > style = "color: red;" <cfelseif current_stock lt 1> style = "border-color: red;"</cfif> > #current_stock# </td>
    </tr>
    </cfloop>
    </table>
</cfoutput>