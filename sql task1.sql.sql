use Task1


create table Author (
Author_ID nvarchar(50) not null Primary key,
Author_Name varchar(50) not null
)




-- Task 1 =


INSERT INTO Author (Author_ID, Author_Name)
VALUES (1, 'Kunj'),
		(2, 'Gautam')


INSERT INTO Publisher (Publisher_ID, Publisher_Name)
VALUES (11, 'Ocean_Publication'),
		(12, 'Navneet_Publication')


INSERT INTO Books (Book_ID, Book_Name, Author_ID, Price, Publisher_ID)
VALUES (21, 'Book1', 1, 270 , 12),
		(22, 'Book2', 2 , 568 , 11)


INSERT INTO Credit_Card_Details (Credit_Card_Number, Credit_Card_Type, Expiry_Date)
VALUES (31, 'Premium', '2028-01-16'),
		(32, 'Normal', '2027-01-16')

INSERT INTO Customer (Customer_ID, Customer_Name, Street_Address, City, Phone_Number , Credit_Card_Number)
VALUES (41, 'customer_1', 'ab appt. , near gandhi school', 'rajkot' , 78293789 , 31),
		(42, 'customer_2','cd appt. , near modi school', 'rajkot' , 3535335 , 32)


INSERT INTO Shipping (Shipping_Type, Shipping_Price)
VALUES ('delux', 1200),
		('normal', 1000)


INSERT INTO Shopping_Cart (Shopping_Cart_ID, Book_ID, Price, Date , Quantity)
VALUES (51, 21 , 270 , '2023-01-16' , 1),
		(52, 22 , 568 , '2028-01-16' , 1)



INSERT INTO Order_Details (Order_ID, Customer_ID, Shipping_Type, Date_of_Purchase , Shopping_Cart_ID)
VALUES (61, 41 , 'delux' , '2023-01-16' , 51),
		(62, 42 , 'normal' , '2023-01-16' , 52)


INSERT INTO Purchase_History (Customer_ID, Order_ID)
VALUES (41, 61),
		(42, 62)



--task 2 =


 CREATE VIEW [View Customer Details] as 
 SELECT c.Customer_Name, CONCAT( c.Street_Address, ',' , c.City ) AS Address , o.Order_ID , o.Shipping_Type , o.Date_of_Purchase , o.Shopping_Cart_ID FROM Customer c
 INNER JOIN Order_Details o
 ON c.Customer_ID = o.Customer_ID

 
 select * from [View Customer Details]


 -- task 3

  SELECT c.Customer_ID , c.Customer_Name , b.Book_Name , o.Date_of_Purchase , o.Shopping_Cart_ID FROM (( Order_Details o

  INNER JOIN Customer c
  ON o.Customer_ID = c.Customer_ID )

  
  INNER JOIN Shopping_Cart s
  ON o.Shopping_Cart_ID = s.Shopping_Cart_ID )

  
  INNER JOIN BookS b
  ON s.Book_ID = b.Book_ID


  
  
  -------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
  
  -- we can update, delete base table ( main table ) by updating , deleting  in view . 

  
  -- create view
  use w3schools
  create view [study_VIEW] as
  select * from study

  -- select view
  select * from [study_VIEW]


  -- update base table by upadting in view
  update [study_VIEW]
  set cid =3
  where sid = 4


  -- delete row in base table by deleting row in view

  delete from [study_VIEW]
  where sid = 4