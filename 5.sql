use TMPV_UNIVER

SELECT *  FROM FACULTY;
SELECT *  FROM TEACHER INNER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
SELECT TEACHER_NAME FROM TEACHER WHERE (PULPIT = '����');


SELECT TEACHER_NAME FROM TEACHER WHERE ( PULPIT = '����' or  PULPIT = '������');

SELECT TEACHER_NAME FROM TEACHER WHERE ( PULPIT = '����' and GENDER = '�');

SELECT TEACHER_NAME [��� �������������] FROM TEACHER WHERE ( PULPIT = '����' and not GENDER = '�');

SELECT Distinct PULPIT FROM TEACHER;

SELECT AUDITORIUM_NAME, AUDITORIUM_CAPACITY FROM AUDITORIUM ORDER BY AUDITORIUM_CAPACITY;

SELECT Distinct Top(2) AUDITORIUM_TYPE, AUDITORIUM_NAME FROM AUDITORIUM  Order by AUDITORIUM_TYPE Desc;

 
SELECT Distinct SUBJECT,NOTE FROM PROGRESS WHERE(NOTE between 8 and 10);

SELECT DISTINCT SUBJECT_NAME , PULPIT FROM SUBJECT where (pulpit in ('�����', '������', '��'));

SELECT PROFESSION, QUALIFICATION FROM PROFESSION where (QUALIFICATION Like '%�����%');


CREATE table  #Students (���_�������� nvarchar(100), ����_�������� date );

INSERT INTO #Students SELECT NAME,BDAY FROM STUDENT ;
drop table #Students


use V_MyBase

select* from ������

select [��� ������], [���� ��������] from ������ where ([���������� ����������� ������]>2)
SELECT Distinct [������������ ������],���� FROM ������ WHERE(���� between 31 and 100);
SELECT Distinct [������������ ������],���� FROM ������ WHERE(���� between 31 and 100) and [������������ ������] like '%��%';


CREATE table  #������1 (����� nvarchar(100), ����_������ date );

INSERT INTO #������1 SELECT [������������ ������],[���� ��������] FROM ������ ;
select* from #������1
drop table #������1