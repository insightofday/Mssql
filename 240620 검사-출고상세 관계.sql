select *
from inspect AS A
left join outwaresub AS B ON A.OrderID = B.OrderID AND A.RollID = B.RollID
where A.orderid = '202406102'
and A.colorid = '004'
and A.CheckOut = '1'
AND B.OrderID IS NULL

update inspect set
checkout = '0'
FROM inspect AS A
LEFT JOIN Outwaresub AS B On A.OrderID = B.OrderID AND A.RollID = B.RollID
WHERE A.OrderID = '202406102'
AND A.ColorID = '004'
AND A.CheckOut = '1'
AND B.OrderID IS NULL


select *
from outwaresub AS A
where a.orderid = '202406102'
and A.rollid = 16