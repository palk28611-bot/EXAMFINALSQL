
--create databases
CREATE DATABASE SmartLibraryManagement;
USE SmartLibraryManagement;


CREATE TABLE Authors (
  author_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150)
);

INSERT INTO Authors VALUES
(1,'R. K. Narayan','rknarayan@example.com'),
(2,'A. P. J. Abdul Kalam','apjkalam@example.com'),
(3,'Ruskin Bond','ruskinbond@example.com'),
(4,'Sudha Murty','sudhamurty@example.com'),
(5,'Chetan Bhagat','chetanbhagat@example.com');


+-----------+----------------------+--------------------------+
| author_id | name                 | email                    |
+-----------+----------------------+--------------------------+
|         1 | R. K. Narayan        | rknarayan@example.com    |
|         2 | A. P. J. Abdul Kalam | apjkalam@example.com     |
|         3 | Ruskin Bond          | ruskinbond@example.com   |
|         4 | Sudha Murty          | sudhamurty@example.com   |
|         5 | Chetan Bhagat        | chetanbhagat@example.com |
+-----------+----------------------+--------------------------+

CREATE TABLE Members (
  member_id INT PRIMARY KEY,
  name VARCHAR(100) NOT NULL,
  email VARCHAR(150),
  phone_number VARCHAR(20),
  membership_date DATE NOT NULL
);

INSERT INTO Members VALUES
(1,'Krish Patel','krish@example.com','9876500001','2021-06-10'),
(2,'Aarav Shah','aarav@example.com','9876500002','2022-02-15'),
(3,'Diya Mehta',NULL,'9876500003','2023-04-20'),
(4,'Riya Desai','riya@example.com','9876500004','2024-01-05'),
(5,'Arjun Joshi','arjun@example.com','9876500005','2020-09-12'),
(6,'Mira Patel','mira@example.com','9876500006','2025-03-01');


+-----------+-------------+-------------------+--------------+-----------------+
| member_id | name        | email             | phone_number | membership_date |
+-----------+-------------+-------------------+--------------+-----------------+
|         1 | Krish Patel | krish@example.com | 9876500001   | 2021-06-10      |
|         2 | Aarav Shah  | aarav@example.com | 9876500002   | 2022-02-15      |
|         3 | Diya Mehta  | NULL              | 9876500003   | 2023-04-20      |
|         4 | Riya Desai  | riya@example.com  | 9876500004   | 2024-01-05      |
|         5 | Arjun Joshi | arjun@example.com | 9876500005   | 2020-09-12      |
|         6 | Mira Patel  | mira@example.com  | 9876500006   | 2025-03-01      |
+-----------+-------------+-------------------+--------------+-----------------+

CREATE TABLE Books (
  book_id INT PRIMARY KEY,
  title VARCHAR(200) NOT NULL,
  author_id INT NOT NULL,
  category VARCHAR(80),
  isbn VARCHAR(30) UNIQUE,
  published_date DATE,
  price DECIMAL(10,2) NOT NULL DEFAULT 0,
  available_copies INT NOT NULL DEFAULT 0,
  FOREIGN KEY (author_id) REFERENCES Authors(author_id),
  CHECK (price >= 0),
  CHECK (available_copies >= 0)
);

INSERT INTO Books VALUES
(101,'The Guide',1,'Fiction','9780000000101','1958-01-01',350.00,4),
(102,'Wings of Fire',2,'Biography','9780000000102','1999-01-01',450.00,6),
(103,'The Blue Umbrella',3,'Fiction','9780000000103','1980-01-01',250.00,3),
(104,'Wise and Otherwise',4,'Stories','9780000000104','2002-01-01',300.00,5),
(105,'One Indian Girl',5,'Fiction','9780000000105','2016-01-01',399.00,2),
(106,'The India Story',4,'Education','9780000000106','2021-01-01',520.00,3),
(107,'A Better India',2,'Science','9780000000107','2011-01-01',480.00,7),
(108,'The Hidden Life of Trees',3,'Science','9780000000108','2018-01-01',650.00,1);

