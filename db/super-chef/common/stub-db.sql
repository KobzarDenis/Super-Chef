-- Create banks
delete from bookkeeping.banks;
insert into bookkeeping.banks values
	(default, 'PrivatBank', '4567344295080587253409579508', 'GB29NWBK60161331926825', 'GB29NWBK601613736474'),
	(default, 'OTPBank', '8567344295080587253409579508', 'CH9300762011623852957', 'CH930076201162385239484'),
	(default, 'InvestBank', '0987344295080587253409579508', 'NL91ABNA0417164299', 'NL91ABNA0417164893748'),
	(default, 'BNP', '2916344295080587253409579508', 'HU42117730161111101800000000', 'HU42117730161111101883758375');

-- Create transaction statuses
delete from bookkeeping."transactionStatuses";
insert into bookkeeping."transactionStatuses" values
	(default, 'Created', 'When transaction is only created but not in process'),
	(default, 'Canceled', 'When transaction is canceled'),
	(default, 'In-Process', 'When transaction in process already'),
	(default, 'Success', 'When transaction is successfull');

-- Create transaction types
delete from bookkeeping."transactionTypes";
insert into bookkeeping."transactionTypes" values
	(default, 'Salary', 'Pay salary'),
	(default, 'Order-Food', 'Food orders'),
	(default, 'Earnings', 'Earnings from service');

-- Create accounts
delete from bookkeeping.accounts;
insert into bookkeeping.accounts values
	(default, '41490000000000000001', (select id from bookkeeping.banks where name='PrivatBank'), true, (select CURRENT_TIMESTAMP), (select CURRENT_TIMESTAMP)),
	(default, '41490000000000000002', (select id from bookkeeping.banks where name='PrivatBank'), true, (select CURRENT_TIMESTAMP), (select CURRENT_TIMESTAMP)),
	(default, '41490000000000000003', (select id from bookkeeping.banks where name='OTPBank'), true, (select CURRENT_TIMESTAMP), (select CURRENT_TIMESTAMP)),
	(default, '41490000000000000004', (select id from bookkeeping.banks where name='InvestBank'), true, (select CURRENT_TIMESTAMP), (select CURRENT_TIMESTAMP)),
	(default, '41490000000000000005', (select id from bookkeeping.banks where name='BNP'), true, (select CURRENT_TIMESTAMP), (select CURRENT_TIMESTAMP));


-- Create employee roles
delete from personal."employeeRoles";
insert into personal."employeeRoles" values
	(default, 'Manager', 'Responsible for service and personal, stock and orders'),
	(default, 'Waiter', 'Responsible for client'),
	(default, 'Accountant', 'Responsible for accounts and payslips');

-- Create employee roles
delete from personal.employees;
insert into personal.employees values
	(default, 'Mark', 'Ivanov', '456431', (select id from bookkeeping.accounts where number='41490000000000000001'), 'AO', '12345', 'male', 500, 'Pantilieva st. 49/20', '+380948765646', 'mark@gmail.com', (select id from personal."employeeRoles" where name='Manager'), (select CURRENT_TIMESTAMP)),
	(default, 'Alla', 'Carlova', '456432', (select id from bookkeeping.accounts where number='41490000000000000002'), 'AO', '12346', 'female', 700, 'Kutuzovsiy avn. 34/97', '+380948765647', 'alla@gmail.com', (select id from personal."employeeRoles" where name='Accountant'), (select CURRENT_TIMESTAMP)),
	(default, 'Anton', 'Buhaev', '456433', (select id from bookkeeping.accounts where number='41490000000000000003'), 'AO', '12347', 'male', 300, 'Pladina st. 11/40', '+380948765648', 'anton@gmail.com', (select id from personal."employeeRoles" where name='Waiter'), (select CURRENT_TIMESTAMP));

-- Create product groups
delete from stock."productGroups";
insert into stock."productGroups" values
	(default, 'Fish'),
	(default, 'Meat'),
	(default, 'Fruit'),
	(default, 'Vegetable');

-- Create product groups
delete from stock.products;
insert into stock.products values
	(default, 'Catfish', 40, 'prd1-ct11', (select id from stock."productGroups" where name='Fish'), 3),
	(default, 'Salmon', 30, 'prd2-ct11', (select id from stock."productGroups" where name='Fish'), 3),
	(default, 'Crucian carp', 20, 'prd3-ct11', (select id from stock."productGroups" where name='Fish'), 3),
	(default, 'Red caviar', 2, 'prd4-ct11', (select id from stock."productGroups" where name='Fish'), 2),
	(default, 'Black caviar', 1, 'prd5-ct11', (select id from stock."productGroups" where name='Fish'), 5),
	(default, 'Beef steaks', 2, 'prd6-ct22', (select id from stock."productGroups" where name='Meat'), 2),
	(default, 'Pork steaks', 2, 'prd7-ct22', (select id from stock."productGroups" where name='Meat'), 2),
	(default, 'Pig legs', 2, 'prd8-ct22', (select id from stock."productGroups" where name='Meat'), 2),
	(default, 'Beef legs', 2, 'prd9-ct22', (select id from stock."productGroups" where name='Meat'), 2),
	(default, 'Orange', 2, 'prd10-ct11', (select id from stock."productGroups" where name='Fruit'), 0.5),
	(default, 'Tangerine', 2, 'prd11-ct11', (select id from stock."productGroups" where name='Fruit'), 0.2),
	(default, 'Apple', 2, 'prd12-ct11', (select id from stock."productGroups" where name='Fruit'), 0.1),
	(default, 'Banana', 2, 'prd13-ct11', (select id from stock."productGroups" where name='Fruit'), 0.1),
	(default, 'Cherry', 2, 'prd14-ct11', (select id from stock."productGroups" where name='Fruit'), 0.2),
	(default, 'Potato', 15, 'prd15-ct22', (select id from stock."productGroups" where name='Vegetable'), 0.1),
	(default, 'Cucumber', 15, 'prd16-ct22', (select id from stock."productGroups" where name='Vegetable'), 0.2),
	(default, 'Cherry tomato', 10, 'prd17-ct22', (select id from stock."productGroups" where name='Vegetable'), 0.3),
	(default, 'Tomato', 20, 'prd18-ct22', (select id from stock."productGroups" where name='Vegetable'), 0.4),
	(default, 'Korean cabbage', 10, 'prd19-ct22', (select id from stock."productGroups" where name='Vegetable'), 0.1),
	(default, 'White cabbage', 20, 'prd20-ct22', (select id from stock."productGroups" where name='Vegetable'), 0.2);

-- Create caterers
delete from stock.caterers;
insert into stock.caterers values
	(default, 'ct-11', 'Fish&Fruits', 'Kiev, Panelnaya st. 67', '+380948765645', null, null, (select id from bookkeeping.accounts where number='41490000000000000004'), (select CURRENT_TIMESTAMP), (select CURRENT_TIMESTAMP)),
	(default, 'ct-22', 'MeetVeg.Co', 'Lutsk, Goldovaya st. 73', '+380948765649', null, null, (select id from bookkeeping.accounts where number='41490000000000000005'), (select CURRENT_TIMESTAMP), (select CURRENT_TIMESTAMP));