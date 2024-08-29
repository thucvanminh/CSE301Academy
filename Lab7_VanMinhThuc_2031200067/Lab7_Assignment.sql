use salemanagement;
SELECT * from clients;

-- 1. SQL statement returns the cities (only distinct values) from both the "Clients" and the "salesman" 
-- table. 

SELECT city from clients
UNION  
SELECT city from salesman;

-- 2. SQL statement returns the cities (duplicate values also) both the "Clients" and the "salesman" table. 

SELECT city from salesman 
UNION ALL
select city from clients;

-- 3. SQL statement returns the Ho Chi Minh cities (only distinct values) from the "Clients" and the 
-- "salesman" table.
SELECT Client_Name from clients
WHERE city = 'Ho Chi Minh'
UNION
SELECT salesman_name from salesman
WHERE city = 'Ho Chi Minh';

-- 4. SQL statement returns the Ho Chi Minh cities (duplicate values also) from the "Clients" and the 
-- "salesman" table.
SELECT Client_Name from clients
WHERE city = 'Ho Chi Minh'
UNION all
SELECT salesman_name from salesman
WHERE city = 'Ho Chi Minh';

-- 5. SQL statement lists all Clients and salesman.
SELECT client_name as 'Name', 'client' as 'type' from clients
UNION ALL
SELECT salesman_name as 'Name', 'salesman' as 'type' from salesman;


-- 6. Write a SQL query to find all salesman and clients located in the city of Ha Noi on a table with 
-- information: ID, Name, City and Type. 

(SELECT  Client_Number as ID, Client_Name AS `name`, 'client' as `type` 
from clients
WHERE City = 'Hanoi'
UNION ALL
SELECT Salesman_Number as ID, Salesman_Name as `name`, 'salesman' as `type`
from salesman
WHERE City = 'Hanoi');

-- 7. Write a SQL query to find those salesman and clients who have placed more than one order. Return 
-- ID, name and order by ID.

SELECT so.Salesman_Number as ID, s.Salesman_Name as 'Name','Sale Man' as 'Type'
from salesorder so INNER JOIN salesman s on so.salesman_number = s.salesman_number
GROUP by s.salesman_number
HAVING COUNT(*)>1
union all 
SELECT so.Client_Number as ID, c.Client_Name as 'Name','Client' as 'Type'
from salesorder so INNER JOIN clients c on so.client_number = c.client_number
GROUP by c.client_number
HAVING COUNT(*)>1
ORDER BY ID;

-- 8. Retrieve Name, Order Number (order by order number) and Type of client or salesman with the client 
-- names who placed orders and the salesman names who processed those orders. 

SELECT so.Order_Number, c.Client_Name, s.Salesman_Name from salesorder so
INNER JOIN clients c on so.client_number = c.client_number
INNER JOIN salesman s on so.salesman_number = s.salesman_number
order BY Order_Number;
-- 9. Write a SQL query to create a union of two queries that shows the salesman, cities, and 
-- target_Achieved of all salesmen. Those with a target of 60 or greater will have the words 'High 
-- Achieved', while the others will have the words 'Low Achieved'. 

SELECT Salesman_Number, Salesman_Name, City, Target_Achieved, case WHEN Target_Achieved >60 then 'High Achieved'
 end 'Mark' from salesman
 WHERE Target_Achieved >60
 UNION
 SELECT Salesman_Number, Salesman_Name, City, Target_Achieved, case WHEN Target_Achieved <=60 then 'Low Achieved'
 end 'Mark' from salesman
 WHERE Target_Achieved <=60
 ORDER BY Salesman_Number;

 -- 10. Write query to creates lists all products (Product_Number AS ID, Product_Name AS Name, 
-- Quantity_On_Hand AS Quantity) and their stock status. Products with a positive quantity in stock are 
-- labeled as 'More 5 pieces in Stock'. Products with zero quantity are labeled as ‘Less 5 pieces in Stock'.

SELECT Product_Number as ID, Product_Name as 'Name', Quantity_On_Hand as 'Quantity' , 
case when Quantity_On_Hand>=0 then 'More 5 pieces in Stock' ELSE
'Less 5 pieces in Stock' end 'Stock Status'  from product
;