+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
| book_id | title                    | author_id | category  | isbn          | published_date | price  | available_copies |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
|     101 | The Guide                |         1 | Fiction   | 9780000000101 | 1958-01-01     | 350.00 |                4 |
|     102 | Wings of Fire            |         2 | Biography | 9780000000102 | 1999-01-01     | 450.00 |                6 |
|     103 | The Blue Umbrella        |         3 | Fiction   | 9780000000103 | 1980-01-01     | 250.00 |                3 |
|     104 | Wise and Otherwise       |         4 | Stories   | 9780000000104 | 2002-01-01     | 300.00 |                5 |
|     105 | One Indian Girl          |         5 | Fiction   | 9780000000105 | 2016-01-01     | 399.00 |                2 |
|     106 | The India Story          |         4 | Education | 9780000000106 | 2021-01-01     | 520.00 |                3 |
|     107 | A Better India           |         2 | Science   | 9780000000107 | 2011-01-01     | 480.00 |                7 |
|     108 | The Hidden Life of Trees |         3 | Science   | 9780000000108 | 2018-01-01     | 650.00 |                1 |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+

CREATE TABLE Transactions (
  transaction_id INT PRIMARY KEY,
  member_id INT NOT NULL,
  book_id INT NOT NULL,
  borrow_date DATE NOT NULL,
  return_date DATE NULL,
  fine_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
  FOREIGN KEY (member_id) REFERENCES Members(member_id),
  FOREIGN KEY (book_id) REFERENCES Books(book_id),
  CHECK (fine_amount >= 0)
);




INSERT INTO Transactions VALUES
(1001,1,101,'2026-01-05','2026-01-15',0.00),
(1002,1,102,'2026-02-10','2026-02-25',20.00),
(1003,2,103,'2026-03-01','2026-03-12',0.00),
(1004,2,101,'2026-04-04','2026-04-20',10.00),
(1005,3,104,'2026-05-15',NULL,0.00),
(1006,4,105,'2026-06-01','2026-06-08',0.00),
(1007,1,101,'2026-07-12',NULL,0.00),
(1008,5,107,'2025-11-02','2025-11-15',15.00),
(1009,5,102,'2026-08-01','2026-08-10',0.00),
(1010,2,105,'2026-09-05',NULL,0.00),
(1011,4,108,'2026-09-15','2026-09-29',5.00),
(1012,1,103,'2026-10-01',NULL,0.00);


+----------------+-----------+---------+-------------+-------------+-------------+
| transaction_id | member_id | book_id | borrow_date | return_date | fine_amount |
+----------------+-----------+---------+-------------+-------------+-------------+
|           1001 |         1 |     101 | 2026-01-05  | 2026-01-15  |        0.00 |
|           1002 |         1 |     102 | 2026-02-10  | 2026-02-25  |       20.00 |
|           1003 |         2 |     103 | 2026-03-01  | 2026-03-12  |        0.00 |
|           1004 |         2 |     101 | 2026-04-04  | 2026-04-20  |       10.00 |
|           1005 |         3 |     104 | 2026-05-15  | NULL        |        0.00 |
|           1006 |         4 |     105 | 2026-06-01  | 2026-06-08  |        0.00 |
|           1007 |         1 |     101 | 2026-07-12  | NULL        |        0.00 |
|           1008 |         5 |     107 | 2025-11-02  | 2025-11-15  |       15.00 |
|           1009 |         5 |     102 | 2026-08-01  | 2026-08-10  |        0.00 |
|           1010 |         2 |     105 | 2026-09-05  | NULL        |        0.00 |
|           1011 |         4 |     108 | 2026-09-15  | 2026-09-29  |        5.00 |
|           1012 |         1 |     103 | 2026-10-01  | NULL        |        0.00 |
+----------------+-----------+---------+-------------+-------------+-------------+

-- UPDATE 
UPDATE Books SET price = 525.00 WHERE book_id = 106;

