<cfoutput>
<cfinclude  template="header.cfm">
    <cfquery name = "test">
        select *
        from products
    </cfquery>
    <cfdump  var="#test#">
    <cfquery name = "po1">
        select po.prod_title as Title, po.prod_quantity as Quantity, po.prod_amount as Amount, po.po_num as PO, p.title as ptitle
        from po_products po
        right join products p on po.prod_title and p.title
        order by po.po_num desc 
    </cfquery>
        <cfquery name = "po">
        select po.prod_title as title, po.prod_quantity as quantity, po.prod_amount as Amount, po.po_num as po, p.title, stoke_out as stock_out
        from po_products po, products p
        where po.prod_title = p.title and p.title = "Pencil"
        group by amount 
        order by po.po_num desc
        
    </cfquery>
    <cfdump  var="#po#" label = "PO">
    <cfdump  var="#po1#">
    <table class = "table">
        <tr>
        <th> Title </th>
        <th> Quantity </th>
        <th> Amount </th>
        <th> Stock Out </th>
        <th> Cost per Item </th>
        <th> PO No. </th>
        </tr>
    <cfloop from = "1" to = "1" index = "i"> 
    <cfloop query = "po">
        <tr>
        <td> #Title# </td>
        <cfset "Quantity#i#" = #Quantity#>
        <td> #Quantity# </td>
        <cfset "Amount#i#" = #Amount#>
        <td> #Amount# </td>
        <cfset "stock_out#i#" = #stock_out#>
        <td> #Stock_out# </td>
        <cfset "cost_per_item#i#" = #Amount# / #Quantity#>
        <td> #evaluate("cost_per_item#i#")# </td>
        <cfset "PO#i#" = #PO#>
        <td> #PO# </td>
        </tr>
        <cfset i = i + 1>
    </cfloop>
    </cfloop>
    </table>
        <!--- Quantity1 from New PO --->
    <cfparam  name="quantity2" default = "0">
    <cfif quantity2 neq 0>
        <cfif quantity2 lt stock_out2 > <!--- FIFO --->
            <cfset remaining2 = 0>
        <cfelse>
            <cfset remaining2 = #Quantity2# - #stock_out2#>
        </cfif>
        Remaining Products: #remaining2#
        <cfset value2  = #remaining2# * #cost_per_item2#>
        Total Value of Old PO: #value2# <br>
        <cfif quantity1 lt stock_out1 - quantity2>
            <cfset remaining1 = 0>
        <cfelse>
            <cfset remaining1 = (quantity1 - stock_out1 + quantity2 - remaining2) >
        </cfif>
        Remaining Products: #remaining1#
        <cfset value1 = #remaining1# * cost_per_item1>
        total value of New PO: #value1# <br>
        <cfset value = value1 + value2>
        total Value of Product: #value#
        <!--- Query to update Value of FIFO --->
        <cfquery name = "lifo">
            update products
            set fifo = #value#
            where title = "#po.Title#"
        </cfquery>
        <!--- LIFO --->
        <br>
        <cfif quantity1 lt stock_out1 >
            <cfset remaining1 = 0>
        <cfelse>
            <cfset remaining1 = #Quantity1# - #stock_out1#>
        </cfif>
        Remaining Products: #remaining1#
        <cfset value1  = #remaining1# * #cost_per_item1#>
        Total Value of New PO: #value1# <br>
        <cfif quantity2 lt stock_out2 - quantity1>
            <cfset remaining2 = 0>
        <cfelse>
            <cfset remaining2 = (quantity2 - stock_out2 + quantity1 - remaining1) >
        </cfif>
        Remaining Products: #remaining2#
        <cfset value2 = #remaining2# * cost_per_item2>
        total value of OLD PO: #value2# <br>
        <cfset value = value2 + value1>
        total Value of Product: #value#
        <!--- Query to update Value of LIFO --->
        <cfquery name = "lifo">
            update products
            set lifo = #value#
            where title = "#po.Title#"
        </cfquery>
    </cfif>
</cfoutput>