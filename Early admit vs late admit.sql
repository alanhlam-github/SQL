select distinct sfrstcr_pidm

FROM SFRSTCR, SPRIDEN, SGBSTDN,saradap,stvterm

where SFRSTCR_PIDM = SPRIDEN_PIDM
and sfrstcr_term_code=stvterm_code
and spriden_pidm=saradap_pidm(+)
--and saradap_term_code_entry=stvterm_code
AND SGBSTDN_PIDM=sfrstcr_pidm
and SFRSTCR_RSTS_CODE IN ('RE','RW','AU','AW','WS','WM')
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF <= 202210)
  AND SPRIDEN_CHANGE_IND IS NULL
  and stvterm_code = 202210