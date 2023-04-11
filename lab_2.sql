--cau 22

--cau 29

--cau 30
SELECT
    *
FROM
    S_EMP
WHERE
    DEPT_ID = (
        SELECT
            DEPT_ID
        FROM
            S_EMP
        WHERE
            LAST_NAME = 'Lan'
    )

--cau 31
SELECT
    Id, FIRST_NAME, LAST_NAME, USERID
FROM
    S_EMP
WHERE
    S_EMP.SALARY >=
    (SELECT
        AVG(S_EMP.SALARY /*[ DISTINCT | ALL ] EXPR*/ )
    FROM
        S_EMP)


--cau 32
SELECT
    Id, FIRST_NAME, LAST_NAME, USERID
FROM
    S_EMP
WHERE
    S_EMP.SALARY >=
    (SELECT
        AVG(S_EMP.SALARY /*[ DISTINCT | ALL ] EXPR*/ )
    FROM
        S_EMP)
        AND REGEXP_LIKE(S_EMP.LAST_NAME,
        'L',
        'i');
--cau 33
SELECT
    *
FROM
    S_CUSTOMER
WHERE
    S_CUSTOMER.id NOT IN (
        SELECT
            DISTINCT CUSTOMER_ID
        FROM
            S_ORD
    )