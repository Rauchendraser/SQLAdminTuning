/*

Profiler
vorsichtig!
SQL Kommandos (Reads, Write, CPU, DAuer, Uhrzeit)
--> Filtern!!

Aufzeichnen in Datei 
Filter
Ereignisse: Stored Procedures. SPStmtCompleted
Endzeit angeben
Größe vordefinieren und Rollout rausnehmen


Perfmon
Windows Leistungsindikatoren
Arbeitsspeicher: Seiten/sec
Physik. Datenträger:  durchschn. Wartenschlangenlänge > 2
lng Zeitraum  unter 2
Prozessor: CPU Zeit %

SQL LIndkatoren
Batches/sec
Benutzerverbindung
Durchschn. Wartezeit in ms
Puffercachetrefferquote   > 90%
Latches und Locks: Durchschnittliche Wartezeit
Lebenserwartung der Seiten (> 300sek)







QueryStore
Lesen und Schreibn aktivieren
Max Dauer : zb 30 Tage
Max Volumen : 1000 MB

Bei Problemen minuten Takt 
Normalbetrieb: 15 min
*/

select * from sys.dm_os_performance_counters