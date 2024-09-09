--DDL

CREATE DATABASE APU_Ebookstore_Database;
USE APU_Ebookstore_Database;

CREATE TABLE Member (
	MemberID NVARCHAR(50) NOT NULL PRIMARY KEY,
	MemberUsername NVARCHAR(50) NOT NULL,
	MemberPassword NVARCHAR(50) NOT NULL UNIQUE,
	MemberFname NVARCHAR(50) NOT NULL,
	MemberLname NVARCHAR(50),
	MemberContact NVARCHAR(50) UNIQUE,
	MemberAddress NVARCHAR(50)

);

CREATE TABLE Author (
	AuthorID NVARCHAR(50) NOT NULL PRIMARY KEY,
	AuthorName NVARCHAR(50) NOT NULL,
	AuthorContact NVARCHAR(50) UNIQUE

);

CREATE TABLE Publisher (
	PublisherID NVARCHAR(50) NOT NULL PRIMARY KEY,
	PublisherName NVARCHAR(50) NOT NULL UNIQUE,
	PublisherAddress NVARCHAR(50),
	PublisherContact NVARCHAR(50) UNIQUE
);


CREATE TABLE Book (
	BookID NVARCHAR(50) NOT NULL PRIMARY KEY,
	AuthorID NVARCHAR(50) FOREIGN KEY REFERENCES Author(AuthorID),
	PublisherID NVARCHAR(50) FOREIGN KEY REFERENCES Publisher(PublisherID),
	BookName NVARCHAR(50) NOT NULL,
	ISBN NVARCHAR(50) NOT NULL UNIQUE,
	Genre VARCHAR(50),
	UnitPrice DECIMAL(5,2) NOT NULL,
	PublishedDate DATE NOT NULL,
	QuantityInSTock INT NOT NULL

);




CREATE TABLE Cart (
	CartID NVARCHAR(50) NOT NULL PRIMARY KEY,
	MemberID NVARCHAR(50) FOREIGN KEY REFERENCES Member(MemberID),
	CartStatus NVARCHAR(50) NOT NULL,
	CartTotal DECIMAL(10,2) NOT NULL,

);


CREATE TABLE CartDetails (
	CartDt_ID NVARCHAR(50) NOT NULL PRIMARY KEY,
	CartID NVARCHAR(50) FOREIGN KEY REFERENCES Cart(CartID),
	BookID NVARCHAR(50) FOREIGN KEY REFERENCES Book(BookID),
	Quantity INT NOT NULL,
	TotalPrice DECIMAL(10,2) NOT NULL

);


CREATE TABLE Delivery (
	DeliveryID NVARCHAR(50) NOT NULL PRIMARY KEY, 
	DeliveryStatus NVARCHAR(50) NOT NULL,
	DeliveryDate DATE NOT NULL
	

);



CREATE TABLE MemberOrder (
	OrderID NVARCHAR(50) NOT NULL PRIMARY KEY,
	MemberID NVARCHAR(50) FOREIGN KEY REFERENCES Member(MemberID),
	DeliveryID NVARCHAR(50) FOREIGN KEY REFERENCES Delivery(DeliveryID),
	OrderDate DATE NOT NULL,
	OrderTotal DECIMAL(10,2) NOT NULL,
	PaymentMethod NVARCHAR(50) NOT NULL,
	PaymentDate DATE NOT NULL

);

CREATE TABLE MemberOrderDetails (
	MbrOrdDt_ID NVARCHAR(50) NOT NULL PRIMARY KEY,
	OrderID NVARCHAR(50) FOREIGN KEY REFERENCES MemberOrder(OrderID),
	BookID NVARCHAR(50) FOREIGN KEY REFERENCES Book(BookID),
	OrderedQuantity INT NOT NULL,
	TotalPrice Decimal(10,2) NOT NULL

);




CREATE TABLE Review (
	ReviewID NVARCHAR(50) NOT NULL PRIMARY KEY,
	MemberID NVARCHAR(50) FOREIGN KEY REFERENCES Member(MemberID),
	BookID NVARCHAR(50) FOREIGN KEY REFERENCES Book(BookID),
	Comment NVARCHAR(50),
	Rating INT CHECK (Rating BETWEEN 1 AND 10)


);




