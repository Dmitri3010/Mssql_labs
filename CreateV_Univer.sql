Use master
drop database Univer1;
CREATE database Univer1;
use Univer1
CREATE TABLE FACULTY(
	код_факультета char(10) primary key not null, 
	наименование_факультета  varchar(50) default '???') ON [PRIMARY] ;

CREATE TABLE AUDITORIUM_TYPE(
	код_типа_аудитории char(10) primary key not null, 
	наименование_типа_аудитории varchar(30) null)ON [PRIMARY];

CREATE TABLE PROFESSION(
	код_специальности char(20) not null primary key, 
	код_факультета  char(10) foreign key(код_факультета) REFERENCES FACULTY(код_факультета) not null, 
	наименование_специальности varchar(100) null, 
	квалификация varchar(50) null )ON [PRIMARY];

CREATE TABLE PULPIT(
	код_кафедры char(20) primary key not null, 
	наименование_кафедры  varchar(100) null, 
	код_факультета char(10) foreign key(код_факультета) REFERENCES FACULTY(код_факультета) null);

CREATE TABLE TEACHER(
	код_преподавателя char(10) primary key not null,
	ФИО_преподавателя  varchar(100) null, 
	пол char(1) default 'м' check (пол in ('м', 'ж')), 
	код_кафедры char(20) foreign key(код_кафедры) REFERENCES PULPIT(код_кафедры) not null);

CREATE TABLE SUBJECTS(
	код_дисциплины char(10) primary key not null, 
	наименование_дисциплины  varchar(100) null  unique, 
	код_кафедры char(20) foreign key(код_кафедры) REFERENCES PULPIT(код_кафедры) not null);

CREATE TABLE AUDITORIUM(
	код_аудитории char(20) primary key not null, 
	код_типа_аудитории char(10) not null foreign key(код_типа_аудитории) REFERENCES AUDITORIUM_TYPE(код_типа_аудитории), 
	вместимость int default 1 check (вместимость <= 300 and вместимость > 0), 
	наименование_аудитории varchar(50) null);

CREATE TABLE GROUPS(
	идентификатор_группы int primary key not null, 
	код_факультета char(10) foreign key(код_факультета) REFERENCES FACULTY(код_факультета) not null, 
	код_специальности char(20) foreign key(код_специальности) REFERENCES PROFESSION(код_специальности) not null, 
	год_поступления smallint  check (год_поступления < year(Getdate())+2), 
	курс AS (year(Getdate()) - год_поступления));

CREATE TABLE STUDENT(
	Код_студента int identity (1000,1) primary key,  
	идентификатор_группы int foreign key(идентификатор_группы) REFERENCES GROUPS(идентификатор_группы) not null,
	ФИО nvarchar(100), 
	дата_рождения date, 
	штамп_времени timestamp,
	дополнительная_информация xml default  null,
	фотография varbinary(max)  default  null );


CREATE TABLE PROGRESS(
	код_дисциплины char(10) foreign key(код_дисциплины) REFERENCES SUBJECTS(код_дисциплины),                
	Код_студента integer foreign key(Код_студента) REFERENCES STUDENT(Код_студента),        
	дата_экзамена    date, 
	оценка     integer check (оценка between 1 and 10));

	
	drop database Univer4
	create database Univer4

	ON PRIMARY
	( NAME='UNIVER_mdf',   FILENAME='E:\учеба\2 Сем\BD\UNIVER.mdf', SIZE=5MB, MAXSIZE=10MB, FILEGROWTH=1MB),
	( NAME='UNIVER_ndf',   FILENAME='E:\учеба\2 Сем\BD\UNIVER.ndf', SIZE=5MB, MAXSIZE=10MB, FILEGROWTH=10%),

FILEGROUP G1
  ( NAME = 'UNIVER11_ndf', FILENAME ='E:\учеба\2 Сем\BD\UNIVER11.ndf', SIZE = 10MB, MAXSIZE=15MB, FILEGROWTH=1MB),
  ( NAME = 'UNIVER12_ndf', FILENAME ='E:\учеба\2 Сем\BD\UNIVER12.ndf', SIZE = 2MB, MAXSIZE=5MB, FILEGROWTH=1MB),

FILEGROUP G2
  ( NAME = 'UNIVER21_ndf', FILENAME ='E:\учеба\2 Сем\BD\UNIVER21.ndf', SIZE = 5MB, MAXSIZE=10MB, FILEGROWTH=1MB),
  ( NAME = 'UNIVER22_ndf', FILENAME ='E:\учеба\2 Сем\BD\UNIVER22.ndf', SIZE = 2MB, MAXSIZE=5MB, FILEGROWTH=1MB)

 LOG ON
  ( NAME='UNIVER_log',
    FILENAME =
       'E:\учеба\2 Сем\BD\UNIVER.ldf', SIZE=5MB,FILEGROWTH=1MB);



	   create database V_MyBase1
