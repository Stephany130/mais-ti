-- phpMyAdmin SQL Dump
-- version 5.2.1deb3
-- https://www.phpmyadmin.net/
--
-- Host: localhost:3306
-- Generation Time: Mar 08, 2026 at 06:16 PM
-- Server version: 8.0.45-0ubuntu0.24.04.1
-- PHP Version: 8.3.6

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `condominio`
--

-- --------------------------------------------------------

--
-- Table structure for table `apartamentos`
--

CREATE TABLE `apartamentos` (
  `id_apartamento` int NOT NULL,
  `id_predio` int NOT NULL,
  `id_morador` int NOT NULL,
  `numero` int NOT NULL,
  `andar` varchar(255) NOT NULL,
  `ativo` enum('sim','não') NOT NULL DEFAULT 'sim'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `apartamentos`
--

INSERT INTO `apartamentos` (`id_apartamento`, `id_predio`, `id_morador`, `numero`, `andar`, `ativo`) VALUES
(1, 1, 1, 3, '0', 'sim'),
(2, 1, 2, 4, '0', 'sim'),
(3, 1, 3, 101, '1', 'sim'),
(4, 1, 4, 102, '1', 'sim'),
(5, 1, 5, 103, '1', 'sim'),
(6, 1, 6, 104, '1', 'sim'),
(7, 1, 7, 201, '2', 'sim'),
(8, 1, 8, 202, '2', 'sim'),
(9, 1, 9, 203, '2', 'sim'),
(10, 1, 10, 204, '2', 'sim'),
(11, 1, 11, 301, '3', 'sim'),
(12, 1, 12, 302, '3', 'sim'),
(13, 1, 13, 303, '3', 'sim'),
(14, 1, 14, 304, '3', 'sim');

-- --------------------------------------------------------

--
-- Table structure for table `contatos`
--

CREATE TABLE `contatos` (
  `id_contato` int NOT NULL,
  `id_predio` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `telefone` varchar(255) NOT NULL,
  `cep` varchar(255) NOT NULL,
  `cidade` varchar(255) NOT NULL,
  `bairro` varchar(255) NOT NULL,
  `rua` varchar(255) NOT NULL,
  `numero` float NOT NULL,
  `descricao` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `despesas`
--

CREATE TABLE `despesas` (
  `id_despesa` int NOT NULL,
  `id_predio` int NOT NULL,
  `id_contato` int DEFAULT NULL,
  `nome` varchar(255) NOT NULL,
  `valor_total` decimal(10,2) NOT NULL,
  `vencimento` date NOT NULL,
  `foi_pago` enum('sim','não') NOT NULL DEFAULT 'não',
  `id_documento` int NOT NULL,
  `categoria` enum('salario','encargos','manutencao','obra','contrato_servico','consumo','outro') NOT NULL,
  `grupo_referencia` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `documentos`
--

CREATE TABLE `documentos` (
  `id_documento` int NOT NULL,
  `descricao` varchar(200) NOT NULL,
  `uri` varchar(200) NOT NULL,
  `tipo` enum('ATA','RECIBO','CONTRATO','NF') NOT NULL,
  `id_sindico_responsavel` int NOT NULL,
  `aprovado` enum('sim','não') NOT NULL,
  `valor_total` decimal(10,2) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `moradores`
--

CREATE TABLE `moradores` (
  `id_morador` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `telefone` varchar(255) NOT NULL,
  `cpf` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `moradores`
--

INSERT INTO `moradores` (`id_morador`, `nome`, `telefone`, `cpf`) VALUES
(1, 'Paulo Henrique Castro', '79999151515', '22344444444'),
(2, 'Renata Moura Dantas', '79999161616', '22355555555'),
(3, 'Ana Paula Ribeiro', '79999111111', '22211111111'),
(4, 'Bruno Carvalho Souza', '79999222222', '22222222222'),
(5, 'Camila Fernandes Lima', '79999333333', '22233333333'),
(6, 'Daniel Santos Oliveira', '79999444444', '22244444444'),
(7, 'Eduardo Martins Costa', '79999555555', '22255555555'),
(8, 'Fernanda Rocha Alves', '79999666666', '22266666666'),
(9, 'Gabriel Barbosa Pinto', '79999777777', '22277777777'),
(10, 'Helena Duarte Campos', '79999888888', '22288888888'),
(11, 'Igor Teixeira Nunes', '79999999999', '22299999999'),
(12, 'Juliana Pires Matos', '79999121212', '22311111111'),
(13, 'Lucas Andrade Gomes', '79999131313', '22322222222'),
(14, 'Mariana Freitas Ribeiro', '79999141414', '22333333333');

-- --------------------------------------------------------

--
-- Table structure for table `predios`
--

CREATE TABLE `predios` (
  `id_predio` int NOT NULL,
  `id_sindico` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `cep` varchar(255) NOT NULL,
  `cidade` varchar(255) NOT NULL,
  `bairro` varchar(255) NOT NULL,
  `rua` varchar(255) NOT NULL,
  `numero` varchar(10) NOT NULL,
  `ativo` enum('sim','não') DEFAULT 'sim'
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `predios`
--

INSERT INTO `predios` (`id_predio`, `id_sindico`, `nome`, `cep`, `cidade`, `bairro`, `rua`, `numero`, `ativo`) VALUES
(1, 1, 'Condomínio Santa Efigência', '49000000', 'Aracaju', 'Jardins', 'Rua Santa Efigência', '100', 'sim');

-- --------------------------------------------------------

--
-- Table structure for table `receitas`
--

CREATE TABLE `receitas` (
  `id_receitas` int NOT NULL,
  `id_apartamento` int NOT NULL,
  `nome` varchar(255) NOT NULL,
  `valor_singular` decimal(10,2) NOT NULL,
  `foi_pago` enum('sim','não') NOT NULL DEFAULT 'não',
  `vencimento` date NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

-- --------------------------------------------------------

--
-- Table structure for table `sindicos`
--

CREATE TABLE `sindicos` (
  `id_sindico` int NOT NULL,
  `cpf` varchar(255) NOT NULL,
  `nome` varchar(255) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `inicio_mandato` date DEFAULT NULL,
  `fim_mandato` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

--
-- Dumping data for table `sindicos`
--

INSERT INTO `sindicos` (`id_sindico`, `cpf`, `nome`, `senha`, `email`, `inicio_mandato`, `fim_mandato`) VALUES
(1, '11111111111', 'Carlos Eduardo Mendes', '123456', 'carlos.mendes@email.com', '2025-01-01', '2027-12-31');

--
-- Indexes for dumped tables
--

--
-- Indexes for table `apartamentos`
--
ALTER TABLE `apartamentos`
  ADD PRIMARY KEY (`id_apartamento`),
  ADD KEY `fk_apartamentos_predios` (`id_predio`),
  ADD KEY `fk_apartamentos_morador` (`id_morador`);

--
-- Indexes for table `contatos`
--
ALTER TABLE `contatos`
  ADD PRIMARY KEY (`id_contato`),
  ADD KEY `fk_contatos_predios` (`id_predio`);

--
-- Indexes for table `despesas`
--
ALTER TABLE `despesas`
  ADD PRIMARY KEY (`id_despesa`),
  ADD KEY `fk_despesas_contatos` (`id_contato`),
  ADD KEY `fk_despesas_predios` (`id_predio`),
  ADD KEY `fk_despesas_Documentos1_idx` (`id_documento`);

--
-- Indexes for table `documentos`
--
ALTER TABLE `documentos`
  ADD PRIMARY KEY (`id_documento`),
  ADD KEY `fk_Documentos_sindico1_idx` (`id_sindico_responsavel`);

--
-- Indexes for table `moradores`
--
ALTER TABLE `moradores`
  ADD PRIMARY KEY (`id_morador`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- Indexes for table `predios`
--
ALTER TABLE `predios`
  ADD PRIMARY KEY (`id_predio`),
  ADD KEY `fk_predios_sindico` (`id_sindico`);

--
-- Indexes for table `receitas`
--
ALTER TABLE `receitas`
  ADD PRIMARY KEY (`id_receitas`),
  ADD KEY `fk_apartamentos` (`id_apartamento`);

--
-- Indexes for table `sindicos`
--
ALTER TABLE `sindicos`
  ADD PRIMARY KEY (`id_sindico`),
  ADD UNIQUE KEY `cpf` (`cpf`);

--
-- AUTO_INCREMENT for dumped tables
--

--
-- AUTO_INCREMENT for table `apartamentos`
--
ALTER TABLE `apartamentos`
  MODIFY `id_apartamento` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=44;

--
-- AUTO_INCREMENT for table `contatos`
--
ALTER TABLE `contatos`
  MODIFY `id_contato` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `despesas`
--
ALTER TABLE `despesas`
  MODIFY `id_despesa` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

--
-- AUTO_INCREMENT for table `documentos`
--
ALTER TABLE `documentos`
  MODIFY `id_documento` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `moradores`
--
ALTER TABLE `moradores`
  MODIFY `id_morador` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=17;

--
-- AUTO_INCREMENT for table `predios`
--
ALTER TABLE `predios`
  MODIFY `id_predio` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=5;

--
-- AUTO_INCREMENT for table `receitas`
--
ALTER TABLE `receitas`
  MODIFY `id_receitas` int NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT for table `sindicos`
--
ALTER TABLE `sindicos`
  MODIFY `id_sindico` int NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- Constraints for dumped tables
--

--
-- Constraints for table `apartamentos`
--
ALTER TABLE `apartamentos`
  ADD CONSTRAINT `fk_apartamentos_morador` FOREIGN KEY (`id_morador`) REFERENCES `moradores` (`id_morador`),
  ADD CONSTRAINT `fk_apartamentos_predios` FOREIGN KEY (`id_predio`) REFERENCES `predios` (`id_predio`);

--
-- Constraints for table `contatos`
--
ALTER TABLE `contatos`
  ADD CONSTRAINT `fk_contatos_predios` FOREIGN KEY (`id_predio`) REFERENCES `predios` (`id_predio`);

--
-- Constraints for table `despesas`
--
ALTER TABLE `despesas`
  ADD CONSTRAINT `fk_despesas_contatos` FOREIGN KEY (`id_contato`) REFERENCES `contatos` (`id_contato`),
  ADD CONSTRAINT `fk_despesas_Documentos1` FOREIGN KEY (`id_documento`) REFERENCES `documentos` (`id_documento`),
  ADD CONSTRAINT `fk_despesas_predios` FOREIGN KEY (`id_predio`) REFERENCES `predios` (`id_predio`);

--
-- Constraints for table `documentos`
--
ALTER TABLE `documentos`
  ADD CONSTRAINT `fk_Documentos_sindico1` FOREIGN KEY (`id_sindico_responsavel`) REFERENCES `sindicos` (`id_sindico`);

--
-- Constraints for table `predios`
--
ALTER TABLE `predios`
  ADD CONSTRAINT `fk_predios_sindico` FOREIGN KEY (`id_sindico`) REFERENCES `sindicos` (`id_sindico`);

--
-- Constraints for table `receitas`
--
ALTER TABLE `receitas`
  ADD CONSTRAINT `fk_apartamentos` FOREIGN KEY (`id_apartamento`) REFERENCES `apartamentos` (`id_apartamento`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
