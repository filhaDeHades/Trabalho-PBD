-- MySQL Workbench Forward Engineering

SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0;
SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0;
SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION';

-- -----------------------------------------------------
-- Schema db_Sistema_Banco
-- -----------------------------------------------------

-- -----------------------------------------------------
-- Schema db_Sistema_Banco
-- -----------------------------------------------------
CREATE SCHEMA IF NOT EXISTS `db_Sistema_Banco` DEFAULT CHARACTER SET utf8 ;
USE `db_Sistema_Banco` ;

-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`endereco`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`endereco` (
  `idendereco` INT NOT NULL,
  `rua` VARCHAR(45) NOT NULL,
  `numero` VARCHAR(20) NULL,
  `bairro` VARCHAR(45) NOT NULL,
  `cidade` VARCHAR(45) NOT NULL,
  `complemento` VARCHAR(120) NULL,
  `UF` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idendereco`))
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`usuario`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`usuario` (
  `idusuario` INT NOT NULL,
  `cpf` VARCHAR(45) NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `senha` VARCHAR(20) NOT NULL,
  `id_endereco` INT NOT NULL,
  `data_nasc` DATETIME NOT NULL,
  PRIMARY KEY (`idusuario`),
  UNIQUE INDEX `idusuario_UNIQUE` (`idusuario` ASC) VISIBLE,
  UNIQUE INDEX `cpf_UNIQUE` (`cpf` ASC) VISIBLE,
  INDEX `id_endereco_idx` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `id_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `db_Sistema_Banco`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`funcionalidade` (
  `idfuncionalidade` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idfuncionalidade`),
  UNIQUE INDEX `idfuncionalidade_UNIQUE` (`idfuncionalidade` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`usuario_funcionalidade`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`usuario_funcionalidade` (
  `idusuario_funcionalidade` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `id_funcionalidade` INT NOT NULL,
  PRIMARY KEY (`idusuario_funcionalidade`),
  UNIQUE INDEX `id_usuario_UNIQUE` (`id_usuario` ASC) VISIBLE,
  UNIQUE INDEX `id_funcionalidade_UNIQUE` (`id_funcionalidade` ASC) VISIBLE,
  CONSTRAINT `id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_Sistema_Banco`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_funcionamento`
    FOREIGN KEY (`id_funcionalidade`)
    REFERENCES `db_Sistema_Banco`.`funcionalidade` (`idfuncionalidade`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`agencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`agencia` (
  `nu_agencia` INT NOT NULL,
  `id_endereco` INT NOT NULL,
  PRIMARY KEY (`nu_agencia`),
  UNIQUE INDEX `nu_agencia_UNIQUE` (`nu_agencia` ASC) VISIBLE,
  INDEX `id_endereco_idx` (`id_endereco` ASC) VISIBLE,
  CONSTRAINT `id_endereco`
    FOREIGN KEY (`id_endereco`)
    REFERENCES `db_Sistema_Banco`.`endereco` (`idendereco`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`conta_bancaria`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`conta_bancaria` (
  `nu_conta_bancaria` INT NOT NULL,
  `nu_agencia` INT NOT NULL,
  `saldo` DOUBLE NOT NULL,
  PRIMARY KEY (`nu_conta_bancaria`),
  UNIQUE INDEX `nu_conta_bancaria_UNIQUE` (`nu_conta_bancaria` ASC) VISIBLE,
  INDEX `nu_agencia_idx` (`nu_agencia` ASC) VISIBLE,
  CONSTRAINT `nu_agencia`
    FOREIGN KEY (`nu_agencia`)
    REFERENCES `db_Sistema_Banco`.`agencia` (`nu_agencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`cliente`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`cliente` (
  `idcliente` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `tipo_cliente` VARCHAR(45) NOT NULL,
  `nu_conta_bancaria` INT NOT NULL,
  PRIMARY KEY (`idcliente`),
  UNIQUE INDEX `idcliente_UNIQUE` (`idcliente` ASC) VISIBLE,
  UNIQUE INDEX `id_usuario_UNIQUE` (`id_usuario` ASC) VISIBLE,
  UNIQUE INDEX `nu_conta_bancaria_UNIQUE` (`nu_conta_bancaria` ASC) VISIBLE,
  CONSTRAINT `id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_Sistema_Banco`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `nu_conta_bancaria`
    FOREIGN KEY (`nu_conta_bancaria`)
    REFERENCES `db_Sistema_Banco`.`conta_bancaria` (`nu_conta_bancaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`administrador`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`administrador` (
  `idadministrador` INT NOT NULL,
  `id_usuario` INT NOT NULL,
  `tipo_adm` VARCHAR(45) NOT NULL,
  PRIMARY KEY (`idadministrador`),
  UNIQUE INDEX `idadministrador_UNIQUE` (`idadministrador` ASC) VISIBLE,
  UNIQUE INDEX `id_usuario_UNIQUE` (`id_usuario` ASC) VISIBLE,
  CONSTRAINT `id_usuario`
    FOREIGN KEY (`id_usuario`)
    REFERENCES `db_Sistema_Banco`.`usuario` (`idusuario`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`suporte`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`suporte` (
  `idsuporte` INT NOT NULL,
  `id_adm` INT NOT NULL,
  `id_cliente` INT NOT NULL,
  `dt_hora` DATETIME NOT NULL,
  PRIMARY KEY (`idsuporte`),
  UNIQUE INDEX `idsuporte_UNIQUE` (`idsuporte` ASC) VISIBLE,
  INDEX `id_adm_idx` (`id_adm` ASC) VISIBLE,
  INDEX `id_cliente_idx` (`id_cliente` ASC) VISIBLE,
  CONSTRAINT `id_adm`
    FOREIGN KEY (`id_adm`)
    REFERENCES `db_Sistema_Banco`.`administrador` (`idadministrador`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_cliente`
    FOREIGN KEY (`id_cliente`)
    REFERENCES `db_Sistema_Banco`.`cliente` (`idcliente`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`mensagem`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`mensagem` (
  `idmensagem` INT NOT NULL,
  `id_suporte` INT NOT NULL,
  `pergunta` VARCHAR(200) NOT NULL,
  `resposta` VARCHAR(200) NOT NULL,
  `suporte_idsuporte` INT NOT NULL,
  PRIMARY KEY (`idmensagem`),
  UNIQUE INDEX `idmensagem_UNIQUE` (`idmensagem` ASC) VISIBLE,
  INDEX `fk_mensagem_suporte1_idx` (`suporte_idsuporte` ASC) VISIBLE,
  CONSTRAINT `fk_mensagem_suporte1`
    FOREIGN KEY (`suporte_idsuporte`)
    REFERENCES `db_Sistema_Banco`.`suporte` (`idsuporte`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`fundo`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`fundo` (
  `idfundo` INT NOT NULL,
  `nome` VARCHAR(45) NOT NULL,
  `valor_cota` DOUBLE NOT NULL,
  `valor_minimo` DOUBLE NOT NULL,
  PRIMARY KEY (`idfundo`),
  UNIQUE INDEX `idfundo_UNIQUE` (`idfundo` ASC) VISIBLE)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`transferencia`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`transferencia` (
  `idtransferencia` INT NOT NULL,
  `id_conta_origem` INT NOT NULL,
  `id_conta_destino` INT NOT NULL,
  `valor` DOUBLE NOT NULL,
  `dt_hora` DATETIME NOT NULL,
  PRIMARY KEY (`idtransferencia`),
  UNIQUE INDEX `idtransferencia_UNIQUE` (`idtransferencia` ASC) VISIBLE,
  INDEX `id_conta_origem_idx` (`id_conta_origem` ASC) VISIBLE,
  INDEX `id_conta_destino_idx` (`id_conta_destino` ASC) VISIBLE,
  CONSTRAINT `id_conta_origem`
    FOREIGN KEY (`id_conta_origem`)
    REFERENCES `db_Sistema_Banco`.`conta_bancaria` (`nu_conta_bancaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_conta_destino`
    FOREIGN KEY (`id_conta_destino`)
    REFERENCES `db_Sistema_Banco`.`conta_bancaria` (`nu_conta_bancaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`deposito`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`deposito` (
  `iddeposito` INT NOT NULL,
  `valor` DOUBLE NOT NULL,
  `dt_hora` DATETIME NOT NULL,
  `id_conta` INT NOT NULL,
  `id_agencia` INT NOT NULL,
  PRIMARY KEY (`iddeposito`),
  UNIQUE INDEX `iddeposito_UNIQUE` (`iddeposito` ASC) VISIBLE,
  INDEX `id_conta_idx` (`id_conta` ASC) VISIBLE,
  INDEX `id_agencia_idx` (`id_agencia` ASC) VISIBLE,
  CONSTRAINT `id_conta`
    FOREIGN KEY (`id_conta`)
    REFERENCES `db_Sistema_Banco`.`conta_bancaria` (`nu_conta_bancaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_agencia`
    FOREIGN KEY (`id_agencia`)
    REFERENCES `db_Sistema_Banco`.`agencia` (`nu_agencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`saque`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`saque` (
  `idsaque` INT NOT NULL,
  `valor` DOUBLE NOT NULL,
  `dt_hora` DATETIME NOT NULL,
  `id_conta` INT NOT NULL,
  `id_agencia` INT NOT NULL,
  PRIMARY KEY (`idsaque`),
  UNIQUE INDEX `idsaque_UNIQUE` (`idsaque` ASC) VISIBLE,
  INDEX `id_conta_idx` (`id_conta` ASC) VISIBLE,
  INDEX `id_agencia_idx` (`id_agencia` ASC) VISIBLE,
  CONSTRAINT `id_conta`
    FOREIGN KEY (`id_conta`)
    REFERENCES `db_Sistema_Banco`.`conta_bancaria` (`nu_conta_bancaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `id_agencia`
    FOREIGN KEY (`id_agencia`)
    REFERENCES `db_Sistema_Banco`.`agencia` (`nu_agencia`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


-- -----------------------------------------------------
-- Table `db_Sistema_Banco`.`investimento`
-- -----------------------------------------------------
CREATE TABLE IF NOT EXISTS `db_Sistema_Banco`.`investimento` (
  `idinvestimento` INT NOT NULL,
  `id_fundo` INT NOT NULL,
  `valor` DOUBLE NOT NULL,
  `dt_hora` DATETIME NOT NULL,
  `qt_cotas` INT NOT NULL,
  `vr_inicio` DOUBLE NOT NULL,
  `conta_bancaria_nu_conta_bancaria` INT NOT NULL,
  `fundo_idfundo` INT NOT NULL,
  PRIMARY KEY (`idinvestimento`),
  UNIQUE INDEX `idinvestimento_UNIQUE` (`idinvestimento` ASC) VISIBLE,
  INDEX `fk_investimento_conta_bancaria1_idx` (`conta_bancaria_nu_conta_bancaria` ASC) VISIBLE,
  INDEX `fk_investimento_fundo1_idx` (`fundo_idfundo` ASC) VISIBLE,
  CONSTRAINT `fk_investimento_conta_bancaria1`
    FOREIGN KEY (`conta_bancaria_nu_conta_bancaria`)
    REFERENCES `db_Sistema_Banco`.`conta_bancaria` (`nu_conta_bancaria`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION,
  CONSTRAINT `fk_investimento_fundo1`
    FOREIGN KEY (`fundo_idfundo`)
    REFERENCES `db_Sistema_Banco`.`fundo` (`idfundo`)
    ON DELETE NO ACTION
    ON UPDATE NO ACTION)
ENGINE = InnoDB;


SET SQL_MODE=@OLD_SQL_MODE;
SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS;
SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS;
