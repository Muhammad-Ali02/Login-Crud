<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <cfinclude template = "bootstrap.cfm">
    <title>Form</title>
</head>
<cfoutput>
<cfif structKeyExists(session, 'loggedIn')>
<cfif isDefined('form.edit')>
    <cfif form.edit eq "i">
        <cfquery   name = "conditionQ">
                select *
                from sign_up
                where cnic = #form.cnic#
        </cfquery>
        <cfif conditionQ.cnic eq form.cnic>
            <script>
                alert("CNIC already exists!");
            </script>
<!---             <cflocation  url="sign_up"> --->
        <cfelse>
            <!--- New User Query --->
            
            <cfquery   name = "testQ3">
                INSERT INTO sign_up (id, User_Name, father_name, CNIC, Password, Address, contact_no, gender, created_by)
                VALUES (null , '#User_Name#' , '#Father_Name#' , '#CNIC#' , '#Password#' , '#Address#' , '#Contact#' , '#Gender#', '#session.loggedIn.userName#');
            </cfquery> 
            <script>
                alert("User Created Succesfully");
            </script>
            <cflocation  url="signup.cfm">
        </cfif>
    <cfelseif form.edit eq "u">
        <cfquery   name = "testQ6">
                update  sign_up 
                set User_Name = '#User_Name#', father_name = '#Father_Name#', CNIC = '#CNIC#', Password ='#Password#', Address = '#Address#', contact_no = '#Contact#', gender ='#Gender#'
                where id = #id#
        </cfquery>
        <cflocation  url="signup.cfm">
                
    </cfif>
</cfif>
<body>
    <cfif isDefined('url.id')>
        <cfquery   name = "updateQ">
            SELECT * FROM sign_up
            where id = '#id#'
        </cfquery>
    </cfif>
<center>
    <table>
        <cfif isDefined('url.id')>
            <form name "sign_up" id = "sign_up" method = "post" action="sign_up.cfm?id=#id#">
                <input type = "text" name = "edit" value = "u" hidden = "true">
        <cfelse>
            <form name "sign_up" id = "sign_up" method = "post" action="sign_up.cfm">
                <input type = "text" name = "edit" value = "i" hidden = "true">
        </cfif>

            <tr>
	            <td>Name</td>
                <TD> 
                <input class="form-control" type="text" name="User_Name" maxlength="30" placeholder="Choose User Name" <cfif isDefined('url.id')> value = "#updateQ.User_Name#" <cfelseif isDefined('form.User_Name')> value = "#form.User_Name#" </cfif> >
                </TD>
            </tr>
            <tr> 
                <td>Father's Name</td>	
                <td>
                <input class="form-control" type="text" name="Father_Name" placeholder="Enter Your Father's Name" <cfif isDefined('url.id')> value = "#updateQ.father_name#"  <cfelseif isDefined('form.father_name')> value = "#form.father_name#" </cfif>>
                </td> 
            </tr>
            <tr>
	            <td>Create Password</td>
<!--- minlength="8" --->
                <td><input class="form-control" type="Password" name="Password"  placeholder="Enter New Password" required <cfif isDefined('url.id')> value = "#updateQ.Password#"  <cfelseif isDefined('form.Password')> value = "#form.Password#"</cfif> > (At least 8 characters)
                </td>
            </tr>
            <tr>
                <td>CNIC</td>
                <td> <input class="form-control" type="number" id = "cnic" name="CNIC" placeholder="*****-*******-*" <cfif isDefined('url.id')> value = "#updateQ.CNIC#" readonly = "true" <cfelseif isDefined('form.CNIC')> value = "#form.CNIC#"</cfif>>
                </td>
            </tr>
            <tr>
                <td>Addres</td>
                <td>
                <input class="form-control" type="text" name="Address" placeholder="Enter Your Postel Addres" <cfif isDefined('url.id')> value = "#updateQ.address#"  <cfelseif isDefined('form.address')> value = "#form.address#" </cfif>>
                </td>
            </tr>
            <tr>
                <td>Contact No.</td>
                <td>
                <input class="form-control" type="number" name="Contact" placeholder="Enter Your Mobile Number" <cfif isDefined('url.id')> value = "#updateQ.Contact_no#"  <cfelseif isDefined('form.Contact')> value = "#form.Contact#" </cfif>>
                </td>
            </tr>
            <tr>
                <td>
                <label for = "Gender">Gender:</label> </td> 
                <td> Male <input class="radio" type="radio" name="Gender" value="M" checked = "true" <cfif isDefined('url.id') and updateQ.Gender eq "M"> checked = "true"  </cfif>>
                    Female <input class="radio" type="radio" name="Gender" value="F" <cfif isDefined('url.id') and updateQ.Gender eq "F" or (isDefined('form.Gender') and form.Gender eq "F")> checked = "true"  </cfif>>
                   
                    <input  type = "number" name = "id" <cfif isDefined('url.id')> value = "#url.id#" </cfif> hidden = "true"/>
                </td>
            </tr>
            <tr>
                <td>
                    <input type = "submit" Value = "Save" class = "btn btn-success">
                   
                <td>
    </form>
                <td> 
                    <div >
                        <a href = "login.cfm"> <button class = "btn btn-danger"> login </button> </a>
                    </div>
                </td>
            </tr>
</table>
    </center>
    <cfelse>
        <h1 class = "bg-danger text-light"> Please Login First </h1>
        <a href="user_login.cfm"> <button type="button" class="btn btn-outline-dark">Login</button> </a>
    </cfif>
            
</cfoutput>
</body>
</html>