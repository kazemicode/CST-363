-- drop schema orientation;
create schema orientation;
use orientation;
create table pet (petid int primary key, name varchar(20), type varchar(10), ownerid int );
create table owner (id int primary key, name varchar(20) not null, address varchar(20), email varchar(20), phone char(11));

insert into owner values (1, 'Tom Thomas', '123 Main', 'tthomas@gmail.com', '18137891234');
insert into owner values (2, 'Mike Mouse', '42 Second Ave', 'mmouse@gmail.com', '18137223456');
insert into owner values (3, 'Ana Santors', '20 Sixth Ave', 'asantors@gmail.com', '14088923456');

insert into pet values(1001, 'Socks', 'cat', 1);
insert into pet values(2001, 'Wolf', 'dog', 1);
insert into pet values(3001, 'Polly', 'parrot', 2);
insert into pet values(4001, 'Furby', 'cat', 1);
