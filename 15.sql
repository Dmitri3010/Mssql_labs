use TMPV_UNIVER

go
create function COUNT_STUDENTS (@faculty varchar(20))
returns int 
as begin
	declare @rc int;
	set @rc = (select count(IDSTUDENT) from FACULTY f inner join GROUPS g
	On g.FACULTY = f.FACULTY inner join STUDENT s 
	On s.IDGROUP = g.IDGROUP where f.FACULTY = @faculty);
	return @rc;
end;

declare @f int = dbo.COUNT_STUDENTS('ЛХФ');
print 'Количество студентов= '+cast(@f as varchar(4));

select f.FACULTY,dbo.COUNT_STUDENTS(f.FACULTY) as [Количество студентов на факультете] from FACULTY f
go


create FUNCTION FSUBJECTS(@p varchar(20)) returns char(300) 
as
begin  
declare @tv char(20);  
declare @t varchar(300) = 'Дисциплины: ';  
declare Subjects CURSOR LOCAL 
for select s.[SUBJECT]
from PULPIT p inner join [SUBJECT] s
On s.PULPIT=p.PULPIT where p.PULPIT=@p;
open Subjects;	  
fetch  Subjects into @tv;   	 
while @@fetch_status = 0                                     
      begin 
         set @t = @t+ ', '+ rtrim(@tv);         
         FETCH  Subjects into @tv; 
      end;    return @t;
end;  

select p.PULPIT,dbo.FSUBJECTS(p.PULPIT) from PULPIT p
go


create function FFACPUL(@facult char(10),@pulpit char(20))
returns table
as return 
	select f.FACULTY,p.PULPIT from FACULTY f left outer join PULPIT p
	On f.FACULTY=p.FACULTY
	where f.FACULTY = isnull(@facult,f.FACULTY) 
		and p.PULPIT = isnull(@pulpit,p.PULPIT)

select * from dbo.FFACPUL(NULL,NULL)
select * from dbo.FFACPUL('ИЭФ',NULL)
select * from dbo.FFACPUL(NULL,'ЭТиМ')
select * from dbo.FFACPUL('ИЭФ','ЭТиМ')
go


create function FCTEACHER(@idpulpit char(20))
returns int
as begin
	return (select count(*) from TEACHER t
		where t.PULPIT=isnull(@idpulpit,t.PULPIT))
end

select dbo.FCTEACHER(NULL) [Всего преподавателей]
select PULPIT, dbo.FCTEACHER(PULPIT) [Количество преподавателей]
from PULPIT
go

create function COUNT_PULPIT(@faculty varchar(20))
returns int
as begin
	return (select count(PULPIT) from PULPIT where FACULTY = @faculty)
end
go
create function COUNT_GROUPS(@faculty varchar(20))
returns int
as begin
	return (select count(IDGROUP) from GROUPS where FACULTY = @faculty)
end
go
create function COUNT_PROFESSION(@faculty varchar(20))
returns int
as begin
	return (select count(PROFESSION) from PROFESSION where FACULTY = @faculty)
end
go
create function FACULTY_REPORT(@c int) 
returns @fr table ([Факультет] varchar(50),
				   [Количество кафедр] int,
				   [Количество групп]  int, 
	               [Количество студентов] int, 
				   [Количество специальностей] int)
as begin
	declare cc cursor static
	for select FACULTY from FACULTY where dbo.COUNT_STUDENTS(FACULTY)> @c; 
	declare @f varchar(30);
	open cc;
	fetch cc into @f;
	while @@fetch_status = 0
	begin
		insert @fr values( @f,  dbo.COUNT_PULPIT(@f),
	    dbo.COUNT_GROUPS(@f),   dbo.COUNT_STUDENTS(@f),
	    dbo.COUNT_PROFESSION(@f)); 
	    fetch cc into @f;  
	end;   
	return; 
end;
go
select * from dbo.FACULTY_REPORT(0)
go

