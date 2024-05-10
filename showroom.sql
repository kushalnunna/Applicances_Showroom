create database electronic_showroom;
use electronic_showroom;

-- -----------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE employee (
	emp_id int PRIMARY KEY AUTO_INCREMENT,
    emp_name VARCHAR(200),
    gender VARCHAR(10),
    salary DECIMAL(10,2),
    email VARCHAR(25),
	phone VARCHAR(12)
);

insert into employee(emp_name,gender,salary,email,phone)
values ('Hari Prasad','Male',35000.00,'hari@gmail.com','8156925481'),('Gopal Rao','Male',30000.00,'gopal@gmail.com','9156925482'),
('Ramesh Suresh','Male',30000.00,'rama@gmail.com','9126925468'),('Vibhav Hosmani','Male',25000.00,'vib@gmail.com','7256925448'),
('Abhishek Kumar','Male',20000.00,'abhi@gmail.com','8755625253'),('Divakar Kulkarni','Male',20000.00,'Diva@gmail.com','7526425452'),
('Kavan Melkote','Male',15000.00,'kav@gmail.com','8156925185'),('Dhawan Kumar','Male',15000.00,'wan@gmail.com','8156925298'),
('Tushar Kapoor','Male',40000.00,'tush@gmail.com','9656925445'),('Mathew Anderson','male',10000.00,'mathew@gmail.com','8569254055');

insert into employee(emp_name,gender,salary,email,phone)
values ('Vinay Rawat','Male',20000.00,'vinay@gmail.com','6254863598'),('Rohith Shetty','Male',15000.00,'roh@gmail.com','9658236514');

select * from employee;

-- ---------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Customers(
  cust_id int PRIMARY KEY AUTO_INCREMENT,
  first_name VARCHAR(50),
  last_name VARCHAR(50),
  full_name VARCHAR(200),
  email VARCHAR(25),
  phone VARCHAR(12),
  address VARCHAR(200)
);

create trigger customer_fullname 
before INSERT on customers 
for each row set NEW.full_name = CONCAT(NEW.first_name,' ',NEW.last_name);

INSERT INTO customers(first_name,last_name,email,phone,address)
VALUES ('Avinash','Dixit','avi@g.com','8762104600','1st Main'),('Kushal','Nunna','kus@g.com','7621046008','2nd Main'),('Shravan','T','rav@g.com','6210460087','3rd Main'),
        ('Samarth','S L','sam@g.com','9160087685','4th Main'),('Shreyas','E','shre@g.com','9160527682','5th Main'),('Sheikh','Abdulla','hisham@g.com','9164987684','6th Main'),
        ('Eshwar','J','kia@g.com','9160024983','7th Main'),('Adithya','D K','adk@g.com','9160800282','8th Main'),('Harsha','N P','hnp@g.com','8260087681','9th Main'),
        ('Vinay','V','vinaya@g.com','8762508685','10th Main'),('Sujay','T','suj@g.com','6254087684','11th Main'),('Himanshu','U','hima@g.com','7254087684','12th Main'),
		('Amit','K','ami@g.com','6252587684','13th Main'),('Vikyath','G','vikki@g.com','8454087684','14th Main'),('Chinmay','Ankolekar','chinmay@g.com','6840876524','15th Main');
        
select * from customers;

-- ----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Products (
  pdt_id int PRIMARY KEY AUTO_INCREMENT,
  pdt_name VARCHAR(200),
  category VARCHAR(100),
  brand VARCHAR(100),
  price DECIMAL(10,2),
  discount_percentage int,
  discounted_price DECIMAl(10,2)
);

create trigger final_price
before insert on products
for each row set NEW.discounted_price=NEW.price-((NEW.discount_percentage*NEW.price)/100);

