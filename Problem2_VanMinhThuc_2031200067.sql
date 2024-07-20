create database Problem2;
use Problem2;

create table employees(
employeeID varchar (3) ,
lastName varchar(20) not null,
middleName varchar(20) ,
firstName varchar(20) not null,
dateOfBirth date not null,
gender varchar(5) not null,
salary int not null,
address varchar(100) not null,
managerID varchar(3),
departmentID int,
primary key (employeeID)
);

create table department (
departmentID int,
departmentName varchar(10) not null,
managerID varchar(3),
dateOfEmployyment date not null,
foreign key(managerID) references employees (employeeID),
primary key(departmentID)
);

create table departmentaddress (
departmentID int,
address varchar(30),
primary key(departmentID,address),
foreign key(departmentID) references department(departmentID)
);

create table project(
projectID int,
projectName varchar(30) not null,
projectAddres varchar(100) not null,
departmentID int,
primary key (projectID),
foreign key (departmentID) references department (departmentID)
);

create table assignment(
employeeID varchar (3) ,
projectID int,
workingHour float,
primary key(employeeID,projectID),
foreign key(employeeID) references employees(employeeID)
);

create table relative(
employeeID varchar(3),
relativeName varchar(50),
gender varchar(5) not null,
dateOfBirth date not null,
relationship varchar(30) not null,
primary key(employeeID, relativeName),
foreign key (employeeID) references employees (employeeID)
); 

insert into employees
values ('123','Dinh','Ba','Tien','1995-1-9','Nam','30000','731 Tran Hung Dao Q1 TPHCM', '333','5'),
('333','Nguyen','Thanh','Tung','1945-12-8','Nam','40000','638 Nguyen Van Cu Q5 TPHCM', '888','5'),
('453','Tran','Thanh','Tam','1962-7-31','Nam','25000','543 Mai Thi Luu Ba Dinh Ha Noi','333','5'),
('666','Nguyen','Manh','Hung','1952-9-15','Nam','38000','','333','5'),
('777','Tran','Hong','Quang','1959-3-29','Nam','25000','980 Le Hong Phong Vung Tau','987','4'),
('888','Vuong','Ngoc','Quyen','1927-10-10','Nu','55000','450 Trung Vuong My Tho TG','','1'),
('987','Le','Thi','Nhan','1931-6-20','Nu','43000','291 Ho Van Hue Q.PN TPHCM','888','4'),
('999','Bui','Thuy','Vu','1958-7-19','Nam','25000','332 Nguyen Thai Hoc Quy Nhon','987','4');

insert into department
values ('1','Quan ly','888','1971-06-19'),
('4','Dieu hanh','777','1985-01-01'),
('5','Nghien cuu','333','1978-05-22');

insert into departmentaddress
values ('1','TP HCM'),
('4','HA NOI'),
('5','NHA TRANG'),
('5', 'TP HCM'),
('5', 'VUNG TAU');

INSERT INTO PROJECT
VALUES ('1','San pham X','Vung Tau','5'),
('2','San pham Y','', '5'),
('3','San pham Z','TP HCM','5'),
('10','Tin hoc hoa','HA NOI','4'),
('20','Cap Quang','TP HCM','1'),
('30','Dao tao','HA NOI','4');

insert into assignment
values ('123','1','22.5'),
('123','2','7.5'),
('123','3','10.0'),
('333','10','10.0'),
('333','20','10.0'),
('453','1','20.0'),
('453','2','20.0'),
('666','3','40.0'),
('888','20','0.0'),
('987','20','15.0');

insert into relative
values ('123','Chau','Nu','1978-12-31','Con gai'),
('123','Duy','Nam','1978-01-01','Con trai'),
('123','Phuong','Nu','1957-05-05','Vo chong'),
('333','Duong','Nu','1948-05-03','Vo chong'),
('333','Quang','Nu','1976-04-05','Con gai'),
('333','Tung','Nam','1973-10-25','Con trai'),
('987','Dang','Nam','1932-02-29','Vo chong');


alter table employees add foreign key employees (departmentID) references department(departmentID);
alter table employees add foreign key employees (managerID) references employees(employeeID);

select * from employees where managerid not in ( select employeeid from employees);
update employees set managerId = NULL where employeeid = 888;










