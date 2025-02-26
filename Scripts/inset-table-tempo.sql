WITH Datas AS (
    SELECT d::DATE AS data
    FROM generate_series('1996-01-01'::date, '1998-12-31'::date, '1 day'::interval) AS t(d)
)
INSERT INTO Tempo (data, ano, trimestre, mes, dia, diadasemana, nomedomes)
SELECT data,
       to_char(data, 'YYYY')::INTEGER,  -- Conversão para inteiro
       (to_char(data, 'MM')::INTEGER - 1) / 3 + 1,
       to_char(data, 'MM')::INTEGER,  -- Conversão para inteiro
       to_char(data, 'DD')::INTEGER,  -- Conversão para inteiro
       to_char(data, 'D')::INTEGER,
       to_char(data, 'YYYY-MM')
FROM Datas;