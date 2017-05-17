SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET time_zone = "+00:00";

-- Usuários
CREATE TABLE `horaconta`.`users` (
    `id` int(10) NOT NULL,
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `username` varchar(32) NOT NULL,
    `password` varchar(64) NOT NULL,
    `email` varchar(50) NOT NULL,
    `apikey` varchar(255) NOT NULL,
    PRIMARY KEY (`id`), 
    INDEX `apikey_idx` (`apikey`), 
    UNIQUE `email_idx` (`email`)) 
    ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
 
-- Negócio
-- Liquidações
CREATE TABLE `horaconta`.`liquidacoes` ( 
    `id` INT NOT NULL AUTO_INCREMENT , 
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `competencia` INT(6) NOT NULL , 
    `saldo` DECIMAL (10,2) NOT NULL , 
    `recebedor` CHAR(3) NOT NULL , 
    `descricao` VARCHAR(255) NOT NULL , 
    PRIMARY KEY (`id`), 
    INDEX `liquidacoes_created_at_idx` (`created_at`), 
    UNIQUE `comp_liquida_idx` (`competencia`)) 
    ENGINE=InnoDB AUTO_INCREMENT=1 DEFAULT CHARSET=latin1;


-- Parcelamentos
CREATE TABLE `horaconta`.`parcelamentos` ( 
    `id` INT NOT NULL AUTO_INCREMENT , 
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `data_compra` DATE NOT NULL , 
    `descricao` VARCHAR(255) NOT NULL , 
    `competencia_inicial` INT(6) NOT NULL , 
    `id_usuario` int(10) NOT NULL , 
    `valor_total` DECIMAL (10,2) NOT NULL , 
    `numero_parcelas` INT(2) NOT NULL , 
    PRIMARY KEY (`id`), 
    INDEX `parcelamento_created_at_idx` (`created_at`), 
    INDEX `comp_inicial_idx` (`competencia_inicial`)) 
    ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=latin1;

ALTER TABLE `horaconta`.`parcelamentos` ADD CONSTRAINT `usuario_parcelamento` FOREIGN KEY (`id_usuario`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;            


-- Pagamentos
CREATE TABLE `horaconta`.`pagamentos` (
    `id` BIGINT NOT NULL AUTO_INCREMENT , 
    `created_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `updated_at` TIMESTAMP NOT NULL DEFAULT CURRENT_TIMESTAMP, 
    `data_pagto` DATE NOT NULL , 
    `descricao` VARCHAR(255) NOT NULL , 
    `competencia` INT(6) NOT NULL , 
    `valor` DECIMAL (10,2) NOT NULL DEFAULT '0' , 
    `id_liquidacao` INT NULL, 
    `id_parcelamento` INT NULL, 
    `id_usuario` int(10) NOT NULL, 
    PRIMARY KEY (`id`), 
    INDEX `data_pagamento_idx` (`data_pagto`), 
    INDEX `usuario_idx` (`id_usuario`), 
    INDEX `competencia_pagamento_idx` (`competencia`),
    INDEX `comp_pagto_idx` (`competencia`,`data_pagto`),
    INDEX `liquidacao_idx` (`id_liquidacao`),
    INDEX `parcelamento_idx` (`id_parcelamento`))
    ENGINE=InnoDB AUTO_INCREMENT=101 DEFAULT CHARSET=latin1;

ALTER TABLE `horaconta`.`pagamentos` ADD CONSTRAINT `liquida_pagamento` FOREIGN KEY (`id_liquidacao`) REFERENCES `liquidacoes`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `horaconta`.`pagamentos` ADD CONSTRAINT `parcela_pagamento` FOREIGN KEY (`id_parcelamento`) REFERENCES `parcelamentos`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;
ALTER TABLE `horaconta`.`pagamentos` ADD CONSTRAINT `usuario_pagamento` FOREIGN KEY (`id_usuario`) REFERENCES `users`(`id`) ON DELETE CASCADE ON UPDATE CASCADE;