+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
| book_id | title                    | author_id | category  | isbn          | published_date | price  | available_copies |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
|     101 | The Guide                |         1 | Fiction   | 9780000000101 | 1958-01-01     | 350.00 |                4 |
|     102 | Wings of Fire            |         2 | Biography | 9780000000102 | 1999-01-01     | 450.00 |                6 |
|     103 | The Blue Umbrella        |         3 | Fiction   | 9780000000103 | 1980-01-01     | 250.00 |                3 |
|     104 | Wise and Otherwise       |         4 | Stories   | 9780000000104 | 2002-01-01     | 300.00 |                5 |
|     105 | One Indian Girl          |         5 | Fiction   | 9780000000105 | 2016-01-01     | 399.00 |                2 |
|     106 | The India Story          |         4 | Education | 9780000000106 | 2021-01-01     | 525.00 |                3 |
|     107 | A Better India           |         2 | Science   | 9780000000107 | 2011-01-01     | 480.00 |                7 |
|     108 | The Hidden Life of Trees |         3 | Science   | 9780000000108 | 2018-01-01     | 650.00 |                1 |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+


-- 2. get Books published after the year 2015.
SELECT * FROM Books WHERE published_date > '2015-12-31';

+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
| book_id | title                    | author_id | category  | isbn          | published_date | price  | available_copies |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
|     105 | One Indian Girl          |         5 | Fiction   | 9780000000105 | 2016-01-01     | 399.00 |                2 |
|     106 | The India Story          |         4 | Education | 9780000000106 | 2021-01-01     | 525.00 |                3 |
|     108 | The Hidden Life of Trees |         3 | Science   | 9780000000108 | 2018-01-01     | 650.00 |                1 |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+

-- retrive Top 5 most expensive books.
SELECT * FROM Books ORDER BY price DESC LIMIT 5;

+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
| book_id | title                    | author_id | category  | isbn          | published_date | price  | available_copies |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
|     108 | The Hidden Life of Trees |         3 | Science   | 9780000000108 | 2018-01-01     | 650.00 |                1 |
|     106 | The India Story          |         4 | Education | 9780000000106 | 2021-01-01     | 525.00 |                3 |
|     107 | A Better India           |         2 | Science   | 9780000000107 | 2011-01-01     | 480.00 |                7 |
|     102 | Wings of Fire            |         2 | Biography | 9780000000102 | 1999-01-01     | 450.00 |                6 |
|     105 | One Indian Girl          |         5 | Fiction   | 9780000000105 | 2016-01-01     | 399.00 |                2 |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+

--find Members who joined before 2022.
SELECT * FROM Members WHERE membership_date < '2022-01-01';

+-----------+-------------+-------------------+--------------+-----------------+
| member_id | name        | email             | phone_number | membership_date |
+-----------+-------------+-------------------+--------------+-----------------+
|         1 | Krish Patel | krish@example.com | 9876500001   | 2021-06-10      |
|         5 | Arjun Joshi | arjun@example.com | 9876500005   | 2020-09-12      |
+-----------+-------------+-------------------+--------------+-----------------+

-- 3. AND, OR, NOT
SELECT * FROM Books WHERE category = 'Science' AND price < 500;

+---------+----------------+-----------+----------+---------------+----------------+--------+------------------+
| book_id | title          | author_id | category | isbn          | published_date | price  | available_copies |
+---------+----------------+-----------+----------+---------------+----------------+--------+------------------+
|     107 | A Better India |         2 | Science  | 9780000000107 | 2011-01-01     | 480.00 |                7 |
+---------+----------------+-----------+----------+---------------+----------------+--------+------------------+


SELECT * FROM Books WHERE NOT available_copies > 0;
SELECT m.member_id, m.name, COUNT(t.transaction_id) AS borrow_count
FROM Members m LEFT JOIN Transactions t ON t.member_id = m.member_id
GROUP BY m.member_id, m.name, m.membership_date
HAVING m.membership_date > '2020-12-31' OR COUNT(t.transaction_id) > 3;

