--201410 graduates with Associate's only:
select distinct sfrstcr_term_code "TERM",SPRIDEN_ID "ID",
  SPRIDEN_LAST_Name "LNAME",
  SPRIDEN_MI "MI",
  SPRIDEN_FIRST_NAME "FNAME",
  to_char(spbpers_birth_date,'yyyymmdd') "DOB",sgbstdn_styp_code "Student_Type",shrdgmr_degc_code,
shrdgmr_degs_code,shrdgmr_majr_code_1,shrdgmr_grad_date
FROM SFRSTCR, SPRIDEN, SGBSTDN,SHRDGMR,spbpers
WHERE SHRDGMR_pidm=spriden_pidm
and spbpers_pidm=spriden_pidm
AND SFRSTCR_PIDM = SPRIDEN_PIDM
  AND SFRSTCR_PIDM = SGBSTDN_PIDM
  AND SPRIDEN_CHANGE_IND IS NULL
  AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 201410) --careful here with = vs. <=
  AND SFRSTCR_TERM_CODE = 201410
  and sgbstdn_styp_code='S'
  and shrdgmr_degc_code LIKE 'A%'
  and shrdgmr_degs_code = 'AW'
  and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
  and shrdgmr_grad_date <= '01-AUG-22'; --graduation date cut off
  

--First time freshmen 202010 with military veteran students:
select distinct sfrstcr_term_code "TERM",SPRIDEN_ID "ID",
  SPRIDEN_LAST_Name "LNAME",
  SPRIDEN_MI "MI",
  SPRIDEN_FIRST_NAME "FNAME",
  to_char(spbpers_birth_date,'yyyymmdd') "DOB",sgbstdn_styp_code "Student_Type",
  stvstyp_desc,sgbstdn_sess_code "MILITARY STATUS"
FROM SFRSTCR, SPRIDEN, SGBSTDN,spbpers,stvstyp
where sgbstdn_styp_code=stvstyp_code
and spbpers_pidm=spriden_pidm
AND SFRSTCR_PIDM = SPRIDEN_PIDM
AND SGBSTDN_PIDM=sfrstcr_pidm
and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202010) --be mindful of this term date
  AND SPRIDEN_CHANGE_IND IS NULL
  AND SFRSTCR_TERM_CODE = 202010
  and sgbstdn_styp_code='S';
  
  --FTF graduation rate for student veterans:
select distinct sfrstcr_term_code "TERM",
  SPRIDEN_ID "ID",
  SPRIDEN_LAST_Name "LNAME",
  SPRIDEN_MI "MI",
  SPRIDEN_FIRST_NAME "FNAME",
  to_char(spbpers_birth_date,'yyyymmdd') "DOB",
  sgbstdn_styp_code "Student_Type",NVL(sgbstdn_sess_code, 'Not Military'),
  stvstyp_desc,
  (select 'YES' from shrdgmr b
    where b.shrdgmr_pidm (+) = spriden_pidm
      and b.shrdgmr_degs_code = 'AW'
      and b.shrdgmr_seq_no = (select max(c.shrdgmr_seq_no)
                               from shrdgmr c
                               where c.shrdgmr_pidm (+) = spriden_pidm
                                 and c.shrdgmr_degs_code = 'AW')) "Graduated?"
FROM SFRSTCR, SPRIDEN, SGBSTDN,spbpers,stvstyp,shrdgmr
where sgbstdn_styp_code=stvstyp_code
and shrdgmr_pidm (+)=sfrstcr_pidm
   and spbpers_pidm=spriden_pidm
   AND SFRSTCR_PIDM = SPRIDEN_PIDM
   AND SGBSTDN_PIDM=sfrstcr_pidm
   and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
   AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202010) --be mindful of this term date
   AND SPRIDEN_CHANGE_IND IS NULL
   AND SFRSTCR_TERM_CODE = 202010;
   

