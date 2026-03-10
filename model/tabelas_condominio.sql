-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema mydb
-- -----------------------------------------------------
-- -----------------------------------------------------
-- Schema condominio
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema condominio
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `condominio` ;
USE `condominio` ;

-- -----------------------------------------------------
-- Table `condominio`.`moradores`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`moradores` (
  `id_morador` INT NOT NULL AUTO_INCREMENT,
  `nome` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(255) NOT NULL,
  `cpf` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_morador`),
  UNIQUE INDEX `cpf` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 3
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`sindicos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`sindicos` (
  `id_sindico` INT NOT NULL AUTO_INCREMENT,
  `cpf` VARCHAR(255) NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `senha` VARCHAR(255) NOT NULL,
  `email` VARCHAR(255) NOT NULL,
  `inicio_mandato` DATE NULL,
  `fim_mandato` DATE NULL,
  PRIMARY KEY (`id_sindico`),
  UNIQUE INDEX `cpf` (`cpf` ASC) VISIBLE)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`predios`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`predios` (
  `id_predio` INT NOT NULL AUTO_INCREMENT,
  `id_sindico` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `cep` VARCHAR(255) NOT NULL,
  `cidade` VARCHAR(255) NOT NULL,
  `bairro` VARCHAR(255) NOT NULL,
  `rua` VARCHAR(255) NOT NULL,
  `numero` VARCHAR(10) NOT NULL,
  `ativo` ENUM('sim', 'não') NULL DEFAULT 'sim',
  PRIMARY KEY (`id_predio`),
  INDEX `fk_predios_sindico` (`id_sindico` ASC) VISIBLE,
  CONSTRAINT `fk_predios_sindico`
    FOREIGN KEY (`id_sindico`)
    REFERENCES `condominio`.`sindicos` (`id_sindico`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`apartamentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`apartamentos` (
  `id_apartamento` INT NOT NULL AUTO_INCREMENT,
  `id_predio` INT NOT NULL,
  `id_morador` INT NOT NULL,
  `numero` INT NOT NULL,
  `andar` VARCHAR(255) NOT NULL,
  `ativo` ENUM('sim', 'não') NOT NULL DEFAULT 'sim',
  PRIMARY KEY (`id_apartamento`),
  INDEX `fk_apartamentos_predios` (`id_predio` ASC) VISIBLE,
  INDEX `fk_apartamentos_morador` (`id_morador` ASC) VISIBLE,
  CONSTRAINT `fk_apartamentos_morador`
    FOREIGN KEY (`id_morador`)
    REFERENCES `condominio`.`moradores` (`id_morador`),
  CONSTRAINT `fk_apartamentos_predios`
    FOREIGN KEY (`id_predio`)
    REFERENCES `condominio`.`predios` (`id_predio`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`receitas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`receitas` (
  `id_receitas` INT NOT NULL AUTO_INCREMENT,
  `id_apartamento` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `valor_singular` DECIMAL(10,2) NOT NULL,
  `foi_pago` ENUM('sim', 'não') NOT NULL DEFAULT 'não',
  `vencimento` DATE NOT NULL,
  PRIMARY KEY (`id_receitas`),
  INDEX `fk_apartamentos` (`id_apartamento` ASC) VISIBLE,
  CONSTRAINT `fk_apartamentos`
    FOREIGN KEY (`id_apartamento`)
    REFERENCES `condominio`.`apartamentos` (`id_apartamento`))
ENGINE = InnoDB
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`contatos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`contatos` (
  `id_contato` INT NOT NULL AUTO_INCREMENT,
  `id_predio` INT NOT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `telefone` VARCHAR(255) NOT NULL,
  `cep` VARCHAR(255) NOT NULL,
  `cidade` VARCHAR(255) NOT NULL,
  `bairro` VARCHAR(255) NOT NULL,
  `rua` VARCHAR(255) NOT NULL,
  `numero` FLOAT NOT NULL,
  `descricao` VARCHAR(255) NULL,
  PRIMARY KEY (`id_contato`),
  INDEX `fk_contatos_predios` (`id_predio` ASC) VISIBLE,
  CONSTRAINT `fk_contatos_predios`
    FOREIGN KEY (`id_predio`)
    REFERENCES `condominio`.`predios` (`id_predio`))
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4
COLLATE = utf8mb4_0900_ai_ci;


-- -----------------------------------------------------
-- Table `condominio`.`documentos`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`documentos` (
  `id_documento` INT NOT NULL AUTO_INCREMENT,
  `descricao` VARCHAR(200) NOT NULL,
  `uri` VARCHAR(200) NOT NULL,
  `tipo` ENUM('ATA', 'RECIBO', 'CONTRATO', 'NF') NOT NULL,
  `id_sindico_responsavel` INT NOT NULL,
  `aprovado` ENUM('sim', 'não') NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  PRIMARY KEY (`id_documento`),
  INDEX `fk_Documentos_sindico1_idx` (`id_sindico_responsavel` ASC) VISIBLE,
  CONSTRAINT `fk_Documentos_sindico1`
    FOREIGN KEY (`id_sindico_responsavel`)
    REFERENCES `condominio`.`sindicos` (`id_sindico`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `condominio`.`despesas`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `condominio`.`despesas` (
  `id_despesa` INT NOT NULL AUTO_INCREMENT,
  `id_predio` INT NOT NULL,
  `id_contato` INT NULL DEFAULT NULL,
  `nome` VARCHAR(255) NOT NULL,
  `valor_total` DECIMAL(10,2) NOT NULL,
  `vencimento` DATE NOT NULL,
  `foi_pago` ENUM('sim', 'não') NOT NULL DEFAULT 'não',
  `id_documento` INT NOT NULL,
  `categoria` ENUM('salario', 'encargos', 'manutencao', 'obra', 'contrato_servico', 'consumo', 'outro') NOT NULL,
  `grupo_referencia` VARCHAR(255) NOT NULL,
  PRIMARY KEY (`id_despesa`),
  INDEX `fk_despesas_contatos` (`id_contato` ASC) VISIBLE,
  INDEX `fk_despesas_predios` (`id_predio` ASC) VISIBLE,
  INDEX `fk_despesas_Documentos1_idx` (`id_documento` ASC) VISIBLE,
  CONSTRAINT `fk_despesas_contatos`
    FOREIGN KEY (`id_contato`)
    REFERENCES `condominio`.`contatos` (`id_contato`),
  CONSTRAINT `fk_despesas_predios`
    FOREIGN KEY (`id_predio`)
    REFERENCES `condominio`.`predios` (`id_predio`),
  CONSTRAINT `fk_despesas_Documentos1`
    FOREIGN KEY (`id_documento`)
    REFERENCES `condominio`.`documentos` (`id_documento`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB
AUTO_INCREMENT = 2
DEFAULT CHARACTER SET = utf8mb4;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
