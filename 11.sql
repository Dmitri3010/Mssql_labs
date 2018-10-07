use TMPV_UNIVER

exec sp_helpindex AUDITORIUM
exec sp_helpindex AUDITORIUM_TYPE
exec sp_helpindex FACULTY
exec sp_helpindex GROUPS
exec sp_helpindex PROFESSION
exec sp_helpindex PULPIT 
exec sp_helpindex STUDENT 
exec sp_helpindex SUBJECT
exec sp_helpindex TEACHER

create table #Test (Name nvarchar(50), Note int)
 
 set nocount on
 declare @i int =0
 while @i <1000
 begin
 insert #Test (Name, Note)
 values ('имя', 10*rand())
 set @i+=1
 end

 select* from #Test order by Note

checkpoint;
 DBCC DROPCLEANBUFFERS;
 create clustered index #Table_CL on #Test(Name asc);
select * from #Test order by Note;



create table #Test2 (Name nvarchar(50), Note int, Age int)
 
 set nocount on
 declare @k int =0
 while @k <10000
 begin
 insert #Test2 (Name, Note, Age)
 values ('имя', 10*rand(), 60*rand())
 set @k+=1
 end

 checkpoint;
 DBCC DROPCLEANBUFFERS;
 create  index #Table2 on #Test2(Name, Note);
select * from #Test2 order by Note;

create table #MT(rn int,ch char(10),it int);
 set nocount on;
 declare @f int=0;
 while @f<100000
	begin
	insert into #MT(rn,ch,it)
	values(1000*rand(),'String',@f);
	set @f=@f+1;
	end
select rn, it from #MT where rn >200; 


create index #MT_pkr on #MT(rn) include (it);
select rn, it from #MT where rn >200 ;
drop table #MT
go


create table #MT(rn int,ch char(10),it int);
 set nocount on;
 declare @i int=0;
 while @i<100000
	begin
	insert into #MT(rn,ch,it)
	values(1000*rand(),'String',@i);
	set @i=@i+1;
	end
select * from #MT where rn between 200 and 600; 
select * from #MT where rn>=200 and rn<600; 
select * from #MT where rn =400; 

create index #MT_where on #MT(rn) where(rn>=200 and rn<600);
select * from #MT where rn between 200 and 600; 
select * from #MT where rn>=200 and rn<600; 
select * from #MT where rn =400; 
drop table #MT
go

create table #MT(rn int,ch char(10),it int);
 declare @i int=0;
 while @i<100000
	begin
	insert into #MT(rn,ch,it)
	values(1000*rand(),'String',@i);
	set @i=@i+1;
	end
create index #MT_rn on #MT(rn);

insert top(100000) #MT(rn,ch,it) select rn,ch,it from #MT;

 SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
 FROM sys.dm_db_index_physical_stats(DB_ID(N'tempdb'), 
 OBJECT_ID(N'#MT'), NULL, NULL, NULL) ss JOIN sys.indexes ii 
 on ss.object_id = ii.object_id and ss.index_id = ii.index_id  
 where name is not null;
  alter index #MT_rn on #MT reorganize;
  alter index #MT_rn on #MT rebuild with (online=off);

  drop index #MT_rn on #MT 
create index #MT_rn1 on #MT(rn) with (fillfactor=40);
insert top(10000) into #MT(rn,ch,it) select rn,ch,it from #MT;
SELECT name [Индекс], avg_fragmentation_in_percent [Фрагментация (%)]
FROM sys.dm_db_index_physical_stats(DB_ID(N'tempdb'), 
OBJECT_ID(N'#MT'), NULL, NULL, NULL) ss JOIN sys.indexes ii 
on ss.object_id = ii.object_id and ss.index_id = ii.index_id  where name is not null;
go

create table #MT4(rn int,ch char(10),it int);
 declare @i int=0;
 while @i<100000
	begin
	insert into #MT4(rn,ch,it)
	values(1000*rand(),'String',@i);
	set @i=@i+1;
	end
truncate table #MT4; --0
delete #MT4; --2,8474
go;

create view [count pulpit] as 
select FACULTY[факультет],count(*) [количество]from PULPIT
group by FACULTY


go

select * from [count pulpit];



use V_MyBase

exec sp_helpindex заказы
exec sp_helpindex товары
exec sp_helpindex заказчики 


