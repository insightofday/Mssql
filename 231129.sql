SELECT A.CustomID,E.KCustom,F.Article,A.OrderID,A.OrderNo,G.WorkName, A.OrderSeq, A.DesignNo,A.Color,A.ColorQty 
       ,A.UnitClss, B.InsDate, B.LotNo, B.InsRoll,B.InsQty, B.InsWgt, B.OutRoll,B.OutQty, B.OutWgt, B.DefectRoll, B.DefectQty, B.DefectWgt        
FROM 
     (SELECT A.AcptDate,A.OrderID,A.OrderNo,A.CustomID,B.ArticleID,B.OrderSeq,B.DesignNo,B.Color,B.ColorQty,A.UnitClss,A.WorkId,A.WorkWidth, B.Sort 
        FROM [order] A 
       INNER JOIN [OrderColor] B on A.OrderID = B.OrderID 
       WHERE b.OrderSeq > 0) As A 
LEFT JOIN 
      (SELECT W.OrderID, W.OrderSeq, MAX(W.InsDate) AS InsDate, W.LotNo, SUM(W.OutRoll) As OutRoll,Sum(W.OutQty) As OutQty, SUM(W.OutWgt)OutWgt,
              SUM(W.InsQty)InsQty, SUM(W.InsRoll)InsRoll, SUM(W.InsWgt)InsWgt,
              SUM(W.DefectQty)DefectQty, SUM(W.DefectRoll)DefectRoll, SUM(W.DefectWgt)DefectWgt
         FROM
             ( SELECT X.OrderID, X.OrderSeq, '' AS InsDate, X.LotNo,
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutRoll) * -1 ELSE SUM(X.OutRoll) END AS OutRoll,
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutQty) * -1 ELSE SUM(X.OutQty) END As OutQty, SUM(X.Weight) OutWgt,
                      0 InsQty, 0 InsRoll, 0 InsWgt,
                      0 DefectQty, 0 DefectRoll, 0 DefectWgt
                 FROM OutwareSub as X
                 LEFT JOIN OutWare As Y on X.OrderID = Y.OrderID AND X.OutSeq = Y.OutSeq
                GROUP BY X.OrderID,X.OrderSeq,Y.outclss,X.LotNo
               UNION All
               SELECT A.Orderid, A.OrderSeq, MAX(A.ExamDate) AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      SUM(A.CtrlQty) as InsQty, COUNT(A.RollSeq) as InsRoll, SUM(A.StuffWeight)InsWgt,
                      0 DefectQty, 0 DefectRoll, 0 DefectWgt
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
                GROUP BY OrderID,OrderSeq, A.LotNo
               UNION All
               SELECT A.Orderid, A.OrderSeq, '' AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      0 InsQty, 0 InsRoll, 0 InsWgt,
                      SUM(A.CtrlQty) as DefectQty, COUNT(A.RollSeq) as DefectRoll, SUM(A.StuffWeight)DefectWgt
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
                  AND dbo.fn_GetGradeResult(A.GradeID) = '2'
                GROUP BY OrderID,OrderSeq,A.LotNo
             ) W
         GROUP BY W.OrderID,W.OrderSeq, W.LotNo
      ) As B on A.OrderID = B.OrderiD AND A.OrderSeq = B.OrderSeq 
LEFT JOIN mt_Custom AS E on A.CustomID = E.CustomID 
LEFT JOIN mt_Article AS F on A.ArticleID = F.ArticleID 
LEFT JOIN mt_Work AS G on A.WorkID = G.WorkID 
WHERE A.Orderid <> '' 
AND (ISNULL(B.InsQty,0) > 0 AND ISNULL(B.InsQty,0) - ISNULL(B.OutQty,0) - ISNULL(B.DefectQty,0) > 0) 
ORDER BY E.KCustom, A.OrderID, A.Sort


------------------------------------------------------------------------------------------
 --spdMainKCustom = 1�ŷ�ó
 --spdMainOrderID = 2������ȣ
 --spdMainOrderNo = 3�����ѹ�
