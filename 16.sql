create table TR_AUDIT
(
	ID int identity,	--number
	STMT varchar(20)	--DML-operator
		check (STMT in('INS','DEL','UPD')),
	TRNAME varchar(50), --trigger name
	CC varchar(300)		--comment
);
go
create trigger TR_TEACHER_INS 
 on TEACHER after INSERT
 as 
 declare @a1 char(20), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
 print '�������� �������';
 set @a1 = (select [TEACHER] from INSERTED);
 set @a2= (select [TEACHER_NAME] from INSERTED);
 set @a3= (select [GENDER] from INSERTED);
 set @a4= (select [PULPIT] from INSERTED);
 set @in = @a1+' '+@a2+' '+@a3+' ' +@a4;
 print @in
 insert into TR_AUDIT(STMT,TRNAME,CC)
	values('INS','TR_TEACHER_INS',@in);
 return;
go
insert into TEACHER
  values('GAV','Glushko Alexandr Viktorovich','�','����')
select * from TR_AUDIT
go

-------

create trigger TR_TEACHER_DEL 
 on TEACHER after DELETE
 as 
 declare @a1 char(20), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
 print '�������� ��������';
 set @a1 = (select [TEACHER] from deleted);
 set @a2= (select [TEACHER_NAME] from deleted);
 set @a3= (select [GENDER] from deleted);
 set @a4= (select [PULPIT] from deleted);
 set @in = @a1+' '+@a2+' '+@a3+' ' +@a4;
 insert into TR_AUDIT(STMT,TRNAME,CC)
	values('DEL','TR_TEACHER_DEL',@in);
 return;
go
delete TEACHER where TEACHER.TEACHER = 'GAV'
select * from TR_AUDIT
go

------

create trigger TR_TEACHER_UPD 
 on TEACHER after UPDATE
 as 
 declare @a1 char(20), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
 print '�������� ���������';
 set @a1 = (select [TEACHER] from deleted);
 set @a2= (select [TEACHER_NAME] from deleted);
 set @a3= (select [GENDER] from deleted);
 set @a4= (select [PULPIT] from deleted);
 set @in = @a1+' '+@a2+' '+@a3+' ' +@a4;
 set @a1 = (select [TEACHER] from inserted);
 set @a2= (select [TEACHER_NAME] from inserted);
 set @a3= (select [GENDER] from inserted);
 set @a4= (select [PULPIT] from inserted);
 set @in = @in +' ' + @a1+' '+@a2+' '+@a3+' ' +@a4;
 insert into TR_AUDIT(STMT,TRNAME,CC)
	values('UPD','TR_TEACHER_UPD',@in);
 return;
go
update TEACHER set TEACHER_NAME='������ ��������� ����������' where TEACHER='GAV'
select * from TR_AUDIT
go

-----------

create trigger TR_TEACHER 
on TEACHER after insert,delete,update 
as 
 declare @a1 char(20), @a2 varchar(100), @a3 char(1), @a4 char(20), @in varchar(300);
 declare @ins int = (select count(*) from inserted),
         @del int = (select count(*) from deleted);
 if  (@ins > 0 and  @del = 0)
 begin 
	print '�������: INSERT';
	set @a1 = (select [TEACHER] from INSERTED);
	set @a2= (select [TEACHER_NAME] from INSERTED);
	set @a3= (select [GENDER] from INSERTED);
	set @a4= (select [PULPIT] from INSERTED);
	set @in = @a1+' '+@a2+' '+@a3+' ' +@a4;
	insert into TR_AUDIT(STMT,TRNAME,CC)
		values('INS','TR_TEACHER',@in);
 end;
 else if (@ins = 0 and  @del > 0)  
 begin
	print '�������: DELETE';
	set @a1 = (select [TEACHER] from deleted);
	set @a2= (select [TEACHER_NAME] from deleted);
	set @a3= (select [GENDER] from deleted);
	set @a4= (select [PULPIT] from deleted);
	set @in = @a1+' '+@a2+' '+@a3+' ' +@a4;
	insert into TR_AUDIT(STMT,TRNAME,CC)
		values('DEL','TR_TEACHER',@in);
 end
 else if (@ins > 0 and  @del > 0) 
 begin
	print '�������: UPDATE'; 
	set @a1 = (select [TEACHER] from deleted);
	set @a2= (select [TEACHER_NAME] from deleted);
	set @a3= (select [GENDER] from deleted);
	set @a4= (select [PULPIT] from deleted);
	set @in = @a1+' '+@a2+' '+@a3+' ' +@a4;
	set @a1 = (select [TEACHER] from inserted);
	set @a2= (select [TEACHER_NAME] from inserted);
	set @a3= (select [GENDER] from inserted);
	set @a4= (select [PULPIT] from inserted);
	set @in = @in +' ' + @a1+' '+@a2+' '+@a3+' ' +@a4;
	insert into TR_AUDIT(STMT,TRNAME,CC)
		values('UPD','TR_TEACHER',@in);
 end;
 return;
