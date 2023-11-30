
SELECT A.OrderID '관리번호', A.OrderNo, B.KCustom '거래처', C.Article '품명', D.WorkName '가공구분', E.Aid '가공조제', F.Pattern '공정패턴'
	,G.StuffWidth '가공폭???stuffWidth랑조인해야하는데공통칼럼없어', A.ChunkRate '축율(줄어든비율)' , A.WorkWeight '중량', A.DvlyPlace '출고처', A.AcptDate '접수일자', A.RequestDate '요청일자',
	A.DvlyDate '회신일자',A.AvgUnitPrice '단가', A.PriceClss '단위', A.OrderQty '수주수량', A.OrderClss '단위', A.ColorCnt '색상수', 
	A.RollFlag '차수????아닌것가튼뎅<아닌거마즘 조건에 따라 숫자를 입력하는 프로세스'
FROM [Order] AS A
LEFT JOIN [mt_Custom] B ON A.CustomID = B.CustomID --얘는많음
LEFT JOIN [mt_Article] C ON A.ArticleID = C.ArticleID --Article,MArticleID,HArticle,ThreadID,StuffWidthID,DyeingID,ArticleGrpId,Weight,UseClss,InptUser,InptDate,UpdtUser,UpdtDate
LEFT JOIN [mt_Work] D ON A.WorkID = D.WorkID --WokrName,UseClss,InptUser,InptDate,UpdtUser,UpdtDate
LEFT JOIN [mt_Aid] E ON A.AidID = E.AidID --Aid,UseClss,InptUser,InptDate,UpdtUser,UpdtDate
LEFT JOIN [mt_Pattern] F ON A.PatternID = F.PatternID --Pattern,WorkId,PatternGrpID,UseClss,InptUser,InptDate,UpdtUser,UpdtDate
LEFT JOIN [mt_StuffWidth] G ON A.StuffWidth = G.StuffWidth
--WHERE A.OrderID = '2023010038'

--select * from [Order] where OrderID = '2023050001'
--select * from mt_StuffWidth
--공정:machine, work
--가공:process

--DS_ProcessHP의 remark에 관련정보인듯?
