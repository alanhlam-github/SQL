SELECT DISTINCT SCBCRSE_TITLE, SSBSECT_CRN,SSBSECT_TERM_CODE,SSBSECT_SUBJ_CODE,SSBSECT_CRSE_NUMB,SSBSECT_SEQ_NUMB,

  (SELECT DISTINCT STVCOLL_DESC FROM STVCOLL S2
   WHERE S2.STVCOLL_CODE = SCBCRSE.SCBCRSE_COLL_CODE) AS SCHOOL,
   
  (SELECT DISTINCT STVDEPT_DESC FROM STVDEPT S2
   WHERE S2.STVDEPT_CODE = SCBCRSE.SCBCRSE_DEPT_CODE) AS DEPARTMENT,
  
  (SELECT DISTINCT STVCAMP_DESC FROM STVCAMP S2
   WHERE S2.STVCAMP_CODE = SSBSECT.SSBSECT_CAMP_CODE) AS CAMPUS,
   
  (SELECT DISTINCT STVTERM_DESC FROM STVTERM S2
   WHERE S2.STVTERM_CODE = SSBSECT.SSBSECT_TERM_CODE) AS TERM,

  CASE
    WHEN (SUBSTR(SSBSECT_SEQ_NUMB, 1, 1) = 'Z') THEN 'Virtual'
    WHEN (SUBSTR(SSBSECT_SEQ_NUMB, 1, 1) = 'H') THEN 'Hybrid'
    WHEN (SUBSTR(SSBSECT_SEQ_NUMB, 1, 1) = 'D') THEN 'Distance'
    ELSE 'Face-to-Face'
  END AS "MODALITY"

FROM SSBSECT,SCBCRSE

WHERE SSBSECT_SUBJ_CODE = SCBCRSE_SUBJ_CODE
AND SSBSECT_CRSE_NUMB = SCBCRSE_CRSE_NUMB

AND SCBCRSE_EFF_TERM = (SELECT MAX(A.SCBCRSE_EFF_TERM)
                          FROM SCBCRSE A
                          WHERE A.SCBCRSE_SUBJ_CODE = SSBSECT_SUBJ_CODE
                          AND A.SCBCRSE_CRSE_NUMB = SSBSECT_CRSE_NUMB)
                         --AND A.SCBCRSE_EFF_TERM <= SSBSECT_TERM_CODE) --this wasn't needed. I forgot why
                            
  --AND SSBSECT_TERM_CODE >= 201910
  --AND SSBSECT_TERM_CODE <= 202430 --don't know why this interfered with showing ENG classes in 201910 or 202310
  
 AND SSBSECT_TERM_CODE IN (201910,201920,201930,202010,202020,202030,202110,202120,202120,202210,202220,202230
,202310,202320,202330,202410,202420,202430,202510,202520,202530)
