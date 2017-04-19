CREATE TABLE `ctacasal`.`liquidacoes` ( 
    `id` INT NOT NULL AUTO_INCREMENT , 
    `data_registro` DATE NOT NULL , 
    `competencia` INT(6) NOT NULL , 
    `saldo` DECIMAL NOT NULL , 
    `recebedor` CHAR(3) NOT NULL , 
    `descricao` VARCHAR(255) NOT NULL , 
    PRIMARY KEY (`id`), 
    INDEX `data_registro_idx` (`data_registro`), 
    UNIQUE `comp_liquida_idx` (`competencia`)) 
    ENGINE = InnoDB;


CREATE TABLE `ctacasal`.`parcelamentos` ( 
    `id` INT NOT NULL AUTO_INCREMENT , 
    `data_registro` DATE NOT NULL , 
    `data_compra` DATE NOT NULL , 
    `descricao` VARCHAR(255) NOT NULL , 
    `competencia_inicial` INT(6) NOT NULL , 
    `comprador` CHAR(3) NOT NULL , 
    `valor_total` DECIMAL NOT NULL , 
    `numero_parcelas` INT(2) NOT NULL , 
    PRIMARY KEY (`id`), 
    INDEX `parcelamento_data_registro_idx` (`data_registro`), 
    INDEX `comp_inicial_idx` (`competencia_inicial`)) 
    ENGINE = InnoDB;


CREATE TABLE `ctacasal`.`pagamentos` 
    ( `id` BIGINT NOT NULL AUTO_INCREMENT , 
    `data_registro` DATE NOT NULL , 
    `data_pagto` DATE NOT NULL , 
    `pagador` CHAR(3) NOT NULL , 
    `descricao` VARCHAR(255) NOT NULL , 
    `competencia` INT(6) NOT NULL , 
    `valor` DECIMAL NOT NULL DEFAULT '0' , 
    `id_liquidacao` INT NULL, 
    `id_parcelamento` INT NULL, 
    PRIMARY KEY (`id`), 
    INDEX `data_pagamento_idx` (`data_pagto`), 
    INDEX `pagador_idx` (`pagador`), 
    INDEX `competencia_idx` (`competencia`),
    INDEX `comp_pagto_idx` (`competencia`,`data_pagto`),
    INDEX `liquidacao_idx` (`id_liquidacao`),
    INDEX `parcelamento_idx` (`id_parcelamento`))
    ENGINE = InnoDB;

-- CONSTRAINTS
ALTER TABLE `pagamentos` ADD CONSTRAINT `liquida_pagamento` FOREIGN KEY (`id_liquidacao`) REFERENCES `liquidacoes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `pagamentos` ADD CONSTRAINT `parcela_pagamento` FOREIGN KEY (`id_parcelamento`) REFERENCES `parcelamentos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;


-- Massa de testes
INSERT INTO `pagamentos` (`data_registro`, `data_pagto`, `pagador`, `descricao`, `competencia`, `valor`) 
    VALUES  ('2017-02-05', '2017-02-02', 'PAT', 'Tintas Carlos'         , '201702', '270'),
            ('2017-02-12', '2017-02-05', 'PAT', 'Viagem 03 à 06/fev'    , '201702', '744'),
            ('2017-02-28', '2017-02-07', 'ROG', 'Pagto Carlos (Pintura)', '201702', '850');

INSERT INTO `pagamentos` (`data_registro`, `data_pagto`, `pagador`, `descricao`, `competencia`, `valor`) 
    VALUES  ('2017-04-24', '2017-02-02', 'PAT', 'cta Luz Fev Atrasada'                 , '201704',  '20.63'),
            ('2017-04-24', '2017-02-05', 'PAT', 'cta Luz'                              , '201704',  '54.18'),
            ('2017-04-24', '2017-02-07', 'PAT', 'Loja 1,99 - vários'                   , '201704', '198.10'),
            ('2017-04-24', '2017-02-07', 'PAT', 'Peças Cozinha'                        , '201704',  '87.10'),
            ('2017-04-24', '2017-02-05', 'ROG', 'Internet'                             , '201704',  '72.37'),
            ('2017-04-24', '2017-02-05', 'ROG', 'Tx Embarque Viagem 17-19/03'          , '201704',  '52.12'),
            ('2017-04-24', '2017-02-05', 'ROG', 'Smiles & Money 17-19/03 (6750Milhas)' , '201704', '202.50'),
            ('2017-04-24', '2017-02-05', 'ROG', 'C&C MANUEL GAYA                     ' , '201704', '204.00'),
            ('2017-04-24', '2017-02-05', 'ROG', 'Azul Pat 31/03                      ' , '201704', '457.57');

-- parcelamentos
insert into parcelamentos (`data_registro`, `data_compra`, `descricao`, `competencia_inicial`, `comprador`, `valor_total`, `numero_parcelas`)
    VALUES  ('20170406','2016-10-13','Avianca Pat','201611','ROG','2120,64',6),
            ('20170406','2016-10-11','Viagem Pat 28-31/10','201611','ROG','757,63',12),
            ('20170406','2016-10-29','Reemissão Viagem Pat 28-31/10','201612','ROG','629,76',12),
            ('20170406','2017-02-26','Joli - Materiais para Casa','201703','ROG','398,72',7),
            ('20170406','2017-03-09','AirBnb','201703','ROG','222',3),
            ('20170406','2017-03-09','Viagem Pat 10-13/03 para JPA','201703','ROG','1360,19',12),
            ('20170406','2017-03-16','Viagem Rog 17-19/03','201704','ROG','640,44',12),
            ('20170406','2017-03-29','Voo Pat 03/04 p/ CGH','201704','ROG','572,39',6);


            