--spdMainWorkClss = 4��������
 --spdMainArticle = 5ǰ��
 --spdMainStyleNo = 6��Ÿ�ϳѹ�(Į����:designNo)
 --spdMainColor = 7����
--spdMainOrderQty = 8���ַ�
--spdMainOrderUnit = 9����
 --spdMainInsDate = 10�˻�����
 --spdMainLOTNO = 11 lotNO
 --spdMainInRoll = 12 �԰�����
 --spdMainInsRoll = 13�˻�>����		spdMainInsQty = 14�˻�>����		spdMainInsWeight = 15�˻�>�߷�

--spdMainOutRoll = 16���>����		spdMainOutQty = 17���>����		spdMainOutWeight = 18���>�߷�

--spdMainNoOutRoll = 19�����>����	spdMainNoOutQty = 20�����>����		spdMainNoOutWeight = 21�����>�߷�

--spdMainDefectRoll = 22�ҷ�>����	spdMainDefectQty = 23�ҷ�>����		spdMainDefectWeight = 24�ҷ�>�߷�
--spdMainOrderSeq = 25����������>x�������ִµ� �Ⱦ��°��ǹ��ϴ°Ͱ��⵵?
																														--�˻���(insDate)�� ������ ���� ���
SELECT A.CustomID, E.KCustom, F.Article, A.OrderID, A.OrderNo, G.WorkName, A.OrderSeq, A.DesignNo, A.Color, A.ColorQty, A.UnitClss, B.InsDate, B.LotNo, 
	   --�˻籸��
	   B.InsRoll, B.InsQty, B.InsWgt, 
	   --�����
	   B.OutRoll, B.OutQty, B.OutWgt, 
	   --�ҷ�����
	   B.DefectRoll, B.DefectQty, B.DefectWgt,
	   --�԰�����(�߰��� ����)
	   B.InRoll
FROM 
     (SELECT A.OrderID, A.OrderNo, A.CustomID, B.ArticleID, B.OrderSeq, B.DesignNo, B.Color, B.ColorQty, A.UnitClss, A.WorkId, A.WorkWidth, B.Sort
        FROM [order] A 
				--�̳� ����(INNER JOIN)�� �� ���̺� ���� ��Ī�Ǵ� �ุ�� ��ȯ�ϸ�, ���� ���̺�� ������ ���̺��� ���� ���ǿ� �����ϴ� �ุ�� �����մϴ�. 
				--�׷��� 1:N ���迡���� ���� �̳� ������ ����Ͽ� �θ� ���̺�� ����� �ڽ� ���̺��� ���� �����ɴϴ�.
       INNER JOIN [OrderColor] B on A.OrderID = B.OrderID 
	   --??orderseq>0������ �ɾ�� ����?�� orderseq��0�ΰ� ��Ȯ���ε� �̰� �����Ϸ��� �ϴ� ��
       WHERE b.OrderSeq > 0) As A 
