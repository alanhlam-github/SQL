--Save this script because it'll be done annually

select (select STVCOLL.STVCOLL_DESC from STVCOLL where SGBSTDN.SGBSTDN_COLL_CODE_1 = STVCOLL.STVCOLL_CODE ) "College",
        (select STVDEGC.STVDEGC_DESC from STVDEGC where  SGBSTDN.SGBSTDN_DEGC_CODE_1 = STVDEGC.STVDEGC_CODE) "Degree",
        (select STVMAJR.STVMAJR_DESC from  STVMAJR where SGBSTDN.SGBSTDN_MAJR_CODE_1 = STVMAJR.STVMAJR_CODE)"Major",
       SPRIDEN.SPRIDEN_ID "ID",
       SGBSTDN.SGBSTDN_COLL_CODE_1,
       SGBSTDN.SGBSTDN_DEGC_CODE_1 ,
       SGBSTDN.SGBSTDN_MAJR_CODE_1 ,
       spriden_last_name||', '||spriden_first_name "Name",
       spbpers.spbpers_sex "Gender",
       SGBSTDN.SGBSTDN_STYP_CODE "Type",
      (select  STVSTYP.STVSTYP_DESC from STVSTYP where STVSTYP.STVSTYP_CODE = SGBSTDN.SGBSTDN_STYP_CODE)   "Student Type",
      (select  shrdgmr.SHRDGMR_degs_code from SHRDGMR where SHRDGMR.shrdgmr_pidm = sgbstdn.sgbstdn_pidm) "Awarded",
      (select  sfrstcr.sfrstcr_term_code from sfrstcr where sfrstcr.sfrstcr_pidm = sgbstdn.sgbstdn_pidm) "Term"
from stvstyp, sgbstdn, spriden,spbpers,SHRDGMR,sfrstcr;

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
  and shrdgmr_degs_code = 'AW'
  and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
  and shrdgmr_grad_date <= '01-AUG-22'; --graduation date cut off
  

--First time freshmen for 201410 - Fall 2014:
select distinct sfrstcr_term_code "TERM",SPRIDEN_ID "ID",
  SPRIDEN_LAST_Name "LNAME",
  SPRIDEN_MI "MI",
  SPRIDEN_FIRST_NAME "FNAME",
  to_char(spbpers_birth_date,'yyyymmdd') "DOB",sgbstdn_styp_code "Student_Type",stvstyp_desc
  
FROM SFRSTCR, SPRIDEN, SGBSTDN,spbpers,stvstyp

where sgbstdn_styp_code=stvstyp_code

and spbpers_pidm=spriden_pidm
AND SFRSTCR_PIDM = SPRIDEN_PIDM
AND SGBSTDN_PIDM=sfrstcr_pidm
and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 201410)
  AND SPRIDEN_CHANGE_IND IS NULL
  AND SFRSTCR_TERM_CODE = 201410
and sgbstdn_styp_code='S';

--new line

select distinct SPRIDEN_ID "ID",
  SPRIDEN_LAST_Name "LNAME",
  SPRIDEN_MI "MI",
  SPRIDEN_FIRST_NAME "FNAME",
  to_char(spbpers_birth_date,'yyyymmdd') "DOB"
  
FROM SFRSTCR, SPRIDEN, SGBSTDN,spbpers

where SFRSTCR_PIDM = SPRIDEN_PIDM
and spbpers_pidm=spriden_pidm
AND SGBSTDN_PIDM=sfrstcr_pidm
and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF >= 202210)
  AND SPRIDEN_CHANGE_IND IS NULL
