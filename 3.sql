create database Bobr_UNIVER
use Bobr_UNIVER
create table STUDENT ([����� �������] int,������� nvarchar(50), [����� ������] int) 
alter table STUDENT add ����_����������� date
ALTER Table STUDENT DROP Column ����_�����������;
INSERT into STUDENT ([����� �������], �������, [����� ������])
    Values (12896,'�������' , 1), (12341,'���������' , 3),
	(85325,'������' , 3), (85615,'�������' , 3),
	(45645,'������������' , 3), (63258,'��������' , 3),
	(23696,'��������' , 3);       

	SELECT * From STUDENT;
	--
	SELECT ������� From STUDENT;
	--
	SELECT �������, [����� �������]  From STUDENT;
	--
	SELECT count(*)[���������� ���������] From STUDENT;
	UPDATE STUDENT set [����� ������] = 5;
	DELETE from STUDENT Where [����� �������] = 45645;
	SELECT * From STUDENT;
	--
	DROP Table STUDENT;
	CREATE TABLE STUDENT
( 	�����_�������   int constraint NumZ primary key,
	������� nvarchar(50) unique  not  null,
	�����_������   int        
    )
	--
	
	--
	INSERT into STUDENT (�����_�������, �������, �����_������) Values (14231,'lol' , 3)
	ALTER Table STUDENT ADD POL nchar(1) default '�' check (POL in ('�', '�'));
	INSERT into STUDENT (�����_�������, �������, �����_������, POL) Values (14121,'�������' , 9,'�');
	--
	DROP Table STUDENT;
 CREATE TABLE STUDENT
( 	�����_�������   int constraint NumZ primary key not  null,
	������� nvarchar(50) unique  not  null,
	����_�������� date,
	����_����������� date,
	���  char(1) default '�' check (��� in ('�', '�'))        
    )
	--	
	SELECT * From STUDENT;

 use V_MyBase
 select* from ������
 select* from ���������
 select* from ������
 alter table ������ add [���� ������] date
 alter table ������ drop column  [���� ������]
  ALTER Table ��������� ADD POL nchar(1) default '�' check (POL in ('�', '�'));
 insert into ������ ( [��� ������],[���������� ����������� ������],[���� ��������],[��� ��������])
 values((5323), (2), ('22.12.2018'), ('���������')), ((2324), (8), ('23.12.2018'), ('���������')),( (2325), (1), ('27.12.2018'), ('���������'))
  
 insert into ���������([������������ ����� ���������],�����, [���������� ����] , �������, POL )
 values (('�������'),('�����, ���������� 25'), ('����'), (375293777463), ('�')),(('�������1'),('�����, ��������� 25'), ('����'), (375293777463), ('�')),
 (('�������2'),('�����, ��������� 11'), ('����'), (37529372342), ('�')), (('�������3'),('�����, ���������� 64'), ('������'), (3752937775653), ('�'))

 insert into ������ ([������������ ������], ����, ��������)
 values (('����'), (24), ('�������')), (('����'), (12), ('��������')), (('�������'), (32), ('�������'))

 select* from ���������
 select* from ������
 select* from ������

 
	Select count(*)[���������� ��������] From ���������;
	Select [������������ ������] From ������;
	UPDATE ������ set ����=68  Where [������������ ������] ='����';
	select* from ������
	
 select* from ���������