CREATE TABLE Staff (
	StaffID NVARCHAR(50) NOT NULL PRIMARY KEY,
	StaffName NVARCHAR(50) NOT NULL,
	StaffContact NVARCHAR(50) UNIQUE,
	StaffRole NVARCHAR(50) NOT NULL
);


CREATE TABLE ManagerOrder (
	OrderID NVARCHAR(50) NOT NULL PRIMARY KEY,
	ManagerID NVARCHAR(50) FOREIGN KEY REFERENCES Staff(StaffID),
	OrderDate DATE NOT NULL,
	OrderTotal DECIMAL(10, 2) NOT NULL

);

CREATE TABLE ManagerOrderDetails (
	MgrOrdDt_ID NVARCHAR(50) NOT NULL PRIMARY KEY,
	OrderID NVARCHAR(50) FOREIGN KEY REFERENCES ManagerOrder(OrderID),
	BookID NVARCHAR(50) FOREIGN KEY REFERENCES Book(BookID),
	OrderedQuantity INT NOT NULL,
	TotalPrice DECIMAL(10, 2) NOT NULL,
	ArrivedDate DATE

);



INSERT INTO Member 
VALUES
('M1', 'John', 'Doe', 'John', 'Doe', '010-3989902', 'Bukit Tinggi,Penang'),
('M2', 'stevenson78', 'Sroberson', 'Steven', 'Roberson', '013-3127894', 'Petaling Jaya,Selangor'),
('M3', 'leethomas33', 'lee_thomas', 'Thomas', 'Lee', '011-5627211', 'Kuching, Sarawak'),
('M4', 'oliver09', 'oliverinwoods', 'Oliver', 'Wood', '010-4723819', 'Wilayah Persekutuan,Kuala Lumpur'),
('M5', 'katie78', 'katiecute', 'Katie', 'Bell', '010-4168756', 'Kuantan,Pahang'),
('M6', 'peterson', 'peterson123', 'Peterson', 'Johnson', '012-4168757', 'Kuching, Sarawak'),
('M7', 'jason', 'jason123', 'Jason', 'Hong', '010-4168758', 'Wilayah Persekutuan,Kuala Lumpur'),
('M8', 'jackson', 'jackson123', 'Jackson', 'Kong', '010-4168759', 'Kuantan,Pahang');

SELECT * FROM Member;


INSERT INTO Publisher
VALUES
('PO1', 'Book&Co', 'Kuala Lumpur, Malaysia', '016-202023'),
('PO2', 'PublisherKing', 'Ipoh, Perak, Malaysia', '012-2423503'),
('PO3', 'Pearson', 'London, England, UK', '1-300-473-277'),
('PO4', 'Thomson Reuters', 'Toronto, Ontario, Canada', '647-480-7000'),
('PO5', 'Penguin Random House', 'New York City, USA', '1-800-733-3000'),
('PO6', 'Kechara Media & Publications', 'Bandar Utama, Malaysia', ' 03-7805 5619'),
('PO7', 'Furture Ace Publishing Sdn.Bhd', 'Butterworth, Malaysia', '04-332 9299'), 
('PO8', 'Kanyin Publications', 'Kuala Lumpur, Malaysia', '03- 332 9288');

SELECT * FROM Publisher;


INSERT INTO Author
VALUES
('A1', 'Aurthur Foo', '016-2029091'),
('A2', 'Jane Peter', '017-2029092'),
('A3', 'John Parker', '018-2029093'),
('A4', 'J. K. Rowling', '012-2029094'),
('A5', 'William Shakespeare', '012-2029095'),
('A6', 'Lawrie Brown', '013-2029096'),
('A7', 'David Olussoga', '012-2029097'),
('A8', 'Zhong Jiang', '015-2029098'),
('A9', 'Thomas Chua', '012-2029099');

SELECT * FROM Author;


