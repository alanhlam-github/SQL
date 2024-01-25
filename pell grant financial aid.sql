
select distinct sfrstcr_term_code,spriden_id,

case when spriden_pidm in(
select distinct rprawrd_pidm
from RPRAWRD
where rprawrd_fund_code='SWST'
and rprawrd_paid_amt != 0
and rprawrd_aidy_code = 2223) then 'YES' else 'NO'

END
"Paid or Not"

from sgbstdn,spriden,sfrstcr

where sgbstdn_pidm=spriden_pidm
and sfrstcr_pidm=spriden_pidm
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202210)
  and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
and sfrstcr_term_code = 202210
AND SPRIDEN_CHANGE_IND IS NULL --count is 2946 for fall 2023;commit test