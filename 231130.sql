select A.OrderID, A.OrderNo, A.CustomID, B.OrderSeq, B.Color, D.LotNo, SUM(D.InRoll) AS InRoll, SUM(D.Qty) AS InQty
from [order] AS A
LEFT JOIN [OrderColor] AS B ON A.OrderID = B.OrderID
LEFT JOIN [StuffINReturn] AS D ON B.OrderID = D.OrderID AND B.OrderSeq = D.OrderSeq
WHERE A.OrderID = '2023030001' AND B.OrderSeq <> 0
GROUP BY A.OrderID, A.OrderNo, A.CustomID, B.OrderSeq, B.Color, D.LotNo
ORDER BY A.OrderID, B.OrderSeq

