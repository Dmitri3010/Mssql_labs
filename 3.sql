create database Bobr_UNIVER
use Bobr_UNIVER
create table STUDENT ([номер зачетки] int,фамилия nvarchar(50), [номер группы] int) 
alter table STUDENT add Дата_поступления date
ALTER Table STUDENT DROP Column Дата_поступления;
INSERT into STUDENT ([номер зачетки], Фамилия, [номер группы])
    Values (12896,'Морозов' , 1), (12341,'Чеховский' , 3),
	(85325,'Юркоец' , 3), (85615,'Эсаулов' , 3),
	(45645,'Бутвиловская' , 3), (63258,'Фурсиков' , 3),
	(23696,'Михайлов' , 3);       

	SELECT * From STUDENT;
	--
	SELECT Фамилия From STUDENT;
	--
	SELECT Фамилия, [номер зачетки]  From STUDENT;
	--
	SELECT count(*)[количество студентов] From STUDENT;
	UPDATE STUDENT set [номер группы] = 5;
	DELETE from STUDENT Where [номер зачетки] = 45645;
	SELECT * From STUDENT;
	--
	DROP Table STUDENT;
	CREATE TABLE STUDENT
( 	Номер_зачетки   int constraint NumZ primary key,
	Фамилия nvarchar(50) unique  not  null,
	Номер_группы   int        
    )
	--
	
	--
	INSERT into STUDENT (Номер_зачетки, Фамилия, Номер_группы) Values (14231,'lol' , 3)
	ALTER Table STUDENT ADD POL nchar(1) default 'м' check (POL in ('м', 'ж'));
	INSERT into STUDENT (Номер_зачетки, Фамилия, Номер_группы, POL) Values (14121,'Куниций' , 9,'м');
	--
	DROP Table STUDENT;
 CREATE TABLE STUDENT
( 	Номер_зачетки   int constraint NumZ primary key not  null,
	Фамилия nvarchar(50) unique  not  null,
	Дата_рождения date,
	Дата_поступления date,
	Пол  char(1) default 'м' check (Пол in ('м', 'ж'))        
    )
	--	
	SELECT * From STUDENT;

 use V_MyBase
 select* from Заказы
 select* from Заказчики
 select* from Товары
 alter table Заказы add [дата заказа] date
 alter table Заказы drop column  [дата заказа]
  ALTER Table Заказчики ADD POL nchar(1) default 'м' check (POL in ('м', 'ж'));
 insert into Заказы ( [Код заказа],[количество заказанного товара],[дата поставки],[вид поставки])
 values((5323), (2), ('22.12.2018'), ('самовывоз')), ((2324), (8), ('23.12.2018'), ('самовывоз')),( (2325), (1), ('27.12.2018'), ('самовывоз'))
  
 insert into Заказчики([Наименование фирмы заказчика],Адрес, [Контактное лицо] , Телефон, POL )
 values (('КОмпани'),('Минск, бобруйская 25'), ('Иван'), (375293777463), ('м')),(('КОмпани1'),('Минск, антоновка 25'), ('Ивен'), (375293777463), ('м')),
 (('КОмпани2'),('Минск, свердлова 11'), ('Катя'), (37529372342), ('ж')), (('КОмпани3'),('Минск, петровщина 64'), ('Андрей'), (3752937775653), ('м'))

 insert into Товары ([Наименование товара], цена, описание)
 values (('шкаф'), (24), ('большой')), (('стул'), (12), ('красивый')), (('кровать'), (32), ('большая'))

 select* from Заказчики
 select* from Заказы
 select* from Товары

 
	Select count(*)[количество столбцов] From Заказчики;
	Select [Наименование товара] From Товары;
	UPDATE Товары set Цена=68  Where [Наименование товара] ='шкаф';
	select* from Товары
	
 select* from Заказчики