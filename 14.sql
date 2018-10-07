use TMPV_UNIVER
drop procedure Psubject

go
create PROCEDURE Psubject
as begin
declare @k int = (select count(*) from SUBJECT)
select* from SUBJECT
return @k
end

    EXEC @k=Psubject;    -- вызов процедуры 
    print 'кол-во предметов = '+cast(@k as varchar(3));

	go
alter procedure Psubject
@p nvarchar(20),
@c int output
as begin
(select s.[SUBJECT],s.SUBJECT_NAME,s.PULPIT 
	from [SUBJECT] s where s.PULPIT=@p);
	set @c = (select count(*) from [SUBJECT] s 
	where s.PULPIT=@p)
	return (select count(*) from [SUBJECT])
end;

declare @k int =0,@r int=0,@p varchar(20)='ИСиТ';
exec @k=PSUBJECT @p, @c = @r output; 
print 'кол-во предметов всего = '+cast(@k as varchar(20));
print 'кол-во предметов на кафедре '+cast(@p as varchar(20))+'= '+cast(@r as varchar(20));
go

alter procedure PSUBJECT
	@p varchar(20)
as begin
declare @k int = (select count(*) from [SUBJECT])
select s.[SUBJECT],s.SUBJECT_NAME,s.PULPIT from [SUBJECT] s where s.PULPIT=@p
end
create table #SUBJECT
( a char(10) primary key,b varchar(100),c char(20));
insert #SUBJECT exec PSUBJECT @p = 'ИСиТ';
select * from #SUBJECT go

create procedure PAUDITORIUM_INSERT 
	@a char(20),
	@n varchar(50),
	@c int = 0,
	@t char(10) 
as begin
	declare @rc int = 1 
	begin try
		insert into AUDITORIUM(AUDITORIUM,
		AUDITORIUM_NAME, AUDITORIUM_CAPACITY,
		AUDITORIUM_TYPE) values
		(@a,@n,@c,@t)
		return @rc;
	end try
	begin catch
		print 'номер ошибки  : ' + cast(error_number() as varchar(6));
		print 'сообщение     : ' + error_message();
		print 'уровень       : ' + cast(error_severity()  as varchar(6));
		return -1;
	end  catch;
 end;

 declare @rc int;
 exec @rc=PAUDITORIUM_INSERT @a='101-3',@n = '109-1',
 @c=100,@t='ЛК';
 print 'код ошибки : ' + cast(@rc as varchar(3)); 	
 go

 create procedure SUBJECT_REPORT
	@p char(10)
 as begin 
	declare @s char(10),@str char(300)='';
	declare @rc int =0;
	begin try
		if not exists (select s.[SUBJECT]
		from [SUBJECT] s where s.PULPIT=@p)
			raiserror('ошибка в параметрах',11,1);
		else
			begin 
				declare CSUB cursor for
				select s.[SUBJECT]
				from [SUBJECT] s where s.PULPIT=@p;
				open CSUB;
				fetch CSUB into @s;
				print 'Предметы: ';
				while @@FETCH_STATUS=0
					 begin
						set @str = rtrim(@s)+','+@str;
						set @rc = @rc +1;
						fetch CSUB into @s;
					 end
				print @str;
				close CSUB;
				return @rc;
			end
	end try
	begin catch
		print 'ошибка в параметрах' 
		if error_procedure() is not null   
		print 'имя процедуры : ' + error_procedure();
		return @rc;
	end catch
 end

 declare @rc int=0;
 exec @rc=SUBJECT_REPORT @p='ИСиТ'
 print 'количество предметов = ' + cast(@rc as varchar(3)); 
 go





 

 create procedure PAUDITORIUM_INSERTX
	@a char(20),
	@n varchar(50),
	@c int = 0,
	@t char(10),
	@tn varchar(50)
as begin
	declare @rc int;
	begin try
		set transaction isolation level SERIALIZABLE;     
		begin tran;     
		insert into AUDITORIUM_TYPE(AUDITORIUM_TYPE,AUDITORIUM_TYPENAME) values (@t,@tn);
		exec @rc = PAUDITORIUM_INSERT @a,@n,@c,@t;
		commit tran;
		return @rc;
	end try
	begin catch
		print 'номер ошибки  : ' + cast(error_number() as varchar(6));
		print 'сообщение     : ' + error_message();
		print 'уровень       : ' + cast(error_severity()  as varchar(6));
		rollback tran;
		return -1;
	end  catch;
end

 delete AUDITORIUM where AUDITORIUM_TYPE = 'ЛК-MY'
 delete AUDITORIUM_TYPE where AUDITORIUM_TYPE = 'ЛК-MY'
 declare @rc int;
 exec @rc=PAUDITORIUM_INSERTX @a='1111-3',@n = '1119-1', @c=100, @t='ЛК-MY', @tn = 'myAud';
 print 'код ошибки : ' + cast(@rc as varchar(3)); 	
 go





