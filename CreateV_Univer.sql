Use master
drop database Univer1;
CREATE database Univer1;
use Univer1
CREATE TABLE FACULTY(
	���_���������� char(10) primary key not null, 
	������������_����������  varchar(50) default '???') ON [PRIMARY] ;

CREATE TABLE AUDITORIUM_TYPE(
	���_����_��������� char(10) primary key not null, 
	������������_����_��������� varchar(30) null)ON [PRIMARY];

CREATE TABLE PROFESSION(
	���_������������� char(20) not null primary key, 
	���_����������  char(10) foreign key(���_����������) REFERENCES FACULTY(���_����������) not null, 
	������������_������������� varchar(100) null, 
	������������ varchar(50) null )ON [PRIMARY];

CREATE TABLE PULPIT(
	���_������� char(20) primary key not null, 
	������������_�������  varchar(100) null, 
	���_���������� char(10) foreign key(���_����������) REFERENCES FACULTY(���_����������) null);

CREATE TABLE TEACHER(
	���_������������� char(10) primary key not null,
	���_�������������  varchar(100) null, 
	��� char(1) default '�' check (��� in ('�', '�')), 
	���_������� char(20) foreign key(���_�������) REFERENCES PULPIT(���_�������) not null);

CREATE TABLE SUBJECTS(
	���_���������� char(10) primary key not null, 
	������������_����������  varchar(100) null  unique, 
	���_������� char(20) foreign key(���_�������) REFERENCES PULPIT(���_�������) not null);

CREATE TABLE AUDITORIUM(
	���_��������� char(20) primary key not null, 
	���_����_��������� char(10) not null foreign key(���_����_���������) REFERENCES AUDITORIUM_TYPE(���_����_���������), 
	����������� int default 1 check (����������� <= 300 and ����������� > 0), 
	������������_��������� varchar(50) null);

CREATE TABLE GROUPS(
	�������������_������ int primary key not null, 
	���_���������� char(10) foreign key(���_����������) REFERENCES FACULTY(���_����������) not null, 
	���_������������� char(20) foreign key(���_�������������) REFERENCES PROFESSION(���_�������������) not null, 
	���_����������� smallint  check (���_����������� < year(Getdate())+2), 
	���� AS (year(Getdate()) - ���_�����������));

CREATE TABLE STUDENT(
	���_�������� int identity (1000,1) primary key,  
	�������������_������ int foreign key(�������������_������) REFERENCES GROUPS(�������������_������) not null,
	��� nvarchar(100), 
	����_�������� date, 
	�����_������� timestamp,
	��������������_���������� xml default  null,
	���������� varbinary(max)  default  null );


CREATE TABLE PROGRESS(
	���_���������� char(10) foreign key(���_����������) REFERENCES SUBJECTS(���_����������),                
	���_�������� integer foreign key(���_��������) REFERENCES STUDENT(���_��������),        
	����_��������    date, 
	������     integer check (������ between 1 and 10));

	
	drop database Univer4
	create database Univer4

	ON PRIMARY
	( NAME='UNIVER_mdf',   FILENAME='E:\�����\2 ���\BD\UNIVER.mdf', SIZE=5MB, MAXSIZE=10MB, FILEGROWTH=1MB),
	( NAME='UNIVER_ndf',   FILENAME='E:\�����\2 ���\BD\UNIVER.ndf', SIZE=5MB, MAXSIZE=10MB, FILEGROWTH=10%),

FILEGROUP G1
  ( NAME = 'UNIVER11_ndf', FILENAME ='E:\�����\2 ���\BD\UNIVER11.ndf', SIZE = 10MB, MAXSIZE=15MB, FILEGROWTH=1MB),
  ( NAME = 'UNIVER12_ndf', FILENAME ='E:\�����\2 ���\BD\UNIVER12.ndf', SIZE = 2MB, MAXSIZE=5MB, FILEGROWTH=1MB),

