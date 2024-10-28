-- Exercício 1.2 - Cursor que exibe os nomes dos YouTubers em ordem reversa
DO $$
DECLARE
    cur_youtuber REFCURSOR; 
    v_youtuber RECORD;      
BEGIN
    -- 2. Abertura do cursor
    OPEN cur_youtuber SCROLL FOR
        SELECT youtuber
        FROM tb_top_youtubers
        ORDER BY youtuber ASC;

    -- Movendo o cursor para a última posição
    MOVE LAST FROM cur_youtuber;

    -- Inserindo um Loop para exibir os YouTubers de baixo para cima
    LOOP
        -- 3. Recuperação de dados
        FETCH PRIOR FROM cur_youtuber INTO v_youtuber;
        EXIT WHEN NOT FOUND;  
        RAISE NOTICE 'YouTuber: %', v_youtuber.youtuber; 
    END LOOP;

    -- 4. Fechamento do cursor
    CLOSE cur_youtuber;
END;
$$;