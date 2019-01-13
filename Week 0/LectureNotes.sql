use orientation;

select * from owner;
select id as OwnerId, name, address from owner;

select id, substring_index(name, ' ',1) as FirstName,
substring_index(name, ' ', -1) as LastName
from owner
order by FirstName;

select * from pet where type != 'cat';

-- inner join or cartesian product; communicative

select * from pet, owner where pet.ownerid = owner.id;
select * from pet as p inner join owner as o on p.ownerid = o.id;
--  if there is no owner that is not match, put it with its null values; not communicative - order matters
select * from owner as o left outer join pet p on p.ownerid = o.id;