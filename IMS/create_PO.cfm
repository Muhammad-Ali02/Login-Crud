<cfoutput>
    <cfinclude  template="bootstrap.cfm">
    <cfif structKeyExists(session, 'loggedIn')>
    <cfquery name = "products">
        select * 
        from products
    </cfquery>
    <cfquery name = "vendors">
        select *
        from vendors
    </cfquery>
    <hr>
    <h1> PO: </h1>
    <center>
    <table>
        <tr> 
            <td>   
                <tr>
                    <form name = "PO" id = "PO" Action = "generate_PO.cfm" Method = "post">
                    <td class = "text-primary" style = "font-weight : bold"> Select Vendor: </td>
                    <td>
                        <select class="form-select" name = "vendor">
                            <option disabled="disabled"> Vendor </option>
                            <cfloop query = "vendors">
                                <option value = "#vender_name#">#vender_name# </option>
                            </cfloop>
                        </select>
                    </td>
                    <td>
                    <input type = "hidden" name = "Generate" value = "Generate" > <!--- Generates a PO Number --->
                    <input type = "submit" value = "Generate PO" class = "btn btn-success">
                    <td>
                    </form>
                </tr>
            </td>
        </tr>
    </table>
    </center>
    <br>
    <center>
        <table>
            <tr> <!--- Form to check Status of Existing PO's --->
                <form name = "PO_status" id = "PO_status" action = "po_preview.cfm" method ="post">
                <td> <strong> Enter PO Number: </strong> </td>
                <td> <input type = "number" placeholder = "Enter PO Number" name = "id" required = "true" class = "form-control"> </td>
                <td> <input type = "submit" value = "Check Status" class = "btn btn-secondary"></td>
                </form>
            </tr>
        </table>
    <hr>
    <a href = "all_po.cfm?draft=true"> <button class = "btn btn-dark"> Draft PO </button></a>
    <a href = "all_po.cfm?pending=true"> <button class = "btn btn-info"> Pending PO </button></a>
    <a href = "all_po.cfm?all=true"><button class = "btn btn-warning"> All PO </button> </a>
    </center>
    <hr>
    </center>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>

</cfoutput>