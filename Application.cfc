<cfcomponent output = "false"> 
    <cfset this.name = 'BJS_Umar'>
    <cfset this.applicationTimeOut = createTimespan(0, 1, 30, 0) >
<!--- By defining datasource in this file, no need to use datasource attribute explicitly in each query   --->
    <cfset this.datasource = 'myDb'>
    <cfset this.sessionManagement = true>
    <cfset this.sessionTimeout = createTimespan(0, 0, 30, 0)>
</cfcomponent>