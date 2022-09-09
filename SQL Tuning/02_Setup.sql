--Setiup

--weitere Instanz für Tuning?
--weil anderee Serversettings <-- > Scoped database seit SQL 2016


--Volumewartungstask. lok Sicherheitsrichtlinie NT
--Ausnullen aus Sicherheitsgründen
--Einem guten Admin rel egal...weil der Admin dafür sorgt, dass die DB sogut wie ie wachsen
--weil sie groß genug sind  Anfangsgrößen größer dimensionieren


--Pfade: 
--Trenne Daten von Logs pyhsikalisch pro DB immer neu überlegen
--da muss aber nicht immer so sein


--tempdb
--eig HDDs 
--trenne Log von Daten
--soviele Datendateien wie Kerne  max 8 
-- T 1117    T 1118     Traceflag

--1117 gleiches autom Wachstum
--1118 uniform extents, weil der Zugriff auf Seiten  bzw Blöcke immer single Threaded ist

--Latch


select sum(freight) as Summe into #t from orders

select * from #t




--MAXDOP

--= max Anzahl der Kerne, die für eine Abfrage zur Verfügung gestellt werden
--Regel: MAXOP = Anzahl der kerne aber nicht mehr als 8
--früher (2014) : MAXDOP 0  = alle




RAM

MAX RAM  gilt immer sofort
Gesamt minus OS (NT)

MIN RAM
der Wert gilt erst, wenn auch die Daten im Speicher gelandet
falls Konkurrenz existiert, dann MIN RAM <> 0


--Filestreaming
--Datentyp image / text  ... depricated seit 2005
--max 2 GB

--WinFS-- seit SQL  2012


\\Server\INSTANZ\DB\TAB

select * from TAB  (Volltextsuche)

Security über TAB in SQL Server
Backup in SQL 
