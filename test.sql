create database OOP
use OOP
create table Laba_2(оценка int, фамилия nvarchar(50))
insert into Laba_2
values (8,'Пивко'), (10,'Вольский'), (3, 'Пешевич'), (9,'Бавтрель')

select* from Laba_2

select фамилия, оценка from Laba_2
where оценка> 8


