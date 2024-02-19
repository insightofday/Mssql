     SELECT B.Color + CASE WHEN Rtrim(B.DesignNO)<>''THEN ' ('+ B.DesignNO +')' ELSE '' END Color ,
            A.BoxName, A.BoxNo, A.LotNo, A.RollNo,   A.OutQty,  ROUND(((A.OutQty)*C.UnitPerWeight) ,2) GrossWeight,   A.OrderSeq             
     FROM [DS27] A, [DS21]B, [DS26] C                                                              
     Where a.OrderID = B.OrderID And a.OrderSeq = B.OrderSeq 
     AND A.OrderID = C.OrderID AND A.OutSeq = C.OutSeq 
     AND A.OrderID = '2024010003'
     AND A.OutSeq = 1
     ORDER BY A.OrderSeq, A.BoxName, A.BoxNo, LEN(A.LotNO), A.LotNo, A.OutSubSeq 


	 select * from ds27
	 select * from ds21
	 select * from ds26-- where lossQty<>0

     SELECT B.Color + CASE WHEN Rtrim(B.DesignNO)<>''THEN ' ('+ B.DesignNO +')' ELSE '' END Color ,
            A.BoxName, A.BoxNo, A.LotNo, A.RollNo,   A.OutQty,  ROUND(((A.OutQty)*C.UnitPerWeight) ,2) GrossWeight,C.lossQty ,  A.OrderSeq             
     FROM [DS27] A, [DS21]B, [DS26] C                                                              
     Where a.OrderID = B.OrderID And a.OrderSeq = B.OrderSeq 
     AND A.OrderID = C.OrderID AND A.OutSeq = C.OutSeq 
     AND A.OrderID = '2024010090'
     AND A.OutSeq = 1
     ORDER BY A.OrderSeq, A.BoxName, A.BoxNo, LEN(A.LotNO), A.LotNo, A.OutSubSeq 


	 select * from ds27
	 select * from ds26