-- 11. Create a procedure stores get_clients _by_city () saves the all Clients in table. Then Call procedure stores.

    delimiter //
    CREATE PROCEDURE get_clients_by_city(IN cityin VARCHAR (30))
    BEGIN
        SELECT * from clients
        WHERE city = cityin;
    END //
    delimiter ;


-- 12. Drop get_clients _by_city () procedure stores.
drop procedure get_clients_by_city;

-- 13. Create a stored procedure to update the delivery status for a given order number. Change value 
-- delivery status of order number “O20006” and “O20008” to “On Way”.
delimiter $$
	create procedure update_status()
    begin
		update salesorder set delivery_status = 'On Way'
        where order_number ='O20006' or order_number = 'O20004';
    end $$
delimiter ;
drop procedure update_status;
call update_status;
-- 14. Create a stored procedure to retrieve the total quantity for each product.    

delimiter $$
	create procedure show_quantity ()
	begin
		select Product_Number, Product_Name, Quantity_On_Hand from product;
    end$$
delimiter ;
drop procedure show_quantity;
call show_quantity;

-- 15. Create a stored procedure to update the remarks for a specific salesman. 
select * from salesman;

delimiter $$
	create procedure updateNote4Salesman(IN sm_ID varchar(15), IN sm_Note varchar(255))
    begin
		update salesman set note = sm_Note
        where salesman_number  = sm_ID;
    end$$
delimiter ;
call updateNote4Salesman('S004','Good');
select * from salesman;

-- 16. Create a procedure stores find_clients() saves all of clients and can call each client by client_number.
delimiter $$ 
	create procedure find_client(IN cl_Number varchar(10))
    begin
		select * from clients
        where client_Number = cl_Number;
	end$$
delimiter ;
select * from clients;
call find_client('C101');

-- 17. Create a procedure stores salary_salesman() saves all of clients (salesman_number, salesman_name, 
-- salary) having salary >15000. Then execute the first 2 rows and the first 4 rows from the salesman 
-- table.

delimiter $$ 
	create procedure salary_salesman(IN limitIn INT)
    begin
	select Salesman_Number,Salesman_Name,Salary from salesman
	group by Salesman_Number
    having salary > 15000
    limit limitIn;
    end$$
delimiter ;
drop procedure salary_salesman;
call salary_salesman(2);

-- 18. Procedure MySQL MAX() function retrieves maximum salary from MAX_SALARY of salary table.

delimiter $$ 
	create procedure max_salary()
    begin
	select Salesman_Number,Salesman_Name,Salary from salesman
    order by Salary desc
    limit 1;
    end$$
delimiter ;

-- 19. Create a procedure stores execute finding amount of order_status by values order status of salesorder table.
delimiter $$ 
	create procedure find_amount_status()
    begin
	select Order_Status, count(*) from salesorder
	group by Order_Status;
    end$$
delimiter ;

-- 21. Count the number of salesman with following conditions : SALARY < 20000; SALARY > 20000; 
-- SALARY = 20000.

delimiter $$ 
	create procedure count_salary_status()
    begin
	select 'SALARY < 20000' as 'TYPE',count(*) as 'Number Of Salesman' from salesman
	where salary<20000
	union all
	select 'SALARY = 20000' as 'TYPE',count(*) as 'Number Of Salesman' from salesman
	where salary=20000
	union all
	select 'SALARY > 20000' as 'TYPE',count(*) as 'Number Of Salesman' from salesman
	where salary>20000;
    end$$
delimiter ;
call count_salary_status;


-- 22. Create a stored procedure to retrieve the total sales for a specific salesman.
delimiter $$
	create procedure find_total_sales(IN smID varchar(15), out totalsales int)
    begin
    select sum(order_quantity) into totalsales
    from salesorder as so, salesorderdetails sod
    where so.order_number = sod.order_number and so.Salesman_Number = smID;
    end$$
delimiter ;
set @totalsales =0;
call find_total_sales('S001',@totalsales);

-- 23. Create a stored procedure to add a new product: 
delimiter $$
	create procedure add_new_product(in p_number varchar(15), in p_name varchar(25), in p_quantity_on_hand int,
									in p_quantity_sell int, in p_sell_price decimal(15,4), in p_cost_price decimal(15.4))
	begin
    insert into product value (p_number,p_name,p_quantity_on_hand,p_quantity_sell,p_sell_price,p_cost_price);
    end$$
delimiter ;


    