Use V_MyBase1 ;
Create Table Company  
( Company_name nvarchar(30) constraint PK_Bank primary key,
   Type_of_ownership nvarchar(30),
   Adress nvarchar(50),
   Work_phone varchar(20),
   Contact_person nvarchar(30) );
Create Table Types_of_loans 
( Name_of_the_loan nvarchar(30) constraint PK1_Bank primary key,
   Rate real);
   Create Table Credits 
( Number int constraint PK2_Bank primary key,
   Company_name nvarchar(30),
   Name_of_the_loan nvarchar(30),
   Amount real,
   Date_of_issue date,
   Return_date date );

   INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('ОАО "БорисовДрев"', 'частная', 'г.Борисов, ул. Н-Неман, 15', '80177962014', 'Абрамов В.П.');         
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('ОАО "Полимиз"', 'частная', 'г.Борисов, ул. Ибарури, 2', '80177926580', 'Копыйло В.В.'); 
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('ОДО "Виталюр"', 'частная', 'г.Борисов, ул. Гагарина, 4а', '80177942578', 'Маршел Е.П.'); 
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('ОАО "БАТЭ"', 'государственная', 'г.Борисов, ул. 3-го интернационала, 79', '80177723012', 'Авгенчик О.Р.'); 
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('ОАО "Белювелирторг"', 'государственная', 'г.Миинск, пр. Партизанский, 10', '8017521395', 'Евтушенко Л.Д.'); 
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('ОДО "Корона"', 'частная', 'г.Борисов, ул. Гагарина, 12', '80177982078', 'Жабов К.Л.'); 
	
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('Бизнес-ипотека', 18);
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('В кач. инвест.', 17);
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('Лизинг', 19);
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('На текущ. деят. ', 16);
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('Факторнг', 20);
	
	      
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (1, 'ОАО "БорисовДрев"', 'В кач. инвест.', 5E+08, '2016-05-25', '2030-05-25');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (2, 'ОАО "Полимиз"', 'Факторнг', 1.5E+07, '2017-02-21', '2020-02-21');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (3, 'ОДО "Виталюр"', 'Бизнес-ипотека', 8E+09, '2016-03-12', '2036-03-12');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (4, 'ОАО "БАТЭ"', 'В кач. инвест.', 5.5E+08, '2017-03-15', '2030-03-15');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (5, 'ОАО "Белювелирторг"', 'На текущ. деят. ', 9E+07, '2016-08-20', '2028-08-20');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (6, 'ОДО "Корона"', 'Лизинг', 3E+08, '2017-01-05', '2022-01-05');


	Select count(*) From Credits;
	Select Name_of_the_loan From Types_of_loans;
	UPDATE Credits set Amount=6E+08  Where Number =4;

	DROP database V_MyBase1;
   use master 

   go
   create database V_MyBase1
ON PRIMARY
	( NAME=N'BANK_mdf',   FILENAME=N'E:\учеба\2 Сем\BD\Base.mdf', SIZE=5MB, MAXSIZE=10MB, FILEGROWTH=1MB),
	( NAME=N'BANK_ndf',   FILENAME=N'E:\учеба\2 Сем\BD\Base.ndf', SIZE=5MB, MAXSIZE=10MB, FILEGROWTH=10%),

 FILEGROUP G1
  ( NAME = N'BANK11_ndf', FILENAME =N'E:\учеба\2 Сем\BD\Base11.ndf', SIZE = 10MB, MAXSIZE=15MB, FILEGROWTH=1MB),
  ( NAME = N'BANK12_ndf', FILENAME =N'E:\учеба\2 Сем\BD\Base12.ndf', SIZE = 2MB, MAXSIZE=5MB, FILEGROWTH=1MB),

FILEGROUP G2
  ( NAME = N'BANK21_ndf', FILENAME =N'E:\учеба\2 Сем\BD\Base21.ndf', SIZE = 5MB, MAXSIZE=10MB, FILEGROWTH=1MB),
  ( NAME = 'BANK22_ndf', FILENAME =N'E:\учеба\2 Сем\BD\Base22.ndf', SIZE = 2MB, MAXSIZE=5MB, FILEGROWTH=1MB)

 LOG ON
  ( NAME=N'BANK_log', FILENAME = N'E:\учеба\2 Сем\BD\Base.ldf', SIZE=5MB, FILEGROWTH=1MB);
   go


