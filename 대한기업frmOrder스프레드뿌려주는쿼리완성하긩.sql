
SELECT A.OrderID '������ȣ', A.OrderNo, B.KCustom '�ŷ�ó', C.Article 'ǰ��', D.WorkName '��������', E.Aid '��������', F.Pattern '��������'
	,G.StuffWidth '������???stuffWidth�������ؾ��ϴµ�����Į������', A.ChunkRate '����(�پ�����)' , A.WorkWeight '�߷�', A.DvlyPlace '���ó', A.AcptDate '��������', A.RequestDate '��û����',
	A.DvlyDate 'ȸ������',A.AvgUnitPrice '�ܰ�', A.PriceClss '����', A.OrderQty '���ּ���', A.OrderClss '����', A.ColorCnt '�����', 
	A.RollFlag '����????�ƴѰͰ�ư��<�ƴѰŸ��� ���ǿ� ���� ���ڸ� �Է��ϴ� ���μ���'
FROM [Order] AS A
LEFT JOIN [mt_Custom] B ON A.CustomID = B.CustomID --��¸���
LEFT JOIN [mt_Article] C ON A.ArticleID = C.ArticleID --Article,MArticleID,HArticle,ThreadID,StuffWidthID,DyeingID,ArticleGrpId,Weight,UseClss,InptUser,InptDate,UpdtUser,UpdtDate
LEFT JOIN [mt_Work] D ON A.WorkID = D.WorkID --WokrName,UseClss,InptUser,InptDate,UpdtUser,UpdtDate
LEFT JOIN [mt_Aid] E ON A.AidID = E.AidID --Aid,UseClss,InptUser,InptDate,UpdtUser,UpdtDate
LEFT JOIN [mt_Pattern] F ON A.PatternID = F.PatternID --Pattern,WorkId,PatternGrpID,UseClss,InptUser,InptDate,UpdtUser,UpdtDate
LEFT JOIN [mt_StuffWidth] G ON A.StuffWidth = G.StuffWidth
--WHERE A.OrderID = '2023010038'

--select * from [Order] where OrderID = '2023050001'
--select * from mt_StuffWidth
--����:machine, work
--����:process

--DS_ProcessHP�� remark�� ���������ε�?
