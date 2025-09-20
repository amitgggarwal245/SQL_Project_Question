CREATE DATABASE OnlineBookstore;
DROP TABLE IF EXISTS Books;
CREATE TABLE Books (
    Book_ID SERIAL PRIMARY KEY,
    Title VARCHAR(100),
    Author VARCHAR(100),
    Genre VARCHAR(50),
    Published_Year INT,
    Price NUMERIC(10, 2),
    Stock INT
);
DROP TABLE IF EXISTS customers;
CREATE TABLE Customers (
    Customer_ID SERIAL PRIMARY KEY,
    Name VARCHAR(100),
    Email VARCHAR(100),
    Phone VARCHAR(15),
    City VARCHAR(50),
    Country VARCHAR(150)
);
DROP TABLE IF EXISTS orders;
CREATE TABLE Orders (
    Order_ID SERIAL PRIMARY KEY,
    Customer_ID INT REFERENCES Customers(Customer_ID),
    Book_ID INT REFERENCES Books(Book_ID),
    Order_Date DATE,
    Quantity INT,
    Total_Amount NUMERIC(10, 2)
);


SELECT * FROM books; 
SELECT * FROM Customers;
SELECT * FROM Orders;




-- Q1) Retrieve all books in the "Fiction" genre.
 
       SELECT * from books where genre ="Fiction";
 
 -- Q2) Find books published after the year 1950:
 
      select * from books where Published_Year > 1950;
 
-- Q3) List all customers from the Canada:
 
      select * from customers where Country = "canada";
   
-- Q4) Show orders placed in November 2023:
  
      select * from orders where  order_date BETWEEN '2023-11-01' AND '2023-11-30';
    
-- Q5) Retrieve the total stock of books available:
    
      select sum(stock) As total_stock  
       from books;
    
-- Q6) Find the details of the most expensive book:
    
       SELECT * FROM Books ORDER BY Price DESC LIMIT 1;
       

-- Q7) Show all customers who ordered more than 1 quantity of a book:
    
       SELECT * FROM Orders WHERE quantity>1 ;

         
-- Q8) Retrieve all orders where the total amount exceeds $20:

       SELECT * FROM Orders WHERE total_amount > '$20';
    

-- Q9) List all genres available in the Books table:

        SELECT DISTINCT genre FROM Books;
   
 -- Q10) Find the book with the lowest stock:  
 
        SELECT * FROM Books ORDER BY stock LIMIT 1;
     
-- Q11) Calculate the total revenue generated from all orders:

        select sum(total_amount)as revenue from orders;
   
--- Advance question

-- 1) Retrieve the total number of books sold for each genre:

      
      select b.Genre , sum(o.quantity) from  books b 
      JOIN orders o  ON b.book_id = o.book_id
      group by b.Genre;
       
-- 2) Find the average price of books in the "Fantasy" genre:
       
       
       SELECT AVG(price) AS Average_Price
	   FROM Books
	   WHERE Genre = 'Fantasy';
 
-- 3) List customers who have placed at least 2 orders:

        
        select c.name , count(o.order_ID) as order_count  from customers c
        join orders o on c.customer_id = o.Customer_ID
        group by c.name
         HAVING COUNT(Order_id) >=2;

-- 4) Find the most frequently ordered book:

     select b.title , o.Book_ID , count(o.order_id) as orders 
     from orders o  join books b  on  b.book_id = o.order_id 
     group by b.title ,o.book_id
     order by orders desc limit 1;
     
-- 5) Show the top 3 most expensive books of 'Fantasy' Genre :

	   select * from books where genre = 'fantasy'
        order by genre  desc  limit 3;

-- 6) Retrieve the total quantity of books sold by each author:
  
          select b.Author, sum(o.quantity) from books b 
          join orders o on b.book_id = o.Book_ID
          group by b.Author;
          

-- 7) List the cities where customers who spent over $30 are located:

     SELECT DISTINCT c.city, total_amount
     FROM orders o  
     JOIN customers c ON o.customer_id=c.customer_id
     WHERE o.total_amount > 30;

-- 8) Find the customer who spent the most on orders:
  
           SELECT c.customer_id, c.name, SUM(o.total_amount) AS Total_Spent
           FROM orders o
           JOIN customers c ON o.customer_id=c.customer_id
           GROUP BY c.customer_id, c.name
           ORDER BY Total_spent Desc LIMIT 1;
         
 
        

