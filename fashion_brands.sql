create database Fashion_brands
use Fashion_brands

create table brand(id numeric(5) primary key,bname varchar(20))
insert into brand values(1235,'Vimal')
insert into brand values(1236,'lakme')
insert into brand values(1237,'sony')
insert into brand values(1238,'apple')
insert into brand values(1239,'mi')
insert into brand values(1240,'oneplus')
insert into brand values(1241,'MB')
insert into brand values(1242,'samsung')
insert into brand values(1243,'hp')
insert into brand values(1244,'dell')

select * from brand

create table celebrity(id int primary key identity,name varchar(20),bid numeric(5) ,
FOREIGN KEY (bid) REFERENCES brand(id))

insert into celebrity values('akshay kumar',1235)
insert into celebrity values('srk',1235)
insert into celebrity values('ajay devgan',1235)
insert into celebrity values('aishvarya',1236)
insert into celebrity values('salman khan',1237)
insert into celebrity values('tiger shroff',1237)
insert into celebrity values('ranvir singh',1238)
insert into celebrity values('john',1241)
insert into celebrity values('shraddha',1243)
insert into celebrity values('hrx',1240)

Exec sp_rename celebrity ,endorsement
select * from endorsement

create table celebrity(id int identity,name varchar(20) primary key)

insert into celebrity values('akshay kumar')
insert into celebrity values('srk')
insert into celebrity values('ajay devgan')
insert into celebrity values('aishvarya')
insert into celebrity values('salman khan')
insert into celebrity values('tiger shroff')
insert into celebrity values('ranvir singh')
insert into celebrity values('john')
insert into celebrity values('shraddha')
insert into celebrity values('hrx')
insert into celebrity values('vicky')

select * from celebrity order by id

CREATE PROCEDURE not_endorsed_brand   
AS  
BEGIN  
    SELECT * from brand as b left  join endorsement as e on e.bid=b.id where e.bid is null
END;   

EXEC not_endorsed_brand

create procedure sp_commonBrands
as
begin
Select b.bname as brands,count (bname) as bb from brand as b 
INNER join endorsement as e 
on b.id = e.bid 
GROUP BY(bname) 
having count(bname) > 1

end

EXEC sp_commonBrands