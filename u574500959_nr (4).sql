-- phpMyAdmin SQL Dump
-- version 5.2.2
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1:3306
-- Tempo de geração: 28/09/2026 às 18:48
-- Versão do servidor: 11.8.9-MariaDB-log
-- Versão do PHP: 7.2.34

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Banco de dados: `u574500959_nr`
--

-- --------------------------------------------------------

--
-- Estrutura para tabela `barbeiros`
--

CREATE TABLE `barbeiros` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `email` varchar(100) NOT NULL,
  `senha` varchar(255) NOT NULL,
  `telefone` varchar(20) DEFAULT NULL,
  `especialidades` text DEFAULT NULL,
  `foto` varchar(255) DEFAULT NULL,
  `ativo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `barbeiros`
--

INSERT INTO `barbeiros` (`id`, `nome`, `email`, `senha`, `telefone`, `especialidades`, `foto`, `ativo`, `created_at`) VALUES
(3, 'Luiz Versaty', 'teste@gmail.com', 'aa1bf4646de67fd9086cf6c79007026c', '27998973301', 'Corte', 'https://d2zdpiztbgorvt.cloudfront.net/region1/br/124943/resource_photos/06f0908c67624f539753e6d74a5ddc-barbearia-thomaz-black-breno-thomaz-bc08db3c203f48a5ae19cb1cd60c2e-booksy.jpeg', 0, '2026-08-22 17:40:17'),
(5, 'Czar', 'teste2@gmail.com', 'aa1bf4646de67fd9086cf6c79007026c', '27998973301', '', 'img/barbeiros/barbeiro_5_1787758148.jpg', 0, '2026-08-25 19:28:32');

-- --------------------------------------------------------

--
-- Estrutura para tabela `horarios`
--

CREATE TABLE `horarios` (
  `id` int(11) NOT NULL,
  `data` date NOT NULL,
  `horario` time NOT NULL,
  `barbeiro_id` int(11) NOT NULL,
  `servico_id` int(11) DEFAULT NULL,
  `cliente_nome` varchar(100) DEFAULT NULL,
  `cliente_email` varchar(100) DEFAULT NULL,
  `cliente_telefone` varchar(20) DEFAULT NULL,
  `status` enum('disponivel','reservado','pago','cancelado','concluido') DEFAULT 'disponivel',
  `referencia_pagamento` varchar(50) DEFAULT NULL,
  `preco` decimal(10,2) DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp(),
  `payment_id` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `horarios`
--

INSERT INTO `horarios` (`id`, `data`, `horario`, `barbeiro_id`, `servico_id`, `cliente_nome`, `cliente_email`, `cliente_telefone`, `status`, `referencia_pagamento`, `preco`, `observacoes`, `created_at`, `payment_id`, `updated_at`) VALUES
(52, '2026-08-23', '11:00:00', 3, 3, '0', 'cezarteneted627@gmail.com', '(27) 99897-3301', '', 'YTC7811XZRR70W59EGGG5FZC', 1.00, '', '2026-08-22 22:21:59', NULL, '2026-08-25 18:47:49'),
(53, '2026-08-25', '09:00:00', 3, 1, '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', 'concluido', 'Q8N3EOM266JIB9WC94X2WDJZ', 1.00, '', '2026-08-23 15:35:08', NULL, '2026-08-25 19:58:36'),
(54, '2026-08-25', '16:00:00', 3, NULL, NULL, NULL, NULL, 'disponivel', NULL, NULL, NULL, '2026-08-25 18:50:45', NULL, NULL),
(57, '2026-08-26', '09:00:00', 3, 1, '0', 'teste@gmail.com', '(27) 99897-3301', '', '3OQSESM2ZA4JWU8CVOXVA3QY', 1.00, '', '2026-08-26 13:20:25', NULL, '2026-08-26 13:25:44'),
(58, '2026-08-26', '10:00:00', 3, 1, '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', '', '3W7RZGR4AI89040Q7NQ3W9AS', 1.00, '', '2026-08-26 13:20:25', NULL, NULL),
(59, '2026-08-26', '11:00:00', 3, 1, '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', '', 'W309T0SUG9OEWBLC906Y8TLS', 1.00, '', '2026-08-26 13:20:25', NULL, NULL),
(60, '2026-08-26', '12:00:00', 3, 1, '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', 'concluido', 'FYRZFZNGL3I7CGZFE1VAJPOC', 1.00, '', '2026-08-26 13:20:25', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `logs_pagamento`
--

CREATE TABLE `logs_pagamento` (
  `id` int(11) NOT NULL,
  `external_reference` varchar(50) DEFAULT NULL,
  `status` varchar(20) DEFAULT NULL,
  `response_data` text DEFAULT NULL,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `pagamentos`
--

CREATE TABLE `pagamentos` (
  `id` int(11) NOT NULL,
  `referencia` varchar(50) DEFAULT NULL,
  `horario_id` int(11) DEFAULT NULL,
  `servico_id` int(11) DEFAULT NULL,
  `barbeiro_id` int(11) DEFAULT NULL,
  `valor` decimal(10,2) DEFAULT NULL,
  `status` varchar(20) DEFAULT 'pending',
  `payment_id` varchar(50) DEFAULT NULL,
  `cliente_nome` varchar(100) DEFAULT NULL,
  `cliente_email` varchar(100) DEFAULT NULL,
  `cliente_telefone` varchar(20) DEFAULT NULL,
  `data_agendada` date DEFAULT NULL,
  `horario_agendado` time DEFAULT NULL,
  `observacoes` text DEFAULT NULL,
  `data_criacao` timestamp NULL DEFAULT current_timestamp(),
  `external_reference` varchar(50) DEFAULT NULL,
  `updated_at` timestamp NULL DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `pagamentos`
--

INSERT INTO `pagamentos` (`id`, `referencia`, `horario_id`, `servico_id`, `barbeiro_id`, `valor`, `status`, `payment_id`, `cliente_nome`, `cliente_email`, `cliente_telefone`, `data_agendada`, `horario_agendado`, `observacoes`, `data_criacao`, `external_reference`, `updated_at`) VALUES
(4, 'YTC7811XZRR70W59EGGG5FZC', 52, 3, 3, 1.00, 'approved', '174248583467', '0', 'cezarteneted627@gmail.com', '(27) 99897-3301', '2026-08-23', '11:00:00', '', '2026-08-22 22:41:58', NULL, NULL),
(5, 'CU9L0NXPWZ2IREZQMS6400PE', NULL, 1, 3, 1.00, 'pending', '174326556077', '0', 'cezarteneted627@gmail.com', '(27) 99897-3301', '2026-08-25', '09:00:00', '', '2026-08-23 15:39:10', NULL, NULL),
(6, 'B5MJCWDPACG1SQVJIN5SKRUC', NULL, 1, 3, 1.00, 'pending', '175307496504', '0', 'cezar@gmail.com', '(27) 99897-3301', '2026-08-25', '09:00:00', '', '2026-08-23 21:35:04', NULL, NULL),
(7, '57C0M1H0FKAYSDGB864XPIMW', NULL, 4, 3, 30.00, 'pending', '174431314753', '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', '2026-08-25', '09:00:00', '', '2026-08-24 11:55:26', NULL, NULL),
(8, 'Q8N3EOM266JIB9WC94X2WDJZ', 53, 1, 3, 1.00, 'approved', '175590953748', '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', '2026-08-25', '09:00:00', '', '2026-08-25 18:45:07', NULL, NULL),
(9, 'KRLI82YZ3GJBU3S7MJ4U59LD', NULL, 5, 5, 120.00, 'pending', '175600517992', '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', '2026-08-25', '16:00:00', '', '2026-08-25 19:58:04', NULL, NULL),
(10, 'F0SK696R8IZEHZ9N6HZHH5BJ', NULL, 5, 5, 120.00, 'pending', '175695958352', '0', 'c@gmail.com', '(27) 99897-3301', '2026-08-25', '17:00:00', '', '2026-08-26 12:56:12', NULL, NULL),
(11, '14JVWL7LBTYXQM88G4SVXO26', NULL, 5, 5, 120.00, 'pending', '175694129934', '0', 'g@gmail.com', '(27) 99897-3301', '2026-08-25', '17:00:00', '', '2026-08-26 13:01:09', NULL, NULL),
(12, '3OQSESM2ZA4JWU8CVOXVA3QY', 57, 1, 3, 1.00, 'approved', '174756466461', '0', 'teste@gmail.com', '(27) 99897-3301', '2026-08-26', '09:00:00', '', '2026-08-26 13:20:53', NULL, NULL),
(13, '3W7RZGR4AI89040Q7NQ3W9AS', 58, 1, 3, 1.00, 'approved', '174763652101', '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', '2026-08-26', '10:00:00', '', '2026-08-26 14:06:05', NULL, NULL),
(14, 'W309T0SUG9OEWBLC906Y8TLS', 59, 1, 3, 1.00, 'approved', '174761975773', '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', '2026-08-26', '11:00:00', '', '2026-08-26 14:14:19', NULL, NULL),
(15, 'FYRZFZNGL3I7CGZFE1VAJPOC', 60, 1, 3, 1.00, 'approved', '174763539949', '0', 'pitagoraspapelaria@gmail.com', '(27) 99897-3301', '2026-08-26', '12:00:00', '', '2026-08-26 14:28:55', NULL, NULL);

-- --------------------------------------------------------

--
-- Estrutura para tabela `servicos`
--

CREATE TABLE `servicos` (
  `id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `duracao_minutos` int(11) NOT NULL DEFAULT 30,
  `ativo` tinyint(1) DEFAULT 1,
  `cor` varchar(7) DEFAULT '#c9a84c',
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Estrutura para tabela `servicos_barbeiro`
--

