-- library.db schema
-- Build with:  sqlite3 library.db < schema.sql
--
-- SQLite only enforces foreign keys when this is switched on, and it must be
-- switched on in EVERY new connection (it is not saved in the file).
PRAGMA foreign_keys = ON;

------------------------------------------------------------------------
-- CATALOG: what the library owns, independent of physical copies
------------------------------------------------------------------------

-- One row per title/edition. No author or genre columns here: those are
-- many-to-many and live in the junction tables below.
CREATE TABLE books (
    book_id           INTEGER PRIMARY KEY,
    title             TEXT    NOT NULL,
    isbn              TEXT    UNIQUE,          -- ISBN-10; TEXT so leading zeros survive
    isbn13            TEXT    UNIQUE,          -- TEXT, never a number (see trade-offs)
    publication_year  INTEGER,                 -- may be negative for ancient works
    edition           TEXT,                    -- e.g. '1st', 'Revised', NULL if unknown
    CHECK (isbn   IS NULL OR length(isbn)   = 10),
    CHECK (isbn13 IS NULL OR length(isbn13) = 13)
);

-- One row per person. "J.K. Rowling, Mary GrandPré" becomes two rows here.
CREATE TABLE authors (
    author_id  INTEGER PRIMARY KEY,
    name       TEXT    NOT NULL UNIQUE
);

-- Junction: which authors wrote which books (many-to-many).
CREATE TABLE book_authors (
    book_id       INTEGER NOT NULL REFERENCES books(book_id)     ON DELETE CASCADE,
    author_id     INTEGER NOT NULL REFERENCES authors(author_id) ON DELETE RESTRICT,
    author_order  INTEGER NOT NULL DEFAULT 1,   -- 1 = first-listed author
    PRIMARY KEY (book_id, author_id)
);

CREATE TABLE genres (
    genre_id  INTEGER PRIMARY KEY,
    name      TEXT    NOT NULL UNIQUE
);

-- Junction: which genres a book belongs to (many-to-many).
CREATE TABLE book_genres (
    book_id   INTEGER NOT NULL REFERENCES books(book_id)   ON DELETE CASCADE,
    genre_id  INTEGER NOT NULL REFERENCES genres(genre_id) ON DELETE RESTRICT,
    PRIMARY KEY (book_id, genre_id)
);

-- One row per physical item on the shelf. Three copies of Dune = three rows.
-- Copies are never deleted; a lost copy keeps status 'lost'.
CREATE TABLE copies (
    copy_id        INTEGER PRIMARY KEY,
    book_id        INTEGER NOT NULL REFERENCES books(book_id) ON DELETE RESTRICT,
    barcode        TEXT    NOT NULL UNIQUE,
    status         TEXT    NOT NULL DEFAULT 'available'
                   CHECK (status IN ('available', 'checked_out', 'overdue', 'lost')),
    acquired_date  TEXT    NOT NULL DEFAULT (date('now'))
);

------------------------------------------------------------------------
-- PEOPLE
------------------------------------------------------------------------

CREATE TABLE members (
    member_id          INTEGER PRIMARY KEY,
    membership_number  TEXT    NOT NULL UNIQUE,   -- the ID printed on the card
    full_name          TEXT    NOT NULL,
    phone              TEXT,
    email              TEXT    UNIQUE,
    home_address       TEXT,
    join_date          TEXT    NOT NULL DEFAULT (date('now')),
    status             TEXT    NOT NULL DEFAULT 'active'
                       CHECK (status IN ('active', 'suspended', 'expired'))
);

------------------------------------------------------------------------
-- ACTIVITY
------------------------------------------------------------------------

-- One row per copy borrowed. Borrowing 3 books at once = 3 loans, so each
-- can be returned on its own day.
CREATE TABLE loans (
    loan_id        INTEGER PRIMARY KEY,
    copy_id        INTEGER NOT NULL REFERENCES copies(copy_id)     ON DELETE RESTRICT,
    member_id      INTEGER NOT NULL REFERENCES members(member_id) ON DELETE RESTRICT,
    checkout_date  TEXT    NOT NULL DEFAULT (date('now')),
    -- Defaults to today + 14. A DEFAULT can't read other columns, so if you
    -- enter a back-dated checkout_date, give its due_date explicitly too.
    due_date       TEXT    NOT NULL DEFAULT (date('now', '+14 days')),
    returned_date  TEXT,                         -- NULL until returned
    status         TEXT    NOT NULL DEFAULT 'active'
                   CHECK (status IN ('active', 'returned', 'overdue', 'lost')),
    CHECK (due_date >= checkout_date),
    CHECK (returned_date IS NULL OR returned_date >= checkout_date),
    CHECK ((status = 'returned') = (returned_date IS NOT NULL))
);

