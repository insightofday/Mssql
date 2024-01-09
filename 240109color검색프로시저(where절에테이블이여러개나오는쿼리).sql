USE [SamIL]
GO
/****** Object:  StoredProcedure [dbo].[xp_Inspect_sOrder]    Script Date: 2024-01-08 오전 9:20:33 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO



/***************************************************************************************************
 * Date : 2003-11-14 (FRI)
 *
 * Description: 검사실적현황
 *		(CInspect -> frmInspect)
 **************************************************************************************************/
ALTER  PROCEDURE [dbo].[xp_Inspect_sOrder]
	@ChkDate     SMALLINT,
	@SDate       CHAR(8),
	@EDate       CHAR(8),
	@ChkCustomID SMALLINT,
	@CustomID    CHAR(4),
	@ChkArticleID SMALLINT,
	@ArticleID   CHAR(4),
	@ChkOrder    SMALLINT,
	@Order       VARCHAR(24),
	@ChkClose    SMALLINT,
	@TaxClss     SMALLINT,
	@ChkColor	SMALLINT,
	@Color		VARCHAR(24)
AS
	SET NOCOUNT ON

	SELECT A.OrderID, A.OrderNo, A.CustomID, C.KCustom, C.ECustom, D.Article, A.BasisID, A.UnitClss, A.CloseClss, B.Roll, B.CtrlQty, a.orderweight
	INTO #TEMP
	FROM [Order] A, 			
		(SELECT S.OrderID, SUM(Roll) AS Roll, CtrlQty = CASE T.UnitClss WHEN '0' THEN SUM(S.CtrlQty) ELSE ROUND(SUM(S.CtrlQty/0.9144),0) END
		FROM (SELECT OrderID, OrderSeq, COUNT(*) AS Roll, SUM(CtrlQty) AS CtrlQty 
			  FROM [Inspect] WITH(INDEX(IDX_Order_ExamDate))
			  WHERE ((@ChkDate = 1 AND ExamDate BETWEEN @SDate AND @EDate) OR (@ChkDate =0))
			  GROUP BY OrderID, OrderSeq) S, 
	   [Order] T
		WHERE S.OrderID = T.OrderID
		GROUP BY S.OrderID, T.UnitClss) B,
		 [mt_Custom] C, [mt_Article] D, [orderColor] E
	  --!!!!!!!!!!!!!!!에엥? from뒤에 테이블 이렇게 나열해도 되냐?? 
		 --ㅇㅇ됨; where에서 join조건을 명시하면 되긴 된대.. 근데 이게 야매방법인지,,아닌지는 몰랑..ㅎ
	WHERE A.OrderID = B.OrderID AND A.CustomID = C.CustomID AND A.ArticleID = D.ArticleID AND A.OrderID = E.OrderID
	AND ((@ChkCustomID = 1 AND A.CustomID = @CustomID) OR (@ChkCustomID = 0))
	AND ((@ChkArticleID = 1 AND A.ArticleID = @ArticleID) OR (@ArticleID = 0))
	AND ((@ChkOrder = 1 AND A.OrderID = @Order) OR (@ChkOrder = 2 AND A.OrderNo LIKE @Order + '%') OR (@ChkOrder =0))
	AND ((@TaxClss < 2 AND A.TaxClss = @TaxClss) OR (@TaxClss =2))
	AND ((@ChkColor = 1 AND E.Color LIKE  '%' + @Color + '%') OR (@ChkColor =0))


	SELECT Depth = 'Z1', OrderID, OrderNo, CustomID, KCustom, ECustom, Article, BasisID, UnitClss, CloseClss, Roll, CtrlQty, orderweight
	FROM #TEMP	

	UNION ALL

	SELECT Depth = 'Z2', OrderID = '', OrderNo = '', CustomID = '', KCustom = '', ECustom = '', Article = '', BasisID = '', 
		UnitClss = '', CloseClss = '', ISNULL(SUM(Roll),0) AS Roll, ISNULL(SUM(CtrlQty),0) AS CtrlQty, orderweight=''
	FROM #TEMP	

	ORDER BY Depth, KCustom