INSERT INTO Products(pdt_name,category,brand,price,discount_percentage)
VALUES ('Samsung Galaxy M01s','Smartphone','Samsung',10000.00,5),('Samsung Galaxy F13','Smartphone','Samsung',12000.00,5),('Samsung Galaxy M14','Smartphone','Samsung',21000.00,5),
        ('Samsung Galaxy S22','Smartphone','Samsung',35000.00,7),('Redmi 8A','Smartphone','Redmi',8000.00,2),('Redmi Note 10Pro','Smartphone','Redmi',22000.00,5),
        ('Redmi Note 12pro','Smartphone','Redmi',32000.00,7),('Redmi 10Tpro','Smartphone','Redmi',40000.00,7),('Hp core i3','Laptop','Hp',35000.00,7),
        ('Hp core i5','Laptop','Hp',50000.00,7),('Hp Ryzen','Laptop','Hp',33000.00,7),('Hp core i7','Laptop','Hp',90000.00,7),
        ('DELL Inspiron 3511','Laptop','DELL',60000.00,7),('DELL Core i3','Laptop','DELL',40000.00,7),('DELL Inspiron i5','Laptop','DELL',55000.00,7),
        ('DELL Core i7','Laptop','DELL',92000.00,7),('Lenevo Yoga','Laptop','Lenevo',85000.00,7),('Boat Airdopes 138','Bluetooth','Boat',2500.00,5),
        ('Boat Airdopes Alpha','Bluetooth','Boat',1000.00,5),('Boat Airdopes 161','Bluetooth','Boat',2000.00,5),('Realme Airdopes','Bluetooth','Realme',2000.00,5),
        ('OnePlus Airdopes','Bluetooth','OnePlus',5000.00,5),('Boat Stone 135','Speakers','Boat',3000,5),('Boat Stone 1200F','Speakers','Boat',4000,5),
        ('Boat Stone 650','Speakers','Boat',3500,5),('Jbl Go3','Speakers','Jbl',3000,5),('Infinity','Speakers','Jbl',3000,15),
        ('Samsung Tv','Tv','Samsung',50000,10),('Lg Tv','Tv','Lg',40000,15),('Panasonic Tv','Tv','Panasonic',60000,15),('Sony Tv','Tv','Sony',55000,15),('Onida Tv','Tv','Onida',30000,5);
        
select * from Products;

-- ----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Inventory (
    pdt_id INT,
    stock_Quantity INT,
    last_Restock_Date DATE,
    FOREIGN KEY (pdt_id) REFERENCES Products(pdt_id) on update cascade on delete set null
);

alter table inventory
modify stock_Quantity INT DEFAULT 50;

DELIMITER //
create trigger low_stock
before update on inventory
for each row
begin
	if NEW.stock_Quantity<=5 THEN
		SET NEW.stock_Quantity=NEW.stock_Quantity+50;
	END IF;
end;
//
DELIMITER ;
           
insert into inventory(pdt_id,last_Restock_Date) 
values (1,"2023-01-2"),(2,"2023-01-15"),(3,"2023-01-30"),(4,"2023-02-5"),(5,"2023-02-20"),(6,"2023-03-20"),(7,"2023-03-4"),(8,"2023-04-8"),(9,"2023-04-26"),
(10,"2023-05-15"),(11,"2023-05-28"),(12,"2023-05-30"),(13,"2023-06-2"),(14,"2023-06-2"),(15,"2023-06-27"),(16,"2023-07-8"),(17,"2023-07-23"),
(18,"2023-08-5"),(19,"2023-08-17"),(20,"2023-08-17"),(21,"2023-08-22"),(22,"2023-08-23"),(23,"2023-09-7"),(24,"2023-09-13"),(25,"2023-09-26"),
(26,"2023-10-1"),(27,"2023-10-7"),(28,"2023-10-8"),(29,"2023-11-9"),(30,"2023-11-9"),(31,"2023-12-12"),(32,"2023-12-20");

select * from inventory;