INSERT INTO Book
VALUES
('B01', 'A1', 'PO1', 'The Unsolved', '868-3151434100', 'Thriller', 75, '12/12/2000', 10),
('B02', 'A2', 'PO2', 'The Habit', '778-3161484101', 'Self-Help', 65, '12/13/1999', 5),
('B03', 'A3', 'PO3', 'Python', '668-3161484102', 'Textbook', 55, '12/14/1998', 20),
('B04', 'A4', 'PO2', 'Harry Potter and the Philosopher Stone ', '778-4161484100', 'Fantasy Fiction', 90, '7/26/1997', 10),
('B05', 'A4', 'PO2', 'Harry Potter and the Chamber of Secrets', '778-4161484101', 'Fantasy Fiction', 90, '7/2/1998', 5),
('B06', 'A6', 'PO3', 'Computer Security', '978-1292220610', 'Textbook', 100, '11/16/2017', 0),
('B07', 'A7', 'PO5', 'A History of Where We All Came From', '978-0744048469', 'History', 60, '4/7/2022', 20),
('B08', 'A8', 'PO6', 'Eat Healthy, Daily', '978-9675365485', 'Health', 50, '9/28/2011', 0),
('B09', 'A9', 'PO8', 'Dividend Growth Investing', '978-9675365490', 'Business', 20, '9/29/2015', 6),
('B10', 'A3', 'PO3', 'Programming for All', '978-9675365486', 'Textbook', 20, '5/30/2021', 5);

SELECT * FROM Book;


INSERT INTO Cart 
VALUES
('COO1', 'M1', 'Checked Out', 620),
('COO2', 'M3', 'Checked Out', 150),
('COO3', 'M5', 'Checked Out', 90),
('COO4', 'M1', 'Checked Out', 40),
('COO5', 'M7', 'Checked Out', 60),
('COO6', 'M8', 'Checked Out', 180),
('COO7', 'M1', 'Checked Out', 90),
('COO8', 'M3', 'Checked Out', 20);


SELECT * FROM Cart;


INSERT INTO CartDetails
VALUES
('CD01', 'COO1', 'B01',  2, 150),
('CD02', 'COO1', 'B02',  3, 195),
('CD03', 'COO1', 'B03', 5, 275),
('CD04', 'COO2', 'B01', 2, 150),
('CD05', 'COO3', 'B04', 1, 90),
('CD06', 'COO4', 'B09', 2, 40),
('CD07', 'COO5', 'B07', 1, 60),
('CD08', 'COO6', 'B05', 2, 180),
('CD09', 'COO7', 'B04', 1, 90),
('CD10', 'COO8', 'B10', 1, 20);
SELECT * FROM CartDetails;


INSERT INTO Delivery
VALUES
('D1', 'Delivered', '12/22/2012'),
('D2',  'Delivered', '12/25/2012'),
('D3', 'Not Delivered',  '12/27/2012'),
('D4', 'Delivered', '1/9/2013'),
('D5', 'Not Delivered', '1/10/2014'),
('D6', 'Delivered', '2/11/2014'),
('D7', 'Delivered', '3/12/2014'),
('D8', 'Delivered', '4/13/2014');


SELECT * FROM Delivery;

INSERT INTO MemberOrder
VALUES
('O1', 'M1', 'D1', '12/15/2012', 620, 'CreditCard', '12/15/2012'),
('O2', 'M3', 'D2', '12/18/2012', 150, 'CreditCard', '12/18/2012'),
('O3', 'M5', 'D3', '12/20/2012', 90, 'Online Banking', '12/20/2012'),
('O4', 'M1', 'D4', '1/2/2013', 40, 'CreditCard', '1/2/2013'),
('O5', 'M7', 'D5', '1/3/2014', 60, 'CreditCard', '1/3/2014'),
('O6', 'M8', 'D6', '2/4/2014', 180, 'CreditCard', '2/4/2014'),
('O7', 'M1', 'D7',  '3/5/2014', 90, 'CreditCard', '3/5/2014'),
('O8', 'M3', 'D8', '4/6/2014', 20, 'CreditCard', '4/6/2014');

SELECT * FROM MemberOrder;


INSERT INTO MemberOrderDetails
VALUES
('I01', 'O1', 'B01', 2, 150),
('I02', 'O1', 'B02', 3, 195),
('I03', 'O1', 'B03', 5, 275),
('I04', 'O2', 'B01', 2, 150),
('I05', 'O3', 'B04', 1, 90),
('I06', 'O4', 'B09', 2, 40),
('I07', 'O5', 'B07', 1, 60),
('I08', 'O6', 'B05', 2, 180),
('I09', 'O7', 'B04', 1, 90),
('I10', 'O8', 'B10', 1, 20);



