
--2
      DECLARE 
      @sDate             CHAR(8)
      , @eDate             CHAR(8)
      , @nChkCustom        SMALLINT
      , @CustomID          CHAR(4)
      , @nChkArticle       SMALLINT
      , @ArticleID         CHAR(4)
      , @nChkOrderID SMALLINT 
      , @OrderID CHAR(10)
      SET     @sDate      =   '20240101'
      SET     @eDate      =   '20240126'
      SET     @nChkCustom =    1
      SET     @CustomID   =   '0065'
      SET     @nChkArticle=    0
      SET     @ArticleID  =   ''
      SET     @nChkOrderID   = 0
      SET     @OrderID   =    ''
     DECLARE @BaseDate   CHAR(8)
     SELECT @BaseDate = ISNULL(MAX(BasisDate), '')
     FROM DS30C
 
     
       SELECT A.OrderID, A.IODate, A.Cls, A.OrderSeq, A.StuffRoll, A.StuffQty, A.OutRoll, A.OutQty, A.OutQtyY, A.OutRealQty, A.Remark, A.Pkey, A.Custom, A.Memo
       INTO #SUBUL
       FROM (
               SELECT A.OrderID, IODate = A.StuffDate, Cls = '1', B.OrderSeq, 0 outseq, B.StuffRoll ,
               B.StuffQty
               , OutRoll=0, OutQty = 0, OutQtyY = 0, OutRealQty = 0,  A.Remark
               , pkey = A.OrderID + '-' + Convert( Varchar(4),A.StuffID)
               , '' Custom, '' Memo
               FROM [DS22] A,
               ( 
                  select OrderID, StuffDate, StuffID,orderSeq, sum(StuffRoll) StuffRoll ,sum(StuffQty) StuffQty, sum(StuffQtyy) StuffQtyy
                  From ds23
                  group by OrderID, StuffDate, StuffID,orderSeq
               ) as b , [DS20] C
              Where a.OrderID = B.OrderID And a.StuffDate = B.StuffDate And a.StuffID = B.StuffID
              AND A.OrderID = C.OrderID
              AND A.StuffDate BETWEEN '20240101'  AND '20240126'
              AND  C.CustomID ='0065'


                 Union All

                  SELECT b.OrderID, IODate = A.OutDate, Cls= '2', b.OrderSeq,b.OutSeq, StuffRoll=0, StuffQty=0
              , B.OutRoll, B.OutQty, B.OutQtyY
              , 0 OutRealQty, A.Remark
              , pkey = A.OrderID + '-' + Convert( Varchar(4), A.OutSeq)
              , Custom = A.OutCustom, CASE LEN(RTRIM(A.Memo))WHEN 0 THEN 0 ELSE 1 END AS Memo
              FROM [DS26] A, [DS20] C,
                  (SELECT OrderID, OutSeq, OrderSeq, SUM(OutRoll) OutRoll, SUM(nOutQty) OutQty, SUM(nOutQty) OutQtyY
                  FROM [DS27] B
                  GROUP BY OrderID, OutSeq, OrderSeq) B
              Where a.OrderID = B.OrderID And a.OutSeq = B.OutSeq
              AND A.OrderID = C.OrderID
              AND A.OutDate BETWEEN '20240101'  AND '20240126'
              AND  C.CustomID ='0065'
         

			   Union All

              SELECT a.OrderID, IODate = A.OutDate, Cls= '2', 999,a.OutSeq, StuffRoll=0, StuffQty=0
              , OutRoll =0, OutQty =0,OutQtyY =0
              , sum(OutRealQty), ''
              , pkey = A.OrderID + '-' + Convert( Varchar(4), A.OutSeq)
              , '', '' Memo
              FROM [DS26] A, [DS20] C
              Where a.OrderID = C.OrderID
              AND A.OutDate BETWEEN '20240101'  AND '20240126'
              AND  C.CustomID ='0065'

             group by a.orderid,a.outdate,a.outseq
          ) A


