-- Ch. 6

-- Exercise 1
SELECT v.vendor_id, SUM(invoice_total) AS invoice_total_sum
FROM vendors v JOIN invoices i
	ON v.vendor_id = i.vendor_id
GROUP BY vendor_id;

-- Exercise 2
SELECT vendor_name, SUM(payment_total) AS payment_total_sum
FROM vendors v JOIN invoices i
	ON v.vendor_id = i.vendor_id
GROUP BY vendor_name
ORDER BY payment_total_sum DESC;

-- Exercise 3
SELECT v.vendor_name, COUNT(*) AS num_invoices, SUM(invoice_total) AS invoice_total_sum
FROM invoices i JOIN vendors v
	ON v.vendor_id = i.vendor_id
GROUP BY v.vendor_name
ORDER BY num_invoices DESC;

-- Exercise 4
SELECT account_description, COUNT(*) AS num_line_items, SUM(line_item_amount) AS sum_line_amount
FROM general_ledger_accounts g JOIN invoice_line_items li
	ON g.account_number = li.account_number
GROUP BY account_description
HAVING COUNT(*) > 1
ORDER BY sum_line_amount DESC;

-- Exercise 5
SELECT account_description, COUNT(*) AS num_line_items, SUM(line_item_amount) AS sum_line_amount
FROM general_ledger_accounts g 
	JOIN invoice_line_items li
		ON g.account_number = li.account_number
	JOIN invoices i
		ON i.invoice_id = li.invoice_id
WHERE i.invoice_date BETWEEN '2014-04-01' AND '2014-06-30'
GROUP BY account_description
HAVING COUNT(*) > 1
ORDER BY sum_line_amount DESC;

-- Exercise 6
SELECT li.account_number, SUM(line_item_amount) AS sum_line_amount
FROM general_ledger_accounts g JOIN invoice_line_items li
	ON g.account_number = li.account_number
GROUP BY LI.account_number WITH ROLLUP;

-- Exercise 7
SELECT vendor_name, COUNT(DISTINCT li.account_number) AS num_gl_accounts
FROM vendors v 
	JOIN invoices i
		ON v.vendor_id = i.vendor_id
	JOIN invoice_line_items li
		ON i.invoice_id = li.invoice_id
GROUP BY vendor_name
HAVING COUNT(DISTINCT li.account_number) > 1;



