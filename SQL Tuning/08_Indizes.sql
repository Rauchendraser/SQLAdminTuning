/*

GR IX = Tabelle sortiert
1 mal pro Tabelle
gut bei Bereichsabfragen   > < aber auch bei eindeutigen Ergebnissen
Tipp: leg zuerst den CL IX auf die Spalte fest, die häufig nach Bereichen abgefragt wird
---dann PK 

PK muss kein CL IX sein!!  er muss eindeutig sein

N GR IX = zusätzliche mit meist nicht allen Spalten der Tabellen
ca 1000 pro Tabelle
wenn rel wenige DS rauskommt--- LOOKUP!!!!


*/

eindeutigen IX  !
abdeckender IX  !! --IX Seek ohne Lookup
IX mit eingeschl Spalten !!
gefilterten IX nicht alle DS in INdex, dann aber weniger Ebene im Index, sonst lohnt es sich nicht

part IX wie viele gefilterte IX

ind Sicht  (bei AGG durchaus sinnvoll, aber count_big())

realen hypoth IX
zusammengesetzter IX   !!
--- kann max 16 Spalten umfassen
-- mehr als 4 Spalten machen oft keinen Sinn
--macht nur SInn mehr Spalten reinzunehmen, wenn auch die Sp im where vorkommen

Columnstore IX


Admin muss repr Workload optimieren
--Tool für Aufzeichnung: Profiler, QueryStore


*/
--CL IX auf orderdate
--Plan: Table Scan
set statistics io, time on
select id from ku where id = 10

--NIX_ID -- SCAN und SEEK
select id from ku where id = 10  --3 Seiten

select id , freight from ku where id = 10  --4 Seiten mit Lookup

select id , freight from ku where id <13980 --b ca 1390 TAble Scan... ca 1,x % der Daten

select id , freight from ku where id <900000

select id , freight , lastname from ku where id =10


NIX_ID_incl_FRLN

select country, city, sum(unitprice*quantity)
from ku
where freight < 1
group by country , city

--2 IX  NIX_PID   NIX_FR  .. beide inkl CYCIUPQU
select country, city, sum(unitprice*quantity)
from ku
where freight < 1 or productid = 10
group by country , city


---Columnstore Index
-- Abfrage where  und eun AGG sum /AVG /  min 

select * into ku2 from ku
select * into ku3 from ku

select companyname, country,sum(unitprice*quantity)
from ku2
where productname like 'Sir Rodney''s Scones'
group by companyname, country
--NIX_PN_incl_CPCYUPQU --50ms  294 Seiten


select * into ku3 from ku

select companyname, country,sum(unitprice*quantity)
from ku3
where freight < 1
group by companyname, country


--wie groß ist Tabelle ku2
--550 MB mit Index

--ku3 


--Wartung von Indizes

-- Fehlende Indizes erstellen
--überflüssige Indizes entfernen  (die nicht gebraucht werden , oder schlecht performen)
--IX defragmentieren

-- A B C ..wieviele Inidzes ? 1000
-- A
-- AB
--ABC 

--Tools zum finden?
--DMV
select * from sys.dm_db_index_usage_stats

--3,4 MB-- auch im RAM

---> Komprimiert
--nach Archivkompression 3,0 MB auch im RAM