--4
      DECLARE 
      @sDate             CHAR(8)
      , @eDate             CHAR(8)
      , @nChkCustom        SMALLINT
      , @CustomID          CHAR(4)
      , @nChkArticle       SMALLINT
      , @ArticleID         CHAR(4)
      , @nChkOrderID SMALLINT 
      , @OrderID CHAR(10)
      SET     @sDate      =   '20240101'
      SET     @eDate      =   '20240126'
      SET     @nChkCustom =    1
      SET     @CustomID   =   '0065'
      SET     @nChkArticle=    0
      SET     @ArticleID  =   ''
      SET     @nChkOrderID   = 0
      SET     @OrderID   =    ''
     SELECT DISTINCT A.OrderID, IODate = ' ', Cls = '0', OrderSeq=888, StuffRoll=0, StuffQty = ISNULL( A.StockQty +  A.StuffINQty -  A.OutQty, 0 ),
       OutRoll=0, OutQty=0, OutQtyY = 0, OutRealQty=0, Remark=' ', pkey=' ', Memo = 0
       INTO #Stock
       FROM dbo.DSF06('20240101',1, '0065',0, '',0, '' )  A


	   select * from #Stock

--5
      SELECT A.OrderID, A.IODate, A.Cls, A.OrderSeq, A.StuffRoll, A.StuffQty, A.OutRoll, A.OutQty, A.OutQtyY, A.OutRealQty, A.Remark, A.Pkey, A.Custom, A.Memo,
         D.KCustom , E.Article, F.WorkName, B.OrderNo, B.UnitClss, B.OrderQty, C.Color, C.DesignNo, C.ColorQty
         INTO #TEMP
      From
              ( SELECT OrderID, IODate, Cls, OrderSeq, StuffRoll, StuffQty, OutRoll, OutQty, OutQtyY, OutRealQty, Remark, Pkey, Custom = '', Memo
                 FROM #Stock
                 Where StuffQty <> 0
                 Union All
                 SELECT OrderID, IODate, Cls, OrderSeq, StuffRoll, StuffQty, OutRoll, OutQty, OutQtyY, OutRealQty, Remark, Pkey, Custom, Memo
                 FROM #SUBUL
              ) AS A, [DS20] B, [DS21] C, [DS02] D, [DS01] E, [DS19] F
      Where a.OrderID = B.OrderID
      AND A.OrderID = C.OrderID
      AND A.OrderSeq *= C.OrderSeq
      AND B.CustomID = D.CustomID
      AND B.ArticleID = E.ArticleID
      AND B.WorkID = F.WorkID
--6
         select  Orderno,kCustom,Article,Color,orderid,
                  case when unitclss = 0 then 'YD' else 'MT'end unitclss,
                  case when cls = 0 then StuffQty else 0 end PrevQty,
                  substring(IODate,5,2) + '-' + substring(IODate,7,2) IODate,
                  case when cls <> 0   then StuffQty else 0 end StuffQty,
                  OutQty,OutRealQty,
                  case when cls = 3 or cls = 4 then stuffqty - outRealqty end stock,
                  Cls,Pkey,OrderID,Remark
          From
          (
              SELECT OrderNO,kCustom, Article ,  OrderSeq,OrderID, Color, DesignNo, OrderQty, ColorQty, UnitClss, IODate, Cls, Custom, StuffRoll, StuffQty
                  ,  OutRoll, OutQty, OutQtyY, OutRealQty, Remark, Pkey, WorkName, Memo
              FROM #TEMP
              Where OrderSeq <> 999
              Union All
              SELECT OrderNO, kCustom, Article , OrderSeq = 9999, OrderID, Color = '', DesigNo = '', OrderQty, ColorQty = 0, UnitClss, IODate= '99999999', Cls='3', Custom='', StuffRoll = SUM(StuffRoll), StuffQty = SUM(StuffQty)
                  , OutRoll=SUM(OutRoll), OutQty=SUM(OutQty), OutQtyY = SUM(OutQtyY), OutRealQty=sum(OutRealQty)
                  , Remark=' ', pkey='', WorkName='', Memo = 0
              FROM #TEMP
              GROUP BY kCustom, Article, OrderID, OrderNo, OrderQty, UnitClss
              Union All
              SELECT OrderNO = '',kCustom, Article , OrderSeq = 99999, OrderID = '9999999999', Color = '', DesignNo = '', OrderQty = 0, ColorQty = 0, UnitClss = '', IODate= '99999999', Cls='4', Custom='', StuffRoll = SUM(StuffRoll), StuffQty = SUM(StuffQty)
              ,  OutRoll=SUM(OutRoll), OutQty=SUM(OutQty), OutQtyY = SUM(OutQtyY), OutRealQty=sum(OutRealQty)
              , Remark=' ', pkey='', WorkName='', Memo = 0
              FROM #TEMP
              GROUP BY kCustom, Article
          ) as a
          ORDER BY kCustom, Article, OrderID,OrderSeq, Cls,IODate