LEFT JOIN 
--A������Ʈ�����ϴ°�:B
      (SELECT W.OrderID, W.OrderSeq, MAX(W.InsDate) AS InsDate, W.LotNo, SUM(W.OutRoll) As OutRoll, Sum(W.OutQty) As OutQty, SUM(W.OutWgt)OutWgt,
              SUM(W.InsQty)InsQty, SUM(W.InsRoll)InsRoll, SUM(W.InsWgt)InsWgt,
              SUM(W.DefectQty)DefectQty, SUM(W.DefectRoll)DefectRoll, SUM(W.DefectWgt)DefectWgt, SUM(W.InRoll)InRoll
         FROM
		 --b���� ������ ���� w�� ���������� �ΰ� ������ ���̺��� ���ϴ� ���� ����
							------1
             (	SELECT X.OrderID, X.OrderSeq, '' AS InsDate, X.LotNo,
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutRoll) * -1 ELSE SUM(X.OutRoll) END AS OutRoll,--outclss==�����
                      CASE WHEN Y.OutClss = '6' THEN SUM(X.OutQty) * -1 ELSE SUM(X.OutQty) END As OutQty, SUM(X.Weight) OutWgt,
					--InsQty ���� ���� �׻� 0 ���� ��ȯ�Ѵٴ� �ǹ�
                      0 InsQty, 0 InsRoll, 0 InsWgt, 0 DefectQty, 0 DefectRoll, 0 DefectWgt, 0 InRoll
                 FROM OutwareSub as X
                 LEFT JOIN OutWare As Y on X.OrderID = Y.OrderID AND X.OutSeq = Y.OutSeq
                GROUP BY X.OrderID,X.OrderSeq,Y.outclss,X.LotNo
               UNION All
						--------2
               SELECT A.Orderid, A.OrderSeq, MAX(A.ExamDate) AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      SUM(A.CtrlQty) as InsQty, COUNT(A.RollSeq) as InsRoll, SUM(A.StuffWeight)InsWgt,
                      0 DefectQty, 0 DefectRoll, 0 DefectWgt, 0 InRoll
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
				AND A.ExamDate BETWEEN '20230129' AND '20231129'
                GROUP BY OrderID,OrderSeq, A.LotNo
               UNION All
					-------3
               SELECT A.Orderid, A.OrderSeq, '' AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt,
                      0 InsQty, 0 InsRoll, 0 InsWgt,
                      SUM(A.CtrlQty) as DefectQty, COUNT(A.RollSeq) as DefectRoll, SUM(A.StuffWeight)DefectWgt, 0 InRoll
                 FROM [Inspect] As A
                WHERE A.OutReClss = '0'
				  AND A.ExamDate BETWEEN '20230129' AND '20231129'
                  AND dbo.fn_GetGradeResult(A.GradeID) = '2'
                GROUP BY OrderID,OrderSeq,A.LotNo
				UNION All
					-----4!!!!!�߰�(�԰������κ�)
				SELECT A.OrderID, A.OrderSeq, '' AS InsDate, A.LotNo, 0 OutRoll, 0 OutQty, 0 OutWgt, 0 InsQty, 0 InsRoll, 0 InsWgt, 0 DefectQty, 0 DefectRoll, 0 DefectWgt,
						SUM(A.InRoll) as Inroll
				FROM [StuffInReturn] As A
				LEFT JOIN StuffIN AS B ON A.KeyDate = B.KeyDate AND A.KeySeq = B.KeySeq
				WHERE B.StuffDate BETWEEN '20230103' AND '20231129'
                GROUP BY A.OrderID,A.OrderSeq, A.LotNo
             ) W
         GROUP BY W.OrderID,W.OrderSeq, W.LotNo
			--Ű�� ���� ��(orderSeq�� �Ϲ������� �⺻Ű�� ����)
      ) As B on A.OrderID = B.OrderiD AND A.OrderSeq = B.OrderSeq 

LEFT JOIN mt_Custom AS E on A.CustomID = E.CustomID 
LEFT JOIN mt_Article AS F on A.ArticleID = F.ArticleID 
LEFT JOIN mt_Work AS G on A.WorkID = G.WorkID 
LEFT JOIN StuffIN AS H on A.OrderID = H.OrderID

WHERE A.Orderid <> '' 
--�̺κп� �˻��������� �ٲ�� �� 
--AND A.Acptdate BETWEEN '20230128' AND '20231128'
AND H.StuffDate BETWEEN '20230129' AND '20231129'--�԰��������� �߰�
AND (ISNULL(B.InsQty,0) > 0 
AND ISNULL(B.InsQty,0) - ISNULL(B.OutQty,0) - ISNULL(B.DefectQty,0) > 0) 
							--sort�� ���ı������� ���� ����??sort�� ���淡??
ORDER BY E.KCustom, A.OrderID, A.Sort
----!!!!!!!!!!!!!!!!!!!!!!!�˻������� ����!!!!!!!!!!!!!!!!!!!!!!

