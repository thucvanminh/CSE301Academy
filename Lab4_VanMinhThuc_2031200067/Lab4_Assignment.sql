use SaleManagement;

-- 1. Show the all-clients details who lives in “Binh Duong”.
select * from clients where Province = 'Binh Duong';

-- 2. Find the client’s number and client’s name who do not live in “Hanoi”.
select * from clients where Province <> 'HaNoi';

-- 3. Identify the names of all products with less than 25 in stock. 
select * from product where quantity_on_hand < '25';

-- 4. Find the product names where company making losses. 
select * from product where sell_price < cost_price;

-- 5. Find the salesman’s details who are able achieved their target.
select * from salesman where target_achieved >= sales_target;

-- 6. Select the names and city of salesman who are not received salary between 10000 and 17000.
select salesman_name,city from salesman where salary not between 10000 and 17000;

-- 7. Show order date and the clients_number of who bought the product between '2022-01-01' and 
-- '2022-02-15'
	select Order_Date,Client_Number from salesorder where Order_Date between '2022-01-01' and '2022-02-15';
    
    -- 8. Find the names of cities in clients table where city name starts with "N"
    select city
    from clients 
    where city like 'N%';
    
    -- 9. Display clients’ information whose names have "u" in third position. 
    select * 
    from clients
    where client_name like '__u%';
    
    -- 10. Find the details of clients whose names have "u" in second last position. 
     select * 
    from clients
    where client_name like '%u_';
    
    -- 11. Find the names of cities in clients table where city name starts with "D" and ends with “n”.
    select city
    from clients
    where city like 'D%n';
    
    -- 12. Select all clients details who belongs from Ho Chi Minh, Hanoi and Da Lat.
    select *
    from clients
    where city in ('Ho Chi Minh','Hanoi','Da Lat');
    
    -- 13. Choose all clients data who do not reside in Ho Chi Minh, Hanoi and Da Lat.
    select * 
    from clients
    where city not in ('Ho Chi Minh','Hanoi','Da Lat');
    
    -- 14. Find the average salesman’s salary. 
    select avg(salary) 
    from salesman;
    
    -- 15. Find the name of the highest paid salesman. 
select salesman_name 
from salesman 
where Salary = (select max(salary) from salesman);

    
    -- 16. Find the name of the salesman who is paid the lowest salary. 
select salesman_name 
from salesman 
where Salary = (select min(salary) from salesman);

-- 17. Determine the total number of salespeople employed by the company.
select count(salesman_name) from salesman;

-- 18. Compute the total salary paid to the company's salesman. 
select sum(salary) from salesman;

-- 19. Select the salesman’s details sorted by their salary.
select * 
from salesman
order by Salary desc;

-- 20. Display salesman names and phone numbers based on their target achieved (in ascending order) 
-- and their city (in descending order).

select salesman_name, phone
from salesman
order by Target_Achieved asc,city desc;

-- 21. Display 3 first names of the salesman table and the salesman’s names in descending order. 

select salesman_name
from salesman
order by salesman_name desc
limit 3;

-- 22. Find salary and the salesman’s names who is getting the highest salary.
select salary, salesman_name
from salesman
where Salary = (select max(Salary) from salesman);

-- 23. Find salary and the salesman’s names who is getting second lowest salary.
SELECT salesman_name, salary
FROM salesman
WHERE salary = (
  SELECT  salary
  FROM salesman
  ORDER BY salary ASC
  LIMIT 1 OFFSET 1
);

-- 24. Display the first five sales orders in formation from the sales order table.
select * 
from SalesOrder
limit 5;

-- 25. Display next ten sales order information from sales order table except first five sales order. 

select * 
from salesorder
limit 10 offset 5;

-- 26. If there are more than one client, find the name of the province and the number of clients in each 
-- province, ordered high to low. 
select Province , count(*) totalclient
from clients
group by Province 
having count(*)>1
order by count(*) desc;

-- 27. Display information clients have number of sales order more than 1. 
select* from clients
where Client_Number in (select client_number
 from salesorder
 group by Client_Number
 having count(*)>1);
 
 -- 28. Display the name and due amount of those clients who lives in “Hanoi”.
 select client_name, amount_due
 from clients
 where city = 'Hanoi';
 
 -- 29. Find the clients details who has due more than 3000. 
	select * from clients
    where Amount_Due > 3000;
 
-- 30. Find the clients name and their province who has no due. 
	select client_name, province
    from clients 
    where Amount_Due =0;
    

-- 31. Show details of all clients paying between 10,000 and 13,000. 
	select * 
    from clients
    where amount_paid between 10000 and 13000;
    
