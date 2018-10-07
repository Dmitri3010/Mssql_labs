use TMPV_UNIVER
select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
from AUDITORIUM inner join AUDITORIUM_TYPE 
 on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE

 select AUDITORIUM.AUDITORIUM, AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
from AUDITORIUM inner join AUDITORIUM_TYPE 
 on AUDITORIUM.AUDITORIUM_TYPE = AUDITORIUM_TYPE.AUDITORIUM_TYPE and AUDITORIUM_TYPE.AUDITORIUM_TYPENAME like '%компьютер%'

 select A.AUDITORIUM,AT.AUDITORIUM_TYPENAME
from AUDITORIUM as A, AUDITORIUM_TYPE AT
where A.AUDITORIUM_TYPE =AT.AUDITORIUM_TYPE

select FACULTY.FACULTY [Факультет],PULPIT.PULPIT_NAME [Кафедра], PROFESSION.PROFESSION [Специальность], SUBJECT.SUBJECT [Дисциплина],STUDENT.NAME [Имя студента],
case
when (PROGRESS.NOTE=6)then 'Шесть'
when (PROGRESS.NOTE=7)then 'Семь'
when (PROGRESS.NOTE=8)then 'Восемь'
end [Оценка] 
from   PROGRESS inner join STUDENT on (PROGRESS.IDSTUDENT=STUDENT.IDSTUDENT and (PROGRESS.IDSTUDENT between 6 and 8 ))
 inner join GROUPS on STUDENT.IDGROUP=GROUPS.IDGROUP
 inner join FACULTY on GROUPS.FACULTY=FACULTY.FACULTY
 inner join SUBJECT on SUBJECT.SUBJECT=PROGRESS.SUBJECT
 inner join PULPIT on SUBJECT.PULPIT=PULPIT.PULPIT_NAME
 inner join PROFESSION on GROUPS.PROFESSION=PROFESSION.PROFESSION
order by ( case when (PROGRESS.NOTE = 7) then 1
when (PROGRESS.NOTE = 8) then 2 else 3 end);


select PULPIT.PULPIT [Кафедра], 
isnull(TEACHER.TEACHER_NAME, '****')[Преподавтель]
 from PULPIT left outer join TEACHER on PULPIT.PULPIT=TEACHER.PULPIT;
go

select PULPIT.PULPIT [Кафедра], isnull(TEACHER.TEACHER_NAME, '****')[Преподавaтель]
 from  TEACHER left outer join PULPIT on PULPIT.PULPIT=TEACHER.PULPIT;
go

select PULPIT.PULPIT [Кафедра], isnull(TEACHER.TEACHER_NAME, '****')[Преподавтель] from 
 TEACHER right outer join PULPIT on PULPIT.PULPIT=TEACHER.PULPIT;
go

create table T1(city nvarchar(10),N int primary key);
insert into T1(city, N)
values ('Berlin', 2),('Kiel', 5),('Munchen', 6),('Dresden', 9);
create table T2(name nvarchar(10),N int);
insert into T2(name, N)
values ('Till', 2),('Paul', 5),('Schnei', 2),('Oli',4);

select name,city from T1 full outer join T2 on T1.N=T2.N;
select name,city from T2 full outer join T1 on T1.N=T2.N;

select name,city from T1 left outer join T2 on T1.N=T2.N;
select name,city from T1 right outer join T2 on T1.N=T2.N;

select name,city from T1 inner join T2 on T1.N=T2.N;

select * from T1 full outer join T2 on T1.N=T2.N where T2.N is null and T2.name is null;
go

select * from T1 full outer join T2 on T1.N=T2.N where T1.N is null and T1.city is null;
go

select * from T1 full outer join T2 on T1.N=T2.N where T1.N is not null and T1.city is not null and T2.name is not null and T2.N is not null;
go



select AUDITORIUM.AUDITORIUM ,AUDITORIUM_TYPE.AUDITORIUM_TYPENAME 
from AUDITORIUM cross join AUDITORIUM_TYPE 
where AUDITORIUM.AUDITORIUM_TYPE =AUDITORIUM_TYPE.AUDITORIUM_TYPE;
go
 

use V_MyBase
go

SELECT Товары.[Наименование товара], Товары.Цена, 
   Заказы.[вид поставки] From Заказы Inner Join Товары 
  On Заказы.[Наименование товара]=Товары.[Наименование товара]


SELECT Товары.[Наименование товара], Товары.Цена, 
   Заказы.[вид поставки] From Заказы Inner Join Товары 
  On Заказы.[Наименование товара]=Товары.[Наименование товара] and Заказы.[наименование товара] like'%кр%'
  order by Товары.цена

  SELECT Товары.[Наименование товара], Товары.Цена, 
   Заказы.[вид поставки],
   case
   when(цена>15) then 'дорого'
   when (цена<15) then 'дешево'
   end
   From Заказы Inner Join Товары 
  On Заказы.[Наименование товара]=Товары.[Наименование товара] 
  


