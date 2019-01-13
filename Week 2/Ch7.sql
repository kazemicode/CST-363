-- Ch. 7

-- Exercise 1
-- Original statement with JOIN
SELECT DISTINCT vendor_name
FROM vendors JOIN invoices
	ON vendors.vendor_id = invoices.vendor_id
ORDER BY vendor_name;

-- Equivalent statement without a JOIN
SELECT vendor_name
FROM vendors
WHERE vendor_id IN (
	SELECT DISTINCT vendor_id
    FROM invoices);
    
-- Exercise 2
SELECT invoice_number, invoice_total
FROM invoices
WHERE payment_total > 
	(
	SELECT AVG(payment_total)
    FROM invoices
    WHERE payment_total > 0
    )
ORDER BY invoice_total DESC;

-- Exercise 3
SELECT account_number, account_description
FROM general_ledger_accounts g
WHERE NOT EXISTS
    (
    SELECT * 
    FROM invoice_line_items
    WHERE account_number = g.account_number
    )
ORDER BY account_number;

-- Exercise 4
SELECT vendor_name, li.invoice_id, invoice_sequence, line_item_amount
FROM vendors v
JOIN invoices i
	ON v.vendor_id = i.vendor_id
JOIN invoice_line_items li
	ON i.invoice_id = li.invoice_id
WHERE i.invoice_id IN(
	SELECT DISTINCT invoice_id
    FROM invoice_line_items
    WHERE invoice_sequence > 1);

-- Exercise 5
SELECT v.vendor_id, MAX(invoice_total) AS gr_unpaid_invoice
FROM vendors v JOIN invoices i
ON v.vendor_id = i.vendor_id
WHERE invoice_id IN(
	SELECT invoice_id
    FROM invoices
    WHERE invoice_total > payment_total + credit_total)
GROUP BY vendor_id;  

-- Exercise 6
SELECT vendor_name, vendor_city, vendor_state
FROM vendors
WHERE CONCAT(vendor_city, vendor_state) IN (
	SELECT CONCAT(vendor_city, vendor_state) AS city_state
    FROM vendors
    GROUP BY vendor_city, vendor_state
    HAVING COUNT(*) <= 1
    )
GROUP BY vendor_name
ORDER BY vendor_state, vendor_city;

-- Exercise 7
SELECT vendor_name, invoice_number, invoice_date, invoice_total
FROM vendors v JOIN invoices i
ON v.vendor_id = i.vendor_id
WHERE invoice_date = (
	SELECT MIN(invoice_date) AS oldest_invoice
    FROM invoices
    WHERE vendor_id = i.vendor_id)
ORDER BY vendor_name;

-- Exercise 8
SELECT vendor_name, invoice_number, invoice_date, invoice_total
FROM invoices i 
JOIN (
	SELECT vendor_id,  MIN(invoice_date) AS 'oldest_invoice'
	FROM invoices
    GROUP BY vendor_id
	)t
	ON t.vendor_id = i.vendor_id
    AND t.oldest_invoice = i.invoice_date
JOIN  vendors v
	ON v.vendor_id = i.vendor_id
ORDER BY vendor_name;



