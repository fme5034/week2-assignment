-- queries.sql: checks and reports for library.db
-- Run:  sqlite3 library.db < queries.sql
.mode table
.headers on

.print '== Row counts =='
SELECT (SELECT count(*) FROM books)        AS books,
       (SELECT count(*) FROM authors)      AS authors,
       (SELECT count(*) FROM book_authors) AS book_authors,
       (SELECT count(*) FROM copies)       AS copies,
       (SELECT count(*) FROM members)      AS members,
       (SELECT count(*) FROM loans)        AS loans;

.print ''
.print '== Copies by status =='
SELECT status, count(*) AS copies
FROM copies
GROUP BY status
ORDER BY CASE status WHEN 'available' THEN 1 WHEN 'checked_out' THEN 2
                     WHEN 'overdue' THEN 3 WHEN 'lost' THEN 4 END;

.print ''
.print '== Loans by status =='
SELECT status, count(*) AS loans FROM loans GROUP BY status ORDER BY status;

.print ''
.print '== Books with more than one author (split from the CSV) =='
SELECT b.title, group_concat(a.name, ' | ') AS authors
FROM books b
JOIN book_authors ba ON ba.book_id = b.book_id
JOIN authors a       ON a.author_id = ba.author_id
GROUP BY b.book_id
HAVING count(*) > 1
ORDER BY b.book_id;

.print ''
.print '== Titles with any copy not on the shelf (title_availability view) =='
SELECT title, total_copies, available_copies, copies_out, copies_lost
FROM title_availability
WHERE available_copies < total_copies
ORDER BY book_id;

.print ''
.print '== Loans currently out (active or overdue) =='
SELECT m.full_name AS member, b.title, c.barcode, l.checkout_date, l.due_date, l.status
FROM loans l
JOIN members m ON m.member_id = l.member_id
JOIN copies c  ON c.copy_id = l.copy_id
JOIN books b   ON b.book_id = c.book_id
WHERE l.status IN ('active', 'overdue')
ORDER BY l.due_date;

.print ''
.print '== Past due but not yet flagged overdue (loans_past_due view) =='
SELECT m.full_name AS member, b.title, p.due_date, CAST(p.days_late AS INTEGER) AS days_late
FROM loans_past_due p
JOIN members m ON m.member_id = p.member_id
JOIN copies c  ON c.copy_id = p.copy_id
JOIN books b   ON b.book_id = c.book_id;

.print ''
.print '== Members and how many loans each has ever had =='
SELECT m.membership_number, m.full_name, m.status, count(l.loan_id) AS total_loans,
       coalesce(sum(l.status IN ('active', 'overdue')), 0) AS out_now
FROM members m
LEFT JOIN loans l ON l.member_id = m.member_id
GROUP BY m.member_id
ORDER BY m.member_id;