--Median number of years to complete studies
select distinct sfrstcr_term_code "TERM",shrdgmr_grad_date,shrdgmr_majr_code_1,
  SPRIDEN_ID "ID",
  SPRIDEN_LAST_Name "LNAME",
  SPRIDEN_MI "MI",
  SPRIDEN_FIRST_NAME "FNAME",
  to_char(spbpers_birth_date,'yyyymmdd') "DOB",
  sgbstdn_styp_code,NVL(sgbstdn_sess_code, 'Not Military') "Military Status",
  stvstyp_desc "Student_Type",
  (select 'YES' from shrdgmr b
    where b.shrdgmr_pidm (+) = spriden_pidm
      and b.shrdgmr_degs_code = 'AW'
      and b.shrdgmr_seq_no = (select max(c.shrdgmr_seq_no)
                               from shrdgmr c
                               where c.shrdgmr_pidm (+) = spriden_pidm
                                 and c.shrdgmr_degs_code = 'AW')) "Graduated?"
FROM SFRSTCR, SPRIDEN, SGBSTDN,spbpers,stvstyp,shrdgmr
where sgbstdn_styp_code=stvstyp_code
and shrdgmr_pidm (+)=sfrstcr_pidm
   and spbpers_pidm=spriden_pidm
   AND SFRSTCR_PIDM = SPRIDEN_PIDM
   AND SGBSTDN_PIDM=sfrstcr_pidm
   and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
   AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 201810) --be mindful of this term date
   AND SPRIDEN_CHANGE_IND IS NULL
   AND SFRSTCR_TERM_CODE <= 202010 
   and shrdgmr_grad_date <= '01-NOV-23';
   
--202110 FTF with veterans
select distinct sfrstcr_term_code "TERM",SPRIDEN_ID "ID",
  SPRIDEN_LAST_Name "LNAME",
  SPRIDEN_MI "MI",
  SPRIDEN_FIRST_NAME "FNAME",
  to_char(spbpers_birth_date,'yyyymmdd') "DOB",sgbstdn_styp_code "Student_Type",
  stvstyp_desc,NVL(sgbstdn_sess_code, 'Not Military') "Military Status"
FROM SFRSTCR, SPRIDEN, SGBSTDN,spbpers,stvstyp
where sgbstdn_styp_code=stvstyp_code
and spbpers_pidm=spriden_pidm
AND SFRSTCR_PIDM = SPRIDEN_PIDM
AND SGBSTDN_PIDM=sfrstcr_pidm
and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202010) --be mindful of this term date
  AND SPRIDEN_CHANGE_IND IS NULL
  AND SFRSTCR_TERM_CODE = 202110;

      --for military median program change count
select sfrstcr_term_code,sgbstdn_pidm,sgbstdn_styp_code,sgbstdn_sess_code,
count(distinct sgbstdn_majr_code_1) as "Enrolled_Program_Count"

from sgbstdn,sfrstcr,spriden

where sgbstdn_pidm=sfrstcr_pidm
and spriden_pidm=sfrstcr_pidm
 and sgbstdn_term_code_eff >= 202010 and sgbstdn_term_code_eff <= 202230
 
and sfrstcr_term_code >= 202010 and sfrstcr_term_code <= 202230

group by sfrstcr_term_code,sgbstdn_pidm,sgbstdn_styp_code,sgbstdn_sess_code;

--Fall 2020 ALL correct (2872 headcount):
select distinct sfrstcr_term_code "TERM",
  SPRIDEN_ID "CID",
 NVL(sgbstdn_sess_code, 'Not Military'),
 '15-AUG-20' "Start_Date",
  stvstyp_desc,
  (select shrdgmr_grad_date from shrdgmr b
    where b.shrdgmr_pidm (+) = spriden_pidm
      and b.shrdgmr_degs_code = 'AW'
      and b.shrdgmr_seq_no = (select max(c.shrdgmr_seq_no)
                               from shrdgmr c
                               where c.shrdgmr_pidm (+) = spriden_pidm
                                 and c.shrdgmr_degs_code = 'AW')) "Grad_Date"
                                 
FROM SFRSTCR, SPRIDEN, SGBSTDN,spbpers,stvstyp

where sgbstdn_styp_code=stvstyp_code
--and shrdgmr_pidm (+)=sfrstcr_pidm
   and spbpers_pidm=spriden_pidm
   AND SFRSTCR_PIDM = SPRIDEN_PIDM
   AND SGBSTDN_PIDM=sfrstcr_pidm
   and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
   AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202010) --be mindful of this term date
   AND SPRIDEN_CHANGE_IND IS NULL
   AND SFRSTCR_TERM_CODE = 202010;

