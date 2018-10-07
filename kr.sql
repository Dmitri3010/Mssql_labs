use KR


create table PROGR(SUBJ nvarchar(50), IDST int not null, PDATE date not null, Note int default('Empty'), FACULTY nvarchar(50) )

insert into PROGR(SUBJ, IDST, PDATE,Note, FACULTY)
values('math', 1, '12.03.18', 5, 'FIT'),
('OAIP', 2, '15.04.16', 10, 'FIT'),
('MP', 1, '1.1.08',5, 'IDIP'),
('An', 3, '2.4.05',9, 'ANV')

select* from PROGR

create table Group1(IDGR nvarchar(50) not null, FACULT smallint, PROF nvarchar(50), YEARP date  )

insert into Group1(IDGR, FACULT,PROF, YEARP)
values ('12-15', 44, '16-15', '15.12.11'),
 ('12-45', 44, '16-15', '15.12.09'),
 ('12-13', 42, '16-5', '1.12.11'),
 ('12-11', 44, '16-2', '15.12.15')

 create table STUD (IDST int not null,  IDGROUP nvarchar(50), Name nvarchar(50), VDAY date default ('&&&&'))
 insert into STUD(IDST, IDGROUP,Name, VDAY)
 values(1,'12-15','asfsd', '12.2.2008'),
 (1,'12-14','asftsd', '12.2.2008'),
 (2,'12-13','asfsed', '12.2.2008'),
 (3,'12-45','agsfsd', '12.2.2008')

 select* from STUD

 select STUD.Name ['фамилия'], PROGR.SUBJ[предмет], PROGR.Note['оценка'], PROGR.FACULTY from Stud inner join PROGR
ON STUD.IDST = PROGR.IDST
WHERE PROGR.Note between '4' and '6' and PROGR.FACULTY = 'FIT'   
 union 
select STUD.Name ['фамилия'], PROGR.SUBJ[предмет], PROGR.Note['оценка'], PROGR.FACULTY from Stud inner join PROGR
ON STUD.IDST = PROGR.IDST
WHERE  PROGR.FACULTY = 'IDIP'   



