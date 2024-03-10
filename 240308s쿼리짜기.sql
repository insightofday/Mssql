

select WRK_TEMP, workdate, worktime from PLC_Tenter1

select worktemp1,worktemp2, worktime, workdate from plc_dye1st

select row_number() over(Order by(select 1)) rn, b.workdate,b.worktime,A.wrk_temp,B.worktemp1,B.worktemp2
FROM plc_tenter1 A
INNER JOIN 
PLC_DYE1ST B
ON  
A.WorkDate=B.WorkDate and A.workDate=B.WorkDate
WHERE A.workdate between '20240305' and '20240305'
