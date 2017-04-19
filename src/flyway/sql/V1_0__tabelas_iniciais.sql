CREATE TABLE `horaconta`.`liquidacoes` ( 
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


CREATE TABLE `horaconta`.`parcelamentos` ( 
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


CREATE TABLE `horaconta`.`pagamentos` 
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
ALTER TABLE `horaconta`.`pagamentos` ADD CONSTRAINT `liquida_pagamento` FOREIGN KEY (`id_liquidacao`) REFERENCES `liquidacoes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `horaconta`.`pagamentos` ADD CONSTRAINT `parcela_pagamento` FOREIGN KEY (`id_parcelamento`) REFERENCES `parcelamentos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;


            