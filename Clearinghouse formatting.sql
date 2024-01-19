/*READ ME - things that need to be changed are the SEARCH DATE and the where conditions.
The conditions in the main query need to match the trailer row to get the correct headcount.
Check T1 headcount by right clicking and COUNT ROWS. */



/*select distinct 'H1',
'003995',
'00',
'Central Carolina Technical College',
to_char(sysdate,'yyyymmdd'),
'SE',
'I',
' ',
' ',
' ',
' ',
' '
from spriden

union all --rbind()*/

select distinct 'D1' H1,
'' "003995",
spriden_first_name "00",
substr(SPRIDEN_MI,1,1) "Central Carolina Technical College",
SPRIDEN_last_NAME "YYYYMMDD",
' ',
to_char(spbpers_birth_date,'yyyymmdd'),
'19990101',                                     --SEARCH DATE NEEDS TO BE CHANGED!!!!!!!!!!!!!!
' ',
'003995',
'00',
spriden_ID
  
FROM SFRSTCR, SPRIDEN, SGBSTDN,spbpers

where SFRSTCR_PIDM = SPRIDEN_PIDM
and spbpers_pidm=spriden_pidm
AND SGBSTDN_PIDM=sfrstcr_pidm
and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202210)
  AND SPRIDEN_CHANGE_IND IS NULL
  and sfrstcr_term_code = 202320
  
union all

select 'T1',
to_char(count (distinct spriden_pidm)),
' ',
' ',
' ',
' ',
' ',
' ',
' ',
' ',
' ',
' '

FROM SFRSTCR, SPRIDEN, SGBSTDN,spbpers

where SFRSTCR_PIDM = SPRIDEN_PIDM
and spbpers_pidm=spriden_pidm
AND SGBSTDN_PIDM=sfrstcr_pidm
and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202210)
  AND SPRIDEN_CHANGE_IND IS NULL
  and sfrstcr_term_code = 202320