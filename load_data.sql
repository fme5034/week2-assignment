-- load_data.sql: sample data for library.db
-- Run once on a freshly built database:
--   sqlite3 library.db < load_data.sql
-- Loan dates are relative to the day you run it, so 'overdue' stays overdue.
PRAGMA foreign_keys = ON;
BEGIN;

-- BOOKS: first 25 rows of books.csv
-- isbn: restored to 10 characters (the CSV dropped leading zeros).
-- isbn13: rebuilt from isbn by the official formula, because the CSV's
--   scientific-notation value (e.g. 9.78043902348e+12) lost the last digit.
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (1, 'The Hunger Games (The Hunger Games, #1)', '0439023483', '9780439023481', 2008);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (2, 'Harry Potter and the Sorcerer''s Stone (Harry Potter, #1)', '0439554934', '9780439554930', 1997);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (3, 'Twilight (Twilight, #1)', '0316015849', '9780316015844', 2005);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (4, 'To Kill a Mockingbird', '0061120081', '9780061120084', 1960);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (5, 'The Great Gatsby', '0743273567', '9780743273565', 1925);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (6, 'The Fault in Our Stars', '0525478817', '9780525478812', 2012);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (7, 'The Hobbit', '0618260307', '9780618260300', 1937);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (8, 'The Catcher in the Rye', '0316769177', '9780316769174', 1951);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (9, 'Angels & Demons  (Robert Langdon, #1)', '1416524797', '9781416524793', 2000);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (10, 'Pride and Prejudice', '0679783261', '9780679783268', 1813);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (11, 'The Kite Runner', '1594480001', '9781594480003', 2003);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (12, 'Divergent (Divergent, #1)', '0062024035', '9780062024039', 2011);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (13, '1984', '0451524934', '9780451524935', 1949);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (14, 'Animal Farm', '0452284244', '9780452284241', 1945);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (15, 'The Diary of a Young Girl', '0553296981', '9780553296983', 1947);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (16, 'The Girl with the Dragon Tattoo (Millennium, #1)', '0307269752', '9780307269751', 2005);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (17, 'Catching Fire (The Hunger Games, #2)', '0439023491', '9780439023498', 2009);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (18, 'Harry Potter and the Prisoner of Azkaban (Harry Potter, #3)', '043965548X', '9780439655484', 1999);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (19, 'The Fellowship of the Ring (The Lord of the Rings, #1)', '0618346252', '9780618346257', 1954);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (20, 'Mockingjay (The Hunger Games, #3)', '0439023513', '9780439023511', 2010);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (21, 'Harry Potter and the Order of the Phoenix (Harry Potter, #5)', '0439358078', '9780439358071', 2003);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (22, 'The Lovely Bones', '0316166685', '9780316166683', 2002);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (23, 'Harry Potter and the Chamber of Secrets (Harry Potter, #2)', '0439064864', '9780439064866', 1998);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (24, 'Harry Potter and the Goblet of Fire (Harry Potter, #4)', '0439139600', '9780439139601', 2000);
INSERT INTO books (book_id, title, isbn, isbn13, publication_year) VALUES (25, 'Harry Potter and the Deathly Hallows (Harry Potter, #7)', '0545010225', '9780545010221', 2007);

