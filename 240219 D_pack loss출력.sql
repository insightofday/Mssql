
  select b.designno, b.color, sum(a.boxcount)box, sum(a.outroll)roll, sum(a.outqty)outqty, sum(a.rqty)rqty, (sum(a.rqty)-sum(a.outqty))bqty, a.orderseq, b.orderid, a.loss
  from( 
         SELECT  a.orderseq, 0 boxcount, SUM(a.OutRoll)OutRoll, SUM(a.OutQty)OutQty, 0 rqty , SUM(a.loss) loss FROM ds27 AS a 
         WHERE a.OrderID = '2023120119' AND a.OutSeq=2
         GROUP BY a.orderseq 
         union
         select a.orderseq, count(a.boxno) boxCount, 0 outroll, 0 outqty, 0 rqty , 0 loss
         from (select orderseq, boxno from ds27 WHERE OutSeq=2 and OrderID = '2023120119' group by orderseq, boxno) a 
         group by a.orderseq 
         union 
         SELECT  b.orderseq, 0 boxcount, 0 OutRoll, 0 OutQty, isnull((b.colorqty - a.outqty),b.colorqty) rqty , 0 loss
         FROM ds21 b left join 
                                ( select sum(a.outqty) outqty, a.orderseq from ds27 a, ds26 b
                                  where a.orderid=b.orderid and a.outseq=b.outseq and a.OrderID = '2023120119' and a.outseq<>2 and b.outdate < '20240206'  
                                  group by a.orderseq) a on a.orderseq=b.orderseq 
         where b.orderseq>0 and b.orderid='2023120119' 
         GROUP BY b.orderseq, b.colorqty, a.outqty 
        ) a, ds21 b 
  where b.orderseq>0 and a.orderseq=b.orderseq and orderid='2023120119' 
  group by a.orderseq, b.color, b.designno, b.orderid , a.loss


  select * from ds21 order by setdate desc
