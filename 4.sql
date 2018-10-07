Use master
CREATE database Bbr_Univer;
use Bbr_Univer
CREATE TABLE FACULTY(
	код_факультета char(10) primary key not null, 
	наименование_факультета  varchar(50) default '???') ON [PRIMARY] ;

CREATE TABLE AUDITORIUM_TYPE(
	код_типа_аудитории char(10) primary key not null, 
	наименование_типа_аудитории varchar(30) null)ON [PRIMARY];

-- 
CREATE TABLE PROFESSION(
	код_специальности char(20) not null primary key, 
	код_факультета  char(10) foreign key(код_факультета) REFERENCES FACULTY(код_факультета) not null, 
	наименование_специальности varchar(100) null, 
	квалификация varchar(50) null )ON [PRIMARY];

CREATE TABLE PULPIT(
	код_кафедры char(20) primary key not null, 
	наименование_кафедры  varchar(100) null, 
	код_факультета char(10) foreign key(код_факультета) REFERENCES FACULTY(код_факультета) null)ON G1;

CREATE TABLE TEACHER(
	код_преподавателя char(10) primary key not null,
	ФИО_преподавателя  varchar(100) null, 
	пол char(1) default 'м' check (пол in ('м', 'ж')), 
	код_кафедры char(20) foreign key(код_кафедры) REFERENCES PULPIT(код_кафедры) not null)ON G1;

CREATE TABLE SUBJECTS(
	код_дисциплины char(10) primary key not null, 
	наименование_дисциплины  varchar(100) null  unique, 
	код_кафедры char(20) foreign key(код_кафедры) REFERENCES PULPIT(код_кафедры) not null)ON G1;

CREATE TABLE AUDITORIUM(
	код_аудитории char(20) primary key not null, 
	код_типа_аудитории char(10) not null foreign key(код_типа_аудитории) REFERENCES AUDITORIUM_TYPE(код_типа_аудитории), 
	вместимость int default 1 check (вместимость <= 300 and вместимость > 0), 
	наименование_аудитории varchar(50) null)ON G2;

CREATE TABLE GROUPS(
	идентификатор_группы int primary key not null, 
	код_факультета char(10) foreign key(код_факультета) REFERENCES FACULTY(код_факультета) not null, 
	код_специальности char(20) foreign key(код_специальности) REFERENCES PROFESSION(код_специальности) not null, 
	год_поступления smallint  check (год_поступления < year(Getdate())+2), 
	курс AS (year(Getdate()) - год_поступления))ON G1;

CREATE TABLE STUDENT(
	Код_студента int identity (1000,1) primary key,  
	идентификатор_группы int foreign key(идентификатор_группы) REFERENCES GROUPS(идентификатор_группы) not null,
	ФИО nvarchar(100), 
	дата_рождения date, 
	штамп_времени timestamp,
	дополнительная_информация xml default  null,
	фотография varbinary(max)  default  null )ON G2;


CREATE TABLE PROGRESS(
	код_дисциплины char(10) foreign key(код_дисциплины) REFERENCES SUBJECTS(код_дисциплины),                
	Код_студента integer foreign key(Код_студента) REFERENCES STUDENT(Код_студента),        
	дата_экзамена    date, 
	оценка     integer check (оценка between 1 and 10))ON G2;

	 