go
insert into TEACHER
  values('GAV', 'Glushko Alexandr Viktorovich', '�', '����');
update TEACHER set TEACHER_NAME = '������ ��������� ����������' where TEACHER = 'GAV';
delete TEACHER where TEACHER.TEACHER = 'GAV';
select * from TR_AUDIT
go

-----
update TEACHER set GENDER='mine' where GENDER='m';
go


----------------

create trigger TR_TEACHER_DEL1 
on TEACHER after delete 
as
print 'TR_TEACHER_DEL1';
return;
go
create trigger TR_TEACHER_DEL2 
on TEACHER after delete 
as
print 'TR_TEACHER_DEL2';
return;
go
create trigger TR_TEACHER_DEL3 
on TEACHER after delete 
as
print 'TR_TEACHER_DEL3';
return;
go
select t.name, e.type_desc 
from sys.triggers  t join  sys.trigger_events e  on t.object_id = e.object_id  
where OBJECT_NAME(t.parent_id)='TEACHER' and e.type_desc = 'DELETE' ;  
exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL1', 
	                        @order='first', @stmttype = 'DELETE';
exec  SP_SETTRIGGERORDER @triggername = 'TR_TEACHER_DEL3', 
	                        @order='last', @stmttype = 'DELETE';
delete TEACHER where TEACHER='GAV'
go


--8.	����������� ��������, ��������������� �� ������� ���� ������ X_UNIVER �����������: AFTER-������� �������� ������ ����������, � ������ �������� ����������� ��������, ���������������� �������.
create trigger PROGRESS_Pick
on PROGRESS after update
as
	declare @r int;
	set @r = (select [NOTE] from inserted);
	if (@r<=2)
	begin
		raiserror('������ �� ����� ���� <3', 10, 1);
		rollback;
	end
return;
go
update PROGRESS set NOTE=1 where IDSTUDENT=1057
go

--9.	������� ��� ������� FACULTY INSTEAD OF-�������, ����������� �������� ����� � �������. ����������� ��������, ������� ������������� �� ������� ���� ������ X_UNIVER, ��� �������� ����������� ����������� ���������, ���� ���� INSTEADOF-�������. � ������� ��������� DROP ������� ��� DML-��������, ��������� � ���� ������������ ������.
create trigger TEACHER_INSTEAD_OF
on TEACHER instead of delete
as
	raiserror(N'�������� ���������', 10, 1);
	return;	
go
delete TEACHER
go


--10.	������� DDL-�������, ����������� �� ��� DDL-������� � �� UNIVER. ������� ������ ��������� ��������� ����� ������� � ������� ������������. ���� ���������� ������� ������ ������������ ����������, ������� ��������: ��� �������, ��� � ��� �������, � ����� ������������� �����, � ������ ���������� ���������� ���������. ����������� ��������, ��������������� ������ ��������. 
create  trigger DDL_G_UNIVER 
on database for DDL_DATABASE_LEVEL_EVENTS  
as  
declare @t varchar(50)= EVENTDATA().value ('(/EVENT_INSTANCE/EventType)[1]', 'varchar(50)');
declare @t1 varchar(50)=EVENTDATA().value ('(/EVENT_INSTANCE/ObjectName)[1]', 'varchar(50)');
declare @t2 varchar(50)=EVENTDATA().value('(/EVENT_INSTANCE/ObjectType)[1]', 'varchar(50)'); 
if @t2 = 'TABLE' 
begin
	print '��� �������: '+@t;
	print '��� �������: '+@t1;
	print '��� �������: '+@t2;
	raiserror( N'�������� � ��������� ���������', 16, 1);  
	rollback;    
end;
go
drop table TEACHER
create table a(c int);
go
