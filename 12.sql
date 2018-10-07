use TMPV_UNIVER

declare @sb char(20), @s char(300)='';
declare Sbj cursor for select s.SUBJECT from [SUBJECT] s where s.PULPIT='ИСиТ';
open Sbj;
fetch Sbj into @sb;
print 'Предметы на кафедре ИСиТ: ';
while @@fetch_status=0
begin
set @s=rtrim(@sb)+','+@s;
fetch Sbj into @sb;
end;
print @s;
close Sbj;

declare ftlty cursor local
for select f.FACULTY,f.FACULTY_NAME from FACULTY f;
declare @fk varchar(10),@fn varchar(70);
print 'Факультеты: ';
open ftlty;
fetch ftlty into @fk,@fn;
print '1 ' +rtrim(@fk)+'-'+@fn;
go
declare @fk varchar(10),@fn varchar(20);
fetch ftlty into @fk,@fn;
print '2 ' +rtrim(@fk)+'-'+@fn;
go

declare ftlty cursor global
for select f.FACULTY,f.FACULTY_NAME from FACULTY f;
declare @fk varchar(10),@fn varchar(70);
print 'Факультеты: ';
open ftlty;
fetch ftlty into @fk,@fn;
print '1 ' +rtrim(@fk)+'-'+@fn;
go
declare @fk varchar(10),@fn varchar(70);
fetch ftlty into @fk,@fn;
print '2 ' +rtrim(@fk)+'-'+@fn;
close ftlty;
deallocate ftlty;
go

create table #Pulp (p char(20),pn varchar(100)) ;
insert into #Pulp(p,pn) select p.PULPIT, p.PULPIT_NAME from PULPIT p;

declare @p char(10),@pn char(70);
declare pulp cursor local static
for select p,pn from #Pulp;
open pulp;
print 'Количество срок: '+ cast(@@CURSOR_ROWS as varchar(5));

update #Pulp set pn='XXX' where p='ИСиТ';
delete #Pulp where p like 'Л%';
insert #Pulp values('XXX','XXXXXXXX');

fetch pulp into @p,@pn;
while @@fetch_status=0
begin
print+rtrim(@p)+'-'+@pn;
fetch pulp into  @p,@pn;
end;
close pulp;
go

drop table #Pulp
create table #Pulp (p char(20),pn varchar(100)) ;
insert into #Pulp(p,pn) select p.PULPIT, p.PULPIT_NAME from PULPIT p;

declare @p char(10),@pn char(70);
declare pulp cursor local dynamic
for select p,pn from #Pulp;
open pulp;
print 'Количество срок: '+ cast(@@CURSOR_ROWS as varchar(5));

update #Pulp set pn='XXX' where p='ИСиТ';
delete #Pulp where p like 'Л%';
insert #Pulp values('XXX','XXXXXXXX');

fetch pulp into @p,@pn;
while @@fetch_status=0
begin
print+rtrim(@p)+'-'+@pn;
fetch pulp into  @p,@pn;
end;
close pulp;
go

drop table #Pulp

create table #Pulp (p char(20),pn varchar(100)) ;
insert into #Pulp(p,pn) select p.PULPIT, p.PULPIT_NAME from PULPIT p;

declare @i int, @p char(10),@pn char(70);
declare pulp cursor local static scroll
for select row_number() over (order by p,pn) N ,p,pn from #Pulp;
open pulp;
fetch pulp into @i, @p,@pn;
print'Следующая строка: '+cast(@i as varchar(3))+' '+rtrim(@p)+'-'+@pn;
fetch last from pulp into @i, @p,@pn;
print'Последняя строка: '+cast(@i as varchar(3))+' '+rtrim(@p)+'-'+@pn;
fetch absolute 4 from pulp into @i, @p,@pn;
print'4-ая от начала строка: '+cast(@i as varchar(3))+' '+rtrim(@p)+'-'+@pn;
fetch next from pulp into @i, @p,@pn;
print'Следующая строка: '+cast(@i as varchar(3))+' '+rtrim(@p)+'-'+@pn;
fetch absolute -6 from pulp into @i, @p,@pn;
print'6-ая отконца строка: '+cast(@i as varchar(3))+' '+rtrim(@p)+'-'+@pn;
fetch relative -2 from pulp into @i, @p,@pn;
print'2-ая строка от текущей назад: '+cast(@i as varchar(3))+' '+rtrim(@p)+'-'+@pn;
fetch first from pulp into @i, @p,@pn;
print'1-ая строка: '+cast(@i as varchar(3))+' '+rtrim(@p)+'-'+@pn;
fetch relative 4 from pulp into @i, @p,@pn;
print'4-ая строка от текущей вперед:'+cast(@i as varchar(3))+' '+rtrim(@p)+'-'+@pn;
fetch prior from pulp into @i, @p,@pn;
print'предыдущая строка от текущей: '+cast(@i as varchar(3))+' '+rtrim(@p)+'-'+@pn;
close pulp;
go


create table #Pulp (p char(20),pn varchar(100)) ;
insert into #Pulp(p,pn) select p.PULPIT, p.PULPIT_NAME from PULPIT p;

declare @p char(20),@pn char(100);
declare pulp cursor local dynamic scroll
for select p,pn from #Pulp for update;
open pulp;
fetch pulp into @p,@pn;
update #Pulp set p='123123' where current of pulp;
fetch pulp into @p,@pn;
delete #Pulp where current of pulp;
close pulp;

select * from #Pulp;
go


select * from PROGRESS where NOTE<4  delete  PROGRESS where;
select * from PROGRESS where IDSTUDENT=1017 update PROGRESS set NOTE=NOTE+1 ;

declare  @s char(20),@id int,@d date,@n int;
declare Prgr cursor local dynamic
for select p.[SUBJECT], p.IDSTUDENT,p.PDATE,p.NOTE from PROGRESS p for update;
open Prgr;
fetch Prgr into @s,@id,@d,@n;
while @@fetch_status=0
begin
if @id=2014 
update PROGRESS set NOTE=NOTE+1 where current of Prgr;
if @n<5  
delete PROGRESS where current of Prgr;
fetch Prgr into @s,@id,@d,@n;
end
close Prgr;

select * from PROGRESS;
truncate table PROGRESS
