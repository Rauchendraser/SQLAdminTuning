/*
Spalten Datentypen

varchar
char

Seite 8192 --- 1:1 in RAM

Normalisierung  Normalform
1. 2. 3. .---------------bis hier 5. BC

PK---> ref Integrität--> FK
1 : N



Indizes




*/

delete from customers where customerid = 'ALFKI'

create table txy (id int identity, spx char(4100))

insert into txy
select 'XY'
Go 20000

---Ging schneller, wenn Schleife (1 Batch statt 20000) um dioe Schleife begin tran 1 TX)


--Wie groß (MB) ? sollte 80 MB sein---> 10000 Seiten

set statistics io, time on

select * from txy where id = 100

--1 Ds pro Seite weil mit 1 DS ca 51 % Füllgrad der Seiten

-- Abfrage kostete 160MB

--Seiten sollten immer sehr voll sein.... messen?

dbcc showcontig('txy')
--- Gescannte Seiten.............................: 2000000
--- Mittlere Seitendichte (voll).....................: 87.79%

--Wie bekommen wir die Seiten voller?
-

--char, varchar, nchar nvarchar.. unicode
--unicode .. man braucht das doppelte
--nur dann n , wenn muss

--Datum
--date , datetime(ms), smalldatetime(sek), datetime2(ns), datetimeoffset

--GebTag  date



select * from orders where year(orderdate) =1997

select * from orders where orderdate between '1.1.1997' and '31.12.1997 23:59:59.997'




