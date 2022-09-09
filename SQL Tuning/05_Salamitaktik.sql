/*

Tabelle 1000    A
Tabelle 100000  B

select ... 10 Zeilen

Welche liefert schneller..?  A

*/


---
--Umsatz  ...seit Jahr 2000 

--u2022  u2021  u2020   u2019

--Part Sicht

select * from umsatz where jahr = 2020

UNION 


create table u2022 (id int identity, jahr int, spx  int)
create table u2021 (id int identity, jahr int, spx  int)
create table u2020 (id int identity, jahr int, spx  int)
create table u2019 (id int identity, jahr int, spx  int)


create view vUmsatz
as
select * from u2022
UNION ALL
select * from u2021
UNION ALL
select * from u2020
UNION ALL
select * from u2019

select * from vUmsatz where jahr = 2021
select * from vumsatz where id = 2010
--Spalte not null


--INS UP DEL
--Bedingung:  keinen Identity, PK muss auf ID und Jahr 


--Partitionierung

USE [master]
GO

--Dateigruppe
ALTER DATABASE [Northwind] ADD FILEGROUP [HOT]
GO
ALTER DATABASE [Northwind]
ADD FILE ( NAME = N'nwhotdata', 
FILENAME = N'D:\_SQLDBDATA\nwhotdata.ndf' ,
SIZE = 8192KB , FILEGROWTH = 65536KB ) 
TO FILEGROUP [HOT]
GO

create table test(id int) on HOT



--partitionierung

--4 Dgruppen  bis100  bis200 bis5000 rest

USE [master]
GO

GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis100', FILENAME = N'D:\_SQLDBDATA\nwbis100.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis100]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbis200', FILENAME = N'D:\_SQLDBDATA\nwbis200.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis200]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwbios5000', FILENAME = N'D:\_SQLDBDATA\nwbios5000.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [bis5000]
GO
ALTER DATABASE [Northwind] ADD FILEGROUP [rest]
GO
ALTER DATABASE [Northwind] ADD FILE ( NAME = N'nwrest', FILENAME = N'D:\_SQLDBDATA\nwrest.ndf' , SIZE = 8192KB , FILEGROWTH = 65536KB ) TO FILEGROUP [rest]
GO



---Part f()

create partition function fzahl(int)
as
RANGE LEFT FOR VALUES (100,200)

-------100--------------200-------------
--1              2                              3


select $partition .fzahl(117) ---2  

--Part Schema
create partition scheme schemaZahl
as
partition fzahl to (bis100,bis200,rest)
--                              1             2        3

create table ptab (id int identity, nummer int, spx char(4100))
ON schemaZahl(nummer)

--keine Messung  set statistics io, time off
--keinen Plan anzeigen lassen (tats. plan)
declare @i as int = 1
Begin tran
while @i <= 20000
	begin 
				insert into ptab (nummer, spx) values (@i, 'xy')
				set @i+=1
	end
commit
	--7 Sek


set statistics io, time on

select * from ptab where nummer= 17 --100 Seiten statt 20000


--Neue Grenze   5000
select * from ptab where nummer= 117 --100 Seiten statt 20000
--Tab      F()       schema           Dgruppe
--nie       ja         ja                     neue Gruppe

-----------100-------------200----------------5000------------

alter partition scheme schemazahl next used bis5000 --kein Änderung

alter partition function fzahl() split  range (5000)

--Grenze 100 raus
-----100!-------------------200-----5000----------------

--TAB       F()     SCHEMA    DGRUPPE
--nie          ja       nö                 nö

alter partition function fzahl()  merge Range (100)

select * from ptab where nummer = 117

--Tipp: die Part verhalten sich so, als wären sie Tabellen

--Archivieren der DAten bis 200
--muss exakt so aussehen wie org Tabelle ausser ID 
create table archiv (id int not null, nummer int, spx char(4100)) on bis200
--das Archiv muss auf der gleichen Dgruppe sein wie die Partition


alter table ptab switch partition 1 to archiv
select * from archiv
select * from ptab

--angenommen: 100MB /Sek 


--100000000000000000000MB --> ?   




create partition function fzahl(datetime)
as
RANGE LEFT FOR VALUES ('31.12.2020 23:59:59.997','')


--a  bis m      n  bis r     s  bis z
create partition function fzahl(varchar(50))
as
RANGE LEFT FOR VALUES ('n','s')

--Müller  ist größer als M

--------------]------------------




--Part Schema
create partition scheme schemaZahl
as
partition fzahl to ([PRIMARY],[PRIMARY],[PRIMARY])






--Part Schema
create partition scheme schemaZahl
as
partition fzahl all to ([PRIMARY])
--                              1         