FILEGROUP G2
  ( NAME = 'UNIVER21_ndf', FILENAME ='E:\�����\2 ���\BD\UNIVER21.ndf', SIZE = 5MB, MAXSIZE=10MB, FILEGROWTH=1MB),
  ( NAME = 'UNIVER22_ndf', FILENAME ='E:\�����\2 ���\BD\UNIVER22.ndf', SIZE = 2MB, MAXSIZE=5MB, FILEGROWTH=1MB)

 LOG ON
  ( NAME='UNIVER_log',
    FILENAME =
       'E:\�����\2 ���\BD\UNIVER.ldf', SIZE=5MB,FILEGROWTH=1MB);



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
    Values ('��� "�����������"', '�������', '�.�������, ��. �-�����, 15', '80177962014', '������� �.�.');         
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('��� "�������"', '�������', '�.�������, ��. �������, 2', '80177926580', '������� �.�.'); 
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('��� "�������"', '�������', '�.�������, ��. ��������, 4�', '80177942578', '������ �.�.'); 
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('��� "����"', '���������������', '�.�������, ��. 3-�� ��������������, 79', '80177723012', '�������� �.�.'); 
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('��� "�������������"', '���������������', '�.������, ��. ������������, 10', '8017521395', '��������� �.�.'); 
	INSERT into Company(Company_name,Type_of_ownership, Adress, Work_phone, Contact_person )
    Values ('��� "������"', '�������', '�.�������, ��. ��������, 12', '80177982078', '����� �.�.'); 
	
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('������-�������', 18);
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('� ���. ������.', 17);
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('������', 19);
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('�� �����. ����. ', 16);
	INSERT into Types_of_loans ( Name_of_the_loan, Rate)
    Values ('��������', 20);
	
	      
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (1, '��� "�����������"', '� ���. ������.', 5E+08, '2016-05-25', '2030-05-25');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (2, '��� "�������"', '��������', 1.5E+07, '2017-02-21', '2020-02-21');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (3, '��� "�������"', '������-�������', 8E+09, '2016-03-12', '2036-03-12');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (4, '��� "����"', '� ���. ������.', 5.5E+08, '2017-03-15', '2030-03-15');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (5, '��� "�������������"', '�� �����. ����. ', 9E+07, '2016-08-20', '2028-08-20');
	INSERT into Credits( Number, Company_name, Name_of_the_loan, Amount, Date_of_issue, Return_date )
    Values (6, '��� "������"', '������', 3E+08, '2017-01-05', '2022-01-05');


	Select count(*) From Credits;
	Select Name_of_the_loan From Types_of_loans;
	UPDATE Credits set Amount=6E+08  Where Number =4;

	DROP database V_MyBase1;
   use master 

   go
   create database V_MyBase1
ON PRIMARY
	( NAME=N'BANK_mdf',   FILENAME=N'E:\�����\2 ���\BD\Base.mdf', SIZE=5MB, MAXSIZE=10MB, FILEGROWTH=1MB),
	( NAME=N'BANK_ndf',   FILENAME=N'E:\�����\2 ���\BD\Base.ndf', SIZE=5MB, MAXSIZE=10MB, FILEGROWTH=10%),

 FILEGROUP G1
  ( NAME = N'BANK11_ndf', FILENAME =N'E:\�����\2 ���\BD\Base11.ndf', SIZE = 10MB, MAXSIZE=15MB, FILEGROWTH=1MB),
  ( NAME = N'BANK12_ndf', FILENAME =N'E:\�����\2 ���\BD\Base12.ndf', SIZE = 2MB, MAXSIZE=5MB, FILEGROWTH=1MB),

FILEGROUP G2
  ( NAME = N'BANK21_ndf', FILENAME =N'E:\�����\2 ���\BD\Base21.ndf', SIZE = 5MB, MAXSIZE=10MB, FILEGROWTH=1MB),
  ( NAME = 'BANK22_ndf', FILENAME =N'E:\�����\2 ���\BD\Base22.ndf', SIZE = 2MB, MAXSIZE=5MB, FILEGROWTH=1MB)

 LOG ON
  ( NAME=N'BANK_log', FILENAME = N'E:\�����\2 ���\BD\Base.ldf', SIZE=5MB, FILEGROWTH=1MB);
   go


