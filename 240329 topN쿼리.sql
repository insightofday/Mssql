
select  TOP (1) b.wrk_temp*10 tempA ,a.worktemp1 tempB,a.worktemp2 tempC
  from PLC_DYE1ST a 
 join PLC_Tenter1 b
     on a.WorkDate=b.WorkDate and a.WorkTime=b.WorkTime
       ORDER BY A.InptDate DESC


