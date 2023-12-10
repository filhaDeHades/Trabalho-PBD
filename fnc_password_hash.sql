CREATE EXTENSION IF NOT EXISTS pgcrypto; -- Necessário para utilizar o gen_salt('bf')

CREATE OR REPLACE FUNCTION hash_senha(senha_text VARCHAR)
RETURNS VARCHAR AS $$
BEGIN
    RETURN crypt(senha_text, gen_salt('bf'));
END;
$$ LANGUAGE plpgsql;
