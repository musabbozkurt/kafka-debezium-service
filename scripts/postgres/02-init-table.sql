CREATE TABLE IF NOT EXISTS inventory.customers
(
    id         SERIAL PRIMARY KEY,
    first_name VARCHAR(255),
    last_name  VARCHAR(255),
    email      VARCHAR(255)
);

-- Set REPLICA IDENTITY to FULL to log all columns for UPDATE and DELETE operations
ALTER TABLE inventory.customers
    REPLICA IDENTITY FULL;

-- Insert sample data
INSERT INTO inventory.customers (first_name, last_name, email)
VALUES ('Sally', 'Thomas', 'sally.thomas@acme.com'),
       ('George', 'Bailey', 'gbailey@foobar.com'),
       ('Edward', 'Walker', 'ed@walker.com'),
       ('Anne', 'Kretchmar', 'annek@noanswer.org');

UPDATE inventory.customers
SET email = 'sally.thomas.updated@acme.commmm'
WHERE first_name = 'Sally';

DELETE
FROM inventory.customers
WHERE first_name = 'George';
