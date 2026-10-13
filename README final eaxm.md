# 📚 Smart Library Management System

<p align="center">

## 🏛️ A Smart SQL-Powered Library Database

**Authors • Books • Members • Borrowing • Returns • Fines**

### A Complete SQL Database Management & Analysis Project

**Created by: Krish**  
**Guided by: Girish Sir**

</p>

---

## 🌟 Project Overview

The **Smart Library Management System** is a practical SQL database project that models everyday library activities. It organizes information about authors, library members, books, and book-borrowing transactions in related database tables.

The project demonstrates how SQL can store structured data, connect related records, retrieve useful information, and analyze borrowing activity.

```sql
CREATE DATABASE SmartLibraryManagement;
USE SmartLibraryManagement;
```

This README is based on the structure, sample records, and query topics in `final exam.sql`.

## 🎯 Project Objectives

- Create a relational database for library operations.
- Store author and member information.
- Maintain a catalog of books and their details.
- Record borrowing and return dates.
- Store fine amounts associated with transactions.
- Connect tables using primary and foreign keys.
- Apply constraints to protect data quality.
- Practice filtering, sorting, grouping, and aggregation.
- Use joins and subqueries to answer library questions.
- Apply date, string, conditional, and window functions.
- Produce useful summaries from borrowing data.

## 🧰 Project Information

| Item | Details |
|---|---|
| Project name | Smart Library Management System |
| SQL file | `final exam.sql` |
| Database | `SmartLibraryManagement` |
| SQL dialect | MySQL |
| Author | Krish |
| Guide | Girish Sir |
| Project type | Academic database project |

---

## 🏗️ Database Architecture

The SQL file creates four related tables:

```text
                 SMART LIBRARY DATABASE
                           |
          +----------------+----------------+
          |                |                |
          v                v                v
       Authors           Members           Books
          |                |                ^
          |                |                |
          |                +-------+        |
          |                        v        |
          |                   Transactions -+
          |
     Books reference Authors
```

### Relationships

```text
Authors  1 ─────────── * Books
Members  1 ─────────── * Transactions
Books    1 ─────────── * Transactions
```

- One author can be associated with multiple books.
- One member can have multiple borrowing transactions.
- One book can appear in multiple transactions over time.
- `Transactions` connects a member to the book borrowed.

## 🗂️ Database Tables

### 1. ✍️ `Authors`

Stores author details.

| Column | Purpose |
|---|---|
| `author_id` | Primary key identifying each author |
| `name` | Author name; required |
| `email` | Author email address |

The sample data includes five authors:

- R. K. Narayan
- A. P. J. Abdul Kalam
- Ruskin Bond
- Sudha Murty
- Chetan Bhagat

### 2. 👥 `Members`

Stores library membership details.

| Column | Purpose |
|---|---|
| `member_id` | Primary key identifying each member |
| `name` | Member name; required |
| `email` | Member email; may be `NULL` |
| `phone_number` | Member phone number |
| `membership_date` | Date the membership began; required |

The sample records include Krish Patel, Aarav Shah, Diya Mehta, Riya Desai, Arjun Joshi, and Mira Patel. Diya Mehta's email is stored as `NULL` in the sample data, demonstrating how missing values can be handled.

### 3. 📚 `Books`

Stores the library's book catalog.

| Column | Purpose |
|---|---|
| `book_id` | Primary key identifying each book |
| `title` | Book title; required |
| `author_id` | Foreign key referencing `Authors` |
| `category` | Book category |
| `isbn` | Unique book identifier in this sample |
| `published_date` | Publication date |
| `price` | Book price; required, default `0` |
| `available_copies` | Available copy count; required, default `0` |

The catalog includes *The Guide*, *Wings of Fire*, *The Blue Umbrella*, *Wise and Otherwise*, *One Indian Girl*, *The India Story*, *A Better India*, and *The Hidden Life of Trees*.

The table definition includes:
- A foreign key from `Books.author_id` to `Authors.author_id`.
- A `UNIQUE` constraint on `isbn`.
- A check that `price >= 0`.
- A check that `available_copies >= 0`.

### 4. 🔄 `Transactions`

Records book-borrowing activity.

| Column | Purpose |
|---|---|
| `transaction_id` | Primary key for each transaction |
| `member_id` | Foreign key referencing `Members` |
| `book_id` | Foreign key referencing `Books` |
| `borrow_date` | Borrowing date; required |
| `return_date` | Return date; can be `NULL` when not returned |
| `fine_amount` | Fine amount; required, default `0` |

The sample data contains transactions numbered `1001` through `1012`. Some have a return date, while others have `NULL`, meaning a return date is not recorded in the supplied data.

