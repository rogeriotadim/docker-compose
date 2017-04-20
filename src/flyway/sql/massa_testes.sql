-- Massa de testes
-- Usuários
INSERT INTO `horaconta`.`users` (`id`, `username`, `password`, `email`, `apikey`) VALUES
(1, 'ROG', '000c285457fc971f862a79b786476c78812c8897063c6fa9c045f579a3b2d63f', 'rogeriotadim@gmail.com', 'd0763edaa9d9bd2a9516280e9044d885'),
(2, 'PAT', '4d6b96d1e8f9bfcd28169bafe2e17da6e1a95f71e8ca6196d3affb4f95ca809f', 'sratadim.pat@gmail.com', 'd0763edaa9d9bd2a9516280e9044d000');



INSERT INTO `horaconta`.`pagamentos` (`data_pagto`, `id_usuario`, `descricao`, `competencia`, `valor`) 
    VALUES  ('2017-02-02', 2, 'Tintas Carlos'         , '201702', 270),
            ('2017-02-05', 2, 'Viagem 03 à 06/fev'    , '201702', 744),
            ('2017-02-07', 1, 'Pagto Carlos (Pintura)', '201702', 850);

INSERT INTO `horaconta`.`pagamentos` (`data_pagto`, `id_usuario`, `descricao`, `competencia`, `valor`) 
    VALUES  ('2017-02-02', 2, 'cta Luz Fev Atrasada'                 , '201704',  20.63),
            ('2017-02-05', 2, 'cta Luz'                              , '201704',  54.18),
            ('2017-02-07', 2, 'Loja 1,99 - vários'                   , '201704', 198.10),
            ('2017-02-07', 2, 'Peças Cozinha'                        , '201704',  87.10),
            ('2017-02-05', 1, 'Internet'                             , '201704',  72.37),
            ('2017-02-05', 1, 'Tx Embarque Viagem 17-19/03'          , '201704',  52.12),
            ('2017-02-05', 1, 'Smiles & Money 17-19/03 (6750Milhas)' , '201704', 202.50),
            ('2017-02-05', 1, 'C&C MANUEL GAYA                     ' , '201704', 204.00),
            ('2017-02-05', 1, 'Azul Pat 31/03                      ' , '201704', 457.57);

-- parcelamentos
insert into `horaconta`.`parcelamentos` (`data_compra`, `descricao`, `competencia_inicial`, `id_usuario`, `valor_total`, `numero_parcelas`)
    VALUES  ('2016-10-13','Avianca Pat','201611',1,2120.64,6),
            ('2016-10-11','Viagem Pat 28-31/10','201611',1,757.63,12),
            ('2016-10-29','Reemissão Viagem Pat 28-31/10','201612',1,629.76,12),
            ('2017-02-26','Joli - Materiais para Casa','201703',1,398.72,7),
            ('2017-03-09','AirBnb','201703',1,222,3),
            ('2017-03-09','Viagem Pat 10-13/03 para JPA','201703',1,1360.19,12),
            ('2017-03-16','Viagem Rog 17-19/03','201704',1,640.44,12),
            ('2017-03-29','Voo Pat 03/04 p/ CGH','201704',1,572.39,6);
