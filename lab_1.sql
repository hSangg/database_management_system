-- cau 4
SELECT
    USERID
FROM
    S_EMP
WHERE
    ID = 23;

--cau 5
SELECT
    *
FROM
    (
        SELECT
            X1.FIRST_NAME,
            X1.LAST_NAME,
            X1.DEPT_ID
        FROM
            S_EMP  X1,
            S_DEPT X2
        WHERE
            X1.DEPT_ID = X2.ID
            AND (X2.ID = 50
            OR X2.ID = 10)
    ) X
ORDER BY
    X.LAST_NAME ASC;

--cau 6
SELECT
    *
FROM
    S_EMP
WHERE
    REGEXP_LIKE(LAST_NAME,
    'S')
    OR REGEXP_LIKE(FIRST_NAME,
    'S');

--cau 7
SELECT
    *
FROM
    S_EMP
WHERE
    TO_DATE(START_DATE,
    'DD-MON-RR') < TO_DATE('26/05/1991',
    'DD/MM/YYYY')
    AND TO_DATE(START_DATE,
    'DD-MON-RR') > TO_DATE('14/05/1990',
    'DD/MM/YYYY');

--cau 8
SELECT
    *
FROM
    S_EMP
WHERE
    SALARY BETWEEN 1000
    AND 2000;

--cau 9
SELECT
    LAST_NAME AS EMPLOYEE_NAME,
    SALARY    AS MONTHLY_SALARY
FROM
    S_EMP
WHERE
    (DEPT_ID = 31
    OR DEPT_ID = 50
    OR DEPT_ID = 42)
    AND SALARY > 1350;

--cau 10
SELECT
    *
FROM
    S_EMP
WHERE
    EXTRACT(YEAR FROM START_DATE) = 1990;

--cau 11
SELECT
    LAST_NAME,
    ID,
    (SALARY + 0.15*SALARY) SALARY
FROM
    S_EMP;

--cau 12
SELECT
    LAST_NAME,
    START_DATE,
    TO_CHAR(ADD_MONTHS(TO_DATE(START_DATE,
    'DD/MM/YYYY') /*DATE*/,
    6 /*INTEGER*/ ) + 2,
    'fmDdsp "of" Month YYYY') SALARY_INCREASE_DATE
FROM
    S_EMP;

--cau 13
SELECT
    *
FROM
    S_PRODUCT
WHERE
    REGEXP_LIKE(NAME,
    'ski',
    'i');

--cau 14
SELECT
    LAST_NAME,
    FLOOR(MONTHS_BETWEEN(START_DATE,
    SYSDATE)/(-1))
FROM
    S_EMP;

--cau 15
SELECT
    COUNT(*) SO_QUAN_LY
FROM
    (
        SELECT
            MANAGER_ID
        FROM
            S_EMP
        GROUP BY
            MANAGER_ID
        HAVING
            MANAGER_ID IS NOT NULL
    )
 --cau 16
    SELECT
        MAX(TOTAL) AS HIGHEST,
        MIN(TOTAL) AS LOWEST
    FROM
        S_ORD;

--cau 17
SELECT
    S_PRODUCT.NAME,
    S_PRODUCT.ID,
    QUANTITY
FROM
    S_ITEM,
    S_ORD,
    S_PRODUCT
WHERE
    S_ITEM.ORD_ID = S_ORD.ID
    AND S_ORD.ID = 101;

--cau 18
SELECT
    *
FROM
    S_CUSTOMER
    LEFT JOIN S_ORD
    ON S_CUSTOMER.ID = S_ORD.CUSTOMER_ID
ORDER BY
    S_CUSTOMER.ID;

--cau 19
SELECT
    S_CUSTOMER.ID,
    S_ITEM.PRODUCT_ID,
    S_ITEM.QUANTITY
FROM
    S_ORD,
    S_CUSTOMER,
    S_ITEM
WHERE
    S_ORD.TOTAL > 100000
    AND S_ORD.ID = S_ITEM.ORD_ID
    AND S_ORD.CUSTOMER_ID = S_CUSTOMER.ID;

--cau 20
SELECT
    *
FROM
    S_EMP