The table also checks that `fine_amount >= 0`.

## 🔐 Keys and Constraints

The project uses several relational database features:

- **Primary keys** uniquely identify rows in each table.
- **Foreign keys** connect books to authors and transactions to members and books.
- **`NOT NULL`** makes selected fields mandatory.
- **`UNIQUE`** prevents duplicate ISBN values.
- **`DEFAULT`** supplies default values for price, available copies, and fine amount.
- **`CHECK`** expresses non-negative rules for prices, copy counts, and fines.

These constraints help prevent inconsistent or invalid data from being inserted.

---

## 🔁 CRUD Operations

CRUD means **Create, Read, Update, and Delete**.

### Create

The project creates the database and tables with `CREATE DATABASE` and `CREATE TABLE`.

### Read

`SELECT` statements retrieve data from the tables.

```sql
SELECT * FROM Books;
```

### Update

The file updates the price of book `106`:

```sql
UPDATE Books
SET price = 525.00
WHERE book_id = 106;
```

This changes the listed price of *The India Story* to `525.00`.

The supplied SQL content does not demonstrate a `DELETE` statement, so no delete operation is claimed here.

---

## 🔎 Query Collection and What It Demonstrates

### 1. Filter books published after 2015

```sql
SELECT *
FROM Books
WHERE published_date > '2015-12-31';
```

This filters the catalog to books published after the end of 2015. The sample output includes *One Indian Girl*, *The India Story*, and *The Hidden Life of Trees*.

### 2. Find the five most expensive books

```sql
SELECT *
FROM Books
ORDER BY price DESC
LIMIT 5;
```

`ORDER BY price DESC` sorts prices from highest to lowest, while `LIMIT 5` returns only the first five rows.

### 3. Find members who joined before 2022

```sql
SELECT *
FROM Members
WHERE membership_date < '2022-01-01';
```

The supplied output identifies Krish Patel and Arjun Joshi.

### 4. Combine conditions with `AND`

```sql
SELECT *
FROM Books
WHERE category = 'Science'
  AND price < 500;
```

This finds Science-category books priced below 500. The sample output returns *A Better India*.

### 5. Use `NOT` to find books with no available copies

```sql
SELECT *
FROM Books
WHERE NOT available_copies > 0;
```

This query illustrates negating a condition. With the supplied book data, every listed book has at least one available copy, so the result is empty.

### 6. Count borrowing transactions per member

```sql
SELECT
    m.member_id,
    m.name,
    COUNT(t.transaction_id) AS books_borrowed
FROM Members m
LEFT JOIN Transactions t
    ON t.member_id = m.member_id
GROUP BY m.member_id, m.name
ORDER BY books_borrowed DESC;
```

The `LEFT JOIN` preserves members who have not borrowed a book. `COUNT(t.transaction_id)` counts matching transactions and returns zero for a member with no matching transaction. In the supplied output, Krish Patel has the highest transaction count, with four.

### 7. Count books by category

```sql
SELECT category, COUNT(*) AS total_books
FROM Books
GROUP BY category;
```

This groups the catalog by category and counts the number of books in each group.

### 8. Calculate the average book price

```sql
SELECT AVG(price) AS average_book_price
FROM Books;
```

The supplied output reports an average price of `425.500000` after the update to book `106`.

### 9. Find the most-borrowed book

```sql
SELECT
    b.book_id,
    b.title,
    COUNT(t.transaction_id) AS times_borrowed
FROM Books b
LEFT JOIN Transactions t
    ON t.book_id = b.book_id
GROUP BY b.book_id, b.title
ORDER BY times_borrowed DESC
LIMIT 1;
```

This counts transactions for each book and returns the highest count. The supplied output identifies *The Guide* with three transactions.

### 10. Calculate the total recorded fines

```sql
SELECT SUM(fine_amount) AS total_fines_collected
FROM Transactions;
```

This adds the fine amounts stored in `Transactions`. The sample output gives a total of `50.00`. This is the sum of recorded fine amounts, not proof that every fine was actually paid.

---

## 🔗 Join Examples

### `INNER JOIN`: Books and authors

```sql
SELECT
    b.book_id,
    b.title,
    a.name AS author_name
FROM Books b
INNER JOIN Authors a
    ON b.author_id = a.author_id;
```

An `INNER JOIN` returns matching book-author pairs.

### `LEFT JOIN`: Members and their transactions

```sql
SELECT
    m.member_id,
    m.name,
    t.transaction_id,
    t.book_id,
    t.borrow_date,
    t.return_date
FROM Members m
LEFT JOIN Transactions t
    ON m.member_id = t.member_id;
```

