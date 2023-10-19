<cfoutput>
<cfinclude  template="header.cfm">
<cfquery name = "all_po">
    select * 
    from po_num
    <cfif structKeyExists(url, 'pending')> 
    where po_status = "pending"
    <cfelseif structKeyExists(url, 'draft')>
    where po_status = "draft"
    </cfif>
</cfquery>
<table class = "table table-warning">
    <thead class = "thead-dark">
    <tr>
        <th> PO Number </th>
        <th> PO Vendor </th>
        <th> PO Status </th>
    </tr>
    </thead>
    <cfloop query = "all_po">
    <tr>
        <td> #po_num# </td>
        <td> #PO_vendor# </td>
        <td> #PO_status# </td>
    </tr>
    </cfloop>
</table>
    <a href = "index.cfm"> <button class = "btn btn-primary"> Dashboard </button>
</cfoutput>