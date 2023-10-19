<cfoutput>
    <cfif isDefined('url.del_id')>
        <cfquery name = "Permanent_DeleteQ">
            Delete from deleted_records where id = #url.del_id#
        </cfquery>
        <cflocation  url="deleted_records.cfm">
    <cfelse>
        <cfquery name = "getDataQ">
            select * from sign_up
            where id = #url.id#
        </cfquery>
        <cfquery name = "copyDataQ">
            INSERT INTO deleted_records (id, User_Name, father_name, CNIC, Password, Address, contact_no, gender, deleted_by, deleted_time)
            VALUES (null , '#getDataQ.User_name#' , '#getDataQ.Father_Name#' , '#getDataQ.CNIC#' , '#getDataQ.Password#' , '#getDataQ.Address#' , '#getDataQ.Contact_no#' , '#getDataQ.Gender#', '#session.loggedIn.userName#' , now());
        </cfquery>
        <cfquery datasource = "myDb" name = "DeleteQ">
                Delete from sign_up where id = #url.id#
        </cfquery>
            <cflocation  url="signup.cfm">
    </cfif>
</cfoutput>

