use TMPV_UNIVER


select t.TEACHER,t.TEACHER_NAME from TEACHER t 
where PULPIT='ИСиТ' 
for xml PATH('TEACHER'),
root('Преподаватели_кафедра_ИСиТ');
go 

select a.AUDITORIUM_NAME,at.AUDITORIUM_TYPENAME, a.AUDITORIUM_CAPACITY
from AUDITORIUM a inner join AUDITORIUM_TYPE at
ON at.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE
where a.AUDITORIUM_TYPE='ЛК' 
for xml auto, root('Лекционные_аудитории');
go 


declare @h int=0, @x varchar(2000)=
'<?xml version="1.0" encoding="windows-1251" ?>
<Предметы>
	<Предмет>
		<SUBJECT>MY_SUB1</SUBJECT>
		<SUBJECT_NAME>MY_SUBJECT1</SUBJECT_NAME>
		<PULPIT>ИСиТ</PULPIT>
	</Предмет>
	<Предмет>
		<SUBJECT>MY_SUB2</SUBJECT>
		<SUBJECT_NAME>MY_SUBJECT2</SUBJECT_NAME>
		<PULPIT>ИСиТ</PULPIT>
	</Предмет>
	<Предмет>
		<SUBJECT>MY_SUB3</SUBJECT>
		<SUBJECT_NAME>MY_SUBJECT3</SUBJECT_NAME>
		<PULPIT>ИСиТ</PULPIT>
	</Предмет>
</Предметы>';

exec SP_XML_PREPAREDOCUMENT @h output,@x;
select * from openxml(@h,'/Предметы/Предмет',2)
with([SUBJECT] char(10),[SUBJECT_NAME] varchar(100),PULPIT char(20));
exec SP_XML_REMOVEDOCUMENT @h;

exec SP_XML_PREPAREDOCUMENT @h output,@x;
insert [SUBJECT] select [SUBJECT],[SUBJECT_NAME],PULPIT
from openxml(@h,'/Предметы/Предмет',2)
with([SUBJECT] char(10),[SUBJECT_NAME] varchar(100),PULPIT char(20));
exec SP_XML_REMOVEDOCUMENT @h;

select * from [SUBJECT]
go



create table Students
(
	STUDENT nvarchar(100) primary key ,
	PasportData xml
);
 
insert into Students values
('Глушко Александр Викторович',
 '<Pasport>
	<Sereal>HB</Sereal>
	<Number>2728704</Number>
	<PersonalNumber>124124124</PersonalNumber>
	<Date>12/05/2013</Date>
	<Addres>ул.Первомайская, д.70</Addres>
 </Pasport>'),
 ('Лакевич Мария Геннадьевна',
 '<Pasport>
	<Sereal>KH</Sereal>
	<Number>286879</Number>
	<PersonalNumber>4e12412</PersonalNumber>
	<Date>15/04/2013</Date>
	<Addres>ул.Цагельника, д.53, кв.16</Addres>
 </Pasport>')
 select Students.STUDENT,
 PasportData.value('(/Pasport/Sereal)[1]','varchar(5)')[Серия паспорта],
 PasportData.value('(/Pasport/Number)[1]','int')[Номер паспорта],
 PasportData.value('(/Pasport/PersonalNumber)[1]','varchar(100)')[Личный номер],
 PasportData.value('(/Pasport/Date)[1]','date')[Дата выдачи],
 PasportData.value('(/Pasport/Addres)[1]','varchar(100)')[Адрес студента],
 PasportData.query('/Pasport') [Паспортные данные]
 from Students;
 update Students 
 set PasportData =
 '<Pasport>
	<Sereal>KH</Sereal>
	<Number>2286879</Number>
	<PersonalNumber>4e12412</PersonalNumber>
	<Date>15/04/2013</Date>
	<Addres>ул.Цагельника, д.53, кв.16</Addres>
 </Pasport>'
 where PasportData.value('(/Pasport/Number)[1]','int')=286879
 go



 create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="студент">
<xs:complexType><xs:sequence>
<xs:element name="паспорт" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="серия" type="xs:string" use="required" />
    <xs:attribute name="номер" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="дата"  use="required"  >
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="телефон" type="xs:unsignedInt"/>
<xs:element name="адрес">   <xs:complexType><xs:sequence>
   <xs:element name="страна" type="xs:string" />
   <xs:element name="город" type="xs:string" />
   <xs:element name="улица" type="xs:string" />
   <xs:element name="дом" type="xs:string" />
   <xs:element name="квартира" type="xs:string" />
</xs:sequence></xs:complexType>  </xs:element>
</xs:sequence></xs:complexType>
</xs:element></xs:schema>';

drop table STUDENT;
go
create table STUDENT 
( IDSTUDENT integer  identity(1000,1) 
		 constraint STUDENT_PK  primary key,
   IDGROUP integer constraint STUDENT_GROUP_FK
		 foreign key  references GROUPS(IDGROUP),        
  NAME nvarchar(100), 
  BDAY  date,
  STAMP timestamp,
  INFO     xml(STUDENT),    -- типизированный столбец XML-типа
  FOTO   varbinary
  );
go 