+-----------+-------------+--------------+
| member_id | name        | borrow_count |
+-----------+-------------+--------------+
|         1 | Krish Patel |            4 |
|         2 | Aarav Shah  |            3 |
|         3 | Diya Mehta  |            1 |
|         4 | Riya Desai  |            2 |
|         6 | Mira Patel  |            0 |
+-----------+-------------+--------------+

-- 4. Sorting and grouping data
SELECT * FROM Books ORDER BY title;

+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
| book_id | title                    | author_id | category  | isbn          | published_date | price  | available_copies |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+
|     107 | A Better India           |         2 | Science   | 9780000000107 | 2011-01-01     | 480.00 |                7 |
|     105 | One Indian Girl          |         5 | Fiction   | 9780000000105 | 2016-01-01     | 399.00 |                2 |
|     103 | The Blue Umbrella        |         3 | Fiction   | 9780000000103 | 1980-01-01     | 250.00 |                3 |
|     101 | The Guide                |         1 | Fiction   | 9780000000101 | 1958-01-01     | 350.00 |                4 |
|     108 | The Hidden Life of Trees |         3 | Science   | 9780000000108 | 2018-01-01     | 650.00 |                1 |
|     106 | The India Story          |         4 | Education | 9780000000106 | 2021-01-01     | 525.00 |                3 |
|     102 | Wings of Fire            |         2 | Biography | 9780000000102 | 1999-01-01     | 450.00 |                6 |
|     104 | Wise and Otherwise       |         4 | Stories   | 9780000000104 | 2002-01-01     | 300.00 |                5 |
+---------+--------------------------+-----------+-----------+---------------+----------------+--------+------------------+

--
SELECT m.member_id, m.name, COUNT(t.transaction_id) AS books_borrowed
FROM Members m LEFT JOIN Transactions t ON t.member_id = m.member_id
GROUP BY m.member_id, m.name ORDER BY books_borrowed DESC;
SELECT category, COUNT(*) AS book_count FROM Books GROUP BY category;

+-----------+-------------+----------------+
| member_id | name        | books_borrowed |
+-----------+-------------+----------------+
|         1 | Krish Patel |              4 |
|         2 | Aarav Shah  |              3 |
|         4 | Riya Desai  |              2 |
|         5 | Arjun Joshi |              2 |
|         3 | Diya Mehta  |              1 |
|         6 | Mira Patel  |              0 |
+-----------+-------------+----------------+

-- 5.USe Aggregates function

SELECT category, COUNT(*) AS total_books FROM Books GROUP BY category;

+-----------+-------------+
| category  | total_books |
+-----------+-------------+
| Fiction   |           3 |
| Biography |           1 |
| Stories   |           1 |
| Education |           1 |
| Science   |           2 |
+-----------+-------------+
SELECT AVG(price) AS average_book_price FROM Books;

+--------------------+
| average_book_price |
+--------------------+
|         425.500000 |
+--------------------+
SELECT b.book_id, b.title, COUNT(t.transaction_id) AS times_borrowed
FROM Books b LEFT JOIN Transactions t ON t.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY times_borrowed DESC LIMIT 1;

+---------+-----------+----------------+
| book_id | title     | times_borrowed |
+---------+-----------+----------------+
|     101 | The Guide |              3 |
+---------+-----------+----------------+

SELECT SUM(fine_amount) AS total_fines_collected FROM Transactions;

+-----------------------+
| total_fines_collected |
+-----------------------+
|                 50.00 |
+-----------------------+

-- 6.establish primary and forirgn key relationship
SELECT b.book_id, b.title, a.name AS author_name
FROM Books b INNER JOIN Authors a ON b.author_id = a.author_id;

