
 Select a.FileNo, a.Seqno, a.OrderID, a.CardNo, A.WorkQty, A.Spec,
b.KCustom
,c.Article
,D.Color, d.orderseq 
,F.PatternChart, F.PatternID
 from 
 [dt_Card] as a, 
 [MT_CUSTOM] as b,
 [mt_article] as c,
 [ORDERCOLOR] AS D, 
 [PT_Ready] as E, 
 [dt_processPattern] as F 
 where a.FileNO = 'CF-2404-1027' and A.SeqNo = '01'
 and a.Buyerid = b.customid 
 and a.Articleid = c.articleid 
 and A.COLORSEQ = D.ORDERSEQ 
 and A.OrderId = D.OrderID
And A.FILENO = E.FILENO
 and A.SEQNO = E.CARDSEQ
 and A.PatternID = F.PatternID


 select * from dt_Card where fileno='CF-2404-1027' and SeqNo = '01'
 
 select * from dt_processpattern

 update dt_card set patternid='1MB' where  fileno='CF-2404-1027' and SeqNo = '01'

 select * from pt_ready where fileno='CF-2404-1027'and cardseq='01'

 select * from [dt_processPattern] where patternid='JS'