A `LEFT JOIN` includes all members, even if they have no transaction. The supplied output shows Mira Patel with `NULL` transaction fields because no matching transaction is recorded for that member.

### `RIGHT JOIN`: Books never borrowed

```sql
SELECT b.book_id, b.title
FROM Transactions t
RIGHT JOIN Books b
    ON t.book_id = b.book_id
WHERE t.transaction_id IS NULL;
```

This keeps all books and filters to those without a matching transaction. In the supplied data, the output identifies *The India Story*.

### Simulating a `FULL OUTER JOIN` in MySQL

The file combines a `LEFT JOIN` and a `RIGHT JOIN` using `UNION` to show rows from both sides. MySQL does not provide native `FULL OUTER JOIN` syntax, so this is a common demonstration pattern.

---

## 🧠 Subqueries

### Books borrowed by members who joined from 2023 onward

The file joins `Books`, `Transactions`, and `Members`, then filters membership dates. This connects book-borrowing activity with when members joined.

### Find the most-borrowed book using a subquery

The project uses a nested query to count transactions by book, find the maximum count, and select the book or books that match that count. The supplied output identifies *The Guide*.

### Find members with no transactions using `NOT EXISTS`

```sql
SELECT m.member_id, m.name
FROM Members m
WHERE NOT EXISTS (
    SELECT 1
    FROM Transactions t
    WHERE t.member_id = m.member_id
);
```

This checks whether a member has no matching transaction. The supplied output identifies Mira Patel.

---

## 📅 Date and Time Functions

### Extract the publication year

```sql
SELECT
    YEAR(published_date) AS publication_year,
    COUNT(*) AS books_published
FROM Books
WHERE published_date IS NOT NULL
GROUP BY YEAR(published_date)
ORDER BY publication_year;
```

This groups books by publication year.

### Calculate borrowing duration

```sql
SELECT
    transaction_id,
    borrow_date,
    return_date,
    DATEDIFF(return_date, borrow_date) AS days_borrowed
FROM Transactions;
```

`DATEDIFF` returns the difference in days. If `return_date` is `NULL`, the result is also `NULL`.

### Estimate days late

The SQL file assumes a 14-day loan period and uses `COALESCE(return_date, CURDATE())` so a missing return date is evaluated against the current date. It subtracts the assumed loan period and uses `GREATEST(..., 0)` to avoid negative late-day counts.

**Important:** This is a query-based estimate under the file's 14-day assumption. The schema does not itself define a formal loan policy.

### Format a date

```sql
SELECT
    transaction_id,
    borrow_date,
    DATE_FORMAT(borrow_date, '%d-%m-%Y') AS formatted_borrow_date
FROM Transactions;
```

This changes the display format to day-month-year.

---

## 🔤 String Functions and Missing Values

### Convert book titles to uppercase

```sql
SELECT book_id, UPPER(title) AS uppercase_title
FROM Books;
```

### Trim author names

```sql
SELECT author_id, TRIM(name) AS trimmed_author_name
FROM Authors;
```

### Display a fallback for missing email

```sql
SELECT
    member_id,
    name,
    COALESCE(NULLIF(TRIM(email), ''), 'Not Provided') AS email_display
FROM Members;
```

This expression:
1. Trims whitespace from the email.
2. Converts an empty string to `NULL` with `NULLIF`.
3. Uses `COALESCE` to display `Not Provided` when no usable email is present.

---

## 📈 Window Functions

Window functions calculate values across related rows while preserving row-level output.

### Rank books by borrowing count

The project first counts transactions per book in a common table expression (CTE), then uses:

```sql
RANK() OVER (ORDER BY times_borrowed DESC)
```

This ranks books from most borrowed to least borrowed. Books with equal counts receive the same rank, and rank numbers can skip after ties.

### Calculate cumulative borrowing per member

The file uses a windowed `COUNT(*)` partitioned by `member_id` and ordered by `borrow_date` and `transaction_id`. The cumulative count starts at one for each member and increases with each recorded transaction for that member.

These examples introduce analytical SQL techniques useful for reporting and trend analysis.

---

## 🏷️ `CASE` Expressions

### Classify membership activity

The SQL file checks whether a member has borrowed a book within the last six months using `EXISTS` and `DATE_SUB`. It labels a member `Active` if a qualifying transaction exists; otherwise, it labels the member `Inactive`.

### Classify publication dates

The project categorizes books according to publication year:

- **New Arrival** — publication year greater than 2020.
- **Classic** — publication year earlier than 2000.
- **Regular** — other publication years covered by the query.

These are labels defined by the SQL query, not an independent library classification standard.

---