+---------+--------------------------+----------------------+
| book_id | title                    | author_name          |
+---------+--------------------------+----------------------+
|     101 | The Guide                | R. K. Narayan        |
|     102 | Wings of Fire            | A. P. J. Abdul Kalam |
|     107 | A Better India           | A. P. J. Abdul Kalam |
|     103 | The Blue Umbrella        | Ruskin Bond          |
|     108 | The Hidden Life of Trees | Ruskin Bond          |
|     104 | Wise and Otherwise       | Sudha Murty          |
|     106 | The India Story          | Sudha Murty          |
|     105 | One Indian Girl          | Chetan Bhagat        |
+---------+--------------------------+----------------------+

SELECT m.member_id, m.name, t.transaction_id, t.book_id, t.borrow_date, t.return_date
FROM Members m LEFT JOIN Transactions t ON m.member_id = t.member_id;

+-----------+-------------+----------------+---------+-------------+-------------+
| member_id | name        | transaction_id | book_id | borrow_date | return_date |
+-----------+-------------+----------------+---------+-------------+-------------+
|         1 | Krish Patel |           1001 |     101 | 2026-01-05  | 2026-01-15  |
|         1 | Krish Patel |           1002 |     102 | 2026-02-10  | 2026-02-25  |
|         1 | Krish Patel |           1007 |     101 | 2026-07-12  | NULL        |
|         1 | Krish Patel |           1012 |     103 | 2026-10-01  | NULL        |
|         2 | Aarav Shah  |           1003 |     103 | 2026-03-01  | 2026-03-12  |
|         2 | Aarav Shah  |           1004 |     101 | 2026-04-04  | 2026-04-20  |
|         2 | Aarav Shah  |           1010 |     105 | 2026-09-05  | NULL        |
|         3 | Diya Mehta  |           1005 |     104 | 2026-05-15  | NULL        |
|         4 | Riya Desai  |           1006 |     105 | 2026-06-01  | 2026-06-08  |
|         4 | Riya Desai  |           1011 |     108 | 2026-09-15  | 2026-09-29  |
|         5 | Arjun Joshi |           1008 |     107 | 2025-11-02  | 2025-11-15  |
|         5 | Arjun Joshi |           1009 |     102 | 2026-08-01  | 2026-08-10  |
|         6 | Mira Patel  |           NULL |    NULL | NULL        | NULL        |
+-----------+-------------+----------------+---------+-------------+-------------+

SELECT b.book_id, b.title
FROM Transactions t RIGHT JOIN Books b ON t.book_id = b.book_id
WHERE t.transaction_id IS NULL;

+---------+-----------------+
| book_id | title           |
+---------+-----------------+
|     106 | The India Story |
+---------+-----------------+

-- MySQL has no native FULL OUTER JOIN  UNION of left and right joins is equivalent.
SELECT m.member_id, m.name, t.transaction_id, t.book_id, t.borrow_date
FROM Members m LEFT JOIN Transactions t ON m.member_id = t.member_id
UNION
SELECT m.member_id, m.name, t.transaction_id, t.book_id, t.borrow_date
FROM Members m RIGHT JOIN Transactions t ON m.member_id = t.member_id;

+-----------+-------------+----------------+---------+-------------+
| member_id | name        | transaction_id | book_id | borrow_date |
+-----------+-------------+----------------+---------+-------------+
|         1 | Krish Patel |           1001 |     101 | 2026-01-05  |
|         1 | Krish Patel |           1002 |     102 | 2026-02-10  |
|         1 | Krish Patel |           1007 |     101 | 2026-07-12  |
|         1 | Krish Patel |           1012 |     103 | 2026-10-01  |
|         2 | Aarav Shah  |           1003 |     103 | 2026-03-01  |
|         2 | Aarav Shah  |           1004 |     101 | 2026-04-04  |
|         2 | Aarav Shah  |           1010 |     105 | 2026-09-05  |
|         3 | Diya Mehta  |           1005 |     104 | 2026-05-15  |
|         4 | Riya Desai  |           1006 |     105 | 2026-06-01  |
|         4 | Riya Desai  |           1011 |     108 | 2026-09-15  |
|         5 | Arjun Joshi |           1008 |     107 | 2025-11-02  |
|         5 | Arjun Joshi |           1009 |     102 | 2026-08-01  |
|         6 | Mira Patel  |           NULL |    NULL | NULL        |
+-----------+-------------+----------------+---------+-------------+

