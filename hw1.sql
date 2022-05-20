-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 19, 2022 alle 18:27
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


-- --------------------------------------------------------

--
-- Struttura della tabella `prodotto-carrello`
--

CREATE TABLE `prodotto-carrello` (
  `prodotto` varchar(255) NOT NULL,
  `carrello` int(11) NOT NULL,
  `quantita` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `prodotto-carrello`
--


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

if ((SELECT max(id) FROM `carrello`) >0) THEN
	SET new.carrelloCorrente=(SELECT (max(id)+1) FROM `carrello`);
ELSE
	set new.carrelloCorrente=2;
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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=2;

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
