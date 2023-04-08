drop table if exists accounts;


create table accounts (
    id int,
    name varchar(100) not null,
    balance dec(15,2) not null,
    primary key(id)
);

insert into accounts(name,balance)
values('Bob',10000);

insert into accounts(name,balance)
values('Alice',10000);

select * from accounts;

drop procedure if exists transfer;

delimiter //

create procedure transfer(
   sender int,
   receiver int, 
   amount dec
)

//

delimiter ;

    
begin
    
    update accounts 
    set balance = balance - amount 
    where id = sender;

    update accounts 
    set balance = balance + amount 
    where id = receiver;

    commit;

call transfer(1,2,5000);

SELECT * FROM accounts;