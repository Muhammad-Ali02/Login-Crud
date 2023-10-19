<cfoutput>
<cfinclude  template="header.cfm">
    <cfquery name = "invoices">
        select * from invoice
    </cfquery>
    <table class = "table">
        <tr>
            <th> Invoice ID </th>
            <th> Customer </th>
            <th> Amount </th>
            <th> Discount </th>
            <th> Payable </th>
            <th> Created </th>
            <th> Status </th>
            <th> View </th>
        </tr>
        <cfloop query = "invoices">
        <tr>
            <td> #invoice_id# </td>
            <td> #customer_name# </td>
            <td> #amount# </td>
            <td> #discount# </td>
            <td> #payable# </td>
            <td> #created_date# </td>
            <td> #status# </td>
            <td> <a href = "sale_point.cfm?id=#invoice_id#"> <button class = "btn btn-info"> view </button> </a></td>
        </tr>
        </cfloop>
    </table>
</cfoutput>