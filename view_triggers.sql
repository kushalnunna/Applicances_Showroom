-- views

create view Products_and_their_cost as
select pdt_name,discounted_price
from products;

select * from Products_and_their_cost;

-- -------------------------------------------------

create view Product_and_its_stock as
select products.pdt_name,inventory.stock_Quantity
from products,inventory
where inventory.pdt_id=products.pdt_id;

select * from Product_and_its_stock;

-- -------------------------------------------------

create view Customer_and_Products_for_each_orderId_and_amount as
select orders.order_id,products.pdt_name,customers.full_name,orderdetails.total_Amount
from orders,products,customers,orderdetails
where products.pdt_id=orders.pdt_id and customers.cust_id=orders.cust_id and orderdetails.order_id=orders.order_id;

select * from Customer_and_Products_for_each_orderId_and_amount;

-- -------------------------------------------------

create view Customer_with_their_totalAmount as
select customers.full_name,SUM(total_Amount) as 'Total Transaction'
from customers,orderdetails,orders
where customers.cust_id=orders.cust_id and orders.order_id=orderdetails.order_id
group by customers.full_name;

select * from Customer_with_their_totalAmount;

-- --------------------------------------------------

create view Monthly_Sales as
SELECT MONTHNAME(order_Date) AS Month,SUM(total_Amount) as 'Sales',COUNT(orderdetails.order_id) as 'Sales per month'
from orderdetails
group by Month
order by Sales DESC;

select * from Monthly_Sales;

-- --------------------------------------------------

create view Product_and_its_Sales as
select products.pdt_name,COUNT(orderdetails.quantity) as 'Sales'
from products,orderdetails,orders
where products.pdt_id=orders.pdt_id and orders.order_id=orderdetails.order_id
group by products.pdt_name;

select * from Product_and_its_Sales;

-- --------------------------------------------------

create view Different_Payment_Mode_Count as
select payment_Method,COUNT(payment_id) as 'No of Users'
from payments
group by payment_Method;

select * from Different_Payment_Mode_Count;

-- ---------------------------------------------------

create view Customer_Reviews as
select customers.full_name,products.pdt_name,reviews.rating
from customers,products,reviews
where customers.cust_id=reviews.cust_id and products.pdt_id=reviews.pdt_id;

select * from Customer_Reviews;

-- *********************************************************************************************************************************************************

-- queries

-- people who have replaced their products along with replace date
select customers.full_name,orders.order_id,orderdetails.order_Date,replacements.replace_date,replacements.reason
from customers
inner join orders on
     customers.cust_id=orders.cust_id
inner join orderdetails on
	 orders.order_id=orderdetails.order_id
inner join replacements on
	orders.order_id=replacements.order_id;
    
-- All orders done by a given customer
SELECT c.full_name AS customer_name, p.pdt_name, od.quantity, od.total_Amount
FROM Customers c
JOIN Orders o ON c.cust_id = o.cust_id
JOIN OrderDetails od ON o.order_id = od.order_id
JOIN Products p ON o.pdt_id = p.pdt_id
WHERE c.cust_id = 1; 

-- Total sales by all employees
select employee.emp_name,sum(payments.payment_Amount) as "Sales"
from employee
left join orders on
employee.emp_id=orders.emp_id
left join payments on
orders.order_id=payments.order_id
group by employee.emp_name
order by sales desc;

 -- Avg rating of product
 select products.pdt_name,AVG(reviews.rating)
  from  products
  right join reviews on
  reviews.pdt_id=products.pdt_id
  group by products.pdt_name;

-- customers who reveiwed their rating greater than 3
select distinct full_name
from customers,reviews
where reviews.cust_id=customers.cust_id and rating > 3;

-- products with battery problems
select pdt_name
from products,replacements,orders
where products.pdt_id=orders.pdt_id and replacements.order_id=orders.order_id and reason like "%battery%";

-- customers with upi payments
select distinct full_name
from customers,payments,orders
where customers.cust_id=orders.cust_id and payments.order_id=orders.order_id and payment_Method = 'UPI'; 

-- products ordered with a quantity more than 2
select pdt_id,pdt_name from products 
where pdt_id in (select pdt_id from orders
					where order_id in (select order_id from orderdetails where quantity>2));