CREATE TABLE `servicos_barbeiro` (
  `id` int(11) NOT NULL,
  `barbeiro_id` int(11) NOT NULL,
  `nome` varchar(100) NOT NULL,
  `descricao` text DEFAULT NULL,
  `preco` decimal(10,2) NOT NULL,
  `duracao_minutos` int(11) NOT NULL DEFAULT 30,
  `cor` varchar(7) DEFAULT '#c9a84c',
  `ativo` tinyint(1) DEFAULT 1,
  `created_at` timestamp NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Despejando dados para a tabela `servicos_barbeiro`
--

INSERT INTO `servicos_barbeiro` (`id`, `barbeiro_id`, `nome`, `descricao`, `preco`, `duracao_minutos`, `cor`, `ativo`, `created_at`) VALUES
(1, 3, 'Corte Luiz TESTE', '', 1.00, 60, '#4a64c9', 1, '2026-08-22 19:59:24'),
(3, 3, 'TESTE DE SERVIÇO', '', 1.00, 50, '#c9a84c', 0, '2026-08-22 22:21:38'),
(4, 3, 'TESTE 2', '', 30.00, 30, '#c9a84c', 1, '2026-08-23 15:34:48'),
(5, 5, 'TESTE', '', 120.00, 30, '#c9a84c', 1, '2026-08-25 19:28:52');

--
-- Índices para tabelas despejadas
--

--
-- Índices de tabela `barbeiros`
--
ALTER TABLE `barbeiros`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `email` (`email`);

--
-- Índices de tabela `horarios`
--
ALTER TABLE `horarios`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_horario_barbeiro` (`data`,`horario`,`barbeiro_id`),
  ADD KEY `barbeiro_id` (`barbeiro_id`),
  ADD KEY `idx_horarios_referencia` (`referencia_pagamento`),
  ADD KEY `horarios_servico_fk` (`servico_id`);

--
-- Índices de tabela `logs_pagamento`
--
ALTER TABLE `logs_pagamento`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `referencia` (`referencia`),
  ADD KEY `horario_id` (`horario_id`),
  ADD KEY `barbeiro_id` (`barbeiro_id`),
  ADD KEY `idx_pagamentos_external_ref` (`external_reference`),
  ADD KEY `pagamentos_servico_barbeiro_fk` (`servico_id`);

--
-- Índices de tabela `servicos`
--
ALTER TABLE `servicos`
  ADD PRIMARY KEY (`id`);

--
-- Índices de tabela `servicos_barbeiro`
--
ALTER TABLE `servicos_barbeiro`
  ADD PRIMARY KEY (`id`),
  ADD UNIQUE KEY `unique_servico_barbeiro` (`barbeiro_id`,`nome`);

--
-- AUTO_INCREMENT para tabelas despejadas
--

--
-- AUTO_INCREMENT de tabela `barbeiros`
--
ALTER TABLE `barbeiros`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `horarios`
--
ALTER TABLE `horarios`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=69;

--
-- AUTO_INCREMENT de tabela `logs_pagamento`
--
ALTER TABLE `logs_pagamento`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT;

--
-- AUTO_INCREMENT de tabela `pagamentos`
--
ALTER TABLE `pagamentos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

--
-- AUTO_INCREMENT de tabela `servicos`
--
ALTER TABLE `servicos`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT de tabela `servicos_barbeiro`
--
ALTER TABLE `servicos_barbeiro`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Restrições para tabelas despejadas
--

--
-- Restrições para tabelas `horarios`
--
ALTER TABLE `horarios`
  ADD CONSTRAINT `horarios_ibfk_1` FOREIGN KEY (`barbeiro_id`) REFERENCES `barbeiros` (`id`),
  ADD CONSTRAINT `horarios_servico_fk` FOREIGN KEY (`servico_id`) REFERENCES `servicos_barbeiro` (`id`) ON DELETE SET NULL;

--
-- Restrições para tabelas `pagamentos`
--
ALTER TABLE `pagamentos`
  ADD CONSTRAINT `pagamentos_ibfk_1` FOREIGN KEY (`horario_id`) REFERENCES `horarios` (`id`),
  ADD CONSTRAINT `pagamentos_ibfk_3` FOREIGN KEY (`barbeiro_id`) REFERENCES `barbeiros` (`id`),
  ADD CONSTRAINT `pagamentos_servico_barbeiro_fk` FOREIGN KEY (`servico_id`) REFERENCES `servicos_barbeiro` (`id`) ON DELETE SET NULL;

--
-- Restrições para tabelas `servicos_barbeiro`
--
ALTER TABLE `servicos_barbeiro`
  ADD CONSTRAINT `servicos_barbeiro_ibfk_1` FOREIGN KEY (`barbeiro_id`) REFERENCES `barbeiros` (`id`) ON DELETE CASCADE;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
