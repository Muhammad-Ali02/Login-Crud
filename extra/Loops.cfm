<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Form</title>
</head>
<body>
    <cfoutput>
    <form method = "post" action = "testDelete.cfm">
        <input name = "cnic" id = "cnic" type = "number" >
        <input type = "submit" value = "Submit">
    </form> 
        
            <cfquery datasource = "myDb" name = "conditionQ">
                        select *
                        from sign_up 
                        
            </cfquery>
            #conditionQ.cnic#
    
    </cfoutput>
    <cfset myVar=false>
            <cfloop condition="myVar eq false">
    <cfoutput>
            <br> myVar = #myVar#  (still in loop) <br>
    </cfoutput>
        <cfif RandRange(1,10) eq 10>
            <cfset myVar="true">
        </cfif>
    </cfloop>
    <cfoutput>
       <br> myVar = #myVar# (loop has finished) 
    </cfoutput> 
    <script type="text/javascript">
            $(document).ready(function(){
            $(".ap").click(function (){
            var id = this.id;
            $("#txt").val(id);
            $("#myFormId").submit()
        })
    })
    </script>
<body>
    <div id="Test" class="ap">click</div>
   <form id="myFormId" method="post">
    <input id="txt" name="txt" value="" type="text">
    </form>
</body>
<!--- Test it ---> 
</body>
</html>