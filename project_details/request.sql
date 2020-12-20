use eis_example;

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[UserRole]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table UserRole (
role_id int primary key identity(1,1),
role_name varchar(15) not null);

go 

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[TaskType]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table TaskType(
task_type_id int primary key identity(1,1),
task_type_name varchar(30) not null);

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[Classroom]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table Classroom(
room_id int primary key identity(1,1),
room_name varchar(5) not null);

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[LessonType]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table LessonType(
lesson_type_id int primary key identity(1,1),
lesson_type_name varchar(15) not null);

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[Discipline]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table Discipline(
discipline_id int primary key identity(1,1),
discipline_name varchar(30) not null);

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[TaskStatus]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table TaskStatus(
task_status_id int primary key identity(1,1),
status_name varchar(15) not null);

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[Users]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table Users(
userid int primary key identity(1,1),
fullname varchar(50) not null,
email varchar(255) not null,
username varchar(30) not null,
pass varchar(30) not null,
role_id int not null,
photo varchar(255) not null,
foreign key (role_id) references UserRole(role_id));

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[Departments]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table Departments(
department_id int primary key identity(1,1),
department_name varchar(50) not null,
parent_dep_id int);

go 

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[Groups]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table Groups(
group_id int primary key identity(1,1),
group_name varchar(10) not null,
course int not null,
department_id int not null,
foreign key (department_id) references Departments(department_id));

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[Student]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table Student(
student_id int primary key identity(1,1),
userid int not null,
group_id int not null,
foreign key (userid) references Users(userid),
foreign key (group_id) references Groups(group_id));

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[Employee]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table Employee(
employee_id int primary key identity(1,1),
userid int not null,
department_id int not null,
foreign key (userid) references Users(userid),
foreign key (department_id) references Departments(department_id));

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[Lesson]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table Lesson(
lesson_id int primary key identity(1,1),
discipline_id int not null,
lesson_type_id int not null,
room_id int not null,
start_time datetime not null,
end_time datetime not null,
foreign key (discipline_id) references Discipline(discipline_id),
foreign key (lesson_type_id) references LessonType(lesson_type_id),
foreign key (room_id) references Classroom(room_id));

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[LessonGroup]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table LessonGroup(
lesson_group_id int primary key identity(1,1),
group_id int not null,
lesson_id int not null,
foreign key (group_id) references Groups(group_id),
foreign key (lesson_id) references Lesson(lesson_id));

go

if (not exists(select 1 from sysobjects where id = object_id(N'[dbo].[Task]') and OBJECTPROPERTY(id,N'IsUserTable')=1))

create table Task(
task_id int primary key identity(1,1),
task_type_id int not null,
status_id int not null,
task_name varchar(100) not null,
author_id int not null,
performer_id int not null,
foreign key (task_type_id) references TaskType(task_type_id),
foreign key (status_id) references TaskStatus(task_status_id),
foreign key (author_id) references Employee(employee_id),
foreign key (performer_id) references Employee(employee_id));

go

create index discipline_IX on Lesson(discipline_id);

create index lesson_type_IX on Lesson(lesson_type_id);

create index room_id_IX on Lesson(lesson_type_id);

create index lesson_group_id_IX on LessonGroup(group_id);

create index lesson_lesson_id_IX on LessonGroup(lesson_id);

create index student_group_id_IX on Student(group_id);

create index performer_id_IX on Task(performer_id);

create index student_user_IX on Student(userid);

create index employee_user_IX on Employee(userid);

go