-- ------------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Orders (
    order_id int PRIMARY KEY AUTO_INCREMENT,
    cust_id INT,
    pdt_id INT,
    emp_id INT,
    FOREIGN KEY (cust_id) REFERENCES Customers(cust_id) on update cascade on delete set null,  
    FOREIGN KEY (pdt_id) REFERENCES Products(pdt_id) on update cascade on delete set null,
    FOREIGN KEY (emp_id) REFERENCES employee(emp_id) on update cascade on delete set null
);

create trigger stock_update
after insert on orders 
for each row update inventory set stock_Quantity=stock_Quantity-1 where NEW.pdt_id=inventory.pdt_id;
                                
INSERT INTO orders(emp_id,cust_id,pdt_id)
VALUES (1,1,3),(2,1,6),(3,1,16),(4,2,15),(5,2,10),(6,2,31),(7,2,5),(8,3,18),(9,3,31),(10,3,20),(1,4,10),(2,4,18),(3,4,25),(4,4,29),(5,5,8),
(6,5,17),(7,5,27),(8,6,4),(9,6,12),(10,6,19),(1,7,23),(2,8,9),(3,8,17),(4,8,12),(5,8,3),(6,9,11),(7,9,13),(8,10,26),(9,10,21),(10,10,10),
(1,11,19),(2,11,32),(3,12,28),(4,12,14),(5,12,7),(6,13,25),(7,13,5),(8,14,9),(9,15,2),(10,15,11),(1,15,20),(2,15,30);

select * from orders;

-- -----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE OrderDetails (
    order_id INT,
    order_Date DATE,
    quantity INT,
    total_Amount DECIMAL(10, 2),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) on update cascade on delete set null
);

create trigger total_amount 
before INSERT on orderdetails
for each row set NEW.total_Amount = NEW.quantity * (select discounted_price from products 
													where pdt_id in (select pdt_id from orders
                                                    where order_id=NEW.order_id));


insert into OrderDetails(order_id,order_Date,quantity)
values (1,'2023-01-02',1),(2,'2023-01-02',1),(3,'2023-01-04',2),(4,'2023-01-04',1),(5,'2023-01-04',1),(6,'2023-01-30',1),
(7,'2023-04-02',1),(8,'2023-01-20',1),(9,'2023-01-20',1),(10,'2023-01-20',2),(11,'2023-02-06',1),(12,'2023-03-09',2),
(13,'2023-03-09',2),(14,'2023-03-09',1),(15,'2023-01-24',2),(16,'2023-01-24',1),(17,'2023-01-08',1),(18,'2023-05-02',2),
(19,'2023-05-02',1),(20,'2023-06-09',3),(21,'2023-05-28',2),(22,'2023-04-16',1),(23,'2023-04-16',2),(24,'2023-04-16',1),
(25,'2023-08-24',2),(26,'2023-06-12',1),(27,'2023-06-12',1),(28,'2023-07-07',1),(29,'2023-07-07',2),(30,'2023-09-25',1),
(31,'2023-08-13',2),(32,'2023-08-13',1),(33,'2023-08-14',1),(34,'2023-08-14',1),(35,'2023-08-14',2),(36,'2023-09-15',2),
(37,'2023-09-15',2),(38,'2023-10-19',2),(39,'2023-10-5',2),(40,'2023-10-05',3),(41,'2023-12-15',2),(42,'2023-12-15',1);

select * from orderdetails;

-- ---------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Payments ( 
    payment_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT,
    payment_Date DATE,
    payment_Amount DECIMAL(10, 2),
    payment_Method ENUM('Cash','Debit Card','Credit Card','UPI'),
    payment_status enum ('Completed','Failed'),
    FOREIGN KEY (order_id) REFERENCES Orders(order_id) on update cascade on delete set null
);

create trigger pay_amt
before insert on payments
for each row set NEW.payment_Amount=(select total_Amount from orderdetails
									where orderdetails.order_id=NEW.order_id);
                                    
