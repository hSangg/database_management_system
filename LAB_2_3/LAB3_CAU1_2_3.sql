--cau 2
DECLARE
    v_n NUMBER := &p_n;
    v_count NUMBER := 0;
    v_i NUMBER := 2;
    v_is_prime BOOLEAN := TRUE;
BEGIN
    WHILE v_count < v_n LOOP
        v_is_prime := TRUE;
        FOR j IN 2..v_i-1 LOOP
            IF v_i MOD j = 0 THEN
                v_is_prime := FALSE;
                EXIT;
            END IF;
        END LOOP;
        
        IF v_is_prime THEN
            DBMS_OUTPUT.PUT_LINE(v_i);
            v_count := v_count + 1;
        END IF;
        
        v_i := v_i + 1;
    END LOOP;
END;

--cau 3
DECLARE
    v_a NUMBER := &p_a;
    v_b NUMBER := &p_b;
    v_c NUMBER := &p_c;
    v_delta NUMBER;
BEGIN
    -- Tính delta
    v_delta := v_b * v_b - 4 * v_a * v_c;
    
    IF v_delta < 0 THEN
        DBMS_OUTPUT.PUT_LINE('Phuong trinh vo nghiem');
    ELSIF v_delta = 0 THEN
        DBMS_OUTPUT.PUT_LINE('Phuong trinh co nghiem kep x = ' || (-v_b/(2*v_a)));
    ELSE
        DBMS_OUTPUT.PUT_LINE('Phuong trinh co 2 nghiem phan biet');
        DBMS_OUTPUT.PUT_LINE('x1 = ' || ((-v_b + sqrt(v_delta))/(2*v_a)));
        DBMS_OUTPUT.PUT_LINE('x2 = ' || ((-v_b - sqrt(v_delta))/(2*v_a)));
    END IF;
END;
