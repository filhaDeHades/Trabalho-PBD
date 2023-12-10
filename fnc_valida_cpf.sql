CREATE OR REPLACE FUNCTION valida_cpf(cpf_text VARCHAR(11))
RETURNS BOOLEAN AS $$
DECLARE
    cpf_array INT[];
    i INT;
    soma1 INT := 0;
    soma2 INT := 0;
BEGIN
    -- Verifica se o CPF possui 11 dígitos
    IF length(cpf_text) <> 11 THEN
        RETURN FALSE;
    END IF;

    -- Converte o CPF para um array de inteiros
    FOR i IN 1..11 LOOP
        cpf_array[i] := CAST(substring(cpf_text FROM i FOR 1) AS INT);
    END LOOP;

    -- Calcula o primeiro dígito verificador
    FOR i IN 1..9 LOOP
        soma1 := soma1 + (cpf_array[i] * (11 - i));
    END LOOP;
    soma1 := (soma1 * 10) % 11;
    IF soma1 = 10 THEN
        soma1 := 0;
    END IF;

    -- Calcula o segundo dígito verificador
    FOR i IN 1..10 LOOP
        soma2 := soma2 + (cpf_array[i] * (12 - i));
    END LOOP;
    soma2 := (soma2 * 10) % 11;
    IF soma2 = 10 THEN
        soma2 := 0;
    END IF;

    -- Verifica se os dígitos verificadores estão corretos
    IF soma1 = cpf_array[10] AND soma2 = cpf_array[11] THEN
        RETURN TRUE;
    ELSE
        RETURN FALSE;
    END IF;
END;
$$ LANGUAGE plpgsql;
