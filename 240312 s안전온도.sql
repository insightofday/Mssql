select distinct concat(a.workdate,a.worktime) '�ð�',substring(a.workdate,5,2)+'��'+substring(a.workdate,7,9)+'��' date,
substring(a.worktime,1,2)+'��'+substring(a.worktime,3,4)+'��' time, a.wrk_temp, worktemp1,worktemp2 from plc_tenter1 a
inner join                                                                                      
plc_dye1st b 
on concat(a.workdate,a.worktime)=concat(b.workdate,b.worktime) 
--where a.workdate between '20240301' and '20240303'
order by '�ð�'  


select distinct concat(a.workdate,a.worktime) '�ð�',substring(a.workdate,5,2)+'��'+substring(a.workdate,7,9)+'��' date,
substring(a.worktime,1,2)+'��'+substring(a.worktime,3,4)+'��' time, a.wrk_temp, worktemp1,worktemp2 from plc_tenter1 a
inner join                                                                                      
plc_dye1st b 
on concat(a.workdate,a.worktime)=concat(b.workdate,b.worktime) 
where a.workdate between  '20240205' AND '20240312'  
order by '�ð�'  