-- AUTHORS: one row per person, split out of the comma-separated CSV field
INSERT INTO authors (author_id, name) VALUES (1, 'Suzanne Collins');
INSERT INTO authors (author_id, name) VALUES (2, 'J.K. Rowling');
INSERT INTO authors (author_id, name) VALUES (3, 'Mary GrandPré');
INSERT INTO authors (author_id, name) VALUES (4, 'Stephenie Meyer');
INSERT INTO authors (author_id, name) VALUES (5, 'Harper Lee');
INSERT INTO authors (author_id, name) VALUES (6, 'F. Scott Fitzgerald');
INSERT INTO authors (author_id, name) VALUES (7, 'John Green');
INSERT INTO authors (author_id, name) VALUES (8, 'J.R.R. Tolkien');
INSERT INTO authors (author_id, name) VALUES (9, 'J.D. Salinger');
INSERT INTO authors (author_id, name) VALUES (10, 'Dan Brown');
INSERT INTO authors (author_id, name) VALUES (11, 'Jane Austen');
INSERT INTO authors (author_id, name) VALUES (12, 'Khaled Hosseini');
INSERT INTO authors (author_id, name) VALUES (13, 'Veronica Roth');
INSERT INTO authors (author_id, name) VALUES (14, 'George Orwell');
INSERT INTO authors (author_id, name) VALUES (15, 'Erich Fromm');
INSERT INTO authors (author_id, name) VALUES (16, 'Celâl Üster');
INSERT INTO authors (author_id, name) VALUES (17, 'Anne Frank');
INSERT INTO authors (author_id, name) VALUES (18, 'Eleanor Roosevelt');
INSERT INTO authors (author_id, name) VALUES (19, 'B.M. Mooyaart-Doubleday');
INSERT INTO authors (author_id, name) VALUES (20, 'Stieg Larsson');
INSERT INTO authors (author_id, name) VALUES (21, 'Reg Keeland');
INSERT INTO authors (author_id, name) VALUES (22, 'Rufus Beck');
INSERT INTO authors (author_id, name) VALUES (23, 'Alice Sebold');

