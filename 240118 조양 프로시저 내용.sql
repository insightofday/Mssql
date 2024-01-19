GO

/****** Object:  StoredProcedure [dbo].[xp_Order_sOrderOne]    Script Date: 2024-01-18 오후 5:05:03 ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO

ALTER        PROCEDURE [dbo].[xp_Order_sOrderOne]  
 @OrderID  CHAR(10)  
AS  
 SELECT A.OrderID, A.CustomID, A.OrderNo, B.KCustom, A.PONO, A.OrderForm, A.OrderClss,  
  A.AcptDate, A.DvlyDate, A.ArticleID, C.Article, A.DvlyPlace, A.WorkID, A.DvlyPlaceTel,  
  A.PriceClss, A.ExchRate, A.OrderQty, A.UnitClss, A.ColorCnt, E.WorkName,   
  A.StuffWidth, A.StuffWeight, A.CutQty,  A.WorkWidth, A.WorkWeight, A.WorkWeight2, A.WorkDensity, A.WorkDensity2,   
  A.ChunkRate, A.LossRate, A.ReduceRate, A.TagClss, A.LabelID, A.BandID, A.EndClss, A.MadeClss,  
  A.SurfaceClss, A.ShipClss, A.AdvnClss, A.LotClss, A.EndMark, A.TagArticle, A.TagOrderNo,  A.TagWeightFlag,  
  A.TagRemark, A.Tag, A.BasisID, A.BasisUnit, A.SpendingClss, A.DyeingID, A.WorkingClss, A.PatternID, A.BTID, A.BTIDSeq, A.ChemClss,  
  A.AccountClss, A.ModifyClss, A.ModifyRemark, A.CancelRemark, A.Remark, A.ActiveClss, A.CloseClss, A.ModifyDate, A.TaxClss,  
                A.TagPrn1, A.TagPrn2, A.TagPrn3, A.TagPrn4, A.InputProcID, A.UnitCostClss, A.SpecialRemark, D.StuffWidth AS WorkWidthS, A.AvgUnitPrice, A.OrderWeight, A.AvgUnitPriceKG,  
                WorkWidthName = ISNULL( ( SELECT StuffWidth    
                                           FROM mt_StuffWidth ZZ  
                                          WHERE A.WorkWidth = ZZ.StuffWidthID ), '' )  ,
 A.WorkWeight3,F.StuffWidth AS StuffWidthName,
 A.TagPosition, A.MakeReport, A.WeightGap, A.FinishKind,a.faceMarkFlag, A.Buyer, A.SampleOrder, A.OrderCancle, A.chkChunkRateFlag, A.TagYMPrnFlag,
 A.ChkQRCode, A.TagQrCode1, A.TagQRcode2, A.TagQRCode3
           
  
                 
 FROM [Order] A
 LEFT JOIN [mt_Custom] AS B ON A.CustomID = B.CustomID
 LEFT JOIN [mt_Article] AS C ON A.ArticleID = C.ArticleID 
 LEFT JOIN [mt_StuffWidth] AS D ON A.WorkWidth = D.StuffWidthID  
 LEFT JOIN [mt_Work] AS E ON A.WorkID = E.WorkID  
 LEFT JOIN [mt_StuffWidth] AS F ON  a.StuffWidth =   f.StuffWidthID  

 WHERE A.OrderID = @OrderID



  /* 20211116 기존 쿼리 
   SELECT A.OrderID, A.CustomID, A.OrderNo, B.KCustom, A.PONO, A.OrderForm, A.OrderClss,  
  A.AcptDate, A.DvlyDate, A.ArticleID, C.Article, A.DvlyPlace, A.WorkID, A.DvlyPlaceTel,  
  A.PriceClss, A.ExchRate, A.OrderQty, A.UnitClss, A.ColorCnt, E.WorkName,   
  A.StuffWidth, A.StuffWeight, A.CutQty,  A.WorkWidth, A.WorkWeight, A.WorkWeight2, A.WorkDensity, A.WorkDensity2,   
  A.ChunkRate, A.LossRate, A.ReduceRate, A.TagClss, A.LabelID, A.BandID, A.EndClss, A.MadeClss,  
  A.SurfaceClss, A.ShipClss, A.AdvnClss, A.LotClss, A.EndMark, A.TagArticle, A.TagOrderNo,  A.TagWeightFlag,  
  A.TagRemark, A.Tag, A.BasisID, A.BasisUnit, A.SpendingClss, A.DyeingID, A.WorkingClss, A.PatternID, A.BTID, A.BTIDSeq, A.ChemClss,  
  A.AccountClss, A.ModifyClss, A.ModifyRemark, A.CancelRemark, A.Remark, A.ActiveClss, A.CloseClss, A.ModifyDate, A.TaxClss,  
                A.TagPrn1, A.TagPrn2, A.TagPrn3, A.TagPrn4, A.InputProcID, A.UnitCostClss, A.SpecialRemark, D.StuffWidth AS WorkWidthS, A.AvgUnitPrice, A.OrderWeight, A.AvgUnitPriceKG,  
                WorkWidthName = ISNULL( ( SELECT StuffWidth    
                                           FROM mt_StuffWidth ZZ  
                                          WHERE A.WorkWidth = ZZ.StuffWidthID ), '' )  ,
 A.WorkWeight3,F.StuffWidth AS StuffWidthName,
 A.TagPosition, A.MakeReport, A.WeightGap, A.FinishKind,a.faceMarkFlag, A.Buyer, A.SampleOrder, A.OrderCancle, A.chkChunkRateFlag

 FROM [Order] A ,[mt_Custom] B, [mt_Article] C, [mt_StuffWidth] D, [mt_Work] E  , [mt_StuffWidth] F 

  WHERE A.CustomID = B.CustomID  
  AND A.ArticleID = C.ArticleID  
  AND A.WorkWidth = D.StuffWidthID  
  AND A.WorkID = E.WorkID  
--  AND A.OrderID = @OrderID
  AND a.StuffWidth =   f.StuffWidthID */
  
GO


