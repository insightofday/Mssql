
     SELECT A.OrderSeq, B.Color, B.DesignNo, A.BoxNo, A.LotNo, A.OutQty, COUNT(A.OutQty) AS OutCnt, A.OutRoll, A.Rollseq, A.OutSubSeq,    A.loss,          
            c.StuffWeight , A.Boxname, A.RollNo, 
            ROUND((A.OutQty*D.UnitPerWeight),2) NetWeight,   
            ROUND(((A.OutQty)*D.UnitPerWeight),2) GrossWeight 
     FROM [DS27] A, [DS21]B, [ds24] c, ds26 D, DS20 E            
     Where a.OrderID = B.OrderID And a.OrderSeq = B.OrderSeq     
       AND a.OrderID = D.OrderID AND A.OutSeq = D.OutSeq         
       AND A.Orderid=E.OrderID                                   
       AND a.OrderID *= c.OrderID AND a.RollSeq *= c.RollSeq     
       AND A.OrderID = '2017050193'                        
       AND A.OutSeq = 2                            
     GROUP BY A.OrderSeq, B.Color, B.DesignNo, A.BoxNo, A.LotNo, A.OutQty, A.OutRoll, A.Rollseq, A.OutSubSeq, c.RollNo, c.StuffWeight    
             ,A.Boxname, A.RollNo, D.UnitPerWeight, D.OtherWeight, E.UnitClss  ,a.loss   
     ORDER BY A.BoxName, A.BoxNo, B.Color, A.OrderSeq, LEN(A.LotNO), A.LotNo, A.OutSubSeq 


