--DDL Trigger --- IUD: DML Trigger
--CREATE ALTER DROP

select eventdata() --wer wann was wo auf ms gemacht,, objekte

create trigger demotrg on database --on Server
for DROP_TABLE --CREATE_VIEW
as
select eventdata() 
exec msdb..sp_send_dbmail 
rollback
GO


create table t1 (id int)