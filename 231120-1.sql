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
    AND A.OrderID = '��1' -- ���⼭ '��1'�� Ls_OrderID ������ ���̶�� �����մϴ�.
    AND A.OutID = ��2 -- ���⼭ ��2�� Li_OutID ������ ���̶�� �����մϴ�.
    AND A.OrderID = C.OrderID 
    AND A.RollID *= C.Rollid
GROUP BY 
    A.ColorID, B.Color, B.DesignNo, A.BoxNo
ORDER BY 
    A.BoxNo, A.ColorID, B.Color