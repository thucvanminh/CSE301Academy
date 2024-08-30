create database sales_for_lab10;
use sales_for_lab10;


select * from customers;
select *, case when quantity_sell > 200000 then 'Good' 
			 when quantity_sell < 200000 then 'not Good'   
		end  'Note' from customers;

sET SQL_SAFE_UPDATES = 0; 
-- Lệnh thêm foreign key
ALTER TABLE INVOICE ADD constraint customers_code_foreign foreign key (CUSTOMERS_CODE)  references CUSTOMERS(CUSTOMER_CODE);
ALTER TABLE INVOICE add constraint salesman_code_foreign foreign key (SALESMAN_CODE) references SALESMAN(SALESMAN_CODE);

alter table detailinvoice add constraint invoice_code_foreign foreign key(invoice_code) references invoice(invoice_code);
alter table detailinvoice add constraint product_code_foreign foreign key (product_code) references products(product_code);
select *
from information_schema.table_constraints
where table_name = 'detailinvoice';

alter table customers add constraint check_code_customer check (customer_code like 'kh%');
alter table PRODUCTS add constraint check_unit check (unit in ('cay','hop','cai','quyen','chuc'));
alter table customers add constraint check_phone check ( length(phone)=10 );

alter table detailinvoice add column price decimal(15,2),
							add column amount decimal(15,2);

update detailinvoice set price = (select price from products where product_code= detailinvoice.product_code),
							amount = price * quantity;
select * from detailinvoice;
select * from invoice;
update invoice set total_amount = (select sum(amount) from detailinvoice where INVOICE.INVOICE_CODE = detailinvoice.invoice_code);
-- Create a store procedure to find customer information that have total amount more than 
--  average of all customers with input address of customer. 

Delimiter $$
create procedure customers_more_than_average (in customer_address_input varchar(50))
begin
	DECLARE average_total_amount DECIMAL(15,2);

  -- Calculate the average total amount for all customers
  SELECT AVG(total_amount) INTO average_total_amount
  FROM INVOICE;

  -- Find customers with total amount greater than the average
  SELECT CUSTOMERS_CODE, FULL_NAME
  FROM CUSTOMERS
  JOIN INVOICE ON CUSTOMERS.CUSTOMERS_CODE = INVOICE.CUSTOMERS_CODE
   WHERE CUSTOMERS.ADDRESS = customer_address
  GROUP BY CUSTOMERS_CODE
  HAVING SUM(INVOICE.TOTAL_AMOUNT) > average_total_amount;
end $$
Delimiter ;


--  CREATE VIEW

-- create or replace view sale_view as 
-- (select sm.*, p.product_name, p.sell_price, sod.Order_Quantity from salesman sm
-- inner join salesorder so on so.Salesman_Number = sm.Salesman_Number
-- inner join salesorderdetails sod on sod.Order_Number = so.Order_Number
-- inner join product p on sod.Product_Number = p.Product_Number
-- where so.Order_status = 'Successful');
-- select * from sale_view;

-- UPDATE NỘI DUNG
#24. Update the delivery status to “Delivered” for the product number P1007.
-- update salesorder set delivery_status = 'Delivered'
-- where order_number in (select order_number from salesorderdetails 
-- where Product_Number = 'P1007');

-- Them cột vào table
-- alter table clients add column Phone varchar(15);

--  CREATE TRIGGER BEFORE INSERT 6. Create a trigger to enforce that the first digit of the pin code in the "Clients" table must be 7. 

-- DELIMITER $$
-- CREATE TRIGGER before_client_insert_update
-- BEFORE INSERT ON clients
-- FOR EACH ROW
-- BEGIN
--   IF LENGTH(NEW.Pincode) < 1 OR SUBSTRING(NEW.Pincode, 1, 1) != '7' THEN
--     SIGNAL SQLSTATE '45000' SET MESSAGE_TEXT = 'Pincode must start with 7';
--   END IF;
-- END $$
-- DELIMITER ;

DELIMITER //

CREATE PROCEDURE find_best_selling_products(IN n INT)
BEGIN
  SELECT 
    PRODUCTS.PRODUCT_CODE, 
    PRODUCTS.PRODUCT_NAME, 
    SUM(DETAILINVOICE.QUANTITY) AS total_quantity_sold
  FROM PRODUCTS
  JOIN DETAILINVOICE ON PRODUCTS.PRODUCT_CODE = DETAILINVOICE.PRODUCT_CODE
  GROUP BY PRODUCTS.PRODUCT_CODE, PRODUCTS.PRODUCT_NAME
  ORDER BY total_quantity_sold DESC
  LIMIT n;
END //

DELIMITER ;


