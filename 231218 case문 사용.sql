SELECT case
when A.TradeID='1' then '매출거래처'
when A.TradeID='2' then '매입거래처'
end as TradeID,

A.ShortCustom, A.SalesGrade,  A.DeliveryClss,  A.Phone1, A.Phone2,  A.FaxNo, A.DeliveryAdrs, A.memo
,A.CustomId, A.KCustom, A.Chief,  SUBSTRING(CustomNO,1,3) + '-' + SUBSTRING(CustomNO,4,2) + '-' + SUBSTRING(CustomNO,6,5) AS CustomNo       
, A.Condition, A.Category, A.Name, A.Phone
, A.Address1, A.Address2, A.ZipCode, A.Email, A.HomePage, A.UserId, A.UserPassWord 
, A.ECustom,  A.LossClss, A.SpendingClss, A.WorkingClss, A.CalClss, A.PointClss,A.VatClss 
,  A.OutsourcingNum, A.KBank, A.BankAccount, A.AccountHolder 
FROM [mt_Custom] AS A 
WHERE A.Useclss <> '*' 
 AND A.KCustom LIKE '%%' 




select * from mt_custom



     SELECT CustomID, ECustom, KCustom, ShortCustom, SUBSTRING(CustomNO,1,3) + '-' + SUBSTRING(CustomNO,4,2) + '-' + SUBSTRING(CustomNO,6,5) AS CustomNo, Chief, Condition, Category,
         ZipCode, Address1, Address2, Phone1, Phone2, FaxNo, EMail, HomePage, Name, Phone, 
         TradeID , UserID, UserPassWord, LossClss, SpendingClss, WorkingClss, CalClss, PointClss,ExpressName1,ExpressName2,ExpressName3,ExpressTEL1,ExpressTEL2,ExpressTEL3,VatClss, Memo, 
         SalesGrade, DeliveryClss, DeliveryAdrs, OutsourcingNum, KBank, BankAccount, AccountHolder
     From [mt_Custom]
     WHERE CustomID = '1' 