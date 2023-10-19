<html>
<head>
<title> Null Page </title>
<cfinclude  template="bootstrap.cfm">
</head>
<body>
<cfoutput>
        <cfquery datasource = "myDb" name = "conditionQ">
                        select *
                        from sign_up
                        where cnic = #form.cnic#
        </cfquery>
        <cfif conditionQ.cnic eq form.cnic>
                <p> *CNIC already Exists </p>
        </cfif>
         <cfif form.id neq "a" and form.edit eq "b">
                <!--- New User Query --->
                <cfquery datasource = "myDb" name = "testQ3">
                        INSERT INTO sign_up (id, User_Name, father_name, CNIC, Password, Address, contact_no, gender)
                        VALUES (null , '#User_Name#' , '#Father_Name#' , '#CNIC#' , '#Password#' , '#Address#' , '#Contact#' , '#Gender#');
                </cfquery> 
                <!--- Edit Query --->    
        <cfelse>
                <cfquery datasource = "myDb" name = "testQ6">
                        update  sign_up 
                        set User_Name = '#User_Name#', father_name = '#Father_Name#', CNIC = '#CNIC#', Password ='#Password#', Address = '#Address#', contact_no = '#Contact#', gender ='#Gender#'
                        where id = #id#
                </cfquery>
                
        </cfif>

<h1>
Data Succesfully Submitted
</h1>
<br>
<a href = "sign_up.cfm"> <button> Add New Data </button> </a>
<br>
<hr>
<a href = "signup.cfm"> <button> View all Users </button> </a>
</cfoutput>
</body>
</html>