## 🧾 SQL Concepts Practiced

| SQL concept | Demonstrated in project |
|---|:---:|
| `CREATE DATABASE` and `USE` | ✅ |
| `CREATE TABLE` | ✅ |
| Primary keys | ✅ |
| Foreign keys | ✅ |
| `NOT NULL`, `UNIQUE`, `DEFAULT`, `CHECK` | ✅ |
| `INSERT INTO` | ✅ |
| `UPDATE` | ✅ |
| `SELECT` and `WHERE` | ✅ |
| `AND`, `OR`, `NOT` | ✅ |
| `ORDER BY` and `LIMIT` | ✅ |
| `GROUP BY` and `HAVING` | ✅ |
| `COUNT`, `AVG`, `SUM`, `MAX` | ✅ |
| `INNER JOIN`, `LEFT JOIN`, `RIGHT JOIN` | ✅ |
| `UNION` | ✅ |
| Subqueries and `NOT EXISTS` | ✅ |
| `YEAR`, `DATEDIFF`, `DATE_FORMAT`, `DATE_SUB` | ✅ |
| `UPPER`, `TRIM`, `NULLIF`, `COALESCE` | ✅ |
| Common table expression (CTE) | ✅ |
| Window functions: `RANK`, cumulative `COUNT` | ✅ |
| `CASE` expressions | ✅ |

---

## 🚀 How to Run the Project

1. Open a MySQL-compatible environment, such as MySQL Workbench.
2. Open the supplied `final exam.sql` file.
3. Review the database and table creation statements.
4. Execute the script in order so referenced tables exist before dependent tables.
5. Inspect the result sets produced by the `SELECT` queries.
6. To verify the book price update, run:

   ```sql
   SELECT book_id, title, price
   FROM Books
   WHERE book_id = 106;
   ```

### Compatibility note

The script uses MySQL-specific functions and syntax, including `USE`, `DATE_FORMAT`, `CURDATE`, `DATE_SUB`, `GREATEST`, `LIMIT`, and window functions. Use a compatible MySQL version; exact feature availability may vary by version.

### Running the file more than once

The file creates a database and tables and inserts sample records. If you rerun it in the same environment, existing objects or duplicate primary keys may cause errors unless the database is reset or the script is adapted for repeatable execution. Back up any data before dropping or recreating a database.

---

## 🌱 Possible Future Enhancements

The supplied SQL file models the core catalog and borrowing transactions. If you choose to expand it later, possible additions include:

- **Librarians** — staff who manage lending activity.
- **Reservations** — requests for books that are currently unavailable.
- **Categories table** — standardized category records instead of free-text values.
- **Loan rules** — configurable loan periods and fine policies.
- **Payments** — distinguish fines assessed from fines paid.
- **Inventory history** — track additions, losses, and damaged copies.
- **Reports or views** — reusable reports for overdue transactions and popular books.
- **Indexes** — support frequent searches on dates and foreign-key columns.
- **Audit history** — record changes to important library data.

These are ideas for future work; they are not claimed to exist in the current SQL file.

---

## 🎓 Learning Outcomes

### Beginner
- Creating databases and tables.
- Understanding rows, columns, and data types.
- Using primary keys and foreign keys.
- Inserting and selecting records.

### Intermediate
- Filtering and sorting results.
- Joining related tables.
- Grouping data and using aggregate functions.
- Working with missing values.

### Advanced
- Writing nested subqueries.
- Using CTEs and window functions.
- Performing date calculations.
- Applying `CASE` logic for classifications.
- Producing summaries from borrowing records.

---

## 🙏 Acknowledgement

I would like to express my sincere gratitude to **Girish Sir** for guidance, teaching, and encouragement throughout this SQL project. Working on this database has helped me connect classroom concepts with practical examples of how structured information can be stored and analyzed.

## 👨‍💻 Author

**Krish**

## 👨‍🏫 Guided By

**Girish Sir**

---

## 🏁 Conclusion

The **Smart Library Management System** demonstrates how a relational database can organize books, authors, members, and borrowing transactions in one connected structure.

Starting with table creation and constraints, the project moves into joins, aggregate functions, subqueries, date and string manipulation, window functions, and conditional logic. Together, these examples form a practical foundation for understanding SQL-based data management and analysis.

> **“Organize the books. Connect the records. Let the data tell the story.”**

---

## 📁 Project Structure

```text
📦 Smart-Library-Management-System
├── final exam.sql
└── README.md
```

<p align="center">

### 📚 SMART LIBRARY MANAGEMENT SYSTEM

**Created by Krish • Guided by Girish Sir**

*Built with SQL, curiosity, and a love of learning.*

</p>
