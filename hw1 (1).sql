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
('https://www.google.it/url?url=https://giochi.unilibro.it/gioco/8051070900617%3Fidaff%3Dgooglebase-03%26srsltid%3DAWLEVJxPcFmR1ks3PXr_IKT-WKOuNmy-2VQBKkA9zlD6A_oOfkZfyyYSIEY&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiGy7eI5Ov3AhUUVTABHcXFCDgQguUECMIG&usg=AOvVaw1345s', 'Unilibro.it', 'Collana Ciondolo Nome Gabriele Angioletto Legno ulivo', 2.8, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQrKOgRaLAO3xtqcDBniRVNDSeMCKR1c71sq8eTqbnfOD0aPZ97pCURs6fZvqeSg6uQTeGSmfM8KkLLQlD4kF0GOWY9PwiL-ZJQyxCoXePP2es_c8TnsqLU&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003117768294.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%', 'AliExpress.com', 'UNO R3 MEGA328P CH340 CH340G ATMEGA16U2   Chip MEGA328P per scheda di sviluppo ...', 0.75, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQ2VFTF_fjxXgRYFFfJs4UglztI_YNq99GwfvODLfH7eKr7CcHcEeiy3I5sXTV8e4QXr6Xu0cyBxdS4lhhrNz0sP-bRFWJz6KH6zjU3st8GeyY8tTnNqs9L0Q&usqp=CAE'),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3/%3Fsrsltid%3DAWLEVJyN_uqGJ3q6fUV8wfJepLsTf90CWbEX2byg0lSopclFl0gLiSaG6FA&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwikhfmY1uv3AhXZmWoFHal6B3wQguUECPQH&usg=AOvVaw1g3HsoUX6Xd1ZJJhIHcRoV', 'Arduino Official Store', 'Arduino Uno REV3 [A000066]', 20, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTNFj5ahb2rljsQ-3kygftelnUWcb98qFTvR6ZsoSoKEnyIkBa55c1zen20Fvc2Ckq1uNTwcG8F5q_iJU6jk1i48EsRKRdnNaI7buJvrK6x&usqp=CAE'),
('https://www.google.it/url?url=https://www.libreriauniversitaria.it/federico-grande-alessandro-barbero-sellerio/libro/9788838936920%3Futm_source%3Dgoogle-shopping%26utm_medium%3Dcpc%26utm_term%3D9788838936920%26utm_content%3DLibri%2520Italiani%26utm_campai', 'LibreriaUniversitaria.it', 'Alessandro Barbero Federico Il Grande', 12.35, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTSmhYpE2qQftxBpNZlraMwgWyqDpX8Ij3Vl5Gy3H7Ap6a_pEfk54dpI59NT0Fw84tpOJ0PijGAEP4VPDvt0PH65vMLVqdB&usqp=CAE'),
('https://www.google.it/url?url=https://www.macrolibrarsi.it/prodotti/__pistacchio-crema-di-pistacchi-bio.php&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwizh9ay5Ov3AhUGn-AKHVmQDAkQguUECNcG&usg=AOvVaw2BDeTetCAib-F41IDLO-a8', 'Macrolibrarsi.it', 'Damiano - Crema di Pistacchi Tostati Bio 180 G', 12.51, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTco3QAoYrT-5a9KG7W1MeYCqUCuqMcfmGSc4AMWSLsXgAndCSxnVmxKNoCN_GcPQS6hFQZLPVmbVn-7UM2rIwdQPT84SCX5GUIdpLDeq7mZKSvAKsQdnwN&usqp=CAE');

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

INSERT INTO `prodotto-carrello` (`prodotto`, `carrello`, `quantita`) VALUES
('https://www.google.it/url?url=https://giochi.unilibro.it/gioco/8051070900617%3Fidaff%3Dgooglebase-03%26srsltid%3DAWLEVJxPcFmR1ks3PXr_IKT-WKOuNmy-2VQBKkA9zlD6A_oOfkZfyyYSIEY&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiGy7eI5Ov3AhUUVTABHcXFCDgQguUECMIG&usg=AOvVaw1345s', 1, 1),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3/%3Fsrsltid%3DAWLEVJyN_uqGJ3q6fUV8wfJepLsTf90CWbEX2byg0lSopclFl0gLiSaG6FA&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwikhfmY1uv3AhXZmWoFHal6B3wQguUECPQH&usg=AOvVaw1g3HsoUX6Xd1ZJJhIHcRoV', 1, 1),
('https://www.google.it/url?url=https://www.libreriauniversitaria.it/federico-grande-alessandro-barbero-sellerio/libro/9788838936920%3Futm_source%3Dgoogle-shopping%26utm_medium%3Dcpc%26utm_term%3D9788838936920%26utm_content%3DLibri%2520Italiani%26utm_campai', 1, 1),
('https://www.google.it/url?url=https://www.macrolibrarsi.it/prodotti/__pistacchio-crema-di-pistacchi-bio.php&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwizh9ay5Ov3AhUGn-AKHVmQDAkQguUECNcG&usg=AOvVaw2BDeTetCAib-F41IDLO-a8', 1, 1);

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

if ((SELECT max(id) FROM `carrello`) >0) THEN
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
