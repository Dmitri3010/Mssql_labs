use TMPV_UNIVER

set nocount on
if  exists (select * from  SYS.OBJECTS        -- таблица X есть?
            where OBJECT_ID= object_id(N'DBO.X') )	            
drop table X;           
declare @c int, @flag char = 'r';           -- commit или rollback?
SET IMPLICIT_TRANSACTIONS  ON   -- включ. режим неявной транзакции
    create table X(K int );                         -- начало транзакции 
	insert X values (1),(2),(3);
	set @c = (select count(*) from X);
	print 'количество строк в таблице X: ' + cast( @c as varchar(2));
	if @flag = 'c'  commit;                   -- завершение транзакции: фиксация 
          else      rollback;                              -- завершение транзакции: откат  
    SET IMPLICIT_TRANSACTIONS  OFF   -- выключ. режим неявной транзакции
-- действует режим автофиксации
if  exists (select * from  SYS.OBJECTS       -- таблица X есть?
            where OBJECT_ID= object_id(N'DBO.X') )
print 'таблица X есть'; 
else print 'таблицы X нет'
go



begin try
	 begin tran                 -- начало  явной транзакции
	   insert AUDITORIUM values ('105-5','ЛК',90,'105-5');
	   insert AUDITORIUM values ('105-3','ЛК',90,'105-3'); 
	   
	   commit tran;               -- фиксация транзакции
	end try
	begin catch
	    print 'ошибка: '+ case 
          when error_number() = 2627 and patindex('%PK%', error_message()) > 0
          then 'дублирование' 
          else 'неизвестная ошибка: '+ cast(error_number() as  varchar(5))+ error_message()  
	  end; 
	 if @@trancount > 0 rollback tran ; 	  
     end catch;
go


declare @point varchar(32);                               
begin try
  begin tran                                                             -- начало  явной транзакции
	delete AUDITORIUM where AUDITORIUM.AUDITORIUM='105-5'; 
	set @point = 'p1'; save tran @point;             -- контрольная точка p1
	insert AUDITORIUM values ('105-5','ЛК',90,'105-5');
	set @point = 'p2'; save tran @point;             -- контрольная точка p2
	insert AUDITORIUM values ('105-5','ЛК',90,'105-5'); 
	commit tran;                                                     -- фиксация транзакции
   end try
   begin catch
	print 'ошибка: '+ case 
      when error_number() = 2627 and patindex('%AUDITORIUM_PK%', error_message()) > 0
      then 'дублирование' 
      else 'неизвестная ошибка: '+ cast(error_number() as  varchar(5)) + error_message()  
	end; 
   if @@trancount > 0 
	begin
	   print 'контрольная точка: '+ @point;
	   rollback tran @point;                                   -- откат к контрольной точке
	   commit tran;                  -- фиксация изменений, выполненных до контрольной точки 
	end;     
   end catch;
   go


   set transaction isolation level READ UNCOMMITTED 
	begin transaction 
	-------------------------- t1 ------------------
select @@SPID, 'insert Товары' 'результат', * from AUDITORIUM 
where AUDITORIUM.AUDITORIUM='105-5';
	  select @@SPID, 'update Заказы'  'результат', 
            AUDITORIUM, AUDITORIUM_NAME from AUDITORIUM  
	                                              where AUDITORIUM.AUDITORIUM='105-5';
	  commit; 
	-------------------------- t2 -----------------
	--- B --	
	begin transaction 
	select @@SPID
	insert AUDITORIUM values ('105-5','ЛК',90,'105-5'); 
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
	select  'update Заказы'  'результат', count(*)
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
          when AUDITORIUM = '105-5' then 'insert  Заказы'  else ' ' 
end 'результат', AUDITORIUM from AUDITORIUM  where AUDITORIUM_NAME = '105-5';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
          insert AUDITORIUM values ('105-5','ЛК',90,'105-5');
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
             insert AUDITORIUM values ('105-5','ЛК',90,'105-5');
          update AUDITORIUM set AUDITORIUM = '105-5' where AUDITORIUM_NAME = '105-5';
	-------------------------- t2 -----------------
	select  AUDITORIUM from AUDITORIUM  where AUDITORIUM_NAME = '105-5';
	commit; 
	--- B ---	
	begin transaction 	  
	-------------------------- t1 --------------------
delete AUDITORIUM where AUDITORIUM = '105-5';  
             insert AUDITORIUM values ('105-5','ЛК',90,'105-5');
          update AUDITORIUM set AUDITORIUM = '105-5' where AUDITORIUM_NAME = '105-5';
          commit; 
		  go


  set transaction isolation level SERIALIZABLE 
	begin transaction 
delete AUDITORIUM where AUDITORIUM = '105-5';  
             insert AUDITORIUM values ('105-5','ЛК',90,'105-5');
          update AUDITORIUM set AUDITORIUM = '105-5' where AUDITORIUM_NAME = '105-5';
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
	-------------------------- t1 -----------------
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
	-------------------------- t2 ------------------ 
	commit; 	
	--- B ---	
	begin transaction 	  
delete AUDITORIUM where AUDITORIUM = '105-5';  
             insert AUDITORIUM values ('105-5','ЛК',90,'105-5');
          update AUDITORIUM set AUDITORIUM = '105-5' where AUDITORIUM_NAME = '105-5';
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
          -------------------------- t1 --------------------
          commit; 
	select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '105-5';
	go

	use TMPV_UNIVER
	begin tran                                           --  внешняя транзакция   
             insert AUDITORIUM values ('103-5','ЛК',90,'103-5');
begin tran                                          --  внутренняя транзакция  
          update AUDITORIUM set AUDITORIUM = '105-3' where AUDITORIUM_NAME = '103-5';
commit;                                             --  внутренняя транзакция  
if @@trancount > 0 
 rollback;        -- внешняя транзакция 
select   (select AUDITORIUM from AUDITORIUM a where a.AUDITORIUM_NAME = '103-5') 'Аудитория', 
(select AUDITORIUM_TYPENAME from AUDITORIUM_TYPE a where a.AUDITORIUM_TYPENAME = 'ЛК') 'Тип'; 
go
