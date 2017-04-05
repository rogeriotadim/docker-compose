CREATE TABLE `ctacasal`.`liquidacao` ( 
    `id` INT NOT NULL AUTO_INCREMENT , 
    `data_registro` DATE NOT NULL , 
    `recebedor` CHAR(3) NOT NULL , 
    `saldo` DECIMAL NOT NULL , 
    `competencia` INT(6) NOT NULL , 
    PRIMARY KEY (`id`), 
    INDEX `data_registro_idx` (`data_registro`), 
    UNIQUE `comp_liquida_idx` (`competencia`)) 
    ENGINE = InnoDB;


CREATE TABLE `ctacasal`.`pagamento` 
    ( `id` BIGINT NOT NULL AUTO_INCREMENT , 
    `data_registro` DATE NOT NULL , 
    `data_pagto` DATE NOT NULL , 
    `pagador` CHAR(3) NOT NULL , 
    `descricao_pagto` VARCHAR(255) NOT NULL , 
    `competencia` INT(6) NOT NULL , 
    `valor` DECIMAL NOT NULL DEFAULT '0' , 
    `id_liquidacao` INT NULL, 
    PRIMARY KEY (`id`), 
    INDEX `data_pagamento_idx` (`data_pagto`), 
    INDEX `pagador_idx` (`pagador`), 
    INDEX `competencia_idx` (`competencia`),
    INDEX `comp_pagto_idx` (`competencia`,`data_pagto`))
    ENGINE = InnoDB;

-- CONSTRAINTS
ALTER TABLE `pagamento` ADD CONSTRAINT `liquida_pagamento` FOREIGN KEY (`id_liquidacao`) REFERENCES `liquidacao`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;


-- Massa de testes
INSERT INTO `pagamento` (`data_registro`, `data_pagto`, `pagador`, `descricao_pagto`, `competencia`, `valor`) 
    VALUES  ('2017-02-05', '2017-02-02', 'PAT', 'Tintas Carlos'         , '201702', '270'),
            ('2017-02-12', '2017-02-05', 'PAT', 'Viagem 03 à 06/fev'    , '201702', '744'),
            ('2017-02-28', '2017-02-07', 'ROG', 'Pagto Carlos (Pintura)', '201702', '850');

INSERT INTO `pagamento` (`data_registro`, `data_pagto`, `pagador`, `descricao_pagto`, `competencia`, `valor`) 
    VALUES  ('2017-04-24', '2017-02-02', 'PAT', 'cta Luz Fev Atrasada'  , '201704',  '20.63'),
            ('2017-04-24', '2017-02-05', 'PAT', 'cta Luz'               , '201704',  '54.18'),
            ('2017-04-24', '2017-02-07', 'PAT', 'Loja 1,99 - vários'    , '201704', '198.10'),
            ('2017-04-24', '2017-02-07', 'PAT', 'Peças Cozinha'         , '201704',  '87.10'),
            ('2017-04-24', '2017-02-05', 'ROG', 'Internet'              , '201704',      '0');

            