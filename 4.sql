Use master
CREATE database Bbr_Univer;
use Bbr_Univer
CREATE TABLE FACULTY(
	���_���������� char(10) primary key not null, 
	������������_����������  varchar(50) default '???') ON [PRIMARY] ;

CREATE TABLE AUDITORIUM_TYPE(
	���_����_��������� char(10) primary key not null, 
	������������_����_��������� varchar(30) null)ON [PRIMARY];

-- 
CREATE TABLE PROFESSION(
	���_������������� char(20) not null primary key, 
	���_����������  char(10) foreign key(���_����������) REFERENCES FACULTY(���_����������) not null, 
	������������_������������� varchar(100) null, 
	������������ varchar(50) null )ON [PRIMARY];

CREATE TABLE PULPIT(
	���_������� char(20) primary key not null, 
	������������_�������  varchar(100) null, 
	���_���������� char(10) foreign key(���_����������) REFERENCES FACULTY(���_����������) null)ON G1;

CREATE TABLE TEACHER(
	���_������������� char(10) primary key not null,
	���_�������������  varchar(100) null, 
	��� char(1) default '�' check (��� in ('�', '�')), 
	���_������� char(20) foreign key(���_�������) REFERENCES PULPIT(���_�������) not null)ON G1;

CREATE TABLE SUBJECTS(
	���_���������� char(10) primary key not null, 
	������������_����������  varchar(100) null  unique, 
	���_������� char(20) foreign key(���_�������) REFERENCES PULPIT(���_�������) not null)ON G1;

CREATE TABLE AUDITORIUM(
	���_��������� char(20) primary key not null, 
	���_����_��������� char(10) not null foreign key(���_����_���������) REFERENCES AUDITORIUM_TYPE(���_����_���������), 
	����������� int default 1 check (����������� <= 300 and ����������� > 0), 
	������������_��������� varchar(50) null)ON G2;

CREATE TABLE GROUPS(
	�������������_������ int primary key not null, 
	���_���������� char(10) foreign key(���_����������) REFERENCES FACULTY(���_����������) not null, 
	���_������������� char(20) foreign key(���_�������������) REFERENCES PROFESSION(���_�������������) not null, 
	���_����������� smallint  check (���_����������� < year(Getdate())+2), 
	���� AS (year(Getdate()) - ���_�����������))ON G1;

CREATE TABLE STUDENT(
	���_�������� int identity (1000,1) primary key,  
	�������������_������ int foreign key(�������������_������) REFERENCES GROUPS(�������������_������) not null,
	��� nvarchar(100), 
	����_�������� date, 
	�����_������� timestamp,
	��������������_���������� xml default  null,
	���������� varbinary(max)  default  null )ON G2;


CREATE TABLE PROGRESS(
	���_���������� char(10) foreign key(���_����������) REFERENCES SUBJECTS(���_����������),                
	���_�������� integer foreign key(���_��������) REFERENCES STUDENT(���_��������),        
	����_��������    date, 
	������     integer check (������ between 1 and 10))ON G2;

	 