SELECT *  FROM MemberOrderDetails;



INSERT INTO Review
VALUES
('R1', 'M1', 'B01', 'Interesting Book',  5),
('R2', 'M1',  'B02', 'Very Informative', 8),
('R3',  'M1',  'B03',	'Interesting Book', 6),
('R4', 'M3',  'B01', 'Informative', 7),
('R5', 'M5',  'B04', 'Very Good', 9),
('R6',  'M7',  'B07', 	'Damn Good',  9),
('R7', 'M8',  'B05', 'bad',	2),
('R8', 'M3', 'B10', 'Average', 4),
('R9', 'M1', 'B04', 'Good', 8);

SELECT * FROM Review;


INSERT INTO Staff
VALUES
('S01', 'Johanson', '017-0989097', 'Manager'),
('S02', 'Samson', '017-0989098', 'Clerk'),
('S03', 'Kevinson', '017-0989099', 'Clerk'),
('S04', 'Markson', '017-0989100', 'Store Helper'),
('S05', 'Hanson', '017-0989101', 'Admin'),
('S06', 'Parkinson', '017-0989102', 'Clerk');

SELECT * FROM Staff;



INSERT INTO ManagerOrder
VALUES
('MO1', 'S01', '12/12/2010', 945),
('MO2', 'S01', '3/14/2011', 180),
('MO3', 'S01', '3/17/2011', 40),
('MO4', 'S01', '3/20/2011', 120),
('MO5', 'S01', '9/5/2011', 100),
('MO6', 'S01', '3/18/2012', 40);

SELECT * FROM ManagerOrder;


INSERT INTO ManagerOrderDetails
VALUES
('MOD1', 'MO1', 'B01', 2, 150, '12/15/2010'),
('MOD2', 'MO1', 'B02', 5, 325, '12/15/2010'),
('MOD3', 'MO1', 'B03', 2, 110, '12/15/2010'),
('MOD4', 'MO1', 'B04', 4, 360, '12/15/2010'),
('MOD5', 'MO2', 'B05', 2, 180, '3/20/2011'),
('MOD6', 'MO3', 'B09', 2, 40, '3/25/2011'),
('MOD7', 'MO4', 'B07', 2, 120, '4/12/2011'),
('MOD8', 'MO5', 'B08', 2, 100, '9/13/2011'),
('MOD9', 'MO6', 'B10', 2, 40, '4/14/2012');

SELECT * FROM ManagerOrderDetails;






--i. Book with highest rating (book id, book name, rating)

SELECT B.BookID, B.BookName, AVG(R.Rating) as AverageRating
FROM Book AS B
INNER JOIN Review AS R
on B.BookID=R.BookID
GROUP BY B.BookID, B.BookName
HAVING AVG(R.Rating) = (
	SELECT MAX(A.AverageRating) 
	FROM (
		SELECT BookID, AVG(Rating) AS AverageRating 
		FROM Review
		GROUP BY BookID
	)AS A
);









--ii. Total number of feedbacks per member (member id, member name)


SELECT M.MemberID, CONCAT(M.MemberFname,M.MemberLname) AS MemberName, COUNT(R.Rating) AS NumOfFeedBacks 
FROM Member AS M
LEFT JOIN Review AS R
ON M.MemberID=R.MemberID
GROUP BY M.MemberID, M.MemberFname, M.MemberLname;

--publisher who have published more than 2 books
SELECT P.PublisherID, P.PublisherName, COUNT(B.BookID) AS NumofBooksPublished 
FROM Publisher AS P
INNER JOIN Book AS B
ON P.PublisherID=B.PublisherID
GROUP BY P.PublisherID, P.PublisherName
HAVING COUNT(B.BookID) > 2;





--iii. Total number of books published by each publisher 

SELECT P.PublisherID, P.PublisherName, COUNT(B.BookID) AS NumofBooksPublished 
FROM Publisher AS P
LEFT JOIN Book AS B
ON P.PublisherID=B.PublisherID
GROUP BY P.PublisherID, P.PublisherName;


--iv. Total number of books ordered by store manager from each publisher

