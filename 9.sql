use TMPV_UNIVER;
go
create view [�������������]
as select 
TEACHER [���],
TEACHER_NAME[��� �������������], 
GENDER [���],
PULPIT [�������]
from TEACHER;
go
Select * from [�������������];
go


create view [���������� ������]
as select 
f1.FACULTY_NAME [���������],(select COUNT( PULPIT) 
from PULPIT where f1.FACULTY=PULPIT.FACULTY
)[���������� ������] 
from FACULTY f1
;
go
select * from [���������� ������];
go


 

create view ���������(���,���,[������������ ���������])
as select a.AUDITORIUM,a.AUDITORIUM_TYPE,a.AUDITORIUM_NAME from AUDITORIUM a 
where a.AUDITORIUM_TYPE like '��%';
go
select * from ���������;
 

insert ��������� values ('002-1','��','31-1');
delete from ��������� where ���='002-1';
go

create view ����������_���������(���,���,[������������ ���������])
as select a.AUDITORIUM,a.AUDITORIUM_TYPE,a.AUDITORIUM_NAME from AUDITORIUM a 
where a.AUDITORIUM_TYPE like '��%' with check option;
go
select * from ����������_���������;
go
insert ����������_��������� values ('002-1','��','31-1');
--insert ����������_��������� values ('003-1','��','32-1');--�� ���������
go

 create view ����������(���, [������������ ����������],[��� �������])
as select top(10) s.[SUBJECT] sb,s.SUBJECT_NAME sn,s.PULPIT p from [SUBJECT] s
order by sn;
go
select * from ����������;

go
alter view [���������� ������] with schemabinding
as select 
f1.FACULTY [���������],(select COUNT( PULPIT) 
from dbo.PULPIT where f1.FACULTY=PULPIT.FACULTY
)[���������� ������] 
from dbo.FACULTY f1
go
select * from [���������� ������];