WHERE
    ID NOT IN (
        SELECT
            DISTINCT MANAGER_ID
        FROM
            S_EMP
        WHERE
            MANAGER_ID IS NOT NULL
    )
ORDER BY
    ID;

--cau 21
SELECT
    *
FROM
    S_PRODUCT
WHERE
    REGEXP_LIKE(NAME,
    '^Pro.*')
ORDER BY
    NAME;

--cau 22
SELECT
    NAME,
    SHORT_DESC
FROM
    S_PRODUCT
WHERE
    REGEXP_LIKE(SHORT_DESC,
    'bicycle',
    'i')
ORDER BY
    NAME;

--cau 23
SELECT
    SHORT_DESC
FROM
    S_PRODUCT
 --cau 24
    SELECT
        FIRST_NAME || ' ' || LAST_NAME || ' ( ' || TITLE || ' )'
    FROM
        S_EMP;

--cau 25
SELECT
    X.ID        MANAGER_ID,
    COUNT(X.ID) QUANLITY_EMPLOYEE
FROM
    (
        SELECT
            DISTINCT MANAGER_ID ID
        FROM
            S_EMP
        WHERE
            MANAGER_ID IS NOT NULL
        ORDER BY
            MANAGER_ID
    ) X
    JOIN S_EMP
    ON X.ID = S_EMP.MANAGER_ID
GROUP BY
    X.ID;

--cau 26
SELECT
    X.ID        MANAGER_ID,
    COUNT(X.ID) QUANLITY_EMPLOYEE
FROM
    (
        SELECT
            DISTINCT MANAGER_ID ID
        FROM
            S_EMP
        WHERE
            MANAGER_ID IS NOT NULL
        ORDER BY
            MANAGER_ID
    ) X
    JOIN S_EMP
    ON X.ID = S_EMP.MANAGER_ID
GROUP BY
    X.ID
HAVING
    COUNT(X.ID) > 20;

--cau 27
SELECT
    DISTINCT S_REGION.ID,
    S_REGION.NAME
FROM
    S_REGION,
    S_DEPT
WHERE
    S_REGION.ID = S_DEPT.REGION_ID
ORDER BY
    ID;

--cau 28
SELECT
    S_CUSTOMER.ID,
    COUNT(S_CUSTOMER.ID) AS QUANLITY
FROM
    S_CUSTOMER,
    S_ORD
WHERE
    S_CUSTOMER.ID = S_ORD.CUSTOMER_ID
GROUP BY
    S_CUSTOMER.ID;

--cau 29
SELECT
    CUSTOMER_ID
FROM
    S_CUSTOMER
    JOIN S_ORD
    ON S_CUSTOMER.ID = S_ORD.CUSTOMER_ID
GROUP BY
    CUSTOMER_ID
ORDER BY
    COUNT(CUSTOMER_ID) FETCH FIRST 1 ROWS ONLY;

--cau 30
SELECT
    CUSTOMER_ID
FROM
    S_CUSTOMER
    JOIN S_ORD
    ON S_CUSTOMER.ID = S_ORD.CUSTOMER_ID
GROUP BY
    CUSTOMER_ID
ORDER BY
    SUM(TOTAL) FETCH FIRST 1 ROWS ONLY;

--cau 31
SELECT
    FIRST_NAME,
    LAST_NAME,
    START_DATE
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
    );

--cau 32
SELECT
    ID,
    LAST_NAME,
    FIRST_NAME,
    USERID
FROM
    S_EMP
WHERE
    SALARY > (
        SELECT
            AVG(SALARY)
        FROM
            S_EMP
    );

--cau 33
SELECT
    ID,
    FIRST_NAME,
    LAST_NAME
FROM
    S_EMP
WHERE
    SALARY > (
        SELECT
            AVG(SALARY)
        FROM
            S_EMP
    )
    AND REGEXP_LIKE(LAST_NAME,
    '.*L.*',
    'i');

--cau 34
SELECT
    ID,
    NAME
FROM
    S_CUSTOMER
WHERE
    S_CUSTOMER.ID NOT IN (
        SELECT
            CUSTOMER_ID
        FROM
            S_ORD
    );