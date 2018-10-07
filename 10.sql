declare @num_1 char
declare @num_2 varchar,
 @num_3 datetime = getdate(),
 @num_4 time,
 @num_5 int = 12,
 @num_6 smallint = 1,
 @num_7 numeric(12,5)
 set @num_1 = 'D'
 set @num_2='AA'
 set @num_7= RAND(156)
 select @num_1,@num_2,@num_3,@num_4,@num_5
 select @num_7
 select @@version as [version],  @@ROWCOUNT as [row]

 print 'num_1= '+ cast(@num_1 as varchar(10))
 