WITH Cohort AS 

(select distinct 

sfrstcr_term_code AS TERM,sfrstcr_pidm AS PIDM,
substr(SFRSTCR_TERM_CODE,1,4) AY,sgbstdn_styp_code,

(select sum(SHRTGPA_HOURS_EARNED)
FROM SHRTGPA
WHERE SHRTGPA_PIDM=SFRSTCR_PIDM
AND SUBSTR(SHRTGPA_TERM_CODE,1,4)=SUBSTR(SFRSTCR_TERM_CODE,1,4)) Hours_Earned,

(select SHRTGPA_HOURS_ATTEMPTED
FROM SHRTGPA
WHERE SHRTGPA_PIDM=SFRSTCR_PIDM
AND SHRTGPA_TERM_CODE=SFRSTCR_TERM_CODE
and shrtgpa_gpa_type_ind='I') Hours_Attempted

from sfrstcr,sgbstdn

where sfrstcr_pidm=sgbstdn_pidm

and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')

and sfrstcr_term_code LIKE '20%'

AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= sfrstcr_term_code)
                                  
AND SFRSTCR_TERM_CODE IN ('201710','201810','201910','202010','202110','202210','202310')
and sgbstdn_styp_code IN ('T','F','S')) --ADDED T AND F

SELECT TERM,COUNT (distinct PIDM) Enrolled,
(select count (distinct A.PIDM) FROM Cohort A
where A.TERM = Cohort.Term
and A.Hours_earned >= 15
and A.Hours_Attempted < 12) "15 or more"

FROM Cohort
WHERE Hours_Attempted < 12
GROUP BY TERM
ORDER BY TERM