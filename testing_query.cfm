<cfoutput>
    <!--- Distinct Query ---> 
    <cfquery name = "testing">
        select DISTINCT level
        from user_rolls
        order by level desc
    </cfquery>
    <table>
        <tr>
        <th> level </th>
        <tr>
            <cfloop query = "testing">
                <tr>
                <td> #level# </td>
                </tr>
            </cfloop>
    </table>
    <!--- top query--->
    <cfquery name = "testing2">
        SELECT contact_no
        FROM sign_up
        limit 5 
    </cfquery>
    <table>
        <tr>
        <th> Contact No </th>
        <tr>
            <cfloop query = "testing2">
                <tr>
                <td> #contact_no# </td>
                </tr>
            </cfloop>
    </table>
    <!--- Min() Max() queries --->
    <cfquery name = "minQ">
        select min(contact_no)
        from sign_up
    </cfquery>
    <cfdump  var="#minQ#" Label = "Min()">
    <cfquery name = "maxQ">
        select max(contact_no)
        from sign_up
    </cfquery>
    <cfdump  var="#maxQ#" Label = "Max()">
    <!--- count() query  same avg() sum() --->
    <cfquery name = "countQ">
        select count(User_Name)
        from sign_up
        where User_Name = "umar"
    </cfquery>
    <cfdump  var="#countQ#" label = "Count Query">
    <!--- Like Query --->
    <cfquery name = "likeQ">
        select count(User_Name)
        from sign_up
        where User_Name like '%admin%' <!--- % means multiple charactors, _ means single charactor --->
    </cfquery>
    <cfdump  var="#likeQ#" label = "Like Query">
    <!--- In Query --->
    <cfquery name = "inQ">
        select * 
        from sign_up
        where User_Name in ("Umar" , "kashif")
    </cfquery>
    <cfdump  var="#inQ#" label = "In Query">
    <!--- Between Query --->
    <cfquery name = "betweenQ">
        select *
        from sign_up
        where contact_no between 50 and 100
    </cfquery>
    <cfdump  var="#betweenQ#" label = "Between query">
    <!--- As alias in Query --->
    <cfquery name = "aliasQ">
        select User_name as Students, Father_name as Parents
        from sign_up
    </cfquery>
    <cfdump  var="#aliasQ#" Label = "Using As Alias in Query">
    <!--- concatinate Query --->
    <cfquery name = "aliasQ2">
        select User_name, concat(address, ' any string', contact_no) as Adress
        from sign_up
    </cfquery>
    <cfdump  var="#aliasQ2#" Label= "Using As to concatinate">
    <!--- Joins in SQl --->
    <!--- Query for left join ---> 
    <cfquery name = "JoinQ">
        select * 
        from sign_up
        left join user_rolls
        on sign_up.id = user_rolls.roll_id
    </cfquery>
    <cfdump  var="#joinQ#" label = "Left Join in SQL">
    <!--- query for inner join --->
    <cfquery name = "joinQ1">
        select * 
        from sign_up
        inner join user_rolls
        on sign_up.id = user_rolls.roll_id
    </cfquery>
    <cfdump  var="#joinQ1#" Label = "Inner Join">
    <!--- query for right join --->
    <cfquery name = "JoinQ2">
        select * 
        from sign_up
        right join user_rolls
        on sign_up.id = user_rolls.roll_id
    </cfquery>
    <cfdump  var="#joinQ2#" label = "Right Join in SQL">
    <!--- query for full outer join --->
    <cfquery name = "JoinQ3">
        select * 
        from sign_up
        left join user_rolls
        on sign_up.id = user_rolls.roll_id
        union
        select * 
        from sign_up
        right join user_rolls
        on sign_up.id = user_rolls.roll_id
    </cfquery>
    <cfdump  var="#joinQ3#" label = "Full Joins in SQL">
    <!--- query for self join --->
    <cfquery name = "joinQ4">
        select * 
        from sign_up, user_rolls
        where sign_up.user_name = user_rolls.user_name
    </cfquery>
    <cfdump  var="#joinQ4#" label = "Self Join Query">
    <!--- query for Case then else --->
    <cfquery name = "caseQ">
        select contact_no, user_name,
        case 
        when contact_no < 10 then 'Number is Greater than 10'
        when contact_no < 20 and contact_no > 10 then 'Number is Less than 20'
        else 'Number is greater than 20'
        end as compare_String
        from sign_up
    </cfquery>
    <cfdump  var="#caseQ#" label = "Case Then Else Query">
    <!--- isnull() ifnull() coalesce() --->
    <cfquery name = "nullQ">
        select user_name
        from sign_up
        where isNull(created_by) <!--- ifNull(coloumn name, value to replace) --->
    </cfquery>
    <cfdump  var="#nullQ#" label = "isNull()">
    <!--- Creating Procedures --->

</cfoutput>