create trigger pay_Date
before insert on payments
for each row set NEW.payment_Date=(select order_Date from orderdetails
									where orderdetails.order_id=NEW.order_id);
                                    
insert into payments(order_id,payment_Method,payment_status) 
values (1,'UPI','completed'),(2,'UPI','completed'),(3,'Debit Card','completed'),(4,'UPI','completed'),(5,'UPI','completed'),(6,'Debit Card','completed'),
(7,'UPI','completed'),(8,'Credit Card','completed'),(9,'Credit Card','completed'),(10,'Credit Card','completed'),(11,'Debit Card','completed'),(12,'UPI','completed'),
(13,'UPI','completed'),(14,'UPI','completed'),(15,'UPI','completed'),(16,'UPI','completed'),(17,'Debit Card','completed'),(18,'UPI','completed'),
(19,'UPI','completed'),(20,'Debit Card','completed'),(21,'Credit Card','completed'),(22,'UPI','completed'),(23,'UPI','completed'),(24,'UPI','completed'),
(25,'Debit Card','completed'),(26,'UPI','completed'),(27,'UPI','completed'),(28,'Debit Card','completed'),(29,'Debit Card','completed'),(30,'Debit Card','completed'),
(31,'Credit Card','completed'),(32,'Credit Card','completed'),(33,'UPI','completed'),(34,'UPI','completed'),(35,'UPI','completed'),(36,'Debit Card','completed'),
(37,'Debit Card','completed'),(38,'UPI','completed'),(39,'Credit Card','completed'),(40,'Credit Card','completed'),(41,'UPI','completed'),(42,'UPI','completed');

select * from payments;

-- -----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Reviews (
    review_id INT PRIMARY KEY auto_increment,
    pdt_id INT,
    cust_id INT,
    rating INT,
    review_Text TEXT,
    FOREIGN KEY (pdt_id) REFERENCES Products(pdt_id) on update cascade on delete set null,
    FOREIGN KEY (cust_id) REFERENCES Customers(cust_id) on update cascade on delete set null
);

alter table reviews drop column review_Text;

insert into reviews(pdt_id,cust_id,rating)
values (3,1,4),(6,1,3),(16,1,5),(15,2,2),(10,2,3),(31,2,4),(5,2,4),(18,3,3),(31,3,5),(20,3,5),(10,4,2),(18,4,1),(25,4,3),(29,4,3),(8,5,4),(17,5,5),
(27,5,2),(4,6,1),(12,6,2),(19,6,1),(23,7,5),(9,8,4),(17,8,5),(12,8,3),(3,8,1),(11,9,2),(13,9,5),(26,10,2),(21,10,4),(10,10,5),(19,11,3),(32,11,4),
(28,12,1),(14,12,5),(7,12,5),(25,13,3),(5,13,1),(9,14,4),(2,15,2),(11,15,5),(20,15,2),(30,15,4);

select * from reviews;

-- -----------------------------------------------------------------------------------------------------------------------------------------

CREATE TABLE Replacements (
    replace_id INT PRIMARY KEY auto_increment,
    order_id INT,
    replace_date DATE,
    reason TEXT,
    FOREIGN KEY (order_id) REFERENCES orders(order_id) on update cascade on delete set null
);

insert into Replacements(order_id,replace_date,reason)
values(2,"2023-01-15",'Battery Not Good'),(10,"2023-01-25",'Worst porduct'),(6,"2023-02-8",'Display Problem'),(18,"2023-05-14",'Camera not good'),
(15,"2023-02-07",'Battery Not Good'),(23,"2023-04-28",'Battery Draining'),(27,"2023-06-15",'Charging Problem'),(32,"2023-08-23",'Display'),
(30,"2023-09-28",'Worst porduct'),(40,"2023-12-21",'Sound issue');

select * from replacements;


-- ****************************************************************************************************************************************

