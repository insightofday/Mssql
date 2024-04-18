

 SELECT A.OutSeq, A.RollID, A.OutQty, A.ColorID, B.Color, B.DesignNO, A.LotNO, A.BoxNO, c.lossqty, c.rollno,C.GradeClss,C.ctrlQty + LossQty as Gross
          , D.Kdefect,Case When charindex( '-',A.LotNO)> 0  then left(A.LotNO,charindex( '-',A.LotNO)-1) else A.LotNO end  LotSort 
 FROM DS27 A, DS21 B, DS24 c, DS04 d
 WHERE A.OrderID = B.OrderID AND cast(A.ColorID as int) = cast(B.ColorID as int) AND A.OrderID = '202304023' AND A.OutID = 7
       and a.orderid =  c.orderid and a.rollid=c.rollid
       and C.DefectID *=D.DefectID
 ORDER BY len(A.LotNo),A.LotNo,A.BoxNO, A.ColorID,  A.OutSeq


 SELECT A.OutSeq, A.RollID, A.OutQty, A.ColorID, B.Color, B.DesignNO, A.LotNO, A.BoxNO, 0 lossqty, '' rollno,'' GradeClss, 0 as Gross
 FROM DS27 A, DS21 B
 WHERE A.OrderID = B.OrderID AND cast(A.ColorID as int) = cast(B.ColorID as int) AND A.OrderID = '202304024' AND A.OutID = 15
 ORDER BY len(A.LotNo),A.LotNo,A.BoxNO, A.ColorID,  A.OutSeq

