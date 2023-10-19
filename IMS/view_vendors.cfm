<cfoutput>
    <cfinclude  template="header.cfm">
    <cfif structKeyExists(session, 'loggedIn')>
    <cfquery name = "vendors">
        select * 
        from vendors
    </cfquery>
    <table class = "table">
        <tr>    
            <th> Vendor ID </th>
            <th> Vendor Name </th>
            <th> Vendor Contact </th>
            <th> Vendor Address </th>
        </tr>
    <cfloop query = "vendors">
        <tr>
            <td> #vender_id# </td>
            <td> #vender_name# </td>
            <td> #vender_contact# </td>
            <td> #vender_address# </td>
        </tr>
    </cfloop>
    </table>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
</cfoutput>