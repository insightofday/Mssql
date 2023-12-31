USE [SamIL]
GO
/****** Object:  StoredProcedure [dbo].[xp_Inspect_sOrderSub]    Script Date: 2024-01-03 오전 10:42:16 ******/
SET ANSI_NULLS ON
GO
SET QUOTED_IDENTIFIER ON
GO


/********************************************************************************
 * Date : 2003-11-14 (FRI)
 *
 * Description: 색상별 Lot별 검사현황 
 *		MRPPlus2 (CInspect -> frmInspect)
 ********************************************************************************/
ALTER   PROCEDURE [dbo].[xp_Inspect_sOrderSub]
	@OrderID CHAR(10)
AS

	SET NOCOUNT ON

	SELECT B.OrderiD, B.OrderSeq, B.LotNo, 
		B.RollQty, B.CtrlQty, B.StuffQty,  B.CtrlQty AS InputQty, C.PassRoll, C.PassQty, 
		D.DefectRoll, D.DefectQty, E.FailJJRoll, E.FailJJQty, F.FailGGRoll, F.FailGGQty,g.SpDefectRoll,g.SpDefectQty
	INTO #Temp
	FROM
		(SELECT OrderID, OrderSeq, LotNo, COUNT(*) RollQty, SUM(CtrlQty) CtrlQty, SUM(StuffQty) StuffQty 
		FROM [Inspect] 
		WHERE OrderID = @OrderID
		GROUP BY OrderID, OrderSeq, LotNo) B,
		(SELECT OrderID, OrderSeq, LotNo, COUNT(*) PassRoll, SUM(CtrlQty) PassQty 
		FROM [Inspect] 
		WHERE GradeID = '1' AND OrderID = @OrderID
		GROUP BY OrderID, OrderSeq, LotNo) C, 
		(SELECT OrderID, OrderSeq, LotNo, COUNT(*) DefectRoll, SUM(CtrlQty) DefectQty 
		FROM [Inspect] 
		WHERE GradeID = '2' AND OrderID = @OrderID
		GROUP BY OrderID, OrderSeq, LotNo) AS D, 
		(SELECT OrderID, OrderSeq, LotNo, COUNT(*) FailJJRoll, SUM(CtrlQty) FailJJQty 
		FROM [Inspect] 
		WHERE GradeID = '2' AND DefectClss = '1' AND OrderID = @OrderID
		GROUP BY OrderID, OrderSeq, LotNo) E, 
		(SELECT OrderID, OrderSeq, LotNo, COUNT(*) FailGGRoll, SUM(CtrlQty) FailGGQty 
		FROM [Inspect] 
		WHERE GradeID = '2' AND DefectClss = '2' AND OrderID = @OrderID
		GROUP BY OrderID, OrderSeq, LotNo) F,
		(SELECT OrderID, OrderSeq, LotNo, COUNT(*) SpDefectRoll, SUM(CtrlQty) SpDefectQty 
		FROM [Inspect] 
		WHERE OutClss = '' AND GradeID = '1' AND OrderID = @OrderID
		GROUP BY OrderID, OrderSeq, LotNo) G
	WHERE B.OrderID *= C.OrderID AND B.OrderSeq *= C.OrderSeq  AND B.LotNo *= C.LotNo
	AND B.OrderID *= D.OrderID AND B.OrderSeq *= D.OrderSeq  AND B.LotNo *= D.LotNo
	AND B.OrderID *= E.OrderID AND B.OrderSeq *= E.OrderSeq  AND B.LotNo *= E.LotNo
	AND B.OrderID *= F.OrderID AND B.OrderSeq *= F.OrderSeq  AND B.LotNo *= F.LotNo
	AND B.OrderID *= G.OrderID AND B.OrderSeq *= G.OrderSeq  AND B.LotNo *= G.LotNo
		
	SELECT A.OrderID, A.OrderSeq, A.Color, A.ColorQty, B.LotNo, B.RollQty, B.CtrlQty, B.StuffQty, B.InputQty, 
		B.PassRoll, B.PassQty, B.DefectRoll, B.DefectQty, B.FailJJRoll, B.FailJJQty, B.FailGGRoll, B.FailGGQty, C.UnitClss, b.SpDefectRoll,b.SpDefectQty, D.StuffWidth, E.workName
	FROM [OrderColor] A, [#Temp] B, [Order] C, [mt_StuffWidth] D, mt_work E
	WHERE A.OrderID *= B.OrderID AND A.OrderSeq *= B.OrderSeq
	AND A.OrderID = C.OrderID
	AND A.OrderSeq <> 0
	AND A.OrderID = @OrderID
    AND C.StuffWidth = D.StuffWidthID
	AND E.workID=A.workID
