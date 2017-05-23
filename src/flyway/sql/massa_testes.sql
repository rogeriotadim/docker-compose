-- Massa de testes
-- cleanup
DELETE FROM `pagamentos`;
DELETE FROM `parcelamentos`;
DELETE FROM `liquidacoes`;
DELETE FROM `users`;

-- Usuários
INSERT INTO `horaconta`.`users` (`id`, `created_at`, `updated_at`, `username`, `password`, `email`, `apikey`) VALUES
(1, '2017-02-10 12:12:00', '2017-02-10 12:12:00', 'ROG', '$2y$10$HI0yYsCLb79oud7cA9tRYO9MbBA.OBjVBrwhZ/qRCkbCje.s597Re', 'rogeriotadim@gmail.com', 'd0763edaa9d9bd2a9516280e9044d885'),
(2, '2017-02-10 12:12:00', '2017-02-10 12:12:00', 'PAT', '$2y$10$/q/y6jSUaoKdWW5u1NQLgePHJE6m5RGNCqXNkHbq7SyAmUkaOCAOO', 'sratadim.pat@gmail.com', 'd0763edaa9d9bd2a9516280e9044d000');


-- pagamentos
INSERT INTO `horaconta`.`pagamentos` (`id`, `created_at`, `updated_at`, `data_pagto`, `id_usuario`, `descricao`, `competencia`, `valor`) 
    VALUES  (1, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-02', 2, 'Tintas Carlos'         , '201702', 270),
            (2, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 2, 'Viagem 03 à 06/fev'    , '201702', 744),
            (3, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-07', 1, 'Pagto Carlos (Pintura)', '201702', 850);

INSERT INTO `horaconta`.`pagamentos` (`id`, `created_at`, `updated_at`, `data_pagto`, `id_usuario`, `descricao`, `competencia`, `valor`) 
    VALUES  (4, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-02', 2, 'cta Luz Fev Atrasada'                 , '201704',  20.63),
            (5, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 2, 'cta Luz'                              , '201704',  54.18),
            (6, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-07', 2, 'Loja 1,99 - vários'                   , '201704', 198.10),
            (7, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-07', 2, 'Peças Cozinha'                        , '201704',  87.10),
            (8, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 1, 'Internet'                             , '201704',  72.37),
            (9, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 1, 'Tx Embarque Viagem 17-19/03'          , '201704',  52.12),
            (10, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 1, 'Smiles & Money 17-19/03 (6750Milhas)' , '201704', 202.50),
            (11, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 1, 'C&C MANUEL GAYA                     ' , '201704', 204.00),
            (12, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 1, 'Azul Pat 31/03                      ' , '201704', 457.57);

-- parcelamentos
insert into `horaconta`.`parcelamentos` (`id`, `created_at`, `updated_at`, `data_compra`, `descricao`, `competencia_inicial`, `id_usuario`, `valor_total`, `numero_parcelas`)
    VALUES  (1, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2016-10-13','Avianca Pat','201611',1,2120.64,6),
            (2, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2016-10-11','Viagem Pat 28-31/10','201611',1,757.63,12),
            (3, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2016-10-29','Reemissão Viagem Pat 28-31/10','201612',1,629.76,12),
            (4, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-26','Joli - Materiais para Casa','201703',1,398.72,7),
            (5, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-03-09','AirBnb','201703',1,222,3),
            (6, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-03-09','Viagem Pat 10-13/03 para JPA','201703',1,1360.19,12),
            (7, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-03-16','Viagem Rog 17-19/03','201704',1,640.44,12),
            (8, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-03-29','Voo Pat 03/04 p/ CGH','201704',1,572.39,6),
            (9, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-03-29','Voo Pat 03/04 p/ CGH','201704',1,572.39,6);

-- pagamentos do parcelamento 9
INSERT INTO `horaconta`.`pagamentos` (`id`, `id_parcelamento`, `created_at`, `updated_at`, `data_pagto`, `id_usuario`, `descricao`, `competencia`, `valor`) 
    VALUES  (14, 9, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-02', 2, 'só na gastança'    , '201704',  20.63),
            (15, 9, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 2, 'cta avião'         , '201704',  54.18),
            (16, 9, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-07', 2, 'Lojão 1,99'        , '201704', 198.10),
            (17, 9, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-07', 2, 'Peças Ferrari'     , '201704',  87.10),
            (18, 9, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 1, 'Intranet'          , '201704',  72.37),
            (19, 9, '2017-02-10 12:12:00', '2017-02-10 12:12:00', '2017-02-05', 1, 'Viagem 17-19/03'   , '201704',  52.12);

-- liquidações
INSERT INTO `horaconta`.`liquidacoes` (`id`, `created_at`, `updated_at`, `competencia`, `saldo`, `recebedor`,`descricao`)
    VALUES  (1, '2017-02-10 12:12:00', '2017-02-10 12:12:00', 201703, 125.30, 2, 'Liquidação de Teste');

-- pagamentos da liquidação 1
INSERT INTO `horaconta`.`pagamentos` (`id`, `id_liquidacao`, `created_at`, `updated_at`, `data_pagto`, `id_usuario`, `descricao`, `competencia`, `valor`) 
    VALUES  (20, 1, '2017-04-10 12:12:00', '2017-04-10 12:12:00', '2017-04-02', 2, 'Teste Liquida 1 - 25'    , '201704',  25.30),
            (21, 1, '2017-04-10 12:12:00', '2017-04-10 12:12:00', '2017-04-05', 2, 'cta avião'         , '201704',  40.50),
            (22, 1, '2017-04-10 12:12:00', '2017-04-10 12:12:00', '2017-04-07', 2, 'Lojão 1,99'        , '201704', 59.50);

