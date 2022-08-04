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
insert into brand values(9998,'tcs')

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
insert into celebrity values('shahid')

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

--Triggers for brand table

create table brand_log(LogID int identity(10,1),brandID int ,operation nvarchar(20), updateddate Datetime)
select * from brand_log

create trigger BrandInsertTrigger
on brand
for insert
as
insert into brand_log(brandID,operation,updateddate)
select id,'Data inserted',GETDATE() from inserted

create trigger BrandUpdateTrigger
on Brand
after update
as 
insert into brand_log(brandID,operation,updateddate)
select id,'Data Updated',GETDATE() from deleted

update brand set bname='voltas' where id='9999'

create trigger BrandDeleteTrigger
on Brand
instead of delete
as 
insert into brand_log(brandID,operation,updateddate)
select id,'Delete Request',GETDATE() from deleted

delete from brand where id=9999

--Triggers for celebrity table

create table celeb_log(LogID int identity(10,1),CID int ,operation nvarchar(20), updateddate Datetime)
select * from celeb_log

create trigger celebInsertTrigger
on celebrity
for insert
as
insert into celeb_log(CID,operation,updateddate)
select id,'Data inserted',GETDATE() from inserted


create trigger celebUpdateTrigger
on celebrity
after update
as 
insert into celeb_log(CID,operation,updateddate)
select id,'Data Updated',GETDATE() from deleted

update celebrity set name='varun' where id=12

create trigger celebDeleteTrigger
on celebrity
instead of delete
as 
insert into celeb_log(CID,operation,updateddate)
select id,'Delete request',GETDATE() from deleted


delete from celebrity where id=11


--Triggers for endorsement table

create table endors_log(LogID int identity(10,1),CID int ,operation nvarchar(20), updateddate Datetime)
select * from endors_log

create trigger endorseInsertTrigger
on endorsement
for insert
as
insert into endors_log(CID,operation,updateddate)
select id,'Data inserted',GETDATE() from inserted

insert into endorsement values('alia',1241)

create trigger endorseUpdateTrigger
on endorsement
after update
as 
insert into endors_log(CID,operation,updateddate)
select id,'Data Updated',GETDATE() from deleted

update endorsement set name='varun' where id=13

create trigger endorseDeleteTrigger
on endorsement
instead of delete
as 
insert into endors_log(CID,operation,updateddate)
select id,'Delete Request',GETDATE() from deleted

delete from endorsement where id=13


