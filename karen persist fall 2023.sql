SELECT SFRSTCR_TERM_CODE,SFRSTCR_PIDM,STVHLDD_CODE,STVHLDD_DESC

FROM SFRSTCR

JOIN SPRHOLD
ON SFRSTCR_PIDM = SPRHOLD_PIDM

JOIN STVHLDD
ON SPRHOLD_HLDD_CODE = STVHLDD_CODE

JOIN SGBSTDN
ON SFRSTCR_PIDM = SGBSTDN_PIDM

JOIN SHRTCKG
ON SFRSTCR_PIDM = SHRTCKG_PIDM
AND SFRSTCR_TERM_CODE = SHRTCKG_TERM_CODE

AND SFRSTCR_TERM_CODE = 202310

ORDER BY SFRSTCR_TERM_CODE
--AND SFRSTCR_TERM_CODE <= 202320;

/*
AND SGBSTDN_TERM_CODE_EFF = (SELECT MAX(A.SGBSTDN_TERM_CODE_EFF)
                                FROM SGBSTDN A
                                WHERE A.SGBSTDN_PIDM = SFRSTCR_PIDM
                                  AND A.SGBSTDN_TERM_CODE_EFF >= SFRSTCR_TERM_CODE)*/
                                  