-- 7.  use Subqueries
SELECT DISTINCT b.book_id, b.title, m.name AS member_name
FROM Books b JOIN Transactions t ON b.book_id = t.book_id
JOIN Members m ON t.member_id = m.member_id
WHERE m.membership_date >= '2023-01-01';

+---------+--------------------------+-------------+
| book_id | title                    | member_name |
+---------+--------------------------+-------------+
|     104 | Wise and Otherwise       | Diya Mehta  |
|     105 | One Indian Girl          | Riya Desai  |
|     108 | The Hidden Life of Trees | Riya Desai  |
+---------+--------------------------+-------------+

SELECT book_id, title FROM Books
WHERE book_id IN (
  SELECT book_id FROM Transactions GROUP BY book_id
  HAVING COUNT(*) = (
    SELECT MAX(cnt) FROM (
      SELECT COUNT(*) AS cnt FROM Transactions GROUP BY book_id
    ) AS book_counts
  )
);

+---------+-----------+
| book_id | title     |
+---------+-----------+
|     101 | The Guide |
+---------+-----------+

SELECT m.member_id, m.name FROM Members m
WHERE NOT EXISTS (SELECT 1 FROM Transactions t WHERE t.member_id = m.member_id);

+-----------+------------+
| member_id | name       |
+-----------+------------+
|         6 | Mira Patel |
+-----------+------------+

-- 8. Date/time functions functions
SELECT YEAR(published_date) AS publication_year, COUNT(*) AS books_published
FROM Books WHERE published_date IS NOT NULL
GROUP BY YEAR(published_date) ORDER BY publication_year;

+------------------+-----------------+
| publication_year | books_published |
+------------------+-----------------+
|             1958 |               1 |
|             1980 |               1 |
|             1999 |               1 |
|             2002 |               1 |
|             2011 |               1 |
|             2016 |               1 |
|             2018 |               1 |
|             2021 |               1 |
+------------------+-----------------+

SELECT transaction_id, borrow_date, return_date,
       DATEDIFF(return_date, borrow_date) AS days_borrowed
FROM Transactions;


+----------------+-------------+-------------+---------------+
| transaction_id | borrow_date | return_date | days_borrowed |
+----------------+-------------+-------------+---------------+
|           1001 | 2026-01-05  | 2026-01-15  |            10 |
|           1002 | 2026-02-10  | 2026-02-25  |            15 |
|           1003 | 2026-03-01  | 2026-03-12  |            11 |
|           1004 | 2026-04-04  | 2026-04-20  |            16 |
|           1005 | 2026-05-15  | NULL        |          NULL |
|           1006 | 2026-06-01  | 2026-06-08  |             7 |
|           1007 | 2026-07-12  | NULL        |          NULL |
|           1008 | 2025-11-02  | 2025-11-15  |            13 |
|           1009 | 2026-08-01  | 2026-08-10  |             9 |
|           1010 | 2026-09-05  | NULL        |          NULL |
|           1011 | 2026-09-15  | 2026-09-29  |            14 |
|           1012 | 2026-10-01  | NULL        |          NULL |
+----------------+-------------+-------------+---------------+


-- Assumed loan period 14 days. NULL return_date uses today's date.
SELECT transaction_id, borrow_date, return_date,
       GREATEST(DATEDIFF(COALESCE(return_date, CURDATE()), borrow_date) - 14, 0) AS days_late
FROM Transactions;

