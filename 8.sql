use TMPV_UNIVER

select 
max(AUDITORIUM_CAPACITY) [��� �����������],
min(AUDITORIUM_CAPACITY) [min �����������],
avg(AUDITORIUM_CAPACITY) [������� �����������],
sum(AUDITORIUM_CAPACITY) [��������� �����������],
count(*) [����� ���������]
from AUDITORIUM;
go

select AUDITORIUM_TYPENAME,
max(A.AUDITORIUM_CAPACITY) [��� �����������],
min(A.AUDITORIUM_CAPACITY) [min �����������],
avg(A.AUDITORIUM_CAPACITY) [������� �����������],
sum(A.AUDITORIUM_CAPACITY)[��������� �����������],
count(*) [���������� ���������]
from AUDITORIUM_TYPE at inner join AUDITORIUM a
on at.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE
group by AUDITORIUM_TYPENAME;


select * from
(select case
when p.NOTE =10 then '10'
when p.NOTE between 8 and 9 then '8-9'
when p.NOTE between 6 and 7 then '6-7'
when p.NOTE between 4 and 5 then '4-5'
end [������], count (*)[����������]
from PROGRESS as p
group by case
when p.NOTE =10 then '10'
when p.NOTE between 8 and 9 then '8-9'
when p.NOTE between 6 and 7 then '6-7'
when p.NOTE between 4 and 5 then '4-5'
end) as slct1
order by case [������]
when '10' then 1
when '8-9' then 2
when '6-7' then 3
when '4-5' then 4
end;



select fa.FACULTY, g.PROFESSION, p.SUBJECT, avg (p.NOTE)[������� ������]
from
STUDENT s inner join PROGRESS p on s.IDSTUDENT=p.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
inner join FACULTY fa on g.FACULTY=fa.FACULTY
where fa.FACULTY='����'
group by rollup (fa.FACULTY, g.PROFESSION, p.SUBJECT);
go

select fa.FACULTY, g.PROFESSION, p.SUBJECT, avg(p.NOTE)[������� ������]
from
STUDENT s inner join PROGRESS p on s.IDSTUDENT=p.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
inner join FACULTY fa on g.FACULTY=fa.FACULTY
where fa.FACULTY='����'
group by cube (fa.FACULTY, g.PROFESSION, p.SUBJECT);
go

select g.PROFESSION [�������������], p.SUBJECT [����������], round(avg(p.NOTE),2)[������� ������]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='����'
group by g.PROFESSION,p.SUBJECT
union
select g.PROFESSION [�������������], p.SUBJECT [����������], round(avg(p.NOTE),2)[������� ������]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='����'
group by g.PROFESSION,p.SUBJECT;
go

select g.PROFESSION [�������������], p.SUBJECT [����������], round(avg(p.NOTE),2)[������� ������]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='����'
group by g.PROFESSION,p.SUBJECT
union all
select g.PROFESSION [�������������], p.SUBJECT [����������], round(avg(p.NOTE),2)[������� ������]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='����'
group by g.PROFESSION,p.SUBJECT;
go


select g.PROFESSION [�������������], p.SUBJECT [����������], round(avg(p.NOTE),2)[������� ������]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDGROUP
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY in ('����', '����')
group by g.PROFESSION,p.SUBJECT
intersect
select g.PROFESSION [�������������], p.SUBJECT [����������], round(avg(p.NOTE),2)[������� ������]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='����'
group by g.PROFESSION,p.SUBJECT;
go


select g.PROFESSION [�������������], p.SUBJECT [����������], round(avg(p.NOTE),2)[������� ������]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY in ('����', '����')
group by g.PROFESSION,p.SUBJECT
except
select g.PROFESSION [�������������], p.SUBJECT [����������], round(avg(p.NOTE),2)[������� ������]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='����'
group by g.PROFESSION,p.SUBJECT
go

 

select p.SUBJECT, p.NOTE, 
(select count(*) from PROGRESS p2 where p.NOTE=p2.NOTE and p.SUBJECT=p2.SUBJECT) [���������� ���������]
from PROGRESS p
group by p.SUBJECT, p.NOTE
having p.NOTE in(8,9)
go
 
 use V_MyBase
 select max(����) [���� ����],
 min (����) [��� ����],

 count(����) [���-�� �������]
 from ������

 select* from
 (select case
 when p.����> 20 then '������'
 when p.����<=20 then '������'
 end[����]
 from ������ as p
) as slct1 
order by case [����]
when '������' then 1
when '������' then 2 
end






