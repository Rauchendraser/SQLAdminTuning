--DB Settings


-- Initialgröße der Dateien.. Lebenserwartung (3 Jahre)

--Wachstumsrate nicht 64MB

--Logfile: --> VLF
--nicht zuviele VLF (3000 bis 6000)

--Methode: RecModel Simple--> Startgröße 1 MB
----> Startgröße  1/3 der Datendateien setzen-->
--> Vergrößerung auf 1024 MB
--> RecModel Full--> Vollsicherung





dbcc loginfo()


--Zeilenversionierung
--evtl massive Traffixc auf tempdb
--dafür hindert ein Ändern das Lesen nicht mehr ..
--der Leser erhält die "alten" noch ngültigen DAten, bis der beim Updater der Commit ausgeeführt wurde..eigtl korrektes verhalten



USE [master]
GO
--Standardverhalten von Abfragen wird von READ COMMITTED auf Snapshot geändert
ALTER DATABASE [Northwind] SET READ_COMMITTED_SNAPSHOT ON WITH NO_WAIT
GO
--Zeilenversionierung aktivieren
ALTER DATABASE [Northwind] SET RECOVERY FULL WITH NO_WAIT
GO

GO
ALTER DATABASE [Northwind] SET ALLOW_SNAPSHOT_ISOLATION ON
GO

--

