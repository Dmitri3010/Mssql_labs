use TMPV_UNIVER

select PULPIT.PULPIT_NAME,FACULTY.FACULTY,PROFESSION.PROFESSION_NAME
from FACULTY inner join PULPIT on FACULTY.FACULTY=PULPIT.FACULTY 
inner join PROFESSION on FACULTY.FACULTY= PROFESSION.FACULTY
where PROFESSION_NAME IN( SELECT PROFESSION_NAME from  PROFESSION  
where PROFESSION_NAME  LIKE '%����������%' or  PROFESSION_NAME like '%��������%')

select PULPIT_NAME,FACULTY.FACULTY,PROFESSION.PROFESSION_NAME
from(select PROFESSION_NAME from PROFESSION 
where PROFESSION_NAME like'%����������%' 
or  PROFESSION_NAME like'%����������%')as t inner join PROFESSION on t. PROFESSION_NAME=PROFESSION. PROFESSION_NAME
inner join FACULTY on PROFESSION.FACULTY=FACULTY.FACULTY
inner join PULPIT on PULPIT.FACULTY=FACULTY.FACULTY;
go

select PULPIT_NAME,FACULTY.FACULTY,PROFESSION.PROFESSION_NAME
from FACULTY inner join  PULPIT on FACULTY.FACULTY=PULPIT.FACULTY
inner join PROFESSION 
on PROFESSION.FACULTY=FACULTY.FACULTY
where PROFESSION.PROFESSION_NAME like'%����������%' 
or PROFESSION_NAME like'%����������%';
go


select AUDITORIUM, AUDITORIUM_TYPE, AUDITORIUM_CAPACITY from
AUDITORIUM bb where AUDITORIUM=(select top(1) AUDITORIUM from AUDITORIUM cc
 where bb.AUDITORIUM_TYPE=cc.AUDITORIUM_TYPE order by AUDITORIUM_CAPACITY desc)

 select FACULTY_NAME from
 FACULTY where not exists(select* from PULPIT
 where FACULTY.FACULTY=PULPIT.FACULTY)

 select top(1)
 (select avg(Note) from PROGRESS where SUBJECT like '����')[����],
  (select AVG (Note) from PROGRESS where SUBJECT like '��')[��],
   (select AVG (Note) from PROGRESS where SUBJECT like '����')[����] from PROGRESS

   select* from PROGRESS

   select SUBJECT, NOTE from PROGRESS
   where NOTE>=all(select NOTE from PROGRESS where NOTE like '%7%')

   select * from AUDITORIUM
where AUDITORIUM_CAPACITY >=any(select AUDITORIUM_CAPACITY from AUDITORIUM where AUDITORIUM like '%4');
go

select s.NAME, s.BDAY from STUDENT s
where exists (
select s1.BDAY from STUDENT s1
where s.BDAY=s1.BDAY and s.NAME!=s1.NAME)
order by s.BDAY;


use V_MyBase

select* from ������
select* from ������

select top(1)
 (select avg(����) from ������1 where �������� like '%�%')[������� ����]
 from ������1

    select* from ������1

   select ��������, ���� from ������1
   where ����>=all(select ���� from ������1 where ���� like '2')
