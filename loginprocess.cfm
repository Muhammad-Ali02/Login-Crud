<cfif isDefined('form.User_Name')>
    <cfquery datasource="myDb" name = "LoginQ" >
        select * 
        from sign_up
        where User_Name = '#form.User_Name#'
    </cfquery>
    <cfif #form.Password# eq #LoginQ.Password#>
        Hwllo
    </cfif>
    </cfif>