--For grad median years mil vet
select distinct sfrstcr_term_code,sgbstdn_pidm,sgbstdn_styp_code,sgbstdn_sess_code,
count(distinct sgbstdn_majr_code_1) as "Enrolled_Program_Count"
                                 
FROM SFRSTCR, SPRIDEN, SGBSTDN

where sgbstdn_styp_code=stvstyp_code
--and shrdgmr_pidm (+)=sfrstcr_pidm
   and spbpers_pidm=spriden_pidm
   AND SFRSTCR_PIDM = SPRIDEN_PIDM
   AND SGBSTDN_PIDM=sfrstcr_pidm
   and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
   AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202010) --be mindful of this term date
   AND SPRIDEN_CHANGE_IND IS NULL;
   

--Query 1: Prog Changes
WITH CHANGE AS (select distinct SFRSTCR_pidm PIDM,count(distinct sgbstdn_majr_code_1) as Program_Change
 
from sfrstcr ,sgbstdn
 
where sfrstcr_pidm = sgbstdn_pidm
 
and sfrstcr_term_code = 202010 --Registered in Fall 202010
AND SGBSTDN_TERM_CODE_EFF <= 202230
AND SFRSTCR_RSTS_CODE IN('RE','RW','AU','AW','WS','WM')
 
group by SFRSTCR_pidm),

--Query 2: MILITARY status
MIL AS(select distinct SFRSTCR_pidm AS PIDM,NVL(sgbstdn_sess_code, 'Not Military') Military_Status
 
from sfrstcr ,sgbstdn
 
where sfrstcr_pidm = sgbstdn_pidm (+)

and sfrstcr_term_code = 202010 --Registered in Fall 202010
AND SFRSTCR_RSTS_CODE IN('RE','RW','AU','AW','WS','WM')
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)

                             FROM SGBSTDN A

                             WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM

                               AND A.SGBSTDN_TERM_CODE_EFF <= 202010))

--JOIN change and military together
SELECT CHANGE.PIDM,

       CHANGE.PROGRAM_CHANGE,

       MIL.MILITARY_STATUS

FROM CHANGE, MIL
 
WHERE CHANGE.PIDM = MIL.PIDM;

--avg GPA for military

select distinct sfrstcr_term_code,sgbstdn_sess_code,sgbstdn_pidm,shrlgpa_gpa

from sgbstdn,shrlgpa,sfrstcr

where shrlgpa_pidm=sgbstdn_pidm
and sgbstdn_pidm=sfrstcr_pidm
and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')

and sfrstcr_term_code >= 202230 and sfrstcr_term_code <= 202310;

--------------------
select * from (
SELECT DISTINCT SHRDGMR_PIDM PIDM,
    SHRDGMR_DEGC_CODE AWARD_TYPE,
    --SHRDGMR_MAJR_CODE_1 PROGRAM,
    ROUND((SHRDGMR_GRAD_DATE - SPBPERS_BIRTH_DATE)/365,0) AGE
 
FROM SHRDGMR, SPBPERS
 
WHERE SHRDGMR_PIDM = SPBPERS_PIDM
  AND SHRDGMR_GRAD_DATE >= '01-JUL-22' AND SHRDGMR_GRAD_DATE <= '30-JUN-23'
  AND SHRDGMR_DEGS_CODE = 'AW'
) sub1 order by 4 asc;

---------------------highest veteran outcomes: enrollment, graduation, retention

select distinct sfrstcr_term_code,sgbstdn_pidm,
shrdgmr_degs_code,stvmajr_desc,SGBSTDN_TERM_CODE_EFF

from shrdgmr,sgbstdn,sfrstcr,stvmajr

where shrdgmr_pidm=sgbstdn_pidm
and stvmajr_code=shrdgmr_majr_code_1
and sfrstcr_pidm=sgbstdn_pidm
and sgbstdn_sess_code ='V'

AND SFRSTCR_RSTS_CODE IN('RE','RW','AU','AW','WS','WM')
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                             FROM SGBSTDN A
                             WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                               AND A.SGBSTDN_TERM_CODE_EFF >= 202210)
                        
and SGBSTDN_TERM_CODE_EFF in ('202220')
and sfrstcr_term_code in ('202220');
 
 