+----------------+-------------+-------------+-----------+
| transaction_id | borrow_date | return_date | days_late |
+----------------+-------------+-------------+-----------+
|           1001 | 2026-01-05  | 2026-01-15  |         0 |
|           1002 | 2026-02-10  | 2026-02-25  |         1 |
|           1003 | 2026-03-01  | 2026-03-12  |         0 |
|           1004 | 2026-04-04  | 2026-04-20  |         2 |
|           1005 | 2026-05-15  | NULL        |       137 |
|           1006 | 2026-06-01  | 2026-06-08  |         0 |
|           1007 | 2026-07-12  | NULL        |        79 |
|           1008 | 2025-11-02  | 2025-11-15  |         0 |
|           1009 | 2026-08-01  | 2026-08-10  |         0 |
|           1010 | 2026-09-05  | NULL        |        24 |
|           1011 | 2026-09-15  | 2026-09-29  |         0 |
|           1012 | 2026-10-01  | NULL        |         0 |
+----------------+-------------+-------------+-----------+


SELECT transaction_id, borrow_date,
       DATE_FORMAT(borrow_date, '%d-%m-%Y') AS formatted_borrow_date
FROM Transactions;


+----------------+-------------+-----------------------+
| transaction_id | borrow_date | formatted_borrow_date |
+----------------+-------------+-----------------------+
|           1001 | 2026-01-05  | 05-01-2026            |
|           1002 | 2026-02-10  | 10-02-2026            |
|           1003 | 2026-03-01  | 01-03-2026            |
|           1004 | 2026-04-04  | 04-04-2026            |
|           1005 | 2026-05-15  | 15-05-2026            |
|           1006 | 2026-06-01  | 01-06-2026            |
|           1007 | 2026-07-12  | 12-07-2026            |
|           1008 | 2025-11-02  | 02-11-2025            |
|           1009 | 2026-08-01  | 01-08-2026            |
|           1010 | 2026-09-05  | 05-09-2026            |
|           1011 | 2026-09-15  | 15-09-2026            |
|           1012 | 2026-10-01  | 01-10-2026            |
+----------------+-------------+-----------------------+


-- 9. String manipulation
SELECT book_id, UPPER(title) AS uppercase_title FROM Books;

+---------+--------------------------+
| book_id | uppercase_title          |
+---------+--------------------------+
|     101 | THE GUIDE                |
|     102 | WINGS OF FIRE            |
|     103 | THE BLUE UMBRELLA        |
|     104 | WISE AND OTHERWISE       |
|     105 | ONE INDIAN GIRL          |
|     106 | THE INDIA STORY          |
|     107 | A BETTER INDIA           |
|     108 | THE HIDDEN LIFE OF TREES |
+---------+--------------------------+
SELECT author_id, TRIM(name) AS trimmed_author_name FROM Authors;

+-----------+----------------------+
| author_id | trimmed_author_name  |
+-----------+----------------------+
|         1 | R. K. Narayan        |
|         2 | A. P. J. Abdul Kalam |
|         3 | Ruskin Bond          |
|         4 | Sudha Murty          |
|         5 | Chetan Bhagat        |
+-----------+----------------------+
SELECT member_id, name,
       COALESCE(NULLIF(TRIM(email), ''), 'Not Provided') AS email_display
FROM Members;

+-----------+-------------+-------------------+
| member_id | name        | email_display     |
+-----------+-------------+-------------------+
|         1 | Krish Patel | krish@example.com |
|         2 | Aarav Shah  | aarav@example.com |
|         3 | Diya Mehta  | Not Provided      |
|         4 | Riya Desai  | riya@example.com  |
|         5 | Arjun Joshi | arjun@example.com |
|         6 | Mira Patel  | mira@example.com  |
+-----------+-------------+-------------------+

-- 10. Window functions book borrowing rank
WITH BookBorrowCounts AS (
  SELECT b.book_id, b.title, COUNT(t.transaction_id) AS times_borrowed
  FROM Books b LEFT JOIN Transactions t ON t.book_id = b.book_id
  GROUP BY b.book_id, b.title
)
SELECT book_id, title, times_borrowed,
       RANK() OVER (ORDER BY times_borrowed DESC) AS borrowing_rank
FROM BookBorrowCounts;

