-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 19, 2022 alle 13:39
-- Versione del server: 10.4.24-MariaDB
-- Versione PHP: 7.4.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Database: `hw1`
--

-- --------------------------------------------------------

--
-- Struttura della tabella `carrello`
--

CREATE TABLE `carrello` (
  `ID` int(11) NOT NULL,
  `proprietario` varchar(20) NOT NULL,
  `Totale` float DEFAULT 0,
  `Nome` varchar(25) DEFAULT NULL,
  `Descrizione` varchar(255) DEFAULT NULL,
  `likes` int(11) DEFAULT 0,
  `commenti` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `carrello`
--

INSERT INTO `carrello` (`ID`, `proprietario`, `Totale`, `Nome`, `Descrizione`, `likes`, `commenti`) VALUES
(1, 'root', 0, NULL, NULL, 0, 0);

-- --------------------------------------------------------

--
-- Struttura della tabella `commenti`
--

CREATE TABLE `commenti` (
  `mittente` varchar(20) NOT NULL,
  `carrello` int(11) NOT NULL,
  `commento` varchar(255) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Trigger `commenti`
--
DELIMITER $$
CREATE TRIGGER `aggiungiCommento` AFTER INSERT ON `commenti` FOR EACH ROW BEGIN
UPDATE carrello
SET commenti = commenti+1
WHERE ID=new.carrello;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sottraiCommento` BEFORE DELETE ON `commenti` FOR EACH ROW BEGIN
UPDATE carrello
SET commenti = commenti-1
WHERE id=old.carrello;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `piaciuti`
--

CREATE TABLE `piaciuti` (
  `mittente` varchar(20) NOT NULL,
  `carrello` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Trigger `piaciuti`
--
DELIMITER $$
CREATE TRIGGER `aggiungiLike` AFTER INSERT ON `piaciuti` FOR EACH ROW BEGIN
UPDATE carrello
SET likes = likes+1
WHERE ID=new.carrello;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sottraiLike` BEFORE DELETE ON `piaciuti` FOR EACH ROW BEGIN
UPDATE carrello
SET likes = likes-1
WHERE ID=old.carrello;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotti`
--

CREATE TABLE `prodotti` (
  `url` varchar(255) NOT NULL,
  `Venditore` varchar(255) NOT NULL,
  `titolo` varchar(255) NOT NULL,
  `prezzo` float NOT NULL,
  `UrlImg` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `prodotti`
--

INSERT INTO `prodotti` (`url`, `Venditore`, `titolo`, `prezzo`, `UrlImg`) VALUES
('https://www.google.it/aclk?sa=L&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABADGgJwdg&sig=AOD64_306pNBXI0luorGXm0xvWx4dzukvw&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Qww8I1gc&adurl=', 'Amazon.it', 'ELEGOO Advanced Starter Kit per progetti per Principianti con Kit di apprendimento Italiano Compatibile con i progetti IDE di Arduino', 45.99, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTLM9mCvOBoVTXBGqbtc5H6t6XwZXQ_rTadHoowaqAkIF4mzf-DDqY-FCozNrlESmnrkDgtOrQS8UUSY-8VMZQLgUkW-acyrBbOXKVa6P8&usqp=CAE'),
('https://www.google.it/aclk?sa=l&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABAFGgJwdg&sig=AOD64_08HBKql0LuQT2bjRR9DfMBSztUFA&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Qww8I2Qc&adurl=', 'RS Components Italy', 'Arduino Starter Kit versione tedesca multilingue, K040007', 101.76, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcR2RHcc-El5yLduwS0yRl950BZWPBqw2jbRjzJfAIFABd70qIFVLXcUpJVurqroehBlKIPAqJaA19R_66WWqLO82PKN-ps1BCwFiuwDBuMII9QZzfHs2vyi&usqp=CAE'),
('https://www.google.it/aclk?sa=l&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABAHGgJwdg&sig=AOD64_0eDoAWfElvi-ruzOoTeQBxcCYpMQ&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Qww8I3Ac&adurl=', 'Arduino Official Store', 'Arduino Starter Kit [Italiano   Manuale Ufficiale]', 79.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRHuMT3wMqwEahxCG_M2Jv9hiR_bj1C5fUbpxmeanD9O9lUPeKYwTQmsiW6DrNd0qTWtSQzCP554t1SsdGETsJt3m3LKER8OE8xQokG25m9ahZ9icW9AJJjGw&usqp=CAE'),
('https://www.google.it/aclk?sa=L&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABAJGgJwdg&sig=AOD64_1qlDFx9ZAXfL-nOUPxhvt1xQoFlg&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Qww8I3wc&adurl=', 'Amazon.it', 'ELEGOO MEGA R3 Lo Starter Kit più Completo con Tutorial Italiano Compatibile con i Progetti IDE di Arduino', 73.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRahb2UxFo_CpIcdprjdL18W_OC5842q_ycqXQ_vdKy4oQDx98Vi0bGxwL9WCjhZnBQevVV2jVxOgUWFtWYZvzG-qimp6gXwVF938cHO_0&usqp=CAE'),
('https://www.google.it/aclk?sa=l&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABCDARoCcHY&sig=AOD64_3iBYlT8ybOs4C-WAACzdzS1l4_Ug&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Q9A4IvQ0&adurl=', 'RS Components Italy', 'Arduino Uno Rev 3, A000066', 24.8, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTSyoRMuv9DazhJf7W7cFDluAqWfzzOkeYqMQtyoUmQlaiG-uTH3bykWU8qu47mEO5yJJwv12o7DJxJ_bWaxM4VsXLnfmrgb8uOI-inIVtGeU81G46EPP9h5Q&usqp=CAE'),
('https://www.google.it/aclk?sa=L&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABCJARoCcHY&sig=AOD64_0OAIrLDsE90cQTDpxzfNhQG54kvA&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Q9A4Ixg0&adurl=', 'Amazon.it', 'Smraza Progetto Starter Kit con Breadboard Holder, DC Motore per Principianti con Manuale Compatibile con Arduino Mega2560 Mega328 Nano', 28.99, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTe_gTd-waSiGSvrzGfpymFDGzk2IN2Ou2BmS4Ed1QukZpCzRVywG1KDFzhGAsKhGgMgKdrZAySCF8Io7pc0AM_SYFQ6K3o9JqOZoZhLkrlGPU1r89rSfv8Cg&usqp=CAE');

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotto-carrello`
--

CREATE TABLE `prodotto-carrello` (
  `prodotto` varchar(255) NOT NULL,
  `carrello` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `prodotto-carrello`
--

INSERT INTO `prodotto-carrello` (`prodotto`, `carrello`) VALUES
('https://www.google.it/aclk?sa=l&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABAFGgJwdg&sig=AOD64_08HBKql0LuQT2bjRR9DfMBSztUFA&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Qww8I2Qc&adurl=', 1),
('https://www.google.it/aclk?sa=l&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABAHGgJwdg&sig=AOD64_0eDoAWfElvi-ruzOoTeQBxcCYpMQ&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Qww8I3Ac&adurl=', 1),
('https://www.google.it/aclk?sa=L&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABAJGgJwdg&sig=AOD64_1qlDFx9ZAXfL-nOUPxhvt1xQoFlg&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Qww8I3wc&adurl=', 1),
('https://www.google.it/aclk?sa=l&ai=DChcSEwiLu5v_rev3AhXrKK0GHSpQBjsYABCDARoCcHY&sig=AOD64_3iBYlT8ybOs4C-WAACzdzS1l4_Ug&ctype=5&q=&ved=0ahUKEwi5yZL_rev3AhXpT98KHfAOCk4Q9A4IvQ0&adurl=', 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `profilo`
--

CREATE TABLE `profilo` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `ImmagineProfilo` blob DEFAULT NULL,
  `carrelloCorrente` int(11) DEFAULT 0,
  `seguaci` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `profilo`
--

INSERT INTO `profilo` (`Username`, `Password`, `Email`, `ImmagineProfilo`, `carrelloCorrente`, `seguaci`) VALUES
('root', 'admin1', 'root@root.it', NULL, 1, 0);

--
-- Trigger `profilo`
--
DELIMITER $$
CREATE TRIGGER `creaCarrello` AFTER INSERT ON `profilo` FOR EACH ROW BEGIN
INSERT INTO `carrello` ( `proprietario`, `Totale`, `Nome`, `Descrizione`, `likes`, `commenti`) VALUES 
(new.Username, '0', NULL, NULL, '0', '0');


END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `numeroCarrello` BEFORE INSERT ON `profilo` FOR EACH ROW BEGIN

if (SELECT (max(id)+1) FROM `carrello`) != null THEN
	SET new.carrelloCorrente=(SELECT (max(id)+1) FROM `carrello`);
ELSE
	set new.carrelloCorrente=1;
end IF;


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `segui`
--

CREATE TABLE `segui` (
  `seguace` varchar(20) NOT NULL,
  `seguito` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Trigger `segui`
--
DELIMITER $$
CREATE TRIGGER `aggiungiFollower` AFTER INSERT ON `segui` FOR EACH ROW BEGIN
UPDATE profilo
SET seguaci = seguaci+1
WHERE Username=new.seguito;
END
$$
DELIMITER ;
DELIMITER $$
CREATE TRIGGER `sottraiFollower` BEFORE DELETE ON `segui` FOR EACH ROW BEGIN
UPDATE profilo
SET seguaci = seguaci-1
WHERE Username=old.seguito;
END
$$
DELIMITER ;

--
-- Indici per le tabelle scaricate
--

--
-- Indici per le tabelle `carrello`
--
ALTER TABLE `carrello`
  ADD PRIMARY KEY (`ID`),
  ADD KEY `proprietario` (`proprietario`);

--
-- Indici per le tabelle `commenti`
--
ALTER TABLE `commenti`
  ADD PRIMARY KEY (`mittente`,`carrello`);

--
-- Indici per le tabelle `piaciuti`
--
ALTER TABLE `piaciuti`
  ADD PRIMARY KEY (`mittente`,`carrello`);

--
-- Indici per le tabelle `prodotti`
--
ALTER TABLE `prodotti`
  ADD PRIMARY KEY (`url`);

--
-- Indici per le tabelle `prodotto-carrello`
--
ALTER TABLE `prodotto-carrello`
  ADD PRIMARY KEY (`prodotto`,`carrello`),
  ADD KEY `carrello` (`carrello`);

--
-- Indici per le tabelle `profilo`
--
ALTER TABLE `profilo`
  ADD PRIMARY KEY (`Username`),
  ADD UNIQUE KEY `ind_email` (`Email`);

--
-- Indici per le tabelle `segui`
--
ALTER TABLE `segui`
  ADD PRIMARY KEY (`seguace`,`seguito`),
  ADD KEY `seguito` (`seguito`);

--
-- AUTO_INCREMENT per le tabelle scaricate
--

--
-- AUTO_INCREMENT per la tabella `carrello`
--
ALTER TABLE `carrello`
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `carrello`
--
ALTER TABLE `carrello`
  ADD CONSTRAINT `carrello_ibfk_1` FOREIGN KEY (`proprietario`) REFERENCES `profilo` (`Username`);

--
-- Limiti per la tabella `commenti`
--
ALTER TABLE `commenti`
  ADD CONSTRAINT `commenti_ibfk_1` FOREIGN KEY (`mittente`) REFERENCES `profilo` (`Username`);

--
-- Limiti per la tabella `piaciuti`
--
ALTER TABLE `piaciuti`
  ADD CONSTRAINT `piaciuti_ibfk_1` FOREIGN KEY (`mittente`) REFERENCES `profilo` (`Username`);

--
-- Limiti per la tabella `prodotto-carrello`
--
ALTER TABLE `prodotto-carrello`
  ADD CONSTRAINT `prodotto-carrello_ibfk_1` FOREIGN KEY (`carrello`) REFERENCES `carrello` (`ID`);

--
-- Limiti per la tabella `segui`
--
ALTER TABLE `segui`
  ADD CONSTRAINT `segui_ibfk_1` FOREIGN KEY (`seguace`) REFERENCES `profilo` (`Username`),
  ADD CONSTRAINT `segui_ibfk_2` FOREIGN KEY (`seguito`) REFERENCES `profilo` (`Username`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
