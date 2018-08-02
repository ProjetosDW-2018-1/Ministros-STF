-- phpMyAdmin SQL Dump
-- version 4.8.2
-- https://www.phpmyadmin.net/
--
-- Host: localhost
-- Tempo de geração: 27/07/2018 às 01:41
-- Versão do servidor: 10.1.34-MariaDB
-- Versão do PHP: 7.1.19

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
SET AUTOCOMMIT = 0;
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `data_warehouse_stf`
--
CREATE DATABASE IF NOT EXISTS `data_warehouse_stf` DEFAULT CHARACTER SET utf8 COLLATE utf8_general_ci;
USE `data_warehouse_stf`;

-- --------------------------------------------------------

--
-- Estrutura para tabela `assunto`
--

DROP TABLE IF EXISTS `assunto`;
CREATE TABLE `assunto` (
  `id_assunto` int(11) NOT NULL,
  `id_fonte` int(11) NOT NULL,
  `nome` varchar(60) NOT NULL,
  `date_from` timestamp NULL DEFAULT NULL,
  `date_to` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `local`
--

DROP TABLE IF EXISTS `local`;
CREATE TABLE `local` (
  `id_local` int(11) NOT NULL,
  `id_fonte` int(11) NOT NULL,
  `pais` varchar(25) NOT NULL,
  `estado` varchar(20) NOT NULL,
  `date_from` timestamp NULL DEFAULT NULL,
  `date_to` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `ministro`
--

DROP TABLE IF EXISTS `ministro`;
CREATE TABLE `ministro` (
  `id_ministro` int(11) NOT NULL,
  `id_fonte` int(11) NOT NULL,
  `ano_indicacao` varchar(4) NOT NULL,
  `indicado_por` varchar(25) NOT NULL,
  `nome_completo` varchar(55) NOT NULL,
  `mes_indicacao` int(10) UNSIGNED NOT NULL,
  `turma` int(10) UNSIGNED NOT NULL,
  `date_from` timestamp NULL DEFAULT NULL,
  `date_to` timestamp NULL DEFAULT NULL,
  `version` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `popularidade`
--

DROP TABLE IF EXISTS `popularidade`;
CREATE TABLE `popularidade` (
  `assunto_id_assunto` int(11) NOT NULL,
  `tempo_keyData` int(11) NOT NULL,
  `ministro_id_ministro` int(11) NOT NULL,
  `local_id_local` int(11) NOT NULL,
  `quantidade_positivos` int(10) UNSIGNED NOT NULL,
  `quantidade_negativos` int(10) UNSIGNED NOT NULL,
  `quantidade_neutros` int(10) UNSIGNED NOT NULL,
  `porcentagem_positivos` float UNSIGNED DEFAULT NULL,
  `porcentagem_negativos` float UNSIGNED DEFAULT NULL,
  `porcentagem_neutros` float UNSIGNED DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- --------------------------------------------------------

--
-- Estrutura para tabela `tempo`
--

DROP TABLE IF EXISTS `tempo`;
CREATE TABLE `tempo` (
  `keyData` int(11) NOT NULL,
  `data_id` datetime NOT NULL,
  `dia_ehdiautil` int(11) DEFAULT NULL,
  `dia_numeronasemana` int(11) DEFAULT NULL,
  `dia_numeronomes` int(11) DEFAULT NULL,
  `dia_numeronoano` int(11) DEFAULT NULL,
  `semana_id` int(11) DEFAULT NULL,
  `semana_nome` varchar(255) DEFAULT NULL,
  `semana_texto` varchar(255) DEFAULT NULL,
  `semana_numeronoano` int(11) DEFAULT NULL,
  `mes_id` int(11) DEFAULT NULL,
  `mes_nome` varchar(255) DEFAULT NULL,
  `mes_texto` varchar(255) DEFAULT NULL,
  `mes_numeronoano` varchar(255) DEFAULT NULL,
  `trimestre_id` int(11) DEFAULT NULL,
  `trimestre_nome` varchar(255) DEFAULT NULL,
  `trimestre_texto` varchar(255) DEFAULT NULL,
  `trimestre_numeronoano` int(11) DEFAULT NULL,
  `semestre_id` int(11) DEFAULT NULL,
  `semestre_nome` varchar(255) DEFAULT NULL,
  `semestre_texto` varchar(255) DEFAULT NULL,
  `semestre_numeronoano` int(11) DEFAULT NULL,
  `ano_id` int(11) DEFAULT NULL,
  `ano_nome` varchar(255) DEFAULT NULL,
  `ano_texto` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Índices de tabelas apagadas
--

--
-- Índices de tabela `assunto`
--
ALTER TABLE `assunto`
  ADD PRIMARY KEY (`id_assunto`);

--
-- Índices de tabela `local`
--
ALTER TABLE `local`
  ADD PRIMARY KEY (`id_local`);

--
-- Índices de tabela `ministro`
--
ALTER TABLE `ministro`
  ADD PRIMARY KEY (`id_ministro`);

--
-- Índices de tabela `popularidade`
--
ALTER TABLE `popularidade`
  ADD PRIMARY KEY (`assunto_id_assunto`,`tempo_keyData`,`ministro_id_ministro`,`local_id_local`),
  ADD KEY `fk_popularidade_ministro1_idx` (`ministro_id_ministro`),
  ADD KEY `fk_popularidade_local1_idx` (`local_id_local`),
  ADD KEY `fk_popularidade_tempo1_idx` (`tempo_keyData`);

--
-- Índices de tabela `tempo`
--
ALTER TABLE `tempo`
  ADD PRIMARY KEY (`keyData`);

--
-- AUTO_INCREMENT de tabelas apagadas
--

--
-- AUTO_INCREMENT de tabela `assunto`
--
ALTER TABLE `assunto`
  MODIFY `id_assunto` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `local`
--
ALTER TABLE `local`
  MODIFY `id_local` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `ministro`
--
ALTER TABLE `ministro`
  MODIFY `id_ministro` int(11) NOT NULL AUTO_INCREMENT;

--
-- Restrições para dumps de tabelas
--

--
-- Restrições para tabelas `popularidade`
--
ALTER TABLE `popularidade`
  ADD CONSTRAINT `fk_popularidade_assunto` FOREIGN KEY (`assunto_id_assunto`) REFERENCES `assunto` (`id_assunto`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_popularidade_local1` FOREIGN KEY (`local_id_local`) REFERENCES `local` (`id_local`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_popularidade_ministro1` FOREIGN KEY (`ministro_id_ministro`) REFERENCES `ministro` (`id_ministro`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_popularidade_tempo1` FOREIGN KEY (`tempo_keyData`) REFERENCES `tempo` (`keyData`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
