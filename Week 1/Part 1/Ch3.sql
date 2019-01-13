-- Exercise 6
SELECT vendor_name, vendor_contact_last_name, vendor_contact_first_name
FROM vendors
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

-- Exercise 7
SELECT vendor_contact_last_name, vendor_contact_first_name, 
	CONCAT(vendor_contact_last_name, ", ", vendor_contact_first_name) AS full_name
FROM vendors
WHERE LEFT(vendor_contact_last_name, 1) IN ('A', 'B', 'C', 'E')
ORDER BY vendor_contact_last_name, vendor_contact_first_name;

-- Exercise 8
SELECT invoice_due_date, invoice_total,
	(invoice_total * 0.1) AS ten_percent, (invoice_total * 0.1 + invoice_total) AS plus_ten
FROM invoices
WHERE invoice_total >= 500 AND invoice_total <= 1000
ORDER BY invoice_due_date DESC;

-- Exercise 9
SELECT invoice_number, invoice_total, (payment_total + credit_total) AS payment_credit_total,
	(invoice_total - credit_total) AS balance_due
FROM invoices
WHERE (invoice_total - credit_total) > 50
ORDER BY balance_due DESC
LIMIT 5;

-- Exercise 10
SELECT invoice_number, invoice_date, (invoice_total - payment_total) AS balance_due, payment_date
FROM invoices
WHERE payment_date IS NULL;

-- Exercise 11
SELECT CURRENT_DATE AS default_format,
	DATE_FORMAT(CURRENT_DATE, '%m-%d-%y') AS 'current_date';

-- Exercise 12    
SELECT 50000 AS starting_principal, 0.65 * 50000 AS interest, (50000 + 0.65 * 50000) AS principal_plus_interest;