-- RULE: one open loan per physical copy. A partial unique index only covers
-- rows matching the WHERE, so a copy can have many returned loans in its
-- history but at most one active/overdue loan at a time. Different copies of
-- the same title are different copy_ids, so they can be out simultaneously.
CREATE UNIQUE INDEX one_open_loan_per_copy
    ON loans(copy_id) WHERE status IN ('active', 'overdue');

CREATE INDEX loans_by_member ON loans(member_id, status);

-- Reservations point at a TITLE (book_id), not a copy: any copy fulfils it.
CREATE TABLE reservations (
    reservation_id  INTEGER PRIMARY KEY,
    book_id         INTEGER NOT NULL REFERENCES books(book_id)     ON DELETE RESTRICT,
    member_id       INTEGER NOT NULL REFERENCES members(member_id) ON DELETE RESTRICT,
    reserved_at     TEXT    NOT NULL DEFAULT (datetime('now')),
    status          TEXT    NOT NULL DEFAULT 'waiting'
                    CHECK (status IN ('waiting', 'fulfilled', 'cancelled'))
);

-- A member can't be in the queue twice for the same title.
CREATE UNIQUE INDEX one_waiting_reservation_per_member_book
    ON reservations(book_id, member_id) WHERE status = 'waiting';

------------------------------------------------------------------------
-- RULES ENFORCED BY TRIGGERS
------------------------------------------------------------------------

-- Borrowing rules: active members only, no lost copies, max 5 open loans.
CREATE TRIGGER loans_check_before_insert
BEFORE INSERT ON loans
BEGIN
    SELECT RAISE(ABORT, 'member is not active')
    WHERE (SELECT status FROM members WHERE member_id = NEW.member_id) <> 'active';

    SELECT RAISE(ABORT, 'copy is lost and cannot be borrowed')
    WHERE (SELECT status FROM copies WHERE copy_id = NEW.copy_id) = 'lost';

    SELECT RAISE(ABORT, 'member already has 5 books out')
    WHERE (SELECT count(*) FROM loans
           WHERE member_id = NEW.member_id
             AND status IN ('active', 'overdue')) >= 5;
END;

-- Keep copies.status in step with the loan that just happened.
CREATE TRIGGER loans_sync_copy_after_insert
AFTER INSERT ON loans
BEGIN
    UPDATE copies SET status = CASE NEW.status
                                   WHEN 'active'  THEN 'checked_out'
                                   WHEN 'overdue' THEN 'overdue'
                                   WHEN 'lost'    THEN 'lost'
                                   ELSE status
                               END
    WHERE copy_id = NEW.copy_id;
END;

CREATE TRIGGER loans_sync_copy_after_update
AFTER UPDATE OF status ON loans
BEGIN
    UPDATE copies SET status = CASE NEW.status
                                   WHEN 'active'   THEN 'checked_out'
                                   WHEN 'overdue'  THEN 'overdue'
                                   WHEN 'lost'     THEN 'lost'
                                   WHEN 'returned' THEN 'available'
                               END
    WHERE copy_id = NEW.copy_id;
END;

------------------------------------------------------------------------
-- HANDY VIEWS (computed on the fly, nothing stored)
------------------------------------------------------------------------

-- Loans past their due date that nobody has marked overdue yet.
-- SQLite can't change data on a timer, so run this (or an UPDATE based on
-- it) when you open each day.
CREATE VIEW loans_past_due AS
SELECT l.loan_id, l.copy_id, l.member_id, l.checkout_date, l.due_date,
       julianday('now') - julianday(l.due_date) AS days_late
FROM loans l
WHERE l.status = 'active' AND l.due_date < date('now');

-- Per title: how many copies exist and how many are on the shelf right now.
CREATE VIEW title_availability AS
SELECT b.book_id, b.title,
       count(c.copy_id)                               AS total_copies,
       sum(c.status = 'available')                    AS available_copies,
       sum(c.status IN ('checked_out', 'overdue'))    AS copies_out,
       sum(c.status = 'lost')                         AS copies_lost
FROM books b
LEFT JOIN copies c ON c.book_id = b.book_id
GROUP BY b.book_id;
