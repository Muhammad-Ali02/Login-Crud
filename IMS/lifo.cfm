<cfoutput>
<cfinclude  template="header.cfm">
<cfparam  name="quantity2" default = "0">
    <cfquery name = "product_name">
        select title
        from products
    </cfquery>
    <cfquery name = "count">
        select count(title) as counter
        from products
    </cfquery>
    <!--- loop will save product name with index number --->
    <cfloop from = "1" to = "1" index = "a">
        <cfloop query = "product_name">
            <cfset "product_name#a#" = #title#>
            <cfset a = a + 1>
        </cfloop>
    </cfloop>
<!----------------------------------------------------------------------------->
    <cfloop from = "1" to = "#count.counter#" index = "b" >
<!---_______________________________________________________________________--->
        <cfquery name = "po">
        select po.prod_title as title, po.prod_quantity as quantity, po.prod_amount as Amount, po.po_num as po, p.title, stoke_out as stock_out
        from po_products po, products p
        where po.prod_title = p.title  and p.title = "#evaluate("product_name#b#")#"
        group by amount 
        order by po.po_num desc
    </cfquery>
            <cfquery name = "count_po"> <!--- Query to Count POs against one product --->
                select count(po_num) as total_po
                from po_products po, products p
                where po.prod_title = p.title  and p.title = "#evaluate("product_name#b#")#" 
                order by po.po_num desc
            </cfquery>
    <cfloop from = "1" to = "1" index = "c"> 
    <cfloop query = "po">
        <cfset "Quantity#c#" = #Quantity#>
        <cfset "Amount#c#" = #Amount#>
        <cfset "stock_out#c#" = #stock_out#>
        <cfset "cost_per_item#c#" = #Amount# / #Quantity#>
        <cfset "PO#c#" = #PO#>
        </tr>
        <cfset c = c + 1>
    </cfloop>
    </cfloop>
    </table>
        <!--- Quantity1 from New PO --->
    <cfset counter = 1> 
    <cfloop index="q" from="#counter#" to="1">
<cfif counter gt 0 >
        <cfif #evaluate("quantity#counter#")# lt #evaluate("stock_out#counter#")#  > <!--- FIFO --->
            <cfset "remaining#counter#" = 0>
        <cfelse>
            <cfset "remaining#counter#" = #evaluate("quantity#counter#")# - #evaluate("stock_out#counter#")# >
        </cfif>
        <br> Product: Title #evaluate("product_name#b#")# <br>
        <br> 
            <cfdump  var="#count_po#" label = "#evaluate("product_name#b#")#"> <br>
        Remaining Products: #evaluate("remaining#counter#")#
        <cfset "value#counter#"  = #evaluate("remaining#counter#")# * #evaluate("cost_per_item#counter#")# >
        Total Value of Old PO: #evaluate("value#counter#")# <br>
        <cfset previous = #evaluate("#counter#")#> <!--- to control flow of loop --->
        <cfset counter = #evaluate("#counter#")# - 1 >
        
    <cfif counter gt 0 >
        <cfif (#evaluate("quantity#counter#")# lt (#evaluate("stock_out#counter#")# - #evaluate("quantity#counter#")#)) >
            <cfset "remaining#counter#"  = 0>
        <cfelse>
            <cfset "remaining#counter#" = (#evaluate("quantity#counter#")# - #evaluate("stock_out#counter#")# + #evaluate("quantity#previous#")#  - #evaluate("remaining#previous#")#) >
        </cfif>
        Remaining Products: #evaluate("remaining#counter#")#
        <cfset "value#counter#" = #evaluate("remaining#counter#")# * #evaluate("cost_per_item#counter#")# >
        total value of New PO: #evaluate("value#counter#")# <br>
        <cfset value = #evaluate("value#counter#")# + #evaluate("value#previous#")#>
        total Value of Product: #value#
    <cfelse>
        <cfset value  = "#value1#"> <!--- if po counter = 0 then stop loop --->
    </cfif>
        <!--- Query to update Value of FIFO --->
        <cfquery name = "lifo">
            update products
            set fifo = #value#
            where title = "#evaluate("product_name#b#")#"
        </cfquery>
</cfif>
    </cfloop>
        <!--- LIFO --->
        <!---
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
            where title = "#evaluate("product_name#b#")#"
        </cfquery> --->
<!----------------------------------------------------------------------------->
    </cfloop>
<!---_______________________________________________________________________--->
</cfoutput>