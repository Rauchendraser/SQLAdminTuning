create proc gptest @par1 int
as
select * from ku where id < @par1
GO

set statistics io, time on

--Plan passt sich an...
select * from ku where id < 2
select * from ku where id < 1000000

--die Procedure nicht..Plan belibt immer derselbe.. statt 52000 Seiten nun über 1 Mio.
exec gptest 2
exec gptest 1000000


--ein paar mal ausführen.. im Query Store sehr gut zu entdecken: Auflisten nach top Ressourcenverbrauchen (Logical reads)