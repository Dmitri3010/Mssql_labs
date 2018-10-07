use TMPV_UNIVER


select t.TEACHER,t.TEACHER_NAME from TEACHER t 
where PULPIT='����' 
for xml PATH('TEACHER'),
root('�������������_�������_����');
go 

select a.AUDITORIUM_NAME,at.AUDITORIUM_TYPENAME, a.AUDITORIUM_CAPACITY
from AUDITORIUM a inner join AUDITORIUM_TYPE at
ON at.AUDITORIUM_TYPE=a.AUDITORIUM_TYPE
where a.AUDITORIUM_TYPE='��' 
for xml auto, root('����������_���������');
go 


declare @h int=0, @x varchar(2000)=
'<?xml version="1.0" encoding="windows-1251" ?>
<��������>
	<�������>
		<SUBJECT>MY_SUB1</SUBJECT>
		<SUBJECT_NAME>MY_SUBJECT1</SUBJECT_NAME>
		<PULPIT>����</PULPIT>
	</�������>
	<�������>
		<SUBJECT>MY_SUB2</SUBJECT>
		<SUBJECT_NAME>MY_SUBJECT2</SUBJECT_NAME>
		<PULPIT>����</PULPIT>
	</�������>
	<�������>
		<SUBJECT>MY_SUB3</SUBJECT>
		<SUBJECT_NAME>MY_SUBJECT3</SUBJECT_NAME>
		<PULPIT>����</PULPIT>
	</�������>
</��������>';

exec SP_XML_PREPAREDOCUMENT @h output,@x;
select * from openxml(@h,'/��������/�������',2)
with([SUBJECT] char(10),[SUBJECT_NAME] varchar(100),PULPIT char(20));
exec SP_XML_REMOVEDOCUMENT @h;

exec SP_XML_PREPAREDOCUMENT @h output,@x;
insert [SUBJECT] select [SUBJECT],[SUBJECT_NAME],PULPIT
from openxml(@h,'/��������/�������',2)
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
('������ ��������� ����������',
 '<Pasport>
	<Sereal>HB</Sereal>
	<Number>2728704</Number>
	<PersonalNumber>124124124</PersonalNumber>
	<Date>12/05/2013</Date>
	<Addres>��.������������, �.70</Addres>
 </Pasport>'),
 ('������� ����� �����������',
 '<Pasport>
	<Sereal>KH</Sereal>
	<Number>286879</Number>
	<PersonalNumber>4e12412</PersonalNumber>
	<Date>15/04/2013</Date>
	<Addres>��.����������, �.53, ��.16</Addres>
 </Pasport>')
 select Students.STUDENT,
 PasportData.value('(/Pasport/Sereal)[1]','varchar(5)')[����� ��������],
 PasportData.value('(/Pasport/Number)[1]','int')[����� ��������],
 PasportData.value('(/Pasport/PersonalNumber)[1]','varchar(100)')[������ �����],
 PasportData.value('(/Pasport/Date)[1]','date')[���� ������],
 PasportData.value('(/Pasport/Addres)[1]','varchar(100)')[����� ��������],
 PasportData.query('/Pasport') [���������� ������]
 from Students;
 update Students 
 set PasportData =
 '<Pasport>
	<Sereal>KH</Sereal>
	<Number>2286879</Number>
	<PersonalNumber>4e12412</PersonalNumber>
	<Date>15/04/2013</Date>
	<Addres>��.����������, �.53, ��.16</Addres>
 </Pasport>'
 where PasportData.value('(/Pasport/Number)[1]','int')=286879
 go



 create xml schema collection Student as 
N'<?xml version="1.0" encoding="utf-16" ?>
<xs:schema attributeFormDefault="unqualified" 
   elementFormDefault="qualified"
   xmlns:xs="http://www.w3.org/2001/XMLSchema">
<xs:element name="�������">
<xs:complexType><xs:sequence>
<xs:element name="�������" maxOccurs="1" minOccurs="1">
  <xs:complexType>
    <xs:attribute name="�����" type="xs:string" use="required" />
    <xs:attribute name="�����" type="xs:unsignedInt" use="required"/>
    <xs:attribute name="����"  use="required"  >
	<xs:simpleType>  <xs:restriction base ="xs:string">
		<xs:pattern value="[0-9]{2}.[0-9]{2}.[0-9]{4}"/>
	 </xs:restriction> 	</xs:simpleType>
     </xs:attribute>
  </xs:complexType>
</xs:element>
<xs:element maxOccurs="3" name="�������" type="xs:unsignedInt"/>
<xs:element name="�����">   <xs:complexType><xs:sequence>
   <xs:element name="������" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="�����" type="xs:string" />
   <xs:element name="���" type="xs:string" />
   <xs:element name="��������" type="xs:string" />
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
  INFO     xml(STUDENT),    -- �������������� ������� XML-����
  FOTO   varbinary
  );
go 

