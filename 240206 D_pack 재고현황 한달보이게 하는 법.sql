
 select c.kcustom, a.orderid, a.orderno, b.article, e.color, case a.unitclss when 0 then 'Y' when 1 then 'M' WHen 2 Then '��' WHen 3 Then '��' end  unit, 
       sum(f.stuffroll)inroll, sum(f.stuffqty)inqty, sum(f.outroll)outroll, sum(f.outqty)outqty, '' �������, '' ������ --, f.StuffDate
 from ds20 a inner join [ds01] as b on a.ArticleID = b.ArticleID --ǰ��
             inner join [ds02] as c on a.CustomID = c.CustomID	--�ŷ�ó��
             inner join [ds21] as e on a.orderid = e.orderid,	--���ֻ�
             ( SELECT OrderID, OrderSeq, SUM(stuffroll) AS StuffRoll , SUM(StuffQty) AS StuffQty, 0 outroll, 0 outqty 
               From ( SELECT  orderid, orderseq, StuffRoll, Stuffqty FROM    ds23   WHERE StuffDate BETWEEN '20240101'  AND '20240103') AS z	--�԰��     WHERE StuffDate BETWEEN '20240101'  AND '20240126'
               GROUP BY OrderID, OrderSeq 
               union
               SELECT OrderID, orderseq, 0 stuffroll, 0 stuffqty, SUM(OutRoll) AS outRoll, SUM(OutQty) OutQty
               From 
                    ( select z.OrderID,z.outCustom,z.outdate,z.Remark,y.orderseq,y.Noutqty as OutQty, case when nOutQty < 0 then -1 else 1 end OutRoll 
                      from  [ds26] as z inner join [ds27] as y on z.orderid = y.orderid and z.outseq = y.OutSeq ) AS a 
						   --���					����
				WHERE outdate BETWEEN '20240101'  AND '20240103'
               GROUP BY OrderID, OrderSeq 
            ) f 
 where e.orderid=f.orderid and e.orderseq=f.orderseq 
 AND a.CustomID = '0065'
 group by c.kcustom, a.orderid, a.orderno, b.article, e.color, a.unitclss


