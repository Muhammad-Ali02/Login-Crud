<cfoutput>
    <cfinclude  template="header.cfm">
    <cfquery name = "po">
        select po.po_num as po_id, po.po_vendor as vendor, sum(products.prod_amount) as amount, po.po_status as status
        from po_num po, po_products products
        where po.po_num = products.po_num and po.po_status = "pending"
        group by po.po_num
        order by po.po_num desc
        limit 20
    </cfquery>
    <cfquery name = "invoice">
        select * 
        from invoice
        order by Invoice_id desc
        limit 20
    </cfquery>
    <p style = "font-weight : bold; color : Green; text-align : center;"> Recently Created Purchase Orders </p>
<!---  Table to Print PO --->
    <table class = "table table-info table-striped table-hover" >
        <tr>
            <th> PO Number </th>
            <th> Vendor </th>
            <th> Total Amount </th>
            <th> Status </th>
        </tr>
        <cfloop query = "po">
        <tr>
            <td> #po_id# </td>
            <td> #vendor# </td>
            <td> #amount# </td>
            <td> #status# </td>
        </tr>
        </cfloop>
    </table>
    <p style = "font-weight : bold; color : Green; text-align : center;"> Recently Created Invoices </p>
<!---  Table to Print Invoice --->
    <table class = "table table-danger table-striped table-hover" >
        <tr>
            <th> Invoice Number </th>
            <th> Customer Name </th>
            <th> Bill Amount </th>
        </tr>
        <cfloop query = "invoice">
        <tr>
            <td> #Invoice_id# </td>
            <td> #Customer_name# </td>
            <td> #amount# </td>
        </tr>
        </cfloop>
    </table>
<a href = "index.cfm"> Dashboard </a>
</cfoutput>