select country, city, sum(freight) from ku
group by country,city

--Analyse

set statistics io, time on
--IO Anzahl der Seiten
--time: CPU Dauer   ms  AusführungsDauer ms

--Query Store aktiviert..


select country, city, sum(freight) from ku
group by country,city
option (maxdop 1)

--Seiten  
--logische Lesevorgänge: 64923
--  4Kerne, CPU-Zeit = 375 ms, verstrichene Zeit = 101 ms.

--CPU > Dauer--> mehr Proz wurden eingesetzt

-- 8 , CPU-Zeit = 597 ms, verstrichene Zeit = 109 ms.
--1 Kern:  344 ms, verstrichene Zeit = 347 ms.

--je mehr CPUs desto größer der Verwaltungsaufwand


--Setup: max 8 Kerne nicht mehr als 16
--nie den Wert 0 nehmen

--SQL setzt dann mehr Kerne ein, wenn die KOsten zu hoch werden
-- SQL Dollar
--ab 5 SQL Dollar wird MAXDOP eingesetzt


--Wir sollten den Kostenschwellwert ändern
--leider ist der Kostenschwellwert nur auf dem Server einestellbar
--OLAP 25  OLTP 50
---Wenn alle Kerne belegt sind
--Aktivitätsmonitor: CXPACKET  SUSPENDED

--SCOPED DATABASE
USE [master]
GO
--Seit SQL 2016 pro DB MAXDOP einstellbar
GO
USE [Northwind]
GO
ALTER DATABASE SCOPED CONFIGURATION SET MAXDOP = 2;
GO

--Tipp: falls im Plan ein Gather und Repartition Stream auftaucht, dann sind oft weniger Kerne besser
