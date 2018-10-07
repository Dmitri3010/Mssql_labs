use TMPV_UNIVER

SELECT *  FROM FACULTY;
SELECT *  FROM TEACHER INNER JOIN PULPIT ON TEACHER.PULPIT = PULPIT.PULPIT
SELECT TEACHER_NAME FROM TEACHER WHERE (PULPIT = 'ИСиТ');


SELECT TEACHER_NAME FROM TEACHER WHERE ( PULPIT = 'ИСиТ' or  PULPIT = 'ПОиСОИ');

SELECT TEACHER_NAME FROM TEACHER WHERE ( PULPIT = 'ИСиТ' and GENDER = 'ж');

SELECT TEACHER_NAME [Имя преподавателя] FROM TEACHER WHERE ( PULPIT = 'ИСиТ' and not GENDER = 'ж');

SELECT Distinct PULPIT FROM TEACHER;

SELECT AUDITORIUM_NAME, AUDITORIUM_CAPACITY FROM AUDITORIUM ORDER BY AUDITORIUM_CAPACITY;

SELECT Distinct Top(2) AUDITORIUM_TYPE, AUDITORIUM_NAME FROM AUDITORIUM  Order by AUDITORIUM_TYPE Desc;

 
SELECT Distinct SUBJECT,NOTE FROM PROGRESS WHERE(NOTE between 8 and 10);

SELECT DISTINCT SUBJECT_NAME , PULPIT FROM SUBJECT where (pulpit in ('ЛЗиДВ', 'ПОиСОИ', 'ОВ'));

SELECT PROFESSION, QUALIFICATION FROM PROFESSION where (QUALIFICATION Like '%химик%');


CREATE table  #Students (ФИО_студента nvarchar(100), Дата_рождения date );

INSERT INTO #Students SELECT NAME,BDAY FROM STUDENT ;
drop table #Students


use V_MyBase

select* from Заказы

select [Код заказа], [дата поставки] from Заказы where ([количество заказанного товара]>2)
SELECT Distinct [Наименование товара],цена FROM Товары WHERE(цена between 31 and 100);
SELECT Distinct [Наименование товара],цена FROM Товары WHERE(цена between 31 and 100) and [Наименование товара] like '%кр%';


CREATE table  #Заказы1 (товар nvarchar(100), Дата_заказа date );

INSERT INTO #Заказы1 SELECT [наименование товара],[дата поставки] FROM Заказы ;
select* from #Заказы1
drop table #Заказы1