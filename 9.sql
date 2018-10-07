use TMPV_UNIVER;
go
create view [Преподаватель]
as select 
TEACHER [Код],
TEACHER_NAME[Имя преподавателя], 
GENDER [Пол],
PULPIT [Кафедра]
from TEACHER;
go
Select * from [Преподаватель];
go


create view [Количество кафедр]
as select 
f1.FACULTY_NAME [факультет],(select COUNT( PULPIT) 
from PULPIT where f1.FACULTY=PULPIT.FACULTY
)[количество кафедр] 
from FACULTY f1
;
go
select * from [Количество кафедр];
go


 

create view Аудитории(код,тип,[наименование аудитории])
as select a.AUDITORIUM,a.AUDITORIUM_TYPE,a.AUDITORIUM_NAME from AUDITORIUM a 
where a.AUDITORIUM_TYPE like 'ЛК%';
go
select * from Аудитории;
 

insert Аудитории values ('002-1','ЛК','31-1');
delete from Аудитории where код='002-1';
go

create view Лекционные_аудитории(код,тип,[наименование аудитории])
as select a.AUDITORIUM,a.AUDITORIUM_TYPE,a.AUDITORIUM_NAME from AUDITORIUM a 
where a.AUDITORIUM_TYPE like 'ЛК%' with check option;
go
select * from Лекционные_аудитории;
go
insert Лекционные_аудитории values ('002-1','ЛК','31-1');
--insert Лекционные_аудитории values ('003-1','ЛБ','32-1');--не сработает
go

 create view Дисциплина(код, [наименование дисциплины],[код кафедры])
as select top(10) s.[SUBJECT] sb,s.SUBJECT_NAME sn,s.PULPIT p from [SUBJECT] s
order by sn;
go
select * from Дисциплина;

go
alter view [Количество кафедр] with schemabinding
as select 
f1.FACULTY [факультет],(select COUNT( PULPIT) 
from dbo.PULPIT where f1.FACULTY=PULPIT.FACULTY
)[количество кафедр] 
from dbo.FACULTY f1
go
select * from [Количество кафедр];






