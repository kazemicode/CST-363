-- select all columns and rows
SELECT * FROM orientation.owner;

-- select subset of columns (projection)
select id, name, address from owner;

-- select subset of rows (predicates)
select * from pets where type='cat';

-- specify sort order of result
select id, name, address from owner order by name;

-- what if we want to order by last name?  
-- use SQL functions to get last name (see chapter 9 "How to work with string data"
-- or design should separate firstname and lastname
select id, substring_index(name,' ',1) as firstname, substring_index(name, ' ', -1) as lastname , address from owner order by lastname;

-- cartesian product.  called inner join
select * from pet, owner;

-- only want pets that go with their owners.  
-- ownerid column in pet should equal id column in owner
select * from pet, owner where ownerid=id;

-- name column is ambiguous because there is a 
-- name column in pet and a name column in owner
select * from pet, owner where ownerid=id and pet.name='Socks';


-- another way to do it
select * from pet p, owner o where p.ownerid=o.id and p.name='Socks';

-- when we get a report of pets and their owners, 
-- an owner with no pets will not appear.
-- outer join to the rescue.

select * from owner o left outer join pet p on(p.ownerid=o.id); 

-- union of two results.  Must have same number of columns.
select id,  name, 'owner' from owner
union 
select petid,  name, type from pet
order by name;