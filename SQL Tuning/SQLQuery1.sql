----Tab A  10000
--- Tab B      100000

--Abfrage : 10 Zeilen


--Mittel zum Verkleinern


--Kompression


--Seiten / Zeilen


--SQL Neustart: RAM 

set statistics io, time on 

select * from txy 

--RAM:   1200  + 160MB Seiten:  20000, Dauer 1,2 Sek   CPU  187 ms

---nach Kompression
-- nach Neustart
--RAM :  vorher 960MB --weniger.. oder auch gleich oder auch mehr

set statistics io, time on 

select * from txy 


--RAM: weniger   29 *8  Seiten: weniger 39  Dauer: gleich CPU  weniger


-------------------------------------------> IO
------------------------------------------->CPU

----------------------->IO
---------------------------------> CPU    -------> CPU 

--in der Praxis 40 bs 60 %



---Salamitaktik



--Tabelle Umsatz

--Problem: Software  select * from umsatz


create table u2021 (id int, jahr int, spx int)

create table u2022 (id int, jahr int, spx int)

create table u2019 (id int, jahr int, spx int)

create table u2018 (id int, jahr int, spx int)

--Wo ist mein Umsatz
select * from umsatz where jahr = 2020



--Sicht 
create view umsatz
as
select * from u2022
UNION  ALL
select * from u2021
UNION ALL
select * from u2019
UNION ALL
select * from u2018

select * from umsatz where id = 2021

select * from umsatz 

--kein Identity PK muss ID und Jahr

---Partitionierung



----Dateigruppe.....

--DB    .mdf  Primary
--         .ndf    HOT
--         .ndf   COLD


create table test123 (id int) on HOT



---------------100]---------200}----------------------------------------------- int
--   1                              2                                       3

--Dgruppen: bis100, bis200, bis5000, rest

--Part f()

create partition function fzahl(int) 
as
RANGE LEFT FOR VALUES (100,200)

select $partition.fzahl(117)---2

--PartSchema

create partition scheme schemaZahl
as
partition fzahl to (bis100, bis200, rest)
--------------           1                 2      3

create table parttab( id int identity, nummer int, spx char(4100)) on schemaZahl(nummer)



 declare @i as int = 1
 begin tran
 while @i <= 20000
	begin
				insert into parttab select @i,'XY'
				set @i+=1
	end
commit


select * from parttab

select * from parttab where id = 117

select * from parttab where nummer = 1170


--neue Grenze einführen: bei 5000
--Dateigruppen +1 neue, F() neue Grenze, scheme wasist die neue Dgruppen, Tab nie never nö nada


alter partition scheme schemaZahl next used bis5000

select $partition.fzahl(nummer) , min (nummer), max(nummer), count(*)
from parttab
group by  $partition.fzahl(nummer) 

------------100----------200-----------------5000split-------------------
alter partition function fzahl() split range (5000)



-----Grenze 100 entfernen
--TAB nee nie nada .. f() ja   schema nö
-----------100!----------200-------------------5000--------------
alter partition function fzahl() merge range(100)


select * from parttab where id = 117
select * from parttab where nummer = 6117



























































--



