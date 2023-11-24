
  SELECT  A.BOXNO, B.Color, '' tGrossQty, B.WeightUnit, '' tLossQty, 1 RollCnt, c.Rollno, a.LotNo,
        C.ctrlQty +c.LossQty GrossQty, C.ctrlQty NetQty, LossQty,
        GradeClss, ((C.ctrlQty + C.LossQty) * B.WeightUnit) + D.VinylWeight AS Weight, '' extra1, A.OrderID, A.ColorID, 1 InsClss
 FROM DS27 A, DS21 B , DS24 AS C, DS20 AS D
 Where A.OrderID = B.OrderID And A.ColorID = B.ColorID
 AND A.OrderID = '202305104' AND A.OutID = 1                                     
 AND A.OrderID = C.OrderID AND A.RollID = C.Rollid
 AND B.OrderID = D.OrderID
 ORDER BY A.BoxNo, A.colorID, A.RollID, B.Color


