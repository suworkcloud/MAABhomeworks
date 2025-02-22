CREATE TABLE #Consecutives
(
     Id VARCHAR(5)  
    ,Vals INT /* Value can be 0 or 1 */
)
GO
 
INSERT INTO #Consecutives VALUES
('a', 1),
('a', 0),
('a', 1),
('a', 1),
('a', 1),
('a', 0),
('b', 1),
('b', 1),
('b', 0),
('b', 1),
('b', 0)


with cte as
(select *,
count(id) over(partition by id)+1 as Nextonorder,
row_number() over(order by id) as rownumber
from #Consecutives),
abc as (select *,cte.rownumber - lag(cte.rownumber) over(order by (select null)) as asd from cte
where cte.vals = 1)
select abc.id,abc.nextonorder, count(abc.id)+1 as maxnum from abc
where asd = 1
group by abc.id,abc.nextonorder
order by abc.id