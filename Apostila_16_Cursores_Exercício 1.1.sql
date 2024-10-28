-- Criando tabela para importar os dados
CREATE TABLE IF NOT EXISTS tb_top_youtubers (
    cod_top_youtubers SERIAL PRIMARY KEY,
    rank INT,
    youtuber VARCHAR(200),
    subscribers BIGINT,
    video_views BIGINT,
    video_count INT,
    category VARCHAR(200),
    started INT
);

-- Exercício 1.1 - Desenvolvendo Cursor para exibir 'rank' e 'youtuber' para tuplas que 
-- atendem aos critérios
DO $$
DECLARE
    cur_rank_youtuber REFCURSOR; 
    v_tupla RECORD;               
BEGIN
    -- 2. Abertura do cursor
    OPEN cur_rank_youtuber FOR 
        SELECT rank, youtuber
        FROM tb_top_youtubers
        WHERE video_count >= 1000 
          AND category IN ('Sports', 'Music');
    
    LOOP
        -- 3. Recuperando dados
        FETCH cur_rank_youtuber INTO v_tupla;
        EXIT WHEN NOT FOUND; 
        RAISE NOTICE 'Rank: %, YouTuber: %', v_tupla.rank, v_tupla.youtuber; 
    END LOOP;

    -- 4. Fechamento do cursor
    CLOSE cur_rank_youtuber; 
END;
$$;

