select * 
from [Order] where OrderID = '2023110002'

select * 
from [OrderColor] where OrderID = '2023110002'




SELECT  
    A.ColorID, B.Color, 
    SUM(A.OutQty) AS OutQty, 
    COUNT(A.RollID) AS RollCnt,
    A.BoxNo,
    ISNULL(SUM(C.ctrlQty + c.LossQty), 0) AS Gross,
    ISNULL(SUM(LossQty), 0) AS LossQty,
    A.BoxNo,
    B.DesignNo,
    ISNULL(MAX(A.WgtPerBox), 0) AS WgtPerBox
FROM 
    DS27 A, DS21 B, DS24 AS C
WHERE  
    A.OrderID = B.OrderID 
    AND A.ColorID = B.ColorID
    AND A.OrderID = '값1' -- 여기서 '값1'은 Ls_OrderID 변수의 값이라고 가정합니다.
    AND A.OutID = 값2 -- 여기서 값2는 Li_OutID 변수의 값이라고 가정합니다.
    AND A.OrderID = C.OrderID 
    AND A.RollID *= C.Rollid
GROUP BY 
    A.ColorID, B.Color, B.DesignNo, A.BoxNo
ORDER BY 
    A.BoxNo, A.ColorID, B.Color