SELECT P.PublisherID, P.PublisherName, ISNULL(SUM(M.OrderedQuantity), 0) AS NumOfBooksOrdered
FROM ManagerOrderDetails AS M
INNER JOIN Book AS B
ON M.BookID = B.BookID
RIGHT JOIN Publisher AS P
ON B.PublisherID = P.PublisherID
GROUP BY P.PublisherID,P.PublisherName;






--v. List the books where quantity is more than the average quantity of all books

SELECT * FROM Book
WHERE QuantityInStock > (SELECT AVG(QuantityInStock) FROM Book);




--vi. Find the bestselling book(s).

SELECT B.*, Q.QuantitySold AS NumOfBooksSold FROM Book AS B
INNER JOIN (
	SELECT BookID, Sum(OrderedQuantity) AS QuantitySold 
	FROM MemberOrderDetails
	GROUP BY BookID
) AS Q
ON B.BookID=Q.BookID
WHERE Q.QuantitySold = (
	SELECT MAX(T.QuantitySold) 
	FROM (
		SELECT BookID, Sum(OrderedQuantity) AS QuantitySold 
		FROM MemberOrderDetails 
		GROUP BY BookID
	)AS T
);












--vii. Show the member(s) who spent most on buying books.

SELECT M.*, O.TotalSum AS TotalAmountSpent
FROM Member AS M
INNER JOIN (
	SELECT MemberID, Sum(OrderTotal) As TotalSum  
	From MemberOrder 
	GROUP BY MemberID
) AS O
ON M.MemberID=O.MemberID
WHERE O.TotalSum = (
	SELECT MAX(S.TotalSales)
	FROM (
		SELECT MemberID, SUM(OrderTotal) AS TotalSales
		FROM MemberOrder 
		Group by MemberID
	) AS S
);






--viii. Show the member(s) who had not make any order

SELECT M.* FROM Member AS M
LEFT JOIN MemberOrder AS O
ON M.MemberID=O.MemberID
WHERE O.MemberID is NULL;




--ix. A list of purchased books that have not been delivered to members. The list should show member identification number, address, contact number, book serial number,book title, quantity, date and status of delivery.


SELECT M.MemberID AS MemberIdentificationNumber, M.MemberAddress, M.MemberContact AS ContactNumber, 
B.ISBN AS SerialNumber, B.BookName AS Title, S.OrderedQuantity, D.DeliveryDate, D.DeliveryStatus 
FROM Delivery AS D
INNER JOIN MemberOrder AS O
ON O.DeliveryID=D.DeliveryID
INNER JOIN MemberOrderDetails AS S
ON O.OrderID=S.OrderID
INNER JOIN Book AS B
ON S.BookID=B.BookID
INNER JOIN Member AS M
ON O.MemberID = M.MemberID
WHERE D.DeliveryStatus='Not Delivered';







--x. Show the members who made more than 2 orders.


SELECT M.*, S.NumOfOrders 
FROM Member AS M 
INNER JOIN (
	SELECT MemberID, Count(OrderID)AS NumOfOrders 
	FROM MemberOrder 
	GROUP BY MemberID 
	HAVING Count(OrderID) > 2
) AS S 
ON M.MemberID = S.MemberID;


SELECT A.AuthorID, A.AuthorName, COUNT(B.BookID) AS BooksWritten
FROM Author AS A
INNER JOIN Book AS B
ON A.AuthorID=B.AuthorID
GROUP BY A.AuthorID, A.AuthorName
HAVING COUNT(B.BookID) > 2;


----find Member(S) who had not given any feedbacks
--SELECT M.* FROM Member AS M
--LEFT JOIN Review AS R
--ON M.MemberID=R.MemberID
--WHERE R.MemberID IS NULL;

----find the total number of books ordered by each member

--SELECT M.MemberID, ISNULL(SUM(O.OrderedQuantity),0)
--FROM MemberOrderDetails AS O
--INNER JOIN MemberOrder AS S
--ON O.OrderID=S.OrderID
--RIGHT JOIN Member AS M
--ON S.MemberID=M.MemberID
--GROUP BY M.MemberID;

SELECT B.BookID, B.BookName, R.rating
FROM Book AS B
INNER JOIN (
SELECT BookID, AVG(Rating) as rating
FROM Review
GROUP BY BookID
HAVING AVG(Rating) > 5
)AS R
ON B.BookID = R.BookID;