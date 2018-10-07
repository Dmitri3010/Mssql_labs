use TMPV_UNIVER

set nocount on
if  exists (select * from  SYS.OBJECTS        -- ������� X ����?
            where OBJECT_ID= object_id(N'DBO.X') )	            
drop table X;           
declare @c int, @flag char = 'r';           -- commit ��� rollback?
SET IMPLICIT_TRANSACTIONS  ON   -- �����. ����� ������� ����������
    create table X(K int );                         -- ������ ���������� 
	insert X values (1),(2),(3);
	set @c = (select count(*) from X);
	print '���������� ����� � ������� X: ' + cast( @c as varchar(2));
	if @flag = 'c'  commit;                   -- ���������� ����������: �������� 
          else      rollback;                              -- ���������� ����������: �����  
    SET IMPLICIT_TRANSACTIONS  OFF   -- ������. ����� ������� ����������
-- ��������� ����� ������������
if  exists (select * from  SYS.OBJECTS       -- ������� X ����?
            where OBJECT_ID= object_id(N'DBO.X') )
print '������� X ����'; 
else print '������� X ���'
go



begin try
	 begin tran                 -- ������  ����� ����������
	   insert AUDITORIUM values ('105-5','��',90,'105-5');
	   insert AUDITORIUM values ('105-3','��',90,'105-3'); 
	   
	   commit tran;               -- �������� ����������
	end try
	begin catch
	    print '������: '+ case 
          when error_number() = 2627 and patindex('%PK%', error_message()) > 0
          then '������������' 
          else '����������� ������: '+ cast(error_number() as  varchar(5))+ error_message()  
	  end; 
	 if @@trancount > 0 rollback tran ; 	  
     end catch;
go


declare @point varchar(32);                               
begin try
  begin tran                                                             -- ������  ����� ����������
	delete AUDITORIUM where AUDITORIUM.AUDITORIUM='105-5'; 
	set @point = 'p1'; save tran @point;             -- ����������� ����� p1
	insert AUDITORIUM values ('105-5','��',90,'105-5');
	set @point = 'p2'; save tran @point;             -- ����������� ����� p2
	insert AUDITORIUM values ('105-5','��',90,'105-5'); 
	commit tran;                                                     -- �������� ����������
   end try
   begin catch
	print '������: '+ case 
      when error_number() = 2627 and patindex('%AUDITORIUM_PK%', error_message()) > 0
      then '������������' 
      else '����������� ������: '+ cast(error_number() as  varchar(5)) + error_message()  
	end; 
   if @@trancount > 0 
	begin
	   print '����������� �����: '+ @point;
	   rollback tran @point;                                   -- ����� � ����������� �����
	   commit tran;                  -- �������� ���������, ����������� �� ����������� ����� 
	end;     
   end catch;
   go


   set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
select @@SPID, 'insert ������' '���������', * from AUDITORIUM 
where AUDITORIUM.AUDITORIUM='105-5';
	  select @@SPID, 'update ������'  '���������', 
            AUDITORIUM, AUDITORIUM_NAME from AUDITORIUM  
	                                              where AUDITORIUM.AUDITORIUM='105-5';
	  commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert AUDITORIUM values ('105-5','��',90,'105-5'); 
	-------------------------- t1 --------------------
	-------------------------- t2 --------------------
	rollback;
go 


set transaction isolation level READ COMMITTED 
	begin transaction 
	select count(*) from AUDITORIUM 
	    where AUDITORIUM.AUDITORIUM='105-5';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  'update ������'  '���������', count(*)
	from AUDITORIUM     where AUDITORIUM.AUDITORIUM='105-5';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          update AUDITORIUM set AUDITORIUM.AUDITORIUM='105-5'
                                       where AUDITORIUM.AUDITORIUM='105-3';
          commit; 
	-------------------------- t2 --------------------	
	go

	-- A ---
          set transaction isolation level  REPEATABLE READ 
	begin transaction 
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
	-------------------------- t1 ------------------ 
	-------------------------- t2 -----------------
	select  case
          when AUDITORIUM = '105-5' then 'insert  ������'  else ' ' 
end '���������', AUDITORIUM from AUDITORIUM  where AUDITORIUM_NAME = '105-5';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert AUDITORIUM values ('105-5','��',90,'105-5');
          commit; 
	-------------------------- t2 --------------------
	go

	use master;
	go
	alter database TMPV_UNIVER set allow_snapshot_isolation on
	use TMPV_UNIVER
	go
	set transaction isolation level SNAPSHOT 
	begin transaction 
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
	-------------------------- t1 ------------------ 
delete AUDITORIUM where AUDITORIUM = '105-5';  
             insert AUDITORIUM values ('105-5','��',90,'105-5');
          update AUDITORIUM set AUDITORIUM = '105-5' where AUDITORIUM_NAME = '105-5';
	-------------------------- t2 -----------------
	select  AUDITORIUM from AUDITORIUM  where AUDITORIUM_NAME = '105-5';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
delete AUDITORIUM where AUDITORIUM = '105-5';  
             insert AUDITORIUM values ('105-5','��',90,'105-5');
          update AUDITORIUM set AUDITORIUM = '105-5' where AUDITORIUM_NAME = '105-5';
          commit; 
		  go


  set transaction isolation level SERIALIZABLE 
	begin transaction 
delete AUDITORIUM where AUDITORIUM = '105-5';  
             insert AUDITORIUM values ('105-5','��',90,'105-5');
          update AUDITORIUM set AUDITORIUM = '105-5' where AUDITORIUM_NAME = '105-5';
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
	-------------------------- t1 -----------------
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
	-------------------------- t2 ------------------ 
	commit; 	
	--- B ---	
	begin transaction 	  
delete AUDITORIUM where AUDITORIUM = '105-5';  
             insert AUDITORIUM values ('105-5','��',90,'105-5');
          update AUDITORIUM set AUDITORIUM = '105-5' where AUDITORIUM_NAME = '105-5';
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
          -------------------------- t1 --------------------
          commit; 
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
	go

	use TMPV_UNIVER
	begin tran                                           --  ������� ����������   
             insert AUDITORIUM values ('103-5','��',90,'103-5');
begin tran                                          --  ���������� ����������  
          update AUDITORIUM set AUDITORIUM = '105-3' where AUDITORIUM_NAME = '103-5';
commit;                                             --  ���������� ����������  
if @@trancount > 0 
 rollback;        -- ������� ���������� 
select   (select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '103-5') '���������', 
(select AUDITORIUM_TYPENAME from AUDITORIUM_TYPE a where a.AUDITORIUM_TYPENAME = '��') '���'; 
go
