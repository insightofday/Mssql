--fillspdmain
SELECT A.Article, A.Color, A.Standard, A.Qty, A.ArticleID 
  FROM (          SELECT B.Article, B.Color, B.Standard, ISNULL(SUM(A.Qty), 0) As Qty, A.ArticleID 
          FROM vw_Stock As A
               LEFT JOIN [mt_Article] AS B ON A.ArticleID = B.ArticleID
          WHERE ISNULL(B.UseClss,'') <> '*' AND ISNULL(B.ArticleID,'') <> '' 
 GROUP BY B.Article, B.Color, B.Standard, A.ArticleID) AS A  
 WHERE A.Qty <> 0 


 --fillspddata
SELECT A.BigStor, A.SmallStor, A.Qty, A.ArticleID, A.BigStorID, A.SmallStorID
  FROM (SELECT B.BigStor, C.SmallStor, ISNULL(A.Qty, 0) As Qty, A.ArticleID, A.BigStorID, A.SmallStorID
  FROM vw_Stock As A
       LEFT JOIN [mt_StorCode] AS B ON A.BigStorID = B.BigStorID
       LEFT JOIN [mt_StorCodeSub] AS C ON B.BigStorID = C.BigStorID AND A.SmallStorID = C.SmallStorID
 WHERE A.ArticleID = 'P5038' 
         ) AS A
 WHERE A.Qty <> 0 
 ORDER BY A.BigStorID, A.SmallStorID 


 USE [DDasion]
GO

/****** Object:  View [dbo].[vw_Stock]    Script Date: 2023-12-26 오전 9:41:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

--view
ALTER VIEW [dbo].[vw_Stock]
AS
    SELECT A.BigStorID, A.SmallStorID, A.ArticleID, SUM(A.Qty) AS QTY
      FROM
           (
			-- 이월재고. 이월재고 테이블에 기준년월 최대인 값을 가져온다
             SELECT BigStorID, SmallStorID, ArticleID, Qty
               FROM sb_StockBase
              WHERE BasisDate = (SELECT MAX(BasisDate) FROM sb_StockBase)
    
              UNION ALL
			
			-- 입고. OutWork로 의뢰한 내용에 대해 입고를 잡아서 OutWorkSub랑 키값이 같다.
			-- 이월재고 테이블에 기준년월 최대값 이후만 정리(그 이전값은 이월정리 되었음)
             SELECT A.BigStorID, A.SmallStorID, B.ArticleID, A.StuffINQty
               FROM StuffIN As A
					INNER JOIN OutWorkSub As B ON A.KeyDate = B.KeyDAte AND A.KeySeq = B.KeySeq AND A.SubKeySeq = B.SubKeySeq
			  WHERE A.InDate > (SELECT MAX(BasisDate) FROM sb_StockBase)
    
              UNION ALL
    
			-- 창고관리.  1 입고(사용안함)  2.불량(출고) 3. 이동출고 4. 이동입고
			-- 이월재고 테이블에 기준년월 최대값 이후만 정리(그 이전값은 이월정리 되었음)
            SELECT BigStorID, SmallStorID, ArticleID
                 , CASE WHEN MoveClss IN ('1','4') THEN ABS(QtY) ELSE ABS(Qty) * -1 END QTY
              FROM sb_StockControl
             WHERE StockDate > (SELECT MAX(BasisDate) FROM sb_StockBase)

			 UNION ALL

			 --포장을 위해 이동한 내역(창고 출고)
			 -- 이월재고 테이블에 기준년월 최대값 이후만 정리(그 이전값은 이월정리 되었음)
			 SELECT BigStorID, SmallStorID, ArticleID, ABS(ReadyPackQty) * -1
			   FROM ReadyPacking
			  WHERE PackDate > (SELECT MAX(BasisDate) FROM sb_StockBase)
            ) AS A
	GROUP BY A.BigStorID, A.SmallStorID, A.ArticleID
GO





