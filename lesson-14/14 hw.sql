--Homework for recursive cte. Find the hierarchial level of people

create table PostDef(postid int, definition varchar(25))
insert into PostDef values (0, 'Director'), (1, 'Deputy Director'), (2, 'Executive Director'), (3, 'Department head'), 
              (4, 'Manager'), (5, 'Senior officer'), (6, 'Junior Officer'), (7, 'Intern')

create table Hierarchy(id int, name varchar(100), manager_id int, manager varchar(100))

insert into Hierarchy values 
(150, 'John Ryden', 111, 'Jack Tarkowski'),
(165, 'Sara Miller', 111, 'Jack Tarkowski'), 
(180, 'Rebecca Carson', 211, 'Thomas Kim'), 
(107, 'Sean Sullivan', 180, 'Rebecca Carson'), 
(142, 'Floyd Kan', 122, 'Alex Pereira'), 
(122, 'Alex Pereira', 107, 'Sean Sullivan'), 
(111, 'Jack Tarkowski', 107, 'Sean Sullivan'), 
(211, 'Thomas Kim', 191, 'Nicolas Jackson'), 
(177, 'Michael Rim', Null, Null), 
(191, 'Nicolas Jackson', 177, 'Michael Rim')


WITH EmployeeHierarchy AS (
SELECT h.id, h.name, h.manager_id, h.manager, 0 as hierarchy_level FROM Hierarchy h
WHERE h.manager_id IS NULL

UNION ALL
SELECT h.id, h.name, h.manager_id, h.manager, eh.hierarchy_level + 1 FROM Hierarchy h
JOIN EmployeeHierarchy eh ON h.manager_id = eh.id)

SELECT eh.id, eh.name, eh.manager_id, h.manager, pd.definition
FROM EmployeeHierarchy eh
LEFT JOIN Hierarchy h ON eh.manager_id = h.id  
LEFT JOIN PostDef pd ON eh.manager_id = pd.postid
ORDER BY eh.hierarchy_level, eh.id;