---------+--------------------------+----------------+----------------+
| book_id | title                    | times_borrowed | borrowing_rank |
+---------+--------------------------+----------------+----------------+
|     101 | The Guide                |              3 |              1 |
|     102 | Wings of Fire            |              2 |              2 |
|     103 | The Blue Umbrella        |              2 |              2 |
|     105 | One Indian Girl          |              2 |              2 |
|     104 | Wise and Otherwise       |              1 |              5 |
|     107 | A Better India           |              1 |              5 |
|     108 | The Hidden Life of Trees |              1 |              5 |
|     106 | The India Story          |              0 |              8 |
+---------+--------------------------+----------------+----------------+


-- Cumulative number of borrow transactions per member
SELECT transaction_id, member_id, book_id, borrow_date,
       COUNT(*) OVER (
         PARTITION BY member_id ORDER BY borrow_date, transaction_id
         ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW
       ) AS cumulative_borrows
FROM Transactions ORDER BY member_id, borrow_date, transaction_id;

+----------------+-----------+---------+-------------+--------------------+
| transaction_id | member_id | book_id | borrow_date | cumulative_borrows |
+----------------+-----------+---------+-------------+--------------------+
|           1001 |         1 |     101 | 2026-01-05  |                  1 |
|           1002 |         1 |     102 | 2026-02-10  |                  2 |
|           1007 |         1 |     101 | 2026-07-12  |                  3 |
|           1012 |         1 |     103 | 2026-10-01  |                  4 |
|           1003 |         2 |     103 | 2026-03-01  |                  1 |
|           1004 |         2 |     101 | 2026-04-04  |                  2 |
|           1010 |         2 |     105 | 2026-09-05  |                  3 |
|           1005 |         3 |     104 | 2026-05-15  |                  1 |
|           1006 |         4 |     105 | 2026-06-01  |                  1 |
|           1011 |         4 |     108 | 2026-09-15  |                  2 |
|           1008 |         5 |     107 | 2025-11-02  |                  1 |
|           1009 |         5 |     102 | 2026-08-01  |                  2 |
+----------------+-----------+---------+-------------+--------------------+



-- 11. CASE expressions Active if borrowed in last 6 months
SELECT m.member_id, m.name,
       CASE WHEN EXISTS (
         SELECT 1 FROM Transactions t
         WHERE t.member_id = m.member_id
           AND t.borrow_date >= DATE_SUB(CURDATE(), INTERVAL 6 MONTH)
       ) THEN 'Active' ELSE 'Inactive' END AS Membership_Status
FROM Members m;

-----------+-------------+-------------------+
| member_id | name        | Membership_Status |
+-----------+-------------+-------------------+
|         1 | Krish Patel | Active            |
|         2 | Aarav Shah  | Active            |
|         3 | Diya Mehta  | Active            |
|         4 | Riya Desai  | Active            |
|         5 | Arjun Joshi | Active            |
|         6 | Mira Patel  | Inactive          |
+-----------+-------------+-------------------+

-- Book publication categories
SELECT book_id, title, published_date,
       CASE
         WHEN YEAR(published_date) > 2020 THEN 'New Arrival'
         WHEN YEAR(published_date) < 2000 THEN 'Classic'
         ELSE 'Regular'
       END AS publication_category
FROM Books;


+---------+--------------------------+----------------+----------------------+
| book_id | title                    | published_date | publication_category |
+---------+--------------------------+----------------+----------------------+
|     101 | The Guide                | 1958-01-01     | Classic              |
|     102 | Wings of Fire            | 1999-01-01     | Classic              |
|     103 | The Blue Umbrella        | 1980-01-01     | Classic              |
|     104 | Wise and Otherwise       | 2002-01-01     | Regular              |
|     105 | One Indian Girl          | 2016-01-01     | Regular              |
|     106 | The India Story          | 2021-01-01     | New Arrival          |
|     107 | A Better India           | 2011-01-01     | Regular              |
|     108 | The Hidden Life of Trees | 2018-01-01     | Regular              |
+---------+--------------------------+----------------+----------------------+