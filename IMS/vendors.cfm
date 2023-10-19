<cfoutput>
    <cfinclude  template="header.cfm">
    <cfif structKeyExists(session, 'loggedIn')>
    <cfparam  name = "merror" default = 0>
    <p style = "text-align : center;" class = "Text-secondary"> Be Carefull! If you Create Once, Never be Delete or Update</p>
    <cfif structKeyExists(form, 'vendor')> <!--- show error when duplicate vendor name --->
        <cfquery name = "check">
            select * from vendors
            where vender_name = '#form.vendor#'
        </cfquery>
        <cfif check.vender_name eq form.vendor>
          <center> <strong> <p class = "text-danger"> *Vendor Name already Exists </p> </strong> </center>
          <cfset merror = 1>
        <cfelse>
        <cfquery name = "insert_vender">
            insert into vendors (vender_id, vender_name, vender_contact, vender_address)
            values (null , '#vendor#', '#Contact#', '#Address#')
        </cfquery>
          <center> <strong> <p class = "text-success"> Vendor Created successfully </p> </strong> </center>
        </cfif>
    </cfif>
    <center>
    <table>
        <tr> 
            <td>   
            <form name = "vendor" id = "vendor" Action = "vendors.cfm" Method = "post">
                <input type = "text" name = "vendor" placeholder = "Vender Name" class = "form-control" <cfif #merror# eq 1 > value = "#form.vendor#" style = "border-color : red; color : red;" </cfif>>
                <hr>
                <input type = "text" name = "Contact" placeholder = "Vendor Contact" class = "form-control" <cfif #merror# eq 1> value = "#form.Contact#" </cfif>>
                <hr>
                <input type = "text" name = "Address" placeholder = "Vendor Address" class = "form-control" <cfif #merror# eq 1> value = "#form.address#" </cfif>>
                <hr>
                <input type = "submit" value = "Create Supplier" class = "btn btn-primary">
            </form>
            <td>
        </tr>
    </table>
    </center>
    <a href="index.cfm"> <button class = "btn btn-info"> Home Page</button> </a> 
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
</cfoutput>