-- 32. Find the details of clients whose name is “Dat”. 
	select * 
    from clients
    where client_name = 'Dat';
    
-- 33. Display all product name and their corresponding selling price. 
--  select * from product;
 select product_name, sell_price
 from product;

-- 34. How many TVs are in stock? 
	select product_name, quantity_on_hand
    from product
    where Product_Name in ('TV');

-- 35. Find the salesman’s details who are not able achieved their target. 
	select * from salesman;
    select * from salesman
    where Target_Achieved < Sales_Target;

-- 36. Show all the product details of product number ‘P1005’. 
	select * from product
    where Product_Number = 'P1005';
    

-- 37. Find the buying price and sell price of a Mouse. 
	select Sell_Price, Cost_Price from product
    where Product_Name = 'Mouse';
    

-- 38. Find the salesman names and phone numbers who lives in Thu Dau Mot. 
 select Salesman_Name,Phone from salesman 
 where city = 'Thu Dau Mot';
 

-- 39. Find all the salesman’s name and salary. 
select Salesman_Name,Salary from salesman;


-- 40. Select the names and salary of salesman who are received between 10000 and 17000. 
	select Salesman_Name,Salary from salesman 
    where Salary between 10000 and 17000;
	

-- 41. Display all salesman details who are received salary between 10000 and 20000 and achieved their target.  
	select * from salesman
    where Salary between 10000 and 20000 and Target_Achieved >= Sales_Target;

-- 42. Display all salesman details who are received salary between 20000 and 30000 and not achieved 
-- their target.  
	select * from salesman
    where Salary between 20000 and 30000 and Target_Achieved <= Sales_Target;

-- 43. Find information about all clients whose names do not end with "h". 
	select * from clients
    where Client_Name  not like '%h';

-- 44. Find client names whose second letter is 'r' or second last letter 'a'. 
	select Client_Name from clients 
    where Client_Name like '_r%' or '%a_';

-- 45. Select all clients where the city name starts with "D" and at least 3 characters in length. 
	select * from clients
    where City like 'D%' and length(city)>=3 ;

-- 46. Select the salesman name, salaries and target achieved sorted by their target_achieved in 
-- descending order. 
	select salesman_name, Salary, Target_Achieved from salesman 
    order by Target_Achieved desc;

-- 47. Select the salesman’s details sorted by their sales_target and target_achieved in ascending order. 

	select * from salesman
    order by target_achieved asc, sales_target asc;
    
    
-- 61 Display product number and product name and count number orders of each product more than 1 (in ascending order).
select * from salesorderdetails;
select order_number,product_number from salesorderdetails
group by Order_quantity 
having count(*)>1
order by count(*) desc;

-- 48. Select the salesman’s details sorted ascending by their salary and descending by achieved target.
select * from salesman
order by salary asc, target_achieved desc;

-- 49. Display salesman names and phone numbers in descending order based on their sales target. 

select salesman_name, phone
from salesman
order by sales_target desc;

-- 50. Display the product name, cost price, and sell price sorted by quantity in hand. 
select product_name,cost_price,sell_price 
from product
order by quantity_on_hand;

-- 51. Retrieve the clients’ names in ascending order. 
select client_name from clients
order by client_name asc;

-- 52. Display client information based on order by their city. 
select * from clients
order by city desc;

-- 53. Display client information based on order by their address and city. 

select * from clients
order by address asc, city asc;

-- 54. Display client information based on their city, sorted high to low based on amount due.

select * from clients
order by  city desc, amount_due desc;

-- 55. Display the data of sales orders depending on their delivery status from the current date to the 
-- old date.

select * from salesorder
order by delivery_status asc, delivery_date desc;

-- 56. Display last five sales order in formation from sales order table.

select * from salesorder
limit 5;

-- 57. Count the pincode in client table. 

select count(pincode) as Pin_count from clients;

-- 58. How many clients are living in Binh Duong?

select count(*) as clientBinhDuong
from clients
where city = 'Binh Duong';

-- 59. Count the clients for each province.
select province, count(*) as clientCount
from clients
group by province;

-- 60. If there are more than three clients, find the name of the province and the number of clients in each  province.
select province, count(*) as NumberOfClients 
from clients
group by province
having count(*) > 3;

-- 61. Display product number and product name and count number orders of each product more than 1  (in ascending order). 

    select product.product_number, product_name, count(*)NumOfOrder
    from product inner join salesorderdetails
    on product.product_number = salesorderdetails.product_number
    group by product.product_number
    having count(*)>1
    order by count(*) asc;


-- 62. Find products which have more quantity on hand than 20 and less than the sum of average.
 select * from product
 where quantity_on_hand > 20 and  quantity_on_hand < (select avg(quantity_on_hand) from product);




