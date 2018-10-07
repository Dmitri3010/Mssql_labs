use TMPV_UNIVER

select 
max(AUDITORIUM_CAPACITY) [мах ¬местимость],
min(AUDITORIUM_CAPACITY) [min ¬местимость],
avg(AUDITORIUM_CAPACITY) [средн€€ ¬местимость],
sum(AUDITORIUM_CAPACITY) [суммарна€ ¬местимость],
count(*) [¬сего аудиторий]
from AUDITORIUM;
go

select AUDITORIUM_TYPENAME,
max(A.AUDITORIUM_CAPACITY) [мах ¬местимость],
min(A.AUDITORIUM_CAPACITY) [min ¬местимость],
avg(A.AUDITORIUM_CAPACITY) [средн€€ ¬местимость],
sum(A.AUDITORIUM_CAPACITY)[суммарна€ ¬местимость],
count(*) [количество аудиторий]
from AUDITORIUM_TYPE at inner join AUDITORIUM a
on at.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE
group by AUDITORIUM_TYPENAME;


select * from
(select case
when p.NOTE =10 then '10'
when p.NOTE between 8 and 9 then '8-9'
when p.NOTE between 6 and 7 then '6-7'
when p.NOTE between 4 and 5 then '4-5'
end [ќценки], count (*)[ оличество]
from PROGRESS as p
group by case
when p.NOTE =10 then '10'
when p.NOTE between 8 and 9 then '8-9'
when p.NOTE between 6 and 7 then '6-7'
when p.NOTE between 4 and 5 then '4-5'
end) as slct1
order by case [ќценки]
when '10' then 1
when '8-9' then 2
when '6-7' then 3
when '4-5' then 4
end;



select fa.FACULTY, g.PROFESSION, p.SUBJECT, avg (p.NOTE)[средн€€ оценка]
from
STUDENT s inner join PROGRESS p on s.IDSTUDENT=p.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
inner join FACULTY fa on g.FACULTY=fa.FACULTY
where fa.FACULTY='»ƒиѕ'
group by rollup (fa.FACULTY, g.PROFESSION, p.SUBJECT);
go

select fa.FACULTY, g.PROFESSION, p.SUBJECT, avg(p.NOTE)[средн€€ оценка]
from
STUDENT s inner join PROGRESS p on s.IDSTUDENT=p.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
inner join FACULTY fa on g.FACULTY=fa.FACULTY
where fa.FACULTY='»ƒиѕ'
group by cube (fa.FACULTY, g.PROFESSION, p.SUBJECT);
go

select g.PROFESSION [—пециальность], p.SUBJECT [ƒисциплина], round(avg(p.NOTE),2)[средн€€ оценка]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='»ƒиѕ'
group by g.PROFESSION,p.SUBJECT
union
select g.PROFESSION [—пециальность], p.SUBJECT [ƒисциплина], round(avg(p.NOTE),2)[средн€€ оценка]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='’“и“'
group by g.PROFESSION,p.SUBJECT;
go

select g.PROFESSION [—пециальность], p.SUBJECT [ƒисциплина], round(avg(p.NOTE),2)[средн€€ оценка]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='»ƒиѕ'
group by g.PROFESSION,p.SUBJECT
union all
select g.PROFESSION [—пециальность], p.SUBJECT [ƒисциплина], round(avg(p.NOTE),2)[средн€€ оценка]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='’“и“'
group by g.PROFESSION,p.SUBJECT;
go


select g.PROFESSION [—пециальность], p.SUBJECT [ƒисциплина], round(avg(p.NOTE),2)[средн€€ оценка]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDGROUP
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY in ('»ƒиѕ', '’“и“')
group by g.PROFESSION,p.SUBJECT
intersect
select g.PROFESSION [—пециальность], p.SUBJECT [ƒисциплина], round(avg(p.NOTE),2)[средн€€ оценка]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='’“и“'
group by g.PROFESSION,p.SUBJECT;
go


select g.PROFESSION [—пециальность], p.SUBJECT [ƒисциплина], round(avg(p.NOTE),2)[средн€€ оценка]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY in ('»ƒиѕ', '’“и“')
group by g.PROFESSION,p.SUBJECT
except
select g.PROFESSION [—пециальность], p.SUBJECT [ƒисциплина], round(avg(p.NOTE),2)[средн€€ оценка]
from PROGRESS p inner join STUDENT s on p.IDSTUDENT=s.IDSTUDENT
inner join GROUPS g on s.IDGROUP=g.IDGROUP
where g.FACULTY='’“и“'
group by g.PROFESSION,p.SUBJECT
go

 

select p.SUBJECT, p.NOTE, 
(select count(*) from PROGRESS p2 where p.NOTE=p2.NOTE and p.SUBJECT=p2.SUBJECT) [количество студентов]
from PROGRESS p
group by p.SUBJECT, p.NOTE
having p.NOTE in(8,9)
go
 
 use V_MyBase
 select max(цена) [макс цена],
 min (цена) [мин цена],

 count(цена) [кол-во товаров]
 from “овары

 select* from
 (select case
 when p.цена> 20 then 'дорого'
 when p.цена<=20 then 'намана'
 end[цена]
 from “овары as p
) as slct1 
order by case [цена]
when 'дорого' then 1
when 'намана' then 2 
end