-- BOOK_AUTHORS: links each book to each of its authors, in listed order
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (1, 1, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (2, 2, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (2, 3, 2);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (3, 4, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (4, 5, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (5, 6, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (6, 7, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (7, 8, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (8, 9, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (9, 10, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (10, 11, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (11, 12, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (12, 13, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (13, 14, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (13, 15, 2);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (13, 16, 3);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (14, 14, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (15, 17, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (15, 18, 2);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (15, 19, 3);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (16, 20, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (16, 21, 2);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (17, 1, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (18, 2, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (18, 3, 2);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (18, 22, 3);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (19, 8, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (20, 1, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (21, 2, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (21, 3, 2);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (22, 23, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (23, 2, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (23, 3, 2);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (24, 2, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (24, 3, 2);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (25, 2, 1);
INSERT INTO book_authors (book_id, author_id, author_order) VALUES (25, 3, 2);

-- COPIES: 1-3 physical copies per book, barcode = B<book>-<copy number>
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (1, 1, 'B00001-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (2, 1, 'B00001-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (3, 2, 'B00002-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (4, 2, 'B00002-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (5, 2, 'B00002-3', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (6, 3, 'B00003-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (7, 4, 'B00004-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (8, 4, 'B00004-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (9, 5, 'B00005-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (10, 5, 'B00005-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (11, 5, 'B00005-3', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (12, 6, 'B00006-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (13, 7, 'B00007-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (14, 7, 'B00007-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (15, 8, 'B00008-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (16, 8, 'B00008-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (17, 8, 'B00008-3', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (18, 9, 'B00009-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (19, 10, 'B00010-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (20, 10, 'B00010-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (21, 11, 'B00011-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (22, 11, 'B00011-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (23, 11, 'B00011-3', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (24, 12, 'B00012-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (25, 13, 'B00013-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (26, 13, 'B00013-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (27, 14, 'B00014-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (28, 14, 'B00014-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (29, 14, 'B00014-3', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (30, 15, 'B00015-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (31, 16, 'B00016-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (32, 16, 'B00016-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (33, 17, 'B00017-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (34, 17, 'B00017-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (35, 17, 'B00017-3', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (36, 18, 'B00018-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (37, 19, 'B00019-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (38, 19, 'B00019-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (39, 20, 'B00020-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (40, 20, 'B00020-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (41, 20, 'B00020-3', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (42, 21, 'B00021-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (43, 22, 'B00022-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (44, 22, 'B00022-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (45, 23, 'B00023-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (46, 23, 'B00023-2', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (47, 23, 'B00023-3', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (48, 24, 'B00024-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (49, 25, 'B00025-1', date('now', '-1 year'));
INSERT INTO copies (copy_id, book_id, barcode, acquired_date) VALUES (50, 25, 'B00025-2', date('now', '-1 year'));

-- MEMBERS: Grace Thompson (5) has never borrowed anything.
-- Omar Haddad (6) starts active so his past loans can be recorded, then is
--   suspended at the end for losing a book.
INSERT INTO members (member_id, membership_number, full_name, phone, email, home_address, join_date) VALUES (1, 'M0001', 'Maria Lopez', '555-0101', 'maria.lopez@example.com', '12 Oak St, Springfield', date('now', '-400 days'));
INSERT INTO members (member_id, membership_number, full_name, phone, email, home_address, join_date) VALUES (2, 'M0002', 'James Carter', '555-0102', 'james.carter@example.com', '48 Maple Ave, Springfield', date('now', '-300 days'));
INSERT INTO members (member_id, membership_number, full_name, phone, email, home_address, join_date) VALUES (3, 'M0003', 'Priya Shah', '555-0103', 'priya.shah@example.com', '7 Birch Rd, Springfield', date('now', '-250 days'));
INSERT INTO members (member_id, membership_number, full_name, phone, email, home_address, join_date) VALUES (4, 'M0004', 'Daniel Kim', '555-0104', 'daniel.kim@example.com', '301 Elm St, Apt 4, Springfield', date('now', '-180 days'));
INSERT INTO members (member_id, membership_number, full_name, phone, email, home_address, join_date) VALUES (5, 'M0005', 'Grace Thompson', '555-0105', 'grace.thompson@example.com', '22 Cedar Ln, Springfield', date('now', '-10 days'));
INSERT INTO members (member_id, membership_number, full_name, phone, email, home_address, join_date) VALUES (6, 'M0006', 'Omar Haddad', '555-0106', 'omar.haddad@example.com', '90 Pine Ct, Springfield', date('now', '-365 days'));

-- LOANS: (member, book, days ago checked out, days ago returned, status)
-- due_date is always checkout + 14 days.
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (1, 1, date('now', '-60 days'), date('now', '-60 days', '+14 days'), date('now', '-50 days'), 'returned');  -- Hunger Games, copy 1
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (3, 2, date('now', '-45 days'), date('now', '-45 days', '+14 days'), date('now', '-33 days'), 'returned');  -- Harry Potter 1
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (7, 3, date('now', '-40 days'), date('now', '-40 days', '+14 days'), date('now', '-30 days'), 'returned');  -- To Kill a Mockingbird
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (9, 1, date('now', '-35 days'), date('now', '-35 days', '+14 days'), date('now', '-22 days'), 'returned');  -- The Great Gatsby
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (13, 4, date('now', '-30 days'), date('now', '-30 days', '+14 days'), date('now', '-18 days'), 'returned');  -- The Hobbit
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (25, 6, date('now', '-50 days'), date('now', '-50 days', '+14 days'), date('now', '-38 days'), 'returned');  -- 1984
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (1, 1, date('now', '-5 days'), date('now', '-5 days', '+14 days'), NULL, 'active');  -- Hunger Games, copy 1 again (same copy, new loan)
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (37, 2, date('now', '-3 days'), date('now', '-3 days', '+14 days'), NULL, 'active');  -- Fellowship of the Ring
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (19, 3, date('now', '-10 days'), date('now', '-10 days', '+14 days'), NULL, 'active');  -- Pride and Prejudice
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (24, 4, date('now', '-8 days'), date('now', '-8 days', '+14 days'), NULL, 'active');  -- Divergent
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (21, 2, date('now', '-25 days'), date('now', '-25 days', '+14 days'), NULL, 'overdue');  -- The Kite Runner, due 11 days ago
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (27, 3, date('now', '-30 days'), date('now', '-30 days', '+14 days'), NULL, 'overdue');  -- Animal Farm, due 16 days ago
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (39, 4, date('now', '-20 days'), date('now', '-20 days', '+14 days'), NULL, 'active');  -- Mockingjay, due 6 days ago, not yet flagged
INSERT INTO loans (copy_id, member_id, checkout_date, due_date, returned_date, status) VALUES (15, 6, date('now', '-90 days'), date('now', '-90 days', '+14 days'), NULL, 'lost');  -- Catcher in the Rye, never returned

UPDATE members SET status = 'suspended' WHERE member_id = 6;  -- lost a book

COMMIT;
