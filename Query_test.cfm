<cfoutput>
<!--- Question No 1 --->
<cfquery name = "query1">
    select pname, pno
    from proj
    where budget > 100000
</cfquery>
<cfdump  var="#query1#" label  = "Question 1">
<!--- Question No 2 --->
<cfquery name = "query2">
    select * 
    from workson
    where hours < 10 and resp = "Manager"
</cfquery>
<cfdump  var="#query2#" label  = "Question 2">
<!--- Question No 3 --->
<cfquery name = "query3">
    select eno, ename
    from emp
    where (title = "EE" or title = "SA") and salary > 35000
</cfquery>
<cfdump  var="#query3#" label  = "Question 3">
<!--- Question No 4 --->
<cfquery name =  "query4">
    select emp.ename
    from emp, dept
    where dept.dname = "D1"
    order by emp.salary desc
</cfquery>
<cfdump  var="#query4#" label  = "Question 4">
<cfquery name =  "query4_1"> <!--- second method --->
    select emp.ename
    from emp
    inner join dept
    on emp.dno = dept.dno
    where dept.dname = "D1"
    order by emp.salary desc
</cfquery>
<cfdump  var="#query4_1#" label  = "Question 4 part 2">
<!--- Question No 5 --->
<cfquery name = "query5">
    select * 
    from dept
    order by dname asc
</cfquery>
<cfdump  var="#query5#" label  = "Question 5">
<!--- Questioni No 6 --->
<cfquery name = "query6">    <!--- working Well --->
    select emp.ename, dept.dname, emp.title 
    from emp, dept
    where emp.dno = dept.dno
</cfquery>
<cfquery name = "query6_1"> <!--- Second Method Also Working --->
    select emp.ename, dept.dname, emp.title 
    from emp
    inner join dept
    on emp.dno = dept.dno
</cfquery>
<cfdump  var="#query6#" label  = "Question 6">
<cfdump  var="#query6_1#" label  = "Question 6 Part 2">
<!--- Question No 7 --->
<cfquery name = "query7">
    select proj.pno, proj.pname, workson.hours
    from proj
    inner join workson
    on proj.pno = workson.pno
    where workson.hours > 10
</cfquery>
<cfdump  var="#query7#" label = "Question 7">
<!--- Question No 8 --->
<cfquery name = "query8">
    select proj.pname, dept.dname, proj.budget
    from proj
    inner join dept
    on proj.dno = dept.dno
    where proj.budget < 50000
</cfquery>
<cfdump  var="#query8#" label = "Question 8">
<!--- Question No 9 --->
<cfquery name = "query9">
    select emp.eno, emp.salary
    from emp
    inner join dept
    on emp.dno = dept.dno
    where dept.dname = "Consulting"
    order by emp.salary desc
</cfquery>
<cfdump  var="#query9#" label = "Question 9">
<!--- Question No 10 --->
<cfquery name = "query10">
    select emp.ename, emp.title, proj.pname
    from emp
    inner join workson
    on emp.eno = workson.eno 
    inner join proj
    on workson.pno = proj.pno
</cfquery>
<cfdump  var="#query10#" label = "Question 10">
<!--- Question No 10 Second Method --->
<cfquery name = "query10_2">
    select emp.ename, emp.title, proj.pname, workson.hours
    from emp, proj, workson
    where (emp.eno = workson.eno)
    and (workson.pno = proj.pno)
</cfquery>
<cfdump  var="#query10_2#" label = "Question 10 2nd Method">
<!--- Tuesday Task  --->
<!--- Task 1: Print Employees Name and Their Manager Name --->
<cfquery name = "task1">
    select e.emp_name as employee, m.emp_name as manager
    from employee e
    left join employee m on m.Emp_ID = e.manager_id
</cfquery>
<cfdump  var="#task1#" label = "Task 1">
<!--- Task 2: Print Employee Name who doesn't managing any other Employee --->
<cfquery name = "task2"> <!--- return the employees that are not manager --->
    select e.emp_name as employee
    from employee e
    left join employee m on e.Emp_ID = m.manager_id
    WHERE m.Manager_ID not in <!--- Not will reverse the result of subquery --->
    (select m.Manager_ID from employee where e.emp_id = m.Manager_ID) <!--- return the employees that are manager --->
    GROUP BY e.Emp_Name
</cfquery>
<cfdump  var="#task2#" label = "Task 2">
<!--- Task 3: Print Employee which does not have any department assinged --->
<cfquery name = "task3">
    SELECT dept_employee.Name, dept_employee.Gender, dept_employee.salary, department.name
    from dept_employee
    left join department on dept_employee.id = department.id
    where dept_employee.Dept_id is null
</cfquery>
<cfdump  var="#task3#" label = "Task 3">
<!--- Task 4: Print Departments which doesn't have any employees assigned to it --->
<cfquery name = "task4">
    select dept_employee.name, dept_employee.Gender, dept_employee.salary, department.name as Department
    from department
    left join dept_employee on department.id = dept_employee.Dept_id
    where dept_employee.Dept_id not in ( <!--- Not will reverse the result of subquery --->
    select department.id
    from department
    where dept_employee.Dept_id = department.id) <!--- It will return departments that are assinged to any employee --->
    group by department.name
</cfquery>
<cfdump  var="#task4#" label = "Task 4">
<!--- Task 5: Print Name of city with highest Number of Male Employees --->
<cfquery name = "task5">
    select City, count(gender) as No_of_Employees
    from city_detail
    where gender = "male"
    group by city
    having count(gender)
    order by No_of_Employees desc
    limit 1
</cfquery>
<cfdump  var="#task5#" label = "task5">
<!--- Task 6: Print name of Female Employee with lowest Salaray --->
<cfquery name = "task6">
    select name, City, min(salary) as Emp_Salary
    from city_detail
    where gender = "female"
    group by Name
    having min(salary)
    order by Emp_Salary asc
    limit 1
</cfquery>
<cfdump  var="#task6#" Label = "Task 6">
<!--- Task 7: Print name of Employees who belongs to the city with highest average Salary --->
<cfquery name = "task7">
    select name, City, avg(salary) as Avg_Salary
    from city_detail
    where city = 
    (select City
        from city_detail
        group by city
        having avg(salary)
        order by salary desc
        limit 1)
    group by name
    having avg(salary)
    order by Avg_salary desc
</cfquery>
<cfdump  var="#task7#" Label = "Task 7">
</cfoutput>
