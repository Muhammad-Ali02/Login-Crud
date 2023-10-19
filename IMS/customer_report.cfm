<cfoutput>
<cfinclude  template="header.cfm">
<h1 style = "text-align: center; color : red;" > Customers Report </h1>
    <cfquery name = "customers">
        select * from invoice
    </cfquery>
    <table class = "table table-dark table-striped table-hover">
    <tr>
        <th> Invoice No. </th>
        <th> Customer Name </th>
        <th> Amount </th>
        <th> Discount </th>
        <th> Paid Amount </th>
        <th> Purchase Date and Time </th>
    </tr>
    <cfloop query = "customers">
    <tr>
        <td> #Invoice_id# </td>
        <td> #Customer_name# </td>
        <td> #amount# </td>
        <td> #discount# </td>
        <td> #payable# </td>
        <td> #created_date# </td>
    </tr>
    </cfloop>
    </table>
</cfoutput>