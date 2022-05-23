-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 23, 2022 alle 23:01
-- Versione del server: 10.4.21-MariaDB
-- Versione PHP: 8.0.12

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
  `commenti` int(11) DEFAULT 0,
  `data` datetime NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `carrello`
--

INSERT INTO `carrello` (`ID`, `proprietario`, `Totale`, `Nome`, `Descrizione`, `likes`, `commenti`, `data`) VALUES
(2, 'root', 0, NULL, NULL, 0, 0, '2022-05-21 00:00:00'),
(3, 'admin', 0, NULL, NULL, 0, 0, '2022-05-21 00:00:00'),
(4, 'marc2000', 0, NULL, NULL, 0, 0, '2022-05-21 00:00:00'),
(12, 'marc2000', 5527.73, 'prova', 'prova', 0, 0, '2022-05-21 00:00:00'),
(13, 'marc2000', 1486.84, 'Marco', 'asd', 0, 0, '2022-05-21 00:00:00'),
(15, 'marc2000', 25874.7, 'katana', 'spade XD', 0, 0, '2022-05-21 00:00:00'),
(16, 'prova', 0, NULL, NULL, 0, 0, '2022-05-21 00:00:00'),
(17, 'admin', 63.01, 'asd', 'sad', 0, 0, '2022-05-21 00:00:00'),
(18, 'admin', 120.45, 'sad', 'asd', 1, 0, '2022-05-21 00:00:00'),
(19, 'admin', 86.89, 'bel carrello', 'sono un bel carrello', 1, 0, '2022-05-21 00:00:00'),
(20, 'marc2000', 134.9, 'Carrello Giorgio', 'Carrello Giorgio', 1, 0, '2022-05-22 00:00:00'),
(21, 'marc2000', 93.09, 'salvatore', 'kolò', 1, 0, '2022-05-23 10:01:55'),
(22, 'marc2000', 4467.63, 'saddddddddddddddddddddddd', 'asdddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddddd', 1, 0, '2022-05-23 11:17:30'),
(23, 'marc2000', 234.49, 'Marco', 'arduino\n', 2, 3, '2022-05-23 12:14:36'),
(24, 'marc2000', 3038.44, 'A catta c\'è', 'e sa spaddari', 2, 5, '2022-05-23 14:39:58'),
(25, 'marc2000', 823.46, 'computer', 'con i soldi\n', 0, 1, '2022-05-23 17:21:08'),
(26, 'marc2000', 1084.65, 'Computer a poco', 'ho trovato dei computer a poco\n', 0, 0, '2022-05-23 19:36:14'),
(27, 'marc2000', 35770.9, 'Trattori', 'Ho trovato un trattore fantastico\n', 2, 2, '2022-05-23 19:38:14'),
(28, 'marc2000', 10746.5, 'altoparlanti', 'belli\n', 1, 0, '2022-05-23 22:26:26');

--
-- Trigger `carrello`
--
DELIMITER $$
CREATE TRIGGER `newid` BEFORE INSERT ON `carrello` FOR EACH ROW BEGIN

if ((SELECT max(id) FROM `carrello`) >0) THEN
	SET new.id=(SELECT (max(id)+1) FROM `carrello`);
ELSE
	set new.id=1;
end IF;


END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Struttura della tabella `commenti`
--

CREATE TABLE `commenti` (
  `mittente` varchar(20) NOT NULL,
  `carrello` int(11) NOT NULL,
  `commento` varchar(255) DEFAULT NULL,
  `id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `commenti`
--

INSERT INTO `commenti` (`mittente`, `carrello`, `commento`, `id`) VALUES
('marc2000', 23, 'bella li', 1),
('marc2000', 23, 'salveeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeeee', 2),
('marc2000', 23, 'bellaaaa', 3),
('marc2000', 24, 'ma quantu n\'hai soddi?', 4),
('marc2000', 24, 'bellaaaaaa', 5),
('marc2000', 24, 'bellaaaa', 6),
('marc2000', 24, 'commento', 7),
('marc2000', 24, 'asd1', 8),
('marc2000', 25, 'Mi piace questo computer', 9),
('marc2000', 27, 'commento ', 10),
('marc2000', 27, 'puoi commentare', 11);

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
-- Dump dei dati per la tabella `piaciuti`
--

INSERT INTO `piaciuti` (`mittente`, `carrello`) VALUES
('admin', 18),
('admin', 20),
('admin', 22),
('admin', 23),
('admin', 24),
('admin', 27),
('admin', 28),
('marc2000', 19),
('marc2000', 21),
('marc2000', 23),
('marc2000', 24),
('marc2000', 27);

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
  `url` varchar(500) NOT NULL,
  `Venditore` varchar(255) NOT NULL,
  `titolo` varchar(255) NOT NULL,
  `prezzo` float NOT NULL,
  `UrlImg` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `prodotti`
--

INSERT INTO `prodotti` (`url`, `Venditore`, `titolo`, `prezzo`, `UrlImg`) VALUES
('https://www.google.it/url?url=/shopping/product/17176339767152412360%3Fhl%3Dit%26prds%3Doid:1369835180782773604%26sts%3D9%26lsf%3Dseller:106515287,store:12589481899460405756,s:h&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjry-6Zuvb3AhURnHIEHaLBCcwQ_uQECIQP&usg=AOvVaw3_gbOvitprHLNnZkictSWc', 'FaceTheSound', 'Audio Pro BT5 Bluetooth Speaker Driftwood', 159.99, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQGr-GQpI0KN6Zi9kPaRIQ8QL3EXq47RHL8m3T6Erwq4IjZknH82MsgBbZz1FNnhKyu4FYdsYJJd9CxlotqC5MYL1X0_d0ivnMDQvn4668uEd712k36KJCT&usqp=CAE'),
('https://www.google.it/url?url=/shopping/product/2129237302702179378%3Fhl%3Dit%26prds%3Doid:4148295202826405884%26sts%3D9%26lsf%3Dseller:6786366,store:3093374873564888626,s:h&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQ_uQECNsH&usg=AOvVaw0hEF', 'Decathlon', 'Plastimo. Giubbotto salvataggio Storm 100N', 13.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS1UpeplwRAkgi5NnNK4mhE2rvmZ92v1hcGaYQHIYRodA39KQxhdQ-Lauzf6nUSXBtRC1TMuhBYfZYfP4Cot2SKlk2G4bjGCSBsF67Gc4_-8PQgF6pCjHFT&usqp=CAE'),
('https://www.google.it/url?url=https://cablematic.com/it/prodotti/scheda-programmabile-arduino-micro-AR102/%3Fcr%3DEUR%26ct%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECOMI&usg=AOvVaw3KV8tiL3YntUzg80YSMUfn', 'Cablematic', 'Arduino Micro', 23.06, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ6qmZio7jKy0C5KJm_rlTogDYgRPWKJxPti4ob8lgCBRnzjg3sqJzcksivKkuCG7LBNCK-iD35W_C0keIda1EhKbJWvyQ2MPQNqNVQyNzCWh0nnKgrEMuv&usqp=CAE'),
('https://www.google.it/url?url=https://campoelettrico.it/materiale-elettrico/scheda-arduino-mega-2560-a000067.html%3Fsrsltid%3DAWLEVJyUYv4TWXd3KRN-8ToGKS3fn_2Ag1xa6ZFvD5K337bV-NnWPLMfi00&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECPAI&us', 'CampoElettrico.it', 'Arduino Scheda Mega 2560 A000067', 38.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTdeQJeaLlmPcwWN7MJTIU8MmC2LkbhoX04Tf1zKfVMGvMskmqilsnXSVOkfaiIiFsNvx4rX04RDa10PLe6c2d_8NKKU4XcWOqP90DkyGrSNwHKNNf8-F7bQw&usqp=CAE'),
('https://www.google.it/url?url=https://friscoshop.it/products/polar-skate-co-psc-co-happysadsocks-long-blk-calze-happy-sad-long-calze-uomo-black&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQgOUECJIH&usg=AOvVaw2BVSG1I7or68zK89qadMVk', 'Friscoshop.it', 'Polar Skate Co., Calze Happy Sad - Long - 4346', 12, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQfxG8wILbfPv3ufojwOJzTc_WeUhaO2kBz50Oy6bawJmVsr7z60XS6tTTfV-57bNphHsFIYN3PvqWTH3z2GEQUZqgxPSkVqAOcV3kcIYzdzbpMv2u_q7-d&usqp=CAE'),
('https://www.google.it/url?url=https://giochi.unilibro.it/gioco/8051070900686%3Fidaff%3Dgooglebase-03%26srsltid%3DAWLEVJybMUtsOSg8T9mpqTuZFmaPMiQwJHlqWjdBIQvbTH-2uqTemDTa_o4&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECNMJ&usg=AOvVaw1jpSGiD51HJf4rmbmOB-8g', 'Unilibro.it', 'Collana Ciondolo Nome Giorgio Angioletto Legno ulivo', 2.8, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcSrjj2lWXu1Ei6ddpQz7nvlTfx_lTEYqcS9MxD3NOKAMj22lErP-Ark9YOFVx-nCdfWg5ZHVM35pX_cbEPuM1kSkmsjwVslbNB8KC_6wW0NFQgNKaoYjXY9qQ&usqp=CAE'),
('https://www.google.it/url?url=https://lojadeartigosreligiosos.com/medalha-duas-faces-9&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQgOUECL8K&usg=AOvVaw1x7DpkLL7XXGoXOscxDaRm', 'Loja de Artigos Religiosos Online', 'Medaglia di San Giorgio 3 cm Dorato', 1.56, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTv2PGQH6CwXAAxG9bp-uTu4itrjnKINF8jdn8APMxQ161PQSDxO80XLUa32hZBSQx2Zr_JCHkRv50uV1nO21jbe9CGww1D7NLkr6iKYSK16t0fu-Ksg6In&usqp=CAE'),
('https://www.google.it/url?url=https://mondoricondizionato.it/computer/4727-dell-optiplex-760-e7400-280ghz-4gb-160gb-hdd-sff-grado-b-0673983035125.html%3Fsrsltid%3DAWLEVJx55pwzLtgDjR0Ld9fQ_hEgEhk_A1lJuJllEosF-LGxkLyynrfLlTE&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECNAI&usg=AOvVaw2RKzxoXrk2HyBlXWbkPptd', 'mondoricondizionato', 'Dell OptiPlex 760 E7400 2.80GHZ 4GB 160GB HDD SFF grado B - Computer', 64.05, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcR-K0GgmVC-rjXcuKQKqdydbrkMLuzKuhd0WKhGszncbScVlhFHuv4ViK3uSA6f9J8ofYTeWLdbYKCgcp2hFHUgdVljQ1HZxw&usqp=CAE'),
('https://www.google.it/url?url=https://ricambiagricoltura.com/prodotto/forbici-elettriche-da-potatura-brumi-con-display/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QgOUECLQJ&usg=AOvVaw1c1_cIkkwpWQMQrL_0zmLi', 'Ricambi Agricoltura', 'FORBICI DA POTATURA ELETTRICHE BRUMI CON DISPLAY E 2 BATTERIE AL LITIO DIAMETRO ...', 350, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcR_w818iZr-svD-6UNOzbaXamGVnecWhPufN4YrzpU71b9NxRVr1OdCLlU6-z9PAp13jHOpelLIScW9ZyqdyNdZWUiiyn8Dds7UWLQhVL1_w2SGxqpzNYib&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002248206928.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%', 'AliExpress.com', 'Giubbotto di salvataggio per adulti nuoto galleggiamento giubbotto di salvataggio ...', 20.88, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTaERZESWh3SyJ6n5apWajx0cIh3odrRIA6KnngBBUCvBzgOZLli0v9qv0cZKOmCFJksr3vpFANcnpE7vPlJcH1FaDdxBK8owagByJZwEcKQFNZJ3O-AqmrMw&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002248206928.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle%2526memo1%253Dfreelisting&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQgOUECN4H&usg=AOvVaw2SwKuNm1KA75J24Bzw8gMI', 'AliExpress.com', 'Giubbotto di salvataggio per adulti nuoto galleggiamento giubbotto di salvataggio ...', 21.06, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTaERZESWh3SyJ6n5apWajx0cIh3odrRIA6KnngBBUCvBzgOZLli0v9qv0cZKOmCFJksr3vpFANcnpE7vPlJcH1FaDdxBK8owagByJZwEcKQFNZJ3O-AqmrMw&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002504051069.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECJYI&usg=AOvVaw118mHMlKZYW8K9zXYOc_0D', 'AliExpress.com', 'SYNBON macchina agricola nuova serra Mini trattore frutteto attrezzature macchine ...', 7643.16, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSSzWnHjNYLgeu5oDF_f1ZjW-WQfNRq3U1MspMw9jnA-tQ62KiD3g6CTE1luPxLZ9WMORS3gIyX8O4BRA3wvM_b_cL83bxPRzFmtWTV_ds&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002885424120.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%', 'AliExpress.com', 'Forbici da potatura elettriche cesoie da potatura 500W potatore da giardino ...', 8.34, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSFEZBIAEZA3P-N6ce__oW9kYdA3NGmxbNCdt9FgQirEE9ruODu6b3e09spO7-Jx7JXk8WWsdmg890DQ3lpKgmkDjWSdYco2TCQmzNdhK1FvB9oQT6sPXjIIA&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002912679332.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%', 'AliExpress.com', 'Sacchetto di nuoto gonfiabile boa di nuoto sacchetto di salvataggio rimorchio ...', 4.66, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQZ5gM0t3SoMoA73kGwpGwYZI6A4spB2AovGD9-RXHicPzaSx7p1--5GQ5WlPhdmEtdpASvqYinLAhyxFujS7KGRIZS9ur1AaSK4vfHMBRAusv5JZoaVWib&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003117768294.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%', 'AliExpress.com', 'UNO R3 MEGA328P CH340 CH340G ATMEGA16U2   Chip MEGA328P per scheda di sviluppo ...', 0.75, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQ2VFTF_fjxXgRYFFfJs4UglztI_YNq99GwfvODLfH7eKr7CcHcEeiy3I5sXTV8e4QXr6Xu0cyBxdS4lhhrNz0sP-bRFWJz6KH6zjU3st8GeyY8tTnNqs9L0Q&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003249588186.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECKMI&usg=AOvVaw0AkMGbtVSlGWdMyrCxpGTh', 'AliExpress.com', 'PC da gioco AMD 6-Core R5 3600 RTX3060 12G DDR4 16G RAM 500G M.2 computer Desktop ...', 113.4, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTU8mnkHCsfFFPjWrTr7akty-UVRO-eGRllDF18AFdFknWeaV5E9oYmRo5tLvQVmxKf-80tQZcUmbZJ0bk1m8SG9ShDyQwV6qGBuRgL94G4ZGzcFWq-sfT1vg&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003911223695.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQgOUECNII&usg=AOvVaw1y51MUomwGytK-oNxzHjo1', 'AliExpress.com', 'Giubbotto di salvataggio in PVC SUP nella migliore qualità', 70.35, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQLmcN-QG4UHVK8uxR3m83EL0cIrb3CAOsnYpq-A8oTkh5FNb6L5qY71nC9UJi6Pd1FIAcgXfiT&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004038949095.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECK0I&usg=AOvVaw39QpJH6X2zv9gydazAPmxO', 'AliExpress.com', '2022 nuovo giubbotto di salvataggio da pesca Dawa giubbotto di salvataggio da ...', 104.32, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQm-5eUG8Lzz1z8woZViecLP8TfZvWNATSvXcnq1MXonD5Zo9j2Xcr0N_MWX_JJCWseqPbTlfnhslLV3D2bQFbeodOS3ca46OLs-6IaZ4c155au2fPpAxAm&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004058750819.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECKEI&usg=AOvVaw0u2AArETpJmOU6iKca1tYn', 'AliExpress.com', 'Piccolo trattore agricolo AOS', 2359.48, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcSvhsDJlEMu9tWHaTnwoNZ1d1AZm9wpwtGxFmrk7eExis3ZLNDzQg70a_5PjkKqwvFfqKOMu7y-VmrfwIk8sNQAC58hCjEOukPmmjr7CAM&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004058924960.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECPUH&usg=AOvVaw1CVjGnw-PJLlkdNXd3Rh6u', 'AliExpress.com', 'Piccolo trattore a quattro ruote motrici che può essere dotato di più ...', 2276.81, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSpkrlAuHobocFec7eqPgO9a83dEkO36Z5QnxisNWr1-Ob2BnCl1AOHSEkwdI-kHX76EwOCGOLxu7LtQNI6eeEO71LkZa9Rt2Z48bI1hDA&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004059444918.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECN8H&usg=AOvVaw2ei8kxnxoLCIfta0obwcxw', 'AliExpress.com', 'Piccolo trattore agricolo multifunzionale e multi-modello', 2194.32, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcSeREUeUkT7pKPX0Epccf4mFWfEjvLcDimdyZEeE4DNnhkmWiysCFiBx7Gj-UqqzLV5j2M08zqFPHWgL-Nm4klogKHWFNzDKKu0twGsVY4&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004144813439.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECOgI&usg=AOvVaw3FxIToWtD3mm_9Wt4DIzlV', 'AliExpress.com', 'Set di Computer computerador pc Gamer Core i5 CPU DDR4 8/16GB SSD Gaming Pc ...', 113.4, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS7c3jYK1tEbeLgmV2rjW06F00e8nFPQo4n2CIvgspR6eoHo_8AbuaL4szUa1dT-wOo_GQjrlDfDoJ2asj74xosb90A-nJ4SXUEsCgFwufYopL4HgBxIGG5&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004187839724.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECMUI&usg=AOvVaw04ibLrrZiQLp2ax3iOrd9Q', 'AliExpress.com', 'OEM CPU I7 Core host computer ad alte prestazioni in vendita', 483.11, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQu4kXPVSn4efWVJplvQ8Z8jr_BzLIYFd6QJENaybZteWtExlUFi-MxQ-Dc8c4kJ5NqBZvblPda3QipC6YyCCZWxp-wc_uh4UO6x7iVxrQcOVPjas2rjWvX&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004195050867.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi0u-PLwfP3AhXmqXIEHbVkAXIQgOUECP8H&usg=AOvVaw2snj0edtZzPEgZ3XOIbsvM', 'AliExpress.com', '100kg giubbotto di salvataggio di sopravvivenza giubbotto di salvataggio per ...', 24.21, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSqkO0eBeNy6I_UPTUV39cmuugRhMOGXr28aSVdU8uROgo2JNQwEiNDzvoqxyR5E91KnSgz5vGHpAUK6OM9k72U5Q2sy5ZLvfwa7waJyucUmThtRlxcWjCs&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004195050867.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECLoH&usg=AOvVaw1nX1IpK0rDJZ4X-sOonzLV', 'AliExpress.com', '100kg giubbotto di salvataggio di sopravvivenza giubbotto di salvataggio per ...', 24.21, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSqkO0eBeNy6I_UPTUV39cmuugRhMOGXr28aSVdU8uROgo2JNQwEiNDzvoqxyR5E91KnSgz5vGHpAUK6OM9k72U5Q2sy5ZLvfwa7waJyucUmThtRlxcWjCs&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F32680845470.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dg', 'AliExpress.com', 'Di alta qualità di Un set di UNO R3 CH340G   MEGA328P Chip di 16Mhz per arduino ...', 1.29, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSzpaR9H49IiKBzMAJrRudGg1ekZJme33eKRQN1EX3HkecWZUTxpauRfHbFDFelucCQJwkr-KGmExqXv-ziwoa1_PejIsv4hYByoWEEX0zE0qAh8yFJ7z-JUA&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F32689353609.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwif9MSDwvb3AhXtj2oFHTVfDZkQgOUECN8G&usg=AOvVaw1V6u_lPVkVdMQrQpAVi5uA', 'AliExpress.com', 'Nuovo MPU-6050 MPU6050 modulo 3 assi giroscopio   modulo accelerometro per MPU 6050', 1.16, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQrGZGmEbpYEF_p11TqreSvXCC_OLKIT_LemAki6dEJacFiqrRQGcMDfmQSACHgSO68a9BL_avAdL4jaQh9E0_MC_vn5-0Ig_l7NB8a8Jav9iSLogocOmTXUA&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F4001309679133.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253', 'AliExpress.com', 'Adulto Giubbotto di Salvataggio di Nuotata di Nuoto Galleggiante Maglia Giubbotto ...', 29.18, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcR1_AVQuyFs8fWN3jq_Udo_2bN8jy5D5jEJNDeW8Ynk9ijyeW3OhRzRGPhRMnPgOh7JcnCSniWe_pfmOlEplI0HnQChkmxeh28Q23qP1Hr-_3rjAx8bFzzN&usqp=CAE'),
('https://www.google.it/url?url=https://sq-service.it/5981-2901252-zattera-ev-12p-abs-iso9650-italy-zattera-di-salvataggio-oceanic-italia-9650-eurovinil.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECPIH&usg=AOvVaw2EHX4HTPgXaN0KKaCO4mWK', 'SQ service', '2901252 zattera ev 12p abs iso9650 italy zattera di salvataggio oceanic-italia ...', 2193.93, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQUMXRntK9cO4qljYnqio1TNxO4VAoCUHir1H9kotH_PZbgOUX3PcbCaMHefUQQ15ek3eLFca9GYiOJudZSOWjp_o83t01q_mLWH63Ygvo0H0VjEj9OZ7EYCA&usqp=CAE'),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3/%3Fsrsltid%3DAWLEVJwmyL9MNayF1yEeNglzWZjKooi3soVF61eFWokhTPr46Kxr_320VG4&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjatMSsrvD3AhXGkIkEHVxGDP0QguUECNsH&usg=AOvVaw3oiDHPbVDZA_qjiJsts8Jj', 'Arduino Official Store', 'Arduino Uno REV3 [A000066]', 20, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTNFj5ahb2rljsQ-3kygftelnUWcb98qFTvR6ZsoSoKEnyIkBa55c1zen20Fvc2Ckq1uNTwcG8F5q_iJU6jk1i48EsRKRdnNaI7buJvrK6x&usqp=CAE'),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3/%3Fsrsltid%3DAWLEVJyQkyFJxVrKLImHbjmaDouE-3AS2ZH8TH8Bu79ZnbTQTD0drvFd51M&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECJcI&usg=AOvVaw26pLRK4wEbygCGOfGRM6oA', 'Arduino Official Store', 'Arduino Uno REV3 [A000066]', 20, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTNFj5ahb2rljsQ-3kygftelnUWcb98qFTvR6ZsoSoKEnyIkBa55c1zen20Fvc2Ckq1uNTwcG8F5q_iJU6jk1i48EsRKRdnNaI7buJvrK6x&usqp=CAE'),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECP0H&usg=AOvVaw1OFpYwRatU6D3s-fewZnl2', 'Tutto Cantiere Online', 'Dispositivo di salvataggio ed evacuazione   sacco TC013', 1450, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ3hHJvoLRip-SEYqcxd-bgafL_MJbOj60HI4WYZkHiwkxbsFPWKfaasc1Z1dQCZTampLiYrs9FHtKP6ByVXsbCcXSgNqy6fCRdKgMDWSOC1e6lzIHfhJ7Z&usqp=CAE'),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQgOUECJ0I&usg=AOvVaw0AZdMu76WEI1PAoS8a7aL-', 'Tutto Cantiere Online', 'Dispositivo di salvataggio ed evacuazione   sacco TC013', 1450, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ3hHJvoLRip-SEYqcxd-bgafL_MJbOj60HI4WYZkHiwkxbsFPWKfaasc1Z1dQCZTampLiYrs9FHtKP6ByVXsbCcXSgNqy6fCRdKgMDWSOC1e6lzIHfhJ7Z&usqp=CAE'),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECIsI&usg=AOvVaw3-cv6nRREj7IcWxXX9prG1', 'Tutto Cantiere Online', 'Dispositivo di salvataggio ed evacuazione   sacco TC013', 1450, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ3hHJvoLRip-SEYqcxd-bgafL_MJbOj60HI4WYZkHiwkxbsFPWKfaasc1Z1dQCZTampLiYrs9FHtKP6ByVXsbCcXSgNqy6fCRdKgMDWSOC1e6lzIHfhJ7Z&usqp=CAE'),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQgOUECJsI&usg=AOvVaw1vccuAtY1BbBSX4Y7b-rgR', 'Tutto Cantiere Online', 'Dispositivo di salvataggio ed evacuazione   sacco TC013', 1450, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ3hHJvoLRip-SEYqcxd-bgafL_MJbOj60HI4WYZkHiwkxbsFPWKfaasc1Z1dQCZTampLiYrs9FHtKP6ByVXsbCcXSgNqy6fCRdKgMDWSOC1e6lzIHfhJ7Z&usqp=CAE'),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjp6ZWilu73AhUYkGoFHVQmCqcQgOUECPoH&usg=AOvVaw3Eea6jU_bt5NfUnWLcySXm', 'Tutto Cantiere Online', 'Dispositivo di salvataggio ed evacuazione   sacco TC013', 1450, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ3hHJvoLRip-SEYqcxd-bgafL_MJbOj60HI4WYZkHiwkxbsFPWKfaasc1Z1dQCZTampLiYrs9FHtKP6ByVXsbCcXSgNqy6fCRdKgMDWSOC1e6lzIHfhJ7Z&usqp=CAE'),
('https://www.google.it/url?url=https://whitecapsproducts.com/it/giubbotto-di-salvataggio-astral-serpent-2-0.html%3Fcombi_id%3D50416&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECIII&usg=AOvVaw1h7_yUwpS6iJ2wUaAvnbmB', 'Whitecaps Products', 'Giubbotto di salvataggio ASTRAL Serpent 2.0 (Dimensione: S/M) (Colore: Grande ...', 200, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRDiJ4ZGiLAHozvppVNkmC-J9t3b8E1QuVMlGwc2S1DY084Xr0xR7UpmGgb9BfNHICtFpo0FWn_&usqp=CAE'),
('https://www.google.it/url?url=https://wixsoo.com/prodotto/costume-mare-rosso-salvataggio-lifeguard-personalizzato-con-logo/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECJQI&usg=AOvVaw3kIVnb1f56T_zfoYCg9JOr', 'wixsoo.com', 'Costume Mare Rosso salvataggio Lifeguard Personalizzato con Logo', 21, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcS0Emg-7tVsgoovsgT0eXe5lfBXSnmuuinL6EvvqJDMW_t69iT1QEr8Wx2yPpRXbNOYtH9-tKZOhBLYDx3b-OKnIHnyeC3U&usqp=CAE'),
('https://www.google.it/url?url=https://wixsoo.com/prodotto/costume-mare-rosso-salvataggio-lifeguard-personalizzato-con-logo/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQguUECPQH&usg=AOvVaw1uUtCOyvqxPrzVnluRswfW', 'wixsoo.com', 'Costume Mare Rosso salvataggio Lifeguard Personalizzato con Logo', 21, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcS0Emg-7tVsgoovsgT0eXe5lfBXSnmuuinL6EvvqJDMW_t69iT1QEr8Wx2yPpRXbNOYtH9-tKZOhBLYDx3b-OKnIHnyeC3U&usqp=CAE'),
('https://www.google.it/url?url=https://wixsoo.com/prodotto/polo-salvataggio-rossa-manica-lunga-uomo-personalizzata-con-logo/%3Fattribute_opzioni%3D%252BBANDIERA%2B(%252B%25E2%2582%25AC1%252C50)&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiH0_-_h-73AhWRq3IEHeIWAcQQguUE', 'wixsoo.com', 'Polo salvataggio Rossa Manica lunga Uomo Personalizzata con Logo', 22.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSrVDiyq8u1s9nhpSNasUtB8aDQYA9lgr2fbyWYfVJfJ5TkodTvDWn7em3foXLEeq3BT8mAyfACF4erEi3aT1_V6b1L8EzVXQ&usqp=CAE'),
('https://www.google.it/url?url=https://wixsoo.com/prodotto/polo-salvataggio-rossa-manica-lunga-uomo-personalizzata-con-logo/%3Fattribute_opzioni%3D%252BBANDIERA%2B(%252B%25E2%2582%25AC1%252C50)&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQguUE', 'wixsoo.com', 'Polo salvataggio Rossa Manica lunga Uomo Personalizzata con Logo', 22.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSrVDiyq8u1s9nhpSNasUtB8aDQYA9lgr2fbyWYfVJfJ5TkodTvDWn7em3foXLEeq3BT8mAyfACF4erEi3aT1_V6b1L8EzVXQ&usqp=CAE'),
('https://www.google.it/url?url=https://wixsoo.com/prodotto/polo-salvataggio-rossa-manica-lunga-uomo-personalizzata-con-logo/%3Fattribute_opzioni%3D%252BBANDIERA%2B(%252B%25E2%2582%25AC1%252C50)&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQguUECPYH&usg=AOvVaw3fF0BRvMbLP2_v9FRTAP7Y', 'wixsoo.com', 'Polo salvataggio Rossa Manica lunga Uomo Personalizzata con Logo', 22.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSrVDiyq8u1s9nhpSNasUtB8aDQYA9lgr2fbyWYfVJfJ5TkodTvDWn7em3foXLEeq3BT8mAyfACF4erEi3aT1_V6b1L8EzVXQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.accesorionautico.com/giubbetto-salvataggio-bambini-3040-lalizas%3Flanguage%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECJ0I&usg=AOvVaw1ZlwfkNEJdHt5xejkTPt-5', 'Accesorionautico.com', 'Lalizas Giubbotto di salvataggio Chico 100N 30-40 kg', 31.57, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSUA5XbOw6lm3mWgPgNH4Tm1eJZVwRVh02jxpuNiCW_qLeKQ1bC3ittqBJjrCXfaDo5cpEFjy4&usqp=CAE'),
('https://www.google.it/url?url=https://www.agrieuro.com/aratri-per-trattore-c-1552.html%3Fhighlight%3D14119%26lgw_code%3D12143-14119&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECIsI&usg=AOvVaw3sZ3ICx2L9LSr-mURzf0pZ', 'AgriEuro.com', 'Aratro monovomere per trattore Geotech DP16 ad Ala corta', 407.12, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQjTng_CuchIFuGoPtBdWMOBMaXjPFDq892Pknh-b89WtUdqC3qnZTuU5_urS5QtMP1HnynNKB5IFgUP3QJ7fWDXI13MHBkivIvWAeQ01et2IPCHKkQXaZfVg&usqp=CAE'),
('https://www.google.it/url?url=https://www.armiantichesanmarino.eu/katana-di-kokushibou-tsugikuni-michikatsu-dall-anime-demon-slayer.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECJwI&usg=AOvVaw0W3zKein1hGTv8P8n7oFLV', 'AAnticheSanMarino', 'Katana di kokushibou tsugikuni michikatsu dall\'anime demon slayer', 48, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRgjiiTl1tRdHQPfpGXbapL7Tkv2Q5CthbFLubPuy7EtMMw9TkyJW5-4s53bi1Nj2q2w3kaxwo&usqp=CAE'),
('https://www.google.it/url?url=https://www.armiantichesanmarino.eu/katana-maledetta-di-ronoroa-one-piece.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECPsH&usg=AOvVaw32gUOyp50Wb79Qjyg0W9PN', 'AAnticheSanMarino', 'Katana maledetta di ronoroa one piece shusui-acqua d\'autunno', 33.9, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSR_sQ1AjS9hCtmXs1i2-b4x_CVyZVYCPfqOw6IHQu7FSv_Rety_mMHiuvMhdtO2GXNynfCxHGT&usqp=CAE'),
('https://www.google.it/url?url=https://www.chioscodellestreghe.com/index.php/katana-dell-ultimo-samurai.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECKcI&usg=AOvVaw1I_lA4_qLvUQlYIhJUjx1R', 'Chiosco Delle Streghe', 'Katana dell\'Ultimo Samurai', 30, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTN5n_mjPGoKdQ80LKBTC5nD1JUeEBxdtf4s4xBAPArDr72M01aPMZIt-LinLo&usqp=CAE'),
('https://www.google.it/url?url=https://www.coastwatersports.co.uk/it/giubbotto-di-salvataggio-sportivo-crewsaver-crewfit-165n-manuale-rosso-9710m-p-20251.html%3Fcurrency%3DEUR&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECKoI&usg=AOvVaw1t2gimJoSg-f2-QHQjfm6m', 'CoastWaterSports', '2022 Crewsaver Crewfit 165N Giubbotto di salvataggio Manuale Sport 971', 96.06, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSNNbB19FJSvRyrktgL389mgSw8j_e_JxfqBthnbG5IIhovgkLwBNtlHgdXRv9oLe0jQPEDUqs4cA&usqp=CAE'),
('https://www.google.it/url?url=https://www.compass24.it/sicurezza/attrezzatura-di-salvataggio/cinture-di-salvataggio/221073/boa-di-salvataggio%3FsPartner%3Dgoogle_products%26number%3D236411_11%26utm_source%3Dgoogle%26utm_medium%3Dcpc%26utm_campaign%3Dfreeshopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECLgI&usg=AOvVaw0ujlFAcTAyXo8O-LYLY_Ov', 'compass24.it', 'Boa di salvataggio', 159.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcT27Y0owG4DKvL_VlLOF2kt-VmdHQE3WHxudxla8zW4DjqlWsuHsJAdix2DuAQpEGJN6NEeidtJf1Yb68VYEyHxIvf6chhlZG5BTJxj2ECBZ4Rss4ZrRZds&usqp=CAE'),
('https://www.google.it/url?url=https://www.compass24.it/sicurezza/giubbotti-di-salvataggio/giubbotti-di-salvataggio-automatici/221415/giubbotto-di-salvataggio-spinlock-6d-automatic-vest%3FsPartner%3Dgoogle_products%26number%3D398250_11%26utm_source%3Dgoogl', 'compass24.it', 'Giubbotto di salvataggio Spinlock 6D Automatic Vest', 379.99, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcROPyDSz1s4Cj0ST-aKJErFgkyBGwHzw8N8rG5U8Z_ABSJN2EeUt-OyTBledceXB6AWwLeAW3AHVqqn9_msoJ6hrCiEmxLZLV7Kg66D8lkQn-VVeaeBltDwoA&usqp=CAE'),
('https://www.google.it/url?url=https://www.compass24.it/sicurezza/giubbotti-di-salvataggio/giubbotti-di-salvataggio-solidi/220435/set-di-giubbotti-di-salvataggio-plastimo%3FsPartner%3Dgoogle_products%26number%3D214651_11%26utm_source%3Dgoogle%26utm_medium%', 'compass24.it', 'Giubbotto di salvataggio Storm 100N Plastimo Storm 100N Pacchetto di 4', 109.99, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQW8pcdFzUEv_2RHIgEZBO8y77BJf2FOXOGbDuaCaEiFi8rKhzwrv_ioeGZjTUBUYzqCekjhs9BekhkvwTh8VO8tmTau52n8wHDI5J_TztYRtUfxu42fNpS3Q&usqp=CAE'),
('https://www.google.it/url?url=https://www.corvezzogiuseppe.it/product/potatore-elettronico-volpi-kv600/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QguUECKgJ&usg=AOvVaw2HamQerMII8J-VXd6dEiqu', 'Corvezzo Giuseppe', 'Forbice Forbici da potatura a Batteria elettriche Volpi Professionale KV600', 739, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTmz1yHENvAgGVAl8bsjK9BJVCcZE7VrnyImltg3YxWzAYwCea5gV0dKBlzYYaWof6YU6R4Et4J5oE8BEjUFhYNMlKtHMlRr2H_tINd6mVgic4846jEghEC&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-bambino-lj100n-easy-arancione-grigio/_/R-p-311034%3Fmc%3D8569209%26utm_medium%3Dorganic-shopping%26srsltid%3DAWLEVJxOMiviuPKMX2teAlEg0rcwkIqBALTF54jMv3-PxE5Kpqs3CG9jALE&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECLcI&usg=AOvVaw3BSjLOTkJ72m0EmtefPXbj', 'Decathlon', 'Tribord. Giubbotto salvataggio Bambino Lj100n Easy Arancione-Grigio', 24.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcSWLn6peNQz26cx8TwGmozVA9X05bKR0CDxFlvlOEUq26YEj3KOJ2wI8GQC-uM0E-jV76b-ozE&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-bambino-lj100n-easy-arancione-grigio/_/R-p-311034%3Fmc%3D8569209%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi0u-PLwfP3AhXmqXIEHbVkAXIQ_uQECI8I&usg=AOvVaw0QANGL_EUl4Wr5zJxjAc0A', 'Decathlon', 'Tribord. Giubbotto salvataggio Bambino Lj100n Easy Arancione-Grigio', 24.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRecHhuG2HD5wGeMxmLQnaFdQEpbcZMBwF3zGICpafJsnjZ0U-aOd5jSYegRjsuvdlHzPzWXVhQIRmiUETYn2mwE9Jpvf3xHvh5niULOs8Ar1ClEtQd2i1L&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-bambino-lj100n-easy-arancione-grigio/_/R-p-311034%3Fmc%3D8569209%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQ_uQECK4H&usg=AOvVaw1NaSHO39ztZ7M79K6V_Hb3', 'Decathlon', 'Tribord. Giubbotto salvataggio Bambino Lj100n Easy Arancione-Grigio', 24.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRecHhuG2HD5wGeMxmLQnaFdQEpbcZMBwF3zGICpafJsnjZ0U-aOd5jSYegRjsuvdlHzPzWXVhQIRmiUETYn2mwE9Jpvf3xHvh5niULOs8Ar1ClEtQd2i1L&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi0u-PLwfP3AhXmqXIEHbVkAXIQ_uQECPIH&usg=AOvVaw0DRKaibsy-Tw19895bpBDq', 'Decathlon', 'Plastimo. Giubbotto salvataggio Storm 100N', 13.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS1UpeplwRAkgi5NnNK4mhE2rvmZ92v1hcGaYQHIYRodA39KQxhdQ-Lauzf6nUSXBtRC1TMuhBYfZYfP4Cot2SKlk2G4bjGCSBsF67Gc4_-8PQgF6pCjHFT&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiH0_-_h-73AhWRq3IEHeIWAcQQ_uQECM4H&usg=AOvVaw2JdZHIvrTTBaghAPdpSCWi', 'Decathlon', 'Plastimo. Giubbotto salvataggio Storm 100N', 13.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS1UpeplwRAkgi5NnNK4mhE2rvmZ92v1hcGaYQHIYRodA39KQxhdQ-Lauzf6nUSXBtRC1TMuhBYfZYfP4Cot2SKlk2G4bjGCSBsF67Gc4_-8PQgF6pCjHFT&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQ_uQECNgH&usg=AOvVaw1852ptlTDsnuJMEcZeIkZx', 'Decathlon', 'Plastimo. Giubbotto salvataggio Storm 100N', 13.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS1UpeplwRAkgi5NnNK4mhE2rvmZ92v1hcGaYQHIYRodA39KQxhdQ-Lauzf6nUSXBtRC1TMuhBYfZYfP4Cot2SKlk2G4bjGCSBsF67Gc4_-8PQgF6pCjHFT&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQ_uQECNIH&usg=AOvVaw1ECeOUoXn5uw-Sl6lp9weX', 'Decathlon', 'Plastimo. Giubbotto salvataggio Storm 100N', 13.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS1UpeplwRAkgi5NnNK4mhE2rvmZ92v1hcGaYQHIYRodA39KQxhdQ-Lauzf6nUSXBtRC1TMuhBYfZYfP4Cot2SKlk2G4bjGCSBsF67Gc4_-8PQgF6pCjHFT&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQ_uQECNAH&usg=AOvVaw0ZFCG1xLU1TstVuDX3f8DC', 'Decathlon', 'Plastimo. Giubbotto salvataggio Storm 100N', 13.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS1UpeplwRAkgi5NnNK4mhE2rvmZ92v1hcGaYQHIYRodA39KQxhdQ-Lauzf6nUSXBtRC1TMuhBYfZYfP4Cot2SKlk2G4bjGCSBsF67Gc4_-8PQgF6pCjHFT&usqp=CAE'),
('https://www.google.it/url?url=https://www.dhm-online.com/board/5019-arduino-uno-rev3-smd-8058333490137.html%3Futm_campaign%3Dpro%26utm_source%3Dgmc%26utm_medium%3Dgs&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECNYI&usg=AOvVaw1x6CMU5lKsJx', 'Compass DHM projects', 'Arduino Uno REV3 SMD', 24.34, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTMXxMQW8i2w5YpJalnnFoUfSBUN7H5Phq_5CWkA1xqotuIQUID9EeO4xsMbEn0m-ddy6hwd66X16aAHxB0pDqWuKSLn_PSx8gl1p7JyBYdMwAC34zVavso&usqp=CAE'),
('https://www.google.it/url?url=https://www.distrelec.it/it/arduino-nano-every-arduino-abx00028/p/30150884&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECMkI&usg=AOvVaw1_xxDVKNYQGNAJG-qz6SkY', 'Distrelec Italia', 'Arduino Nano Every', 12.74, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTRfxJMk29I5vAU3sO1ekTYGyLoj9vUPxGeY5NWodya7xDk4sM65mSI9YSEj-8Hks8pdA3OHIJHtUR1JEtAlkQJvCiHUtZZQJO5yuatkuATfzVASRjMEBKMzQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.dna-marine.it/it/giubbotto-di-salvataggio-sv-100-100n-fnip61091&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECKEI&usg=AOvVaw1dhY-B4Bqgk_fj2n0c_g_4', 'dna-marine.it', 'Plastimo Giubbotto di salvataggio Typhon 100N 30-50 kg', 29.27, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTKCJtmmPgJ9-HAR1vTVNXnGHishxR7rP_wPDxeBNTWFxpRU4tnxBmLk4xY54n44KGpfp-aTOSOIgkbXmLfGFjbrYGcV9A-lj8MVbBh-45GGjFfIW_sLAUU&usqp=CAE'),
('https://www.google.it/url?url=https://www.dodax.it/it-it/dp/MP3V5UAE3PQ%3FofferId%3Ded64adcce82437e895e78b866fcc3ca5%26srsltid%3DAWLEVJwI7feGTnvtNtFC2n1S_Ji1jynq0OSswTqfWaAoMcnqMf8v8_HAJ88&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjatMSsrvD3AhXGkIkEHVxGDP0QguUECPUH', 'Dodax.it', 'Arduino - Starter Kit', 124.97, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTDI-knt_aruoHGlDr519RbeC--KtYEIowbe5U0FpNraeNZo00tKyZKjXK7uQ8o9RDjRU9vGVeHIewisgQ553KOz4iLGkZmqUUVuqntFpo&usqp=CAE'),
('https://www.google.it/url?url=https://www.dodax.it/it-it/dp/MP3V5UAE3PQ%3FofferId%3Ded64adcce82437e895e78b866fcc3ca5%26srsltid%3DAWLEVJxytJY2wx_5jFuroDhBxv-O5v-HYqidMeXY9Riq2TwRv_GQUKtm62g&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECLwI', 'Dodax.it', 'Arduino - Starter Kit', 125.15, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTDI-knt_aruoHGlDr519RbeC--KtYEIowbe5U0FpNraeNZo00tKyZKjXK7uQ8o9RDjRU9vGVeHIewisgQ553KOz4iLGkZmqUUVuqntFpo&usqp=CAE'),
('https://www.google.it/url?url=https://www.ebay.it/itm/202675088074%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECMkJ&usg=AOvVaw2MnMvQIMsFS6ddnAMuphDU', 'eBay - outdoorfan_de', 'Tattico Tomahawk TF2 Nero con Kopftasche Ascia salvataggio Esercito Campeggio', 23.57, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcT_Z-YpyW6H2qSommDBlDCr1HtpY9dhsRd3RQICycX6u7zp6NaILGB2Cs48z6YOfbZI03AGi2XfZah8iCXjrkZT6XV1pHufUPzkR1772uB3UkN1tH2zbujk&usqp=CAE'),
('https://www.google.it/url?url=https://www.ebay.it/itm/253370699449%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjp6ZWilu73AhUYkGoFHVQmCqcQguUECMoK&usg=AOvVaw1ozIcgRYLsoQ7w4drNf2cP', 'eBay - oltrevela', 'Giubbotto di salvataggio Spinlock Deckvest Lite 170N - Nero', 231.99, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQBhwdIum7fx9jHb2urCiEI6YXXq4pi-YfxltxKme2bnJ0ex1tajYcJRqtTLLiwErRx4TXwainKV3EBTO9zH-i4FQfZ-0cfmPYTArZaRGKXAVXDHYmZKaXbsA&usqp=CAE'),
('https://www.google.it/url?url=https://www.ebay.it/itm/302980639583%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECI8I&usg=AOvVaw1m8ALvBVHyBSrv9l-hDVxH', 'eBay - inoxnautica', 'Lalizas Bambino Giubbotto di salvataggio 100N 10-20 kg', 11.99, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTM6PYac0ihdDd-mQWURuKyqVyMMjrBqkttypZaxpE7LjpCoQtIOoDVWOn0obMey2z5MIq55MLt&usqp=CAE'),
('https://www.google.it/url?url=https://www.edilizia-valenti.com/prodotto/outlet-computer-outsider-pc-fisso-completo-intel-i5-ram-8gb-ssd-240-gb-monitor-24-pollici-tastiera-e-mouse-usb-casse-audio/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECK4I&usg=AOvVaw16YYEJtBDpToqlT574YPmR', 'Edilizia-Valenti', 'Outlet computer outsider Pc fisso completo intel i5 ram 8gb - ssd 240 gb monitor ...', 49.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTov6WmGoFBJ9S9PrNV6MsB9kI2XbizibkH0JTbXJYM8wEcbtS_caQ6GSJMfdQNnGR4Iz0b234Bq2TSOw_YcMDa-xuVAvDYYx8XZCg-ty4&usqp=CAE'),
('https://www.google.it/url?url=https://www.eprice.it/pc-assemblati-NONSOLOINFORMATICA/d-59834690%3Fshopid%3D5742&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECNwI&usg=AOvVaw3C1k4eK0srjd4a6Evn0f9S', 'ePRICE.it - ePRICE - Marketplace', 'Computer Completo 16GB RAM SSD 240GB Monitor Mouse Tastiera Altoparlanti inclusi', 529, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcSD06kNmb4F_ZTWpyqpHcO_wT8nq0ybP9QdXQ1QjTYi6SYIC6ohYbADRg94QL7lFs7mgyhDzwrFRd_8M_fJlMElM0BtEw6j9nnTi-2EHY7kftRpSp3uzs4J6g&usqp=CAE'),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1026026646/katana-di-nuova-classe-master%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECIYI&usg=AOvVaw3qltazb9c5eh4LBJClQj4k', 'Etsy - StormwindCity', 'Katana di nuova classe master completamente fatta a mano, katana giapponese ...', 25387.4, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcR2srGk1kfbzi7_4UWtfH155E3MhRNfYYOAwxHxMYb_o7241Jb4Kg6Dfw77jm-gYRbUbkFQsh0&usqp=CAE'),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1100658433/giorgio%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQgOUECN4J&usg=AOvVaw3ufDfu8oza_fqeVGgBHw6r', 'Etsy - Seller', 'Giorgio', 15.04, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRRij8OJ261_GHefg0gq-n1ackpgqyB5c6ROOb8BaOHOL5Vr2dcRFwPQXxcDrTP_Y9qh8mBq0MFqcezKJcnWQ9Oh-zruwZKz5nEOSEWMjegYmJ_fXvq22xa&usqp=CAE'),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/400661661/convoglio-559-salvataggio-in-mare-olio%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECPwI&usg=AOvVaw1NuVK-VCBldfBsVqkWFZd0', 'Etsy - Seller', 'Convoglio 559 - salvataggio in mare olio originale', 1541.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSerUNUGvgDEmpOstvEYsNlBeoYOvCslxehQSWYuztnRXNr7WC0UNooOuMH_kYIvA_E8ZazV79B1yuVtQloImNFFzqnp6PCQODAnq7I3Z8&usqp=CAE'),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/877319541/nichnyy-sad-giardino-notturno%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQgOUECKkH&usg=AOvVaw1RCRO3IOiZu3anr9CapK5R', 'Etsy - Seller', 'Nichnyy Sad / Giardino notturno', 70.87, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTa8SPWHnkW5mFBcgZctRDmIEnJkXfqyeTa3yYiN2H84wHdPt61T6yzxFjd56kkjfvq62OWO8n9BeHtkRUXDn6fYIysahmuGkmEkvDWe-8X&usqp=CAE'),
('https://www.google.it/url?url=https://www.eurobrico.com/it/forb-potatura-batt-16v-con-2-batt-lithio-C000393831&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QguUECJAJ&usg=AOvVaw0FkNlRB90xeT-y-LQnypYk', 'Eurobrico.com', 'Armour - Forbice da potatura Elettrica a Batteria 16V con 2 Batterie al LITIO incluse', 99.5, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTny5NXljZAHvalGu97ZjdLdrS4NBT9raL6OHHW-1DLuCcG1PlCbXiQcJJW45V9DtGoNsHTqksBoFKmwfNYAff7j4RVHhcSeRlXt0FCpalWgJZWiqIa7ytfLg&usqp=CAE'),
('https://www.google.it/url?url=https://www.fruugo.it/bambini-e-adulti-giubbotto-di-salvataggio-nuoto-galleggiante-aid-giubbotti-di-salvataggio/p-72578130-145872575%3Flanguage%3Dit%26ac%3Dcroud%26utm_source%3Dorganic_shopping%26utm_medium%3Dorganic&rct=j&q=', 'fruugo.it', 'Wangst bambini e Adulti Giubbotto di salvataggio Nuoto Galleggiante Aid Giubbotti ...', 48.95, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQv3HhMsyn_ERyV_-4daWKTYXyh3Jab1KjmE3Da1nr_qZ7-xOMAtfoZnan5BtbRNSnK49pF6EnS5m5OCGTgt_ipk37b9pmZBO6h7CmiuB2W_VDQ20c9UAXyTg&usqp=CAE'),
('https://www.google.it/url?url=https://www.gamaronline.com/4189-giubbotto-di-salvataggio-per-bambini-auto-manuale.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjp6ZWilu73AhUYkGoFHVQmCqcQgOUECPcK&usg=AOvVaw1YVtH-LO4Ynl9uJlqhCtM2', 'GaMar', 'GIUBBOTTO DI SALVATAGGIO PER BAMBINI AUTO/MANUALE', 101.92, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcR7bvnNJPSMewsrL2iIEXDy6v_lI3V01iwWSqbE0QT5c7CVMNLdtJCB1gruvr4JhwYNCH4Wel2m_TQaJdqQ5yrkOhcf5mdTBa2kuLk9SMdWlpHckvmwgRJjig&usqp=CAE'),
('https://www.google.it/url?url=https://www.gardenbedettishop.com/attrezzi-a-batteria/5178-forbice-da-potatura-a-batteria-stocker-vulcano-e-30-tp-8016604003110.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QgOUECIIJ&usg=AOvVaw0aZyD2heNWJwDpF', 'GardenBedettiShop', 'Forbice da potatura a batteria Stocker vulcano E-30 TP', 88.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTesapLnBtqpBBHUklUwOhUoq3tNhfJJNYhDwatC3RW_B2MHRAEpmkcQIb3kXNjA71raY_P3Bg8eTdP5fkPni9Xb5VMeLyO71pb9Uzn__8xk_h550Q889ajZg&usqp=CAE'),
('https://www.google.it/url?url=https://www.hinelson.com/it/16315-39166-plastimo-cruise-entro-12-miglia-revisione-zatterera-salvataggio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECPEI&usg=AOvVaw06SGXv41z-YYOPnS6K', 'HiNelson', 'Plastimo Cruise entro 12 miglia - Revisione zattera salvataggio 12', 646.6, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSfUx9xpeEJnTr6Sjs03cxAUkrBa_ndja6RBhw8xC6KAIdHcvKUjvmi6EkVoQ6rI8QkAwBEbE8yL1aELumWJ35_NBsVmo1jGtswyhlMsjJLDJajWFvaZkWooQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.hinelson.com/it/16317-39178-zodiac-open-sea-iso-9650-senza-limiti-revisione-zatterera-salvataggio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECOEJ&usg=AOvVaw15oSyZ5ljXiw', 'HiNelson', 'Zodiac Open Sea ISO 9650 senza limiti - Revisione zattera salvataggio 8', 756.4, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTp2b-t8WfzlcnadIcI0yZ3noLdiCoXEBdXpYcMnhVjwyA-mzAv-_ofC3ckxrUkS2FZT5MaJy3yrb0JJmEtc-R8n2f4djp3oOMjY6PuT403HU4sgLWL9Ts9&usqp=CAE'),
('https://www.google.it/url?url=https://www.hinelson.com/it/17510-41403-giubbotto-di-salvataggio-150n-skipper-baby-autogonfiabile-automatico-veleria-san-giorgio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECMMI&usg=AOvVaw2yeShgj5uFSFyYMvGGy6Rs', 'HiNelson', 'Giubbotto di salvataggio 150N Skipper Baby autogonfiabile automatico - Veleria ...', 99.75, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRMhpMHkQ6Cc1iQQRjmv6YwkhIszz5ec1dwY7xgjdLMYDqdNDbL5gLuQ64FguXuCP6HSpSRwVcCX_-o1U5wFq-_Y23L1iMg2Zh6W0Qp7NuccS6PbQTITlfF&usqp=CAE'),
('https://www.google.it/url?url=https://www.ibs.it/giorgio-pira-utopia-salvera-storia-libro-maurizio-certini/e/9788862447171%3Flgw_code%3D1122-B9788862447171&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECI8K&usg=AOvVaw01kck1S3fFIr51Bq9RjcYk', 'IBS.it', 'Maurizio Certini Giorgio La Pira. L\'utopia salverà La Storia', 9.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTWX6hIFL-qFjWTOI2HhxWJCpB-u8-1lkDnXkvQM-fwxNK22WNMpbnexHn7Y3S1_ftzTk2kWWxPj5lMXHJDRhq_nUqLetr0nHS5LYCwqDJ1O-fAFy03senjjA&usqp=CAE'),
('https://www.google.it/url?url=https://www.ibs.it/pc-fisso-computer-i5-quad-informatica-nonsoloinformatica/e/8052679510115%3Flgw_code%3D1122-W8052679510115&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECLkI&usg=AOvVaw1x8p2S71urWNSiVfKjADH6', 'IBS.it', 'PC fisso Computer i5 Quad Core Windows 10 Pro 8GB RAM, SSD 240GB, HD 500GB, Wifi', 319.99, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRI7BqYbuHau0Uv2YJtYSnYnYnOMdFV2yjZl-xTpVhZCLBAVLNQUndP17wsjreiOy8o4OM-GlENncV8WLHn79OrUromCUqQkRsiXgNZBTPZ9X8a_SfN6htcow&usqp=CAE'),
('https://www.google.it/url?url=https://www.ibs.it/sad-party-cd-sin-fang/e/0880918817026%3Flgw_code%3D1122-M0880918817026&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQguUECJ0H&usg=AOvVaw37Y6q1qSr8DmC9PpCNpIsA', 'IBS.it', 'Sad Party - Sin Fang', 20.5, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcR-nkM1OPJ7xmhpw-N8R3Bpbh9SCGT6tt6zuNPns90EGbmpbPRPnKrGc-UZEhyjYt-WKzeBBesJWTTwlv4D-r6VfRMhVIvM_Viul9o9deJ5dn4X0QvsKhC_Vw&usqp=CAE'),
('https://www.google.it/url?url=https://www.ibs.it/storie-dei-furetti-salvataggio-in-libro-rizzoli/e/9788817108119%3Flgw_code%3D1122-W9788817108119&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECNoI&usg=AOvVaw3Y9-YJ_be72h_ighpFcs0g', 'IBS.it', 'Rizzoli Le Storie dei furetti. salvataggio in Mare - Richard Bach', 7.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRqihfD65iToZrXdc9zAU8-J_IUUdajopOGPHgMlO5XJwfEb8tuc1RSlypXvzZrQ7PTKzkRM03bOP95jewO7R71ZxHwOONbUf4uu01lj9zYGHQJ5Kc-xKehnQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.justathlete.it/beco-sealife-swim-jacket-blue-pink-m%3Futm_source%3Dgoogle%26utm_medium%3Dsurfaces%26utm_campaign%3Dshopping%2520feed%26utm_content%3Dfree%2520google%2520shopping%2520clicks&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECMYI&usg=AOvVaw0pYAmLXJepZI2Pi7EhRAAe', 'Justathlete.it', 'Beco Beermann Sealife Giubbotto di salvataggio Blu/Fucsia - 77502866', 35.95, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRAYt4y_0WopuFdp-5Jwlu_R4uNoYTQqGN_Nz7gYHFNp9Abv1CIy0s5PWmCzKvJ0-K4CoYiwx1V&usqp=CAE'),
('https://www.google.it/url?url=https://www.lafeltrinelli.it/falling-in-love-with-sadness-cd-emika/e/0666017320823%3Flgw_code%3D50948-M0666017320823&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQguUECLQH&usg=AOvVaw1MxLidJHlQSawkVGnk4SLt', 'Feltrinelli', 'Falling in Love with Sadness - Emika', 17.08, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcR6ZXf0tjm-RtT6-asEZHSuUhwdw0GDYtk1P8zin68ItxmFFN_I2GGX9_dsArM5mAN3C9h4cxnDCLOLaQ743khD1GAd1EmeRsbldTgNyYNFoiJHPaxnqZO6&usqp=CAE'),
('https://www.google.it/url?url=https://www.lafeltrinelli.it/palazzo-san-giorgio-autorita-portuale-libro-danilo-cabona/e/9788870589290%3Flgw_code%3D50948-B9788870589290&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECJsK&usg=AOvVaw3SYl5qQ2q3Q62cdvDdk09a', 'Feltrinelli', 'Danilo Cabona Palazzo San Giorgio. autorità portuale', 4.75, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRPObVYh9O-wGhggUF3Qz1lXm2C-rzywdDLBKAZc8ON1YZPxk8a9JQWfXLL_NvhdGZiG13tYPWrrW8bv37_ek65rMEtE_vF0w7psxbJs0x8&usqp=CAE'),
('https://www.google.it/url?url=https://www.legami.com/it_it/VSHOW0008.html%3Fsrsltid%3DAWLEVJzrgX5pMXsac3D4zLyQQy8dYRyF_aKUcXU3LZcbFE6KDyjyZ_MfvOA&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjry-6Zuvb3AhURnHIEHaLBCcwQguUECKAP&usg=AOvVaw0vx8ou5EDzvslCPXeTRobt', 'Legami', 'Legami Show0008 - Singing in The Shower - Vivavoce e Speaker Bluetooth resisten', 19.95, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcT32-3gb2dYRfa9jxJqXkm0rxPWh9PJtVPawPEhOYMpQEP5EJdT494bjvlpJPYVhtQqAPuSx8YLlR8qjLBotxFxoblHBb6yCN47oUniDO7ObkbGux1wjXnZSA&usqp=CAE'),
('https://www.google.it/url?url=https://www.libraccio.it/libro/9788867407996/giorgio-coppola/default.html%3Ftipo%3Dnuovo%26lgw_code%3D1115-I9788867407996&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECLMK&usg=AOvVaw0Cmk53B4Aiepe3MduSSwWX', 'Libraccio.it', 'Giorgio Coppola Default', 10, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcRPjQ6sh8zG5_GkR7cKvKlgZe1EaAm_D-zr7hlTrc88FO1RabmjNC-UlDEQveyWVpO3fLtqzfx0VkuDNk0OscOS7otYSZ51u6I5ztFz2c9PgLVmqTNU5dI_&usqp=CAE'),
('https://www.google.it/url?url=https://www.libreriauniversitaria.it/giorgio-chiesura-fabrizio-serra-editore/libro/9788862278324%3Futm_source%3Dgoogle-shopping%26utm_medium%3Dcpc%26utm_term%3D9788862278324%26utm_content%3DLibri%2520Italiani%26utm_campaign%3Dgoogle-shopping-lib&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECKcK&usg=AOvVaw2WMICL5RBYbQ227OUjvN1a', 'LibreriaUniversitaria.it', 'Fabrizio Serra EDITORE Giorgio Chiesura', 26.6, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSLlziWtTQf24drR3rxDoRokaZ2TRCHrG-fTz0pBhCqw7ZnJjlq4Z5qu6v577awCY4TYAiP0HE5ncVhKuseb_Gyp-7Pcm3DIIe6zJHsr_JvoNikbzF5Bu-v&usqp=CAE'),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiH0_-_h-73AhWRq3IEHeIWAcQQguUECNwH&usg=AOvVaw2sbAkAPCpxhO4Uv1ibxTFJ', 'MagellanoStore.it', 'Giubbotto salvataggio Antille 100 N - XXS', 29.34, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQQ-JEPmiP6c7k40U23hrJ_dcIGGh56v1-MQ6itjPlJRnk5RtL4iw8BreC33oGB6Fs_sZo5zW2og9x8NcrUvMG3wL0PGm8XrQgBcsG0L2SxSqZ9yefpbVjP&usqp=CAE'),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECKAH&usg=AOvVaw2poYGFk0q9MKVbGFloPRcF', 'MagellanoStore.it', 'Giubbotto salvataggio Antille 100 N - XXS', 29.34, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQQ-JEPmiP6c7k40U23hrJ_dcIGGh56v1-MQ6itjPlJRnk5RtL4iw8BreC33oGB6Fs_sZo5zW2og9x8NcrUvMG3wL0PGm8XrQgBcsG0L2SxSqZ9yefpbVjP&usqp=CAE');
INSERT INTO `prodotti` (`url`, `Venditore`, `titolo`, `prezzo`, `UrlImg`) VALUES
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQguUECOsH&usg=AOvVaw3On3wJKbwizD820DVSY_Mc', 'MagellanoStore.it', 'Giubbotto salvataggio Antille 100 N - XXS', 29.34, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQQ-JEPmiP6c7k40U23hrJ_dcIGGh56v1-MQ6itjPlJRnk5RtL4iw8BreC33oGB6Fs_sZo5zW2og9x8NcrUvMG3wL0PGm8XrQgBcsG0L2SxSqZ9yefpbVjP&usqp=CAE'),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECPQH&usg=AOvVaw2l3bqM3CmBH4icSEnrdRBh', 'MagellanoStore.it', 'Giubbotto salvataggio Antille 100 N - XXS', 29.34, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQQ-JEPmiP6c7k40U23hrJ_dcIGGh56v1-MQ6itjPlJRnk5RtL4iw8BreC33oGB6Fs_sZo5zW2og9x8NcrUvMG3wL0PGm8XrQgBcsG0L2SxSqZ9yefpbVjP&usqp=CAE'),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQguUECOkH&usg=AOvVaw1sWLBpPJedTr20D03C0iaU', 'MagellanoStore.it', 'Giubbotto salvataggio Antille 100 N - XXS', 29.34, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQQ-JEPmiP6c7k40U23hrJ_dcIGGh56v1-MQ6itjPlJRnk5RtL4iw8BreC33oGB6Fs_sZo5zW2og9x8NcrUvMG3wL0PGm8XrQgBcsG0L2SxSqZ9yefpbVjP&usqp=CAE'),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-nadir-100-n-tg-adulto-P7497.htm%3Fmid%3D7497&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECOYI&usg=AOvVaw3glD_-Pn4koEaAtLiF-GOo', 'MagellanoStore.it', 'Giubbotto salvataggio Nadir 100 N TG. Adulto', 13.18, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcR86m6_6jFOtdIMvCg4W6j1jblSVIiuKxRBtKugqtvZpE_rMLkphVyFoszTAbiX0pPehWgM32xlQkzwnk6rqNnYqEdAk3Lyjo6JmrKHhaHRqVmCOaHZ-VLibg&usqp=CAE'),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-nadir-100-n-tg-adulto-P7497.htm%3Fmid%3D7497&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQguUECL4I&usg=AOvVaw02O-g1_DK8Fj5gizmYcfuR', 'MagellanoStore.it', 'Giubbotto salvataggio Nadir 100 N TG. Adulto', 13.18, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcR86m6_6jFOtdIMvCg4W6j1jblSVIiuKxRBtKugqtvZpE_rMLkphVyFoszTAbiX0pPehWgM32xlQkzwnk6rqNnYqEdAk3Lyjo6JmrKHhaHRqVmCOaHZ-VLibg&usqp=CAE'),
('https://www.google.it/url?url=https://www.mam-srl.it/trattore-kubota-b-1220-d-p-2369.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECOoH&usg=AOvVaw2GgIZGsN7A1QOBtry1OVuX', 'MAM Srl', 'Trattore Kubota B 1220 D', 8927.96, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcT3-1R1-dloCU0xC-8Zxfiw0okqLXArmy8LvKwkjABhI82ekHxPEsnbPqfFDwspaBfXBsCtesNBWPcY4b5txYruVHfxB3Jo&usqp=CAE'),
('https://www.google.it/url?url=https://www.mam-srl.it/trattore-kubota-b-1620-d-p-2370.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECIAI&usg=AOvVaw1v3_EeUg5nRRk0NcRIu47H', 'MAM Srl', 'Trattore Kubota B 1620 D', 11962.1, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQ4szGy7YFZDy7SgIYKR5JRvsd_OoFP9mjWvKwHqLQSUMuzQjUWWCcIQj3bjvJFD9zZ1akwF8x2w70ERzWSh6NFUR43sHNC&usqp=CAE'),
('https://www.google.it/url?url=https://www.mediaworld.it/product/p-989877/jbl-flip-essential&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjry-6Zuvb3AhURnHIEHaLBCcwQguUECLAP&usg=AOvVaw1rbQDigNFCXbMPmaT2JNCN', 'mediaworld.it', 'JBL Flip 3 - Stealth Edition - altoparlante - portatile - senza fili - Bluetooth ...', 58.99, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTBsF9iJWmsuS-qLFWx4si8nIXK1p7P0aRQKSFyDweawiXRyKYe2RASuIRGMiqVRuZreQqZ549qcSpxhm6UuKujn3GDWNzjJB9nhzGgGfyb-Y5-s9S6lGoqmg&usqp=CAE'),
('https://www.google.it/url?url=https://www.mouser.it/ProductDetail/Arduino/AKX00002%3Fqs%3DfAHHVMwC%25252BbjuZX12Z140WQ%253D%253D%26mgh%3D1%26vip%3D1&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECPwI&usg=AOvVaw2zJEg0fWNfflN9pCfVmtn8', 'Mouser Italia', 'Arduino CTC 101 Program - Full', 2173.13, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQA8wczcLF4uYig7kX5yDy83gr0X9Yi9zNE6TujZmixUTYLstU1-z_WmUKREQat1ZbuOOy8vr88BUMkMaceIvV9hCdbV_pLeYpb9HeJ0dP_hOQg_JbtPlNQNTc&usqp=CAE'),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-chico-lifejacket-15-30kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi0u-PLwfP3AhXmqXIEHbVkAXIQguUECJ8I&usg=AOvVaw3NS1Sxh09_hYXtL8-UhPSf', 'Muziker IT', 'Lalizas Giubbotto di salvataggio Chico 100N 15-30 kg', 29.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRG7BaCrsz0VuKDmRnGkskJxGcYLXFVtPOcEqxJ1aX0USx3NKujrOPvUoRHq80iqYGWJjKr6RviKJxkASjtmYRD5FqAhFrlYcwXoTPoBpXvSuUs6VpftUhV&usqp=CAE'),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-chico-lifejacket-15-30kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiH0_-_h-73AhWRq3IEHeIWAcQQguUECIsI&usg=AOvVaw12XNTgbzEIeJJvzSE0doaS', 'Muziker IT', 'Lalizas Giubbotto di salvataggio Chico 100N 15-30 kg', 29.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRG7BaCrsz0VuKDmRnGkskJxGcYLXFVtPOcEqxJ1aX0USx3NKujrOPvUoRHq80iqYGWJjKr6RviKJxkASjtmYRD5FqAhFrlYcwXoTPoBpXvSuUs6VpftUhV&usqp=CAE'),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-chico-lifejacket-15-30kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQguUECIMI&usg=AOvVaw2jZrlPW6EoyW0ql5bopYSH', 'Muziker IT', 'Lalizas Giubbotto di salvataggio Chico 100N 15-30 kg', 29.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRG7BaCrsz0VuKDmRnGkskJxGcYLXFVtPOcEqxJ1aX0USx3NKujrOPvUoRHq80iqYGWJjKr6RviKJxkASjtmYRD5FqAhFrlYcwXoTPoBpXvSuUs6VpftUhV&usqp=CAE'),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-chico-lifejacket-15-30kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECKgI&usg=AOvVaw0qBmqK5SOEJ5RLfa9yyAxz', 'Muziker IT', 'Lalizas Giubbotto di salvataggio Chico 100N 15-30 kg', 29.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRG7BaCrsz0VuKDmRnGkskJxGcYLXFVtPOcEqxJ1aX0USx3NKujrOPvUoRHq80iqYGWJjKr6RviKJxkASjtmYRD5FqAhFrlYcwXoTPoBpXvSuUs6VpftUhV&usqp=CAE'),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-chico-lifejacket-15-30kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQguUECI8I&usg=AOvVaw0NBwJHrBtjZo-TipNSvh_0', 'Muziker IT', 'Lalizas Giubbotto di salvataggio Chico 100N 15-30 kg', 29.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRG7BaCrsz0VuKDmRnGkskJxGcYLXFVtPOcEqxJ1aX0USx3NKujrOPvUoRHq80iqYGWJjKr6RviKJxkASjtmYRD5FqAhFrlYcwXoTPoBpXvSuUs6VpftUhV&usqp=CAE'),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-life-jacket100n-iso-12402-4-50-70kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECMkH&usg=AOvVaw2wch_Pv47zhYvkRzT8Zwdj', 'Muziker IT', 'Lalizas Giubbotto di salvataggio 100N 50-70 kg', 34.9, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSUgOESAD4sCp5R8Mr-IfVL8hJGHpb1P3X2BIdxZk-zL3NlYCN-xhr2NNiKGscR1a3wUlFI1pcLMk_jKM09u_FGbqVDsb0_Hi17zReCJ3SR-OSspI3tGEJaUQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.nonsoloinformatica.com/computer-pc-fisso-i7-quad-core-windows-10-pro-16gb-ram-ssd-240gb-hd-1tb-wifi/id/252642%26r%3Dgoogle-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECJcI&usg=AOvVaw3TVEblJP60lyHtEeM9Orqs', 'Nonsoloinformatica', 'Computer PC fisso i7 Quad Core Windows 10 Pro 16GB RAM, SSD 240GB, HD 1TB, Wifi', 399.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRIbcJwh0tCH52K2zcnWMLHuzI2hYol7lWNI0wESlgApkbVUbrcb1RgDBcofuHjdVoUuWnJ7_zMxYJmcnOKuD0j2rTCMutVZto1yykcs3DaHS4C5KkrdeAqfA&usqp=CAE'),
('https://www.google.it/url?url=https://www.opendeel.com/product/tempo-di-saldi-altoparlante-bluetooth-impermeabile-mini-cassa-stereo-con-vivavoce-e-microfono-paXzfnwBWuR_74FsrJmc.html%3Ff%3Dgm&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjry-6Zuvb3AhURnHIEHaLBCcwQguUECJIP&usg=AOvVaw1um1S5c5Ut2n3Jldb4th4M', 'Opendeel', 'Tempo di Saldi Altoparlante Bluetooth Impermeabile Mini Cassa Stereo con Vivavoce ...', 12.1, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRUAV599eZkN_eXJFcmiEQHS0ozo9JAp4RcWFaXf1MdVkwwbQZOZs5FRXwVNagHGKqtD_Mju0DOUnRdo7v5vhb-SRCx4N4R_kuErMEu7OxYnUpkvAREhUCHBw&usqp=CAE'),
('https://www.google.it/url?url=https://www.prezziaffare.com/Forbici-potatura-elettriche-AMC-2-batterie-caricatore-valigetta-e-accessori/id/41&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QgOUECMsJ&usg=AOvVaw1pA7MzCvzyyli6L7Ig9O1X', 'Prezziaffare', 'Forbici potatura elettriche AMC 2 batterie caricatore valigetta e accessori', 104.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTQeuQzt60HPN-_vbdMk0lcitln86ZMrZCDSt3FRExQHjE3MIfp5yHB5KFZiAdra3Wfu2c1p5wqUd1-rlkVYqfjVqa8WTt2s6mz0Ubx42rAK0RUnyH2rBbP&usqp=CAE'),
('https://www.google.it/url?url=https://www.prezzoforte.it/foppapedretti-portacinture-in-faggio-giorgio-naturale-p-4597.html%3Ffrom%3Dgoogleshopping%26id_link%3D9c402845f2b48bf1292a01b3b32a2e6a&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECOoJ&usg=AOvVaw37HIWoN4qcq5DQg-xUYKdf', 'Prezzoforte', 'Foppapedretti Giorgio Portacinture Naturale', 11.16, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcT7UceQuGneMktBOImlugSas1Hvv6uvxO1DjRIbxNDl5wgP060IJSVuTmfYkVuvlxf9stfMQa7K1MoOqZ5dMMgOX0Dj_W5nKtKppTOWVupf8cWPsv_6vZhC&usqp=CAE'),
('https://www.google.it/url?url=https://www.reichelt.com/it/it/arduino-uno-wifi-rev2-atmega-4809-arduino-uno-rev2-p248661.html%3FPROVID%3D2814&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjatMSsrvD3AhXGkIkEHVxGDP0QguUECIII&usg=AOvVaw2yKDmcC_Q8glxD--evjcfH', 'reichelt.com', 'Arduino Uno Wifi REV2', 43.01, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcREbKq6rUfsQiqJSjO4zvaUmYbUUykQzfJ2EwwaJNrzCGXg1DXfK48a-GP6KgLVI4Ze8yrY8bXeqoU00ZelGOzBTTbt39Scno5Znt6zsKCHQTVuNTT0rGI2NA&usqp=CAE'),
('https://www.google.it/url?url=https://www.reichelt.com/it/it/arduino-uno-wifi-rev2-atmega-4809-arduino-uno-rev2-p248661.html%3FPROVID%3D2814&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECK8I&usg=AOvVaw3CWvQeqR_ZxZPWdEF89-zt', 'reichelt.com', 'Arduino Uno Wifi REV2', 43.01, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcREbKq6rUfsQiqJSjO4zvaUmYbUUykQzfJ2EwwaJNrzCGXg1DXfK48a-GP6KgLVI4Ze8yrY8bXeqoU00ZelGOzBTTbt39Scno5Znt6zsKCHQTVuNTT0rGI2NA&usqp=CAE'),
('https://www.google.it/url?url=https://www.svb-marine.it/it/seatec-giubbotto-di-salvataggio-automatico-go-150-n-rosso.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECIkI&usg=AOvVaw2d2n6fjk3Ci9963818MJST', 'SVB-Marine.it', 'SEATEC Giubbotto di salvataggio automatico Go / 150 N / Rosso', 64.95, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQUwrt-7vj__ffw_S71vLKO6DUMSDKGtbiZF7uaO0cEfqOTwNbGZZ1xtgEITtp3GANSBDZe2v38BOr6GLFtO-2aW1TnYxqnn7Ik_mdDW9Zx6U8_3Nk6gw55&usqp=CAE'),
('https://www.google.it/url?url=https://www.svb-marine.it/it/seatec-giubbotto-di-salvataggio-in-schiuma-100-n-10-120-kg.html%2357569&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECPQH&usg=AOvVaw2j6pbGPQ0T8PpBNWLLFSFN', 'SVB-Marine.it', 'Lalizas Giubbotto di salvataggio 100N 15-30 kg', 21.95, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRtXZ58ONkK7YjeS8UYcke9dchYAPFIFtiFKNDUd8WM6eEUZTpjQkbSRgLVF0m_hS-NjdUmzpUe&usqp=CAE'),
('https://www.google.it/url?url=https://www.svb-marine.it/it/spinlock-giubbotto-di-salvataggio-deckvest-6d-170n-bianco-nero.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECIkJ&usg=AOvVaw1d0pqDdl5JM5dAjHCtYEWj', 'SVB-Marine.it', 'Spinlock Giubbotto di salvataggio Deckvest 6D / 170N / Bianco-Nero', 314.95, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcS0-tvf-SDLzZ4YNByuu0m-kBx6Wdm1zkF_3sdc5TduoBkepWmEqBkeA6jctgmWthgvTX8DiFAghi35IIcKG4thfIW4ry6walDvykD-FRr0ij2rQIcGxEwfwA&usqp=CAE'),
('https://www.google.it/url?url=https://www.svb-marine.it/it/spinlock-lite-giubbotto-di-salvataggio-170-n.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjp6ZWilu73AhUYkGoFHVQmCqcQguUECLIK&usg=AOvVaw3vDh6KBf9ODBlw90yRINnH', 'SVB-Marine.it', 'Giubbotto di salvataggio Spinlock Deckvest Lite 170N - Blu', 179.95, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTVUE6xeKgDEKkR_uQA5RPvLk9n790jOEyG4TEJOhA6Y3VJU_5swYj1vqKN37EnHTvhLtWRQHklXkedNP4ka1tNJyGezE_XX6--mly8nlu3Y-kszA2iSKFnRA&usqp=CAE'),
('https://www.google.it/url?url=https://www.thinksafe.it/scarpe-antinfortunistiche-u-power/315-1296-scarpe-antinfortunistiche-alte-u-power-real-s1p.html%23/134-misura-37&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwif74Sfm-73AhVXrHIEHWi-AT8QguUECKMJ&usg=AOvVaw3uqD3u3R3r', 'Think Safe Italia', 'U-Power Scarpe antinfortunistiche Real S1P Taglia 37', 35.9, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRHzNdZeFu7ouDcOSRZ_gEfzLo910Ou60VcsN01EMmBw1k1jv1T4pDQdOBFLDfJ07hkGMp9uLd-qvBj0BihKPQe00CThZBnGJhwlUxvQkQJYPdJXhDVfNro&usqp=CAE'),
('https://www.google.it/url?url=https://www.tradeinn.com/dressinn/it/giorgio-beverly-hills-eau-de-toilette-30ml-i/135910632/p%3Futm_source%3Dgoogle_products%26utm_medium%3Dmerchant%26id_producte%3D2298751%26country%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECPcJ&usg=AOvVaw1qm_d6u0zZ0aAcsSXeiOPH', 'Dressinn.com', 'Giorgio BEVERLY Hills - Eau de Toilette 30 ml', 13.99, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQzcmi2lzT-hQG0gosUxicELQSdsrIoUMVwpTLVH24ocQi4ay3kD2n-6pfCcJ8U11337dM77RFnOLNTxZH6h0zgM5Lw__WHSAVjm5Rzxzetb0fyafP8mbnu&usqp=CAE'),
('https://www.google.it/url?url=https://www.tradeinn.com/waveinn/it/spinlock-giubbotto-di-salvataggio-6d-275n/137632452/p%3Futm_source%3Dgoogle_products%26utm_medium%3Dmerchant%26id_producte%3D11079954%26country%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-', 'Waveinn.com', 'Spinlock Giubbotto di salvataggio Deckvest 6D / 275N', 371.99, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcR_EgvihWm49benq7Qtsx9IjP2fcC7JK4hAnYm9Hs3DChu-bvm_9TOd4ZqSilqeU7MPWf-BYuct2D4iRDnTAnJhKmwxwMoQJFpVXZJOwWJC6mIBt2DG0tnpMA&usqp=CAE'),
('https://www.google.it/url?url=https://www.unilibro.it/libro/9788866410393%3Fidaff%3Dgooglebase-DI%26srsltid%3DAWLEVJz074JEvnSdiHWSPiqs4D40PCI4lVeA-U6IffyCF2H_5LTRkOyiWbo&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECIMK&usg=AOvVaw13F377ZI1h6MeAqWZqflQS', 'Unilibro.it', 'Giorgione. Orto e cucina - Barchiesi Giorgio', 17.1, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQIbvvA13IeEkXoX3zfKKUmX2-AeU0qBhbU92Pzbo7_gDXrgH-Z5yucncHpeVqimcJfAvQz5KtRLTMpA9_-QvWDf0Qai-eqVn_eOjb-NGV2&usqp=CAE'),
('https://www.google.it/url?url=https://www.vidaxl.it/e/vidaxl-giubbotti-di-salvataggio-4-pz-100-n-90-kg/.html/8718475606468.html%3F&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECOYH&usg=AOvVaw0l2L9c6YMovUeYi--Tfuin', 'vidaXL.it', 'vidaXL - Giubbotti di salvataggio 4 pz 100 N 90  kg', 216.99, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQNk_ZmQZ68InvXlZFd5Ym1u2dcdclekBisH1Vr-4L2KaV__W9kiPBo0Vzh_ggQaN-e0raxToDB0tifAPNJQx3Tsbq2kUP763mhgDvpxg-nPam7HEHi9PGNVw&usqp=CAE'),
('https://www.google.it/url?url=https://www.wetsuitoutlet.it/2022-crewsaver-crewfit-165n-giubbotto-salvataggio-manuale-sport-9710blm-nero-p-38246.html%3Fproducts_id%3D38246%26source%3Dgoogleshopping%26lang_ovd%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwicweHlp-73', 'Wetsuit Outlet IT', 'Giubbotto di salvataggio sportivo Crewsaver Crewfit 165N - Manuale - Nero - 9710', 86.35, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQFSk_-XkiGZr_44WMFrBvYdb6OwGMCSNc7ysPQga9HpNWv7ILvG8O6MW26b71xm_Z0JzIbyAb2sRljzZx8p6600PmUjQ-UIo6F3KaZgddnSmdet5tVnjXJaQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.wetsuitoutlet.it/2022-crewsaver-crewfit-165n-giubbotto-salvataggio-manuale-sport-9710blm-nero-p-38246.html%3Fproducts_id%3D38246%26source%3Dgoogleshopping%26lang_ovd%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3', 'Wetsuit Outlet IT', 'Giubbotto di salvataggio sportivo Crewsaver Crewfit 165N - Manuale - Nero - 9710', 86.35, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQFSk_-XkiGZr_44WMFrBvYdb6OwGMCSNc7ysPQga9HpNWv7ILvG8O6MW26b71xm_Z0JzIbyAb2sRljzZx8p6600PmUjQ-UIo6F3KaZgddnSmdet5tVnjXJaQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.wetsuitoutlet.it/2022-crewsaver-crewfit-165n-giubbotto-salvataggio-manuale-sport-9710blm-nero-p-38246.html%3Fproducts_id%3D38246%26source%3Dgoogleshopping%26lang_ovd%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73', 'Wetsuit Outlet IT', 'Giubbotto di salvataggio sportivo Crewsaver Crewfit 165N - Manuale - Nero - 9710', 86.35, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQFSk_-XkiGZr_44WMFrBvYdb6OwGMCSNc7ysPQga9HpNWv7ILvG8O6MW26b71xm_Z0JzIbyAb2sRljzZx8p6600PmUjQ-UIo6F3KaZgddnSmdet5tVnjXJaQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.wetsuitoutlet.it/2022-crewsaver-crewfit-165n-giubbotto-salvataggio-manuale-sport-9710blm-nero-p-38246.html%3Fproducts_id%3D38246%26source%3Dgoogleshopping%26lang_ovd%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3', 'Wetsuit Outlet IT', 'Giubbotto di salvataggio sportivo Crewsaver Crewfit 165N - Manuale - Nero - 9710', 86.35, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQFSk_-XkiGZr_44WMFrBvYdb6OwGMCSNc7ysPQga9HpNWv7ILvG8O6MW26b71xm_Z0JzIbyAb2sRljzZx8p6600PmUjQ-UIo6F3KaZgddnSmdet5tVnjXJaQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.wish.com/c/5f2272abe4a653520424b29f%3Fhide_login_modal%3Dtrue%26from_ad%3Dgoog_shopping_organic%26_display_country_code%3DIT%26_force_currency_code%3DEUR%26pid%3Dgoogleadwords_int%26c%3D%257BcampaignId%257D%26ad_c', 'Wish', 'Forgiata a mano, spada da samurai giapponese ad alte prestazioni, affilata ...', 133.09, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSha5HkenIpikZl0yOWMZcMN_T3nNGeEbZiT7MJGocb3j-oFC2YeXhwI2WmYNg&usqp=CAE');

-- --------------------------------------------------------

--
-- Struttura della tabella `prodotto-carrello`
--

CREATE TABLE `prodotto-carrello` (
  `prodotto` varchar(500) NOT NULL,
  `carrello` int(11) NOT NULL,
  `quantita` int(11) NOT NULL DEFAULT 1
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `prodotto-carrello`
--

INSERT INTO `prodotto-carrello` (`prodotto`, `carrello`, `quantita`) VALUES
('https://www.google.it/url?url=/shopping/product/17176339767152412360%3Fhl%3Dit%26prds%3Doid:1369835180782773604%26sts%3D9%26lsf%3Dseller:106515287,store:12589481899460405756,s:h&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjry-6Zuvb3AhURnHIEHaLBCcwQ_uQECIQP&usg=AOvVaw3_gbOvitprHLNnZkictSWc', 28, 1),
('https://www.google.it/url?url=/shopping/product/2129237302702179378%3Fhl%3Dit%26prds%3Doid:4148295202826405884%26sts%3D9%26lsf%3Dseller:6786366,store:3093374873564888626,s:h&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQ_uQECNsH&usg=AOvVaw0hEFZREpJfUeiUGWFLqF3f', 13, 1),
('https://www.google.it/url?url=https://friscoshop.it/products/polar-skate-co-psc-co-happysadsocks-long-blk-calze-happy-sad-long-calze-uomo-black&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQgOUECJIH&usg=AOvVaw2BVSG1I7or68zK89qadMVk', 18, 1),
('https://www.google.it/url?url=https://giochi.unilibro.it/gioco/8051070900686%3Fidaff%3Dgooglebase-03%26srsltid%3DAWLEVJybMUtsOSg8T9mpqTuZFmaPMiQwJHlqWjdBIQvbTH-2uqTemDTa_o4&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECNMJ&usg=AOvVaw1jpSGiD51HJf4rmbmOB-8g', 20, 1),
('https://www.google.it/url?url=https://lojadeartigosreligiosos.com/medalha-duas-faces-9&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQgOUECL8K&usg=AOvVaw1x7DpkLL7XXGoXOscxDaRm', 20, 1),
('https://www.google.it/url?url=https://mondoricondizionato.it/computer/4727-dell-optiplex-760-e7400-280ghz-4gb-160gb-hdd-sff-grado-b-0673983035125.html%3Fsrsltid%3DAWLEVJx55pwzLtgDjR0Ld9fQ_hEgEhk_A1lJuJllEosF-LGxkLyynrfLlTE&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECNAI&usg=AOvVaw2RKzxoXrk2HyBlXWbkPptd', 24, 9),
('https://www.google.it/url?url=https://mondoricondizionato.it/computer/4727-dell-optiplex-760-e7400-280ghz-4gb-160gb-hdd-sff-grado-b-0673983035125.html%3Fsrsltid%3DAWLEVJx55pwzLtgDjR0Ld9fQ_hEgEhk_A1lJuJllEosF-LGxkLyynrfLlTE&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECNAI&usg=AOvVaw2RKzxoXrk2HyBlXWbkPptd', 25, 1),
('https://www.google.it/url?url=https://mondoricondizionato.it/computer/4727-dell-optiplex-760-e7400-280ghz-4gb-160gb-hdd-sff-grado-b-0673983035125.html%3Fsrsltid%3DAWLEVJx55pwzLtgDjR0Ld9fQ_hEgEhk_A1lJuJllEosF-LGxkLyynrfLlTE&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECNAI&usg=AOvVaw2RKzxoXrk2HyBlXWbkPptd', 26, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002248206928.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle%2526memo1%253Dfreelisting&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQgOUECN4H&usg=AOvVaw2SwKuNm1KA75J24Bzw8gMI', 19, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002504051069.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECJYI&usg=AOvVaw118mHMlKZYW8K9zXYOc_0D', 27, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002504051069.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECJYI&usg=AOvVaw118mHMlKZYW8K9zXYOc_0D', 28, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002912679332.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECKQJ&usg=AOvVaw0ABw2YjQMQGeyD4ylAafsY', 15, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003249588186.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECKMI&usg=AOvVaw0AkMGbtVSlGWdMyrCxpGTh', 24, 5),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003249588186.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECKMI&usg=AOvVaw0AkMGbtVSlGWdMyrCxpGTh', 25, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003249588186.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECKMI&usg=AOvVaw0AkMGbtVSlGWdMyrCxpGTh', 26, 8),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003911223695.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQgOUECNII&usg=AOvVaw1y51MUomwGytK-oNxzHjo1', 28, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004038949095.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECK0I&usg=AOvVaw39QpJH6X2zv9gydazAPmxO', 22, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004058750819.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECKEI&usg=AOvVaw0u2AArETpJmOU6iKca1tYn', 27, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004058750819.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECKEI&usg=AOvVaw0u2AArETpJmOU6iKca1tYn', 28, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004058924960.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECPUH&usg=AOvVaw1CVjGnw-PJLlkdNXd3Rh6u', 27, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004059444918.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECN8H&usg=AOvVaw2ei8kxnxoLCIfta0obwcxw', 27, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004144813439.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECOgI&usg=AOvVaw3FxIToWtD3mm_9Wt4DIzlV', 24, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004144813439.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECOgI&usg=AOvVaw3FxIToWtD3mm_9Wt4DIzlV', 25, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004144813439.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECOgI&usg=AOvVaw3FxIToWtD3mm_9Wt4DIzlV', 26, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004187839724.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECMUI&usg=AOvVaw04ibLrrZiQLp2ax3iOrd9Q', 24, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004187839724.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECMUI&usg=AOvVaw04ibLrrZiQLp2ax3iOrd9Q', 25, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004195050867.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi0u-PLwfP3AhXmqXIEHbVkAXIQgOUECP8H&usg=AOvVaw2snj0edtZzPEgZ3XOIbsvM', 21, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004195050867.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECLoH&usg=AOvVaw1nX1IpK0rDJZ4X-sOonzLV', 22, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005004195050867.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECLoH&usg=AOvVaw1nX1IpK0rDJZ4X-sOonzLV', 23, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F32689353609.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwif9MSDwvb3AhXtj2oFHTVfDZkQgOUECN8G&usg=AOvVaw1V6u_lPVkVdMQrQpAVi5uA', 3, 1),
('https://www.google.it/url?url=https://sq-service.it/5981-2901252-zattera-ev-12p-abs-iso9650-italy-zattera-di-salvataggio-oceanic-italia-9650-eurovinil.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECPIH&usg=AOvVaw2EHX4HTPgXaN0KKaCO4mWK', 22, 1),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3/%3Fsrsltid%3DAWLEVJwmyL9MNayF1yEeNglzWZjKooi3soVF61eFWokhTPr46Kxr_320VG4&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjatMSsrvD3AhXGkIkEHVxGDP0QguUECNsH&usg=AOvVaw3oiDHPbVDZA_qjiJsts8Jj', 17, 1),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECP0H&usg=AOvVaw1OFpYwRatU6D3s-fewZnl2', 22, 1),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECIsI&usg=AOvVaw3-cv6nRREj7IcWxXX9prG1', 13, 1),
('https://www.google.it/url?url=https://whitecapsproducts.com/it/giubbotto-di-salvataggio-astral-serpent-2-0.html%3Fcombi_id%3D50416&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECIII&usg=AOvVaw1h7_yUwpS6iJ2wUaAvnbmB', 28, 1),
('https://www.google.it/url?url=https://wixsoo.com/prodotto/costume-mare-rosso-salvataggio-lifeguard-personalizzato-con-logo/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECJQI&usg=AOvVaw3kIVnb1f56T_zfoYCg9JOr', 22, 1),
('https://www.google.it/url?url=https://wixsoo.com/prodotto/costume-mare-rosso-salvataggio-lifeguard-personalizzato-con-logo/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQguUECPQH&usg=AOvVaw1uUtCOyvqxPrzVnluRswfW', 16, 1),
('https://www.google.it/url?url=https://wixsoo.com/prodotto/polo-salvataggio-rossa-manica-lunga-uomo-personalizzata-con-logo/%3Fattribute_opzioni%3D%252BBANDIERA%2B(%252B%25E2%2582%25AC1%252C50)&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQguUECPYH&usg=AOvVaw3fF0BRvMbLP2_v9FRTAP7Y', 19, 1),
('https://www.google.it/url?url=https://www.accesorionautico.com/giubbetto-salvataggio-bambini-3040-lalizas%3Flanguage%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECJ0I&usg=AOvVaw1ZlwfkNEJdHt5xejkTPt-5', 28, 1),
('https://www.google.it/url?url=https://www.agrieuro.com/aratri-per-trattore-c-1552.html%3Fhighlight%3D14119%26lgw_code%3D12143-14119&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECIsI&usg=AOvVaw3sZ3ICx2L9LSr-mURzf0pZ', 27, 1),
('https://www.google.it/url?url=https://www.armiantichesanmarino.eu/katana-di-kokushibou-tsugikuni-michikatsu-dall-anime-demon-slayer.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECJwI&usg=AOvVaw0W3zKein1hGTv8P8n7oFLV', 15, 1),
('https://www.google.it/url?url=https://www.armiantichesanmarino.eu/katana-maledetta-di-ronoroa-one-piece.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECPsH&usg=AOvVaw32gUOyp50Wb79Qjyg0W9PN', 15, 1),
('https://www.google.it/url?url=https://www.chioscodellestreghe.com/index.php/katana-dell-ultimo-samurai.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECKcI&usg=AOvVaw1I_lA4_qLvUQlYIhJUjx1R', 15, 1),
('https://www.google.it/url?url=https://www.coastwatersports.co.uk/it/giubbotto-di-salvataggio-sportivo-crewsaver-crewfit-165n-manuale-rosso-9710m-p-20251.html%3Fcurrency%3DEUR&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECKoI&usg=AOvVaw1t2gimJoSg-f2-QHQjfm6m', 28, 1),
('https://www.google.it/url?url=https://www.compass24.it/sicurezza/attrezzatura-di-salvataggio/cinture-di-salvataggio/221073/boa-di-salvataggio%3FsPartner%3Dgoogle_products%26number%3D236411_11%26utm_source%3Dgoogle%26utm_medium%3Dcpc%26utm_campaign%3Dfreeshopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECLgI&usg=AOvVaw0ujlFAcTAyXo8O-LYLY_Ov', 22, 1),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-bambino-lj100n-easy-arancione-grigio/_/R-p-311034%3Fmc%3D8569209%26utm_medium%3Dorganic-shopping%26srsltid%3DAWLEVJxOMiviuPKMX2teAlEg0rcwkIqBALTF54jMv3-PxE5Kpqs3CG9jALE&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECLcI&usg=AOvVaw3BSjLOTkJ72m0EmtefPXbj', 28, 1),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-bambino-lj100n-easy-arancione-grigio/_/R-p-311034%3Fmc%3D8569209%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi0u-PLwfP3AhXmqXIEHbVkAXIQ_uQECI8I&usg=AOvVaw0QANGL_EUl4Wr5zJxjAc0A', 21, 1),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-bambino-lj100n-easy-arancione-grigio/_/R-p-311034%3Fmc%3D8569209%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQ_uQECK4H&usg=AOvVaw1NaSHO39ztZ7M79K6V_Hb3', 22, 1),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-bambino-lj100n-easy-arancione-grigio/_/R-p-311034%3Fmc%3D8569209%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQ_uQECK4H&usg=AOvVaw1NaSHO39ztZ7M79K6V_Hb3', 23, 1),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi0u-PLwfP3AhXmqXIEHbVkAXIQ_uQECPIH&usg=AOvVaw0DRKaibsy-Tw19895bpBDq', 21, 1),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQ_uQECNgH&usg=AOvVaw1852ptlTDsnuJMEcZeIkZx', 22, 1),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQ_uQECNIH&usg=AOvVaw1ECeOUoXn5uw-Sl6lp9weX', 19, 1),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQ_uQECNAH&usg=AOvVaw0ZFCG1xLU1TstVuDX3f8DC', 16, 1),
('https://www.google.it/url?url=https://www.dna-marine.it/it/giubbotto-di-salvataggio-sv-100-100n-fnip61091&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECKEI&usg=AOvVaw1dhY-B4Bqgk_fj2n0c_g_4', 22, 1),
('https://www.google.it/url?url=https://www.dodax.it/it-it/dp/MP3V5UAE3PQ%3FofferId%3Ded64adcce82437e895e78b866fcc3ca5%26srsltid%3DAWLEVJwI7feGTnvtNtFC2n1S_Ji1jynq0OSswTqfWaAoMcnqMf8v8_HAJ88&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjatMSsrvD3AhXGkIkEHVxGDP0QguUECPUH&usg=AOvVaw06GtZGHiVOKqa2yiPGApzA', 17, 1),
('https://www.google.it/url?url=https://www.ebay.it/itm/202675088074%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECMkJ&usg=AOvVaw2MnMvQIMsFS6ddnAMuphDU', 15, 1),
('https://www.google.it/url?url=https://www.ebay.it/itm/302980639583%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECI8I&usg=AOvVaw1m8ALvBVHyBSrv9l-hDVxH', 28, 1),
('https://www.google.it/url?url=https://www.edilizia-valenti.com/prodotto/outlet-computer-outsider-pc-fisso-completo-intel-i5-ram-8gb-ssd-240-gb-monitor-24-pollici-tastiera-e-mouse-usb-casse-audio/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECK4I&usg=AOvVaw16YYEJtBDpToqlT574YPmR', 24, 1),
('https://www.google.it/url?url=https://www.edilizia-valenti.com/prodotto/outlet-computer-outsider-pc-fisso-completo-intel-i5-ram-8gb-ssd-240-gb-monitor-24-pollici-tastiera-e-mouse-usb-casse-audio/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QgOUECK4I&usg=AOvVaw16YYEJtBDpToqlT574YPmR', 25, 1),
('https://www.google.it/url?url=https://www.eprice.it/pc-assemblati-NONSOLOINFORMATICA/d-59834690%3Fshopid%3D5742&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECNwI&usg=AOvVaw3C1k4eK0srjd4a6Evn0f9S', 24, 1),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1026026646/katana-di-nuova-classe-master%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECIYI&usg=AOvVaw3qltazb9c5eh4LBJClQj4k', 15, 1),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1100658433/giorgio%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQgOUECN4J&usg=AOvVaw3ufDfu8oza_fqeVGgBHw6r', 20, 1),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/877319541/nichnyy-sad-giardino-notturno%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQgOUECKkH&usg=AOvVaw1RCRO3IOiZu3anr9CapK5R', 16, 1),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/877319541/nichnyy-sad-giardino-notturno%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQgOUECKkH&usg=AOvVaw1RCRO3IOiZu3anr9CapK5R', 18, 1),
('https://www.google.it/url?url=https://www.fruugo.it/bambini-e-adulti-giubbotto-di-salvataggio-nuoto-galleggiante-aid-giubbotti-di-salvataggio/p-72578130-145872575%3Flanguage%3Dit%26ac%3Dcroud%26utm_source%3Dorganic_shopping%26utm_medium%3Dorganic&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECM0I&usg=AOvVaw09EnHVaoKQI35fpH88dDHh', 13, 1),
('https://www.google.it/url?url=https://www.hinelson.com/it/16315-39166-plastimo-cruise-entro-12-miglia-revisione-zatterera-salvataggio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECPEI&usg=AOvVaw06SGXv41z-YYOPnS6KE4J2', 13, 1),
('https://www.google.it/url?url=https://www.hinelson.com/it/16317-39178-zodiac-open-sea-iso-9650-senza-limiti-revisione-zatterera-salvataggio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECOEJ&usg=AOvVaw15oSyZ5ljXiwalLk0adk6R', 15, 1),
('https://www.google.it/url?url=https://www.hinelson.com/it/17510-41403-giubbotto-di-salvataggio-150n-skipper-baby-autogonfiabile-automatico-veleria-san-giorgio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQgOUECMMI&usg=AOvVaw2yeShgj5uFSFyYMvGGy6Rs', 22, 1),
('https://www.google.it/url?url=https://www.ibs.it/giorgio-pira-utopia-salvera-storia-libro-maurizio-certini/e/9788862447171%3Flgw_code%3D1122-B9788862447171&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECI8K&usg=AOvVaw01kck1S3fFIr51Bq9RjcYk', 20, 1),
('https://www.google.it/url?url=https://www.ibs.it/pc-fisso-computer-i5-quad-informatica-nonsoloinformatica/e/8052679510115%3Flgw_code%3D1122-W8052679510115&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECLkI&usg=AOvVaw1x8p2S71urWNSiVfKjADH6', 24, 1),
('https://www.google.it/url?url=https://www.ibs.it/sad-party-cd-sin-fang/e/0880918817026%3Flgw_code%3D1122-M0880918817026&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQguUECJ0H&usg=AOvVaw37Y6q1qSr8DmC9PpCNpIsA', 16, 1),
('https://www.google.it/url?url=https://www.ibs.it/sad-party-cd-sin-fang/e/0880918817026%3Flgw_code%3D1122-M0880918817026&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQguUECJ0H&usg=AOvVaw37Y6q1qSr8DmC9PpCNpIsA', 18, 1),
('https://www.google.it/url?url=https://www.ibs.it/storie-dei-furetti-salvataggio-in-libro-rizzoli/e/9788817108119%3Flgw_code%3D1122-W9788817108119&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECNoI&usg=AOvVaw3Y9-YJ_be72h_ighpFcs0g', 13, 1),
('https://www.google.it/url?url=https://www.ibs.it/storie-dei-furetti-salvataggio-in-libro-rizzoli/e/9788817108119%3Flgw_code%3D1122-W9788817108119&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECNoI&usg=AOvVaw3Y9-YJ_be72h_ighpFcs0g', 15, 1),
('https://www.google.it/url?url=https://www.justathlete.it/beco-sealife-swim-jacket-blue-pink-m%3Futm_source%3Dgoogle%26utm_medium%3Dsurfaces%26utm_campaign%3Dshopping%2520feed%26utm_content%3Dfree%2520google%2520shopping%2520clicks&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECMYI&usg=AOvVaw0pYAmLXJepZI2Pi7EhRAAe', 28, 1),
('https://www.google.it/url?url=https://www.lafeltrinelli.it/falling-in-love-with-sadness-cd-emika/e/0666017320823%3Flgw_code%3D50948-M0666017320823&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQguUECLQH&usg=AOvVaw1MxLidJHlQSawkVGnk4SLt', 16, 1),
('https://www.google.it/url?url=https://www.lafeltrinelli.it/falling-in-love-with-sadness-cd-emika/e/0666017320823%3Flgw_code%3D50948-M0666017320823&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjypfa_rvD3AhVDHzQIHQCGD_sQguUECLQH&usg=AOvVaw1MxLidJHlQSawkVGnk4SLt', 18, 1),
('https://www.google.it/url?url=https://www.lafeltrinelli.it/palazzo-san-giorgio-autorita-portuale-libro-danilo-cabona/e/9788870589290%3Flgw_code%3D50948-B9788870589290&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECJsK&usg=AOvVaw3SYl5qQ2q3Q62cdvDdk09a', 20, 1),
('https://www.google.it/url?url=https://www.legami.com/it_it/VSHOW0008.html%3Fsrsltid%3DAWLEVJzrgX5pMXsac3D4zLyQQy8dYRyF_aKUcXU3LZcbFE6KDyjyZ_MfvOA&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjry-6Zuvb3AhURnHIEHaLBCcwQguUECKAP&usg=AOvVaw0vx8ou5EDzvslCPXeTRobt', 28, 1),
('https://www.google.it/url?url=https://www.libraccio.it/libro/9788867407996/giorgio-coppola/default.html%3Ftipo%3Dnuovo%26lgw_code%3D1115-I9788867407996&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECLMK&usg=AOvVaw0Cmk53B4Aiepe3MduSSwWX', 20, 1),
('https://www.google.it/url?url=https://www.libreriauniversitaria.it/giorgio-chiesura-fabrizio-serra-editore/libro/9788862278324%3Futm_source%3Dgoogle-shopping%26utm_medium%3Dcpc%26utm_term%3D9788862278324%26utm_content%3DLibri%2520Italiani%26utm_campaign%3Dgoogle-shopping-lib&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECKcK&usg=AOvVaw2WMICL5RBYbQ227OUjvN1a', 20, 1),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECKAH&usg=AOvVaw2poYGFk0q9MKVbGFloPRcF', 22, 1),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECKAH&usg=AOvVaw2poYGFk0q9MKVbGFloPRcF', 23, 1),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjB04OZzPD3AhWjmYQIHVsvDkQQguUECOsH&usg=AOvVaw3On3wJKbwizD820DVSY_Mc', 19, 1),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECPQH&usg=AOvVaw2l3bqM3CmBH4icSEnrdRBh', 13, 1),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECPQH&usg=AOvVaw2l3bqM3CmBH4icSEnrdRBh', 15, 1),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQguUECOkH&usg=AOvVaw1sWLBpPJedTr20D03C0iaU', 16, 1),
('https://www.google.it/url?url=https://www.mam-srl.it/trattore-kubota-b-1220-d-p-2369.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECOoH&usg=AOvVaw2GgIZGsN7A1QOBtry1OVuX', 27, 1),
('https://www.google.it/url?url=https://www.mam-srl.it/trattore-kubota-b-1620-d-p-2370.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjM2bTYlPb3AhXS16QKHe6ND44QgOUECIAI&usg=AOvVaw1v3_EeUg5nRRk0NcRIu47H', 27, 1),
('https://www.google.it/url?url=https://www.mediaworld.it/product/p-989877/jbl-flip-essential&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjry-6Zuvb3AhURnHIEHaLBCcwQguUECLAP&usg=AOvVaw1rbQDigNFCXbMPmaT2JNCN', 28, 1),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-chico-lifejacket-15-30kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwi0u-PLwfP3AhXmqXIEHbVkAXIQguUECJ8I&usg=AOvVaw3NS1Sxh09_hYXtL8-UhPSf', 21, 1),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-life-jacket100n-iso-12402-4-50-70kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECMkH&usg=AOvVaw2wch_Pv47zhYvkRzT8Zwdj', 22, 1),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-life-jacket100n-iso-12402-4-50-70kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECMkH&usg=AOvVaw2wch_Pv47zhYvkRzT8Zwdj', 23, 1),
('https://www.google.it/url?url=https://www.nonsoloinformatica.com/computer-pc-fisso-i7-quad-core-windows-10-pro-16gb-ram-ssd-240gb-hd-1tb-wifi/id/252642%26r%3Dgoogle-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiLt56K0vX3AhVjUd8KHTAsA44QguUECJcI&usg=AOvVaw3TVEblJP60lyHtEeM9Orqs', 24, 1),
('https://www.google.it/url?url=https://www.opendeel.com/product/tempo-di-saldi-altoparlante-bluetooth-impermeabile-mini-cassa-stereo-con-vivavoce-e-microfono-paXzfnwBWuR_74FsrJmc.html%3Ff%3Dgm&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjry-6Zuvb3AhURnHIEHaLBCcwQguUECJIP&usg=AOvVaw1um1S5c5Ut2n3Jldb4th4M', 28, 1),
('https://www.google.it/url?url=https://www.prezzoforte.it/foppapedretti-portacinture-in-faggio-giorgio-naturale-p-4597.html%3Ffrom%3Dgoogleshopping%26id_link%3D9c402845f2b48bf1292a01b3b32a2e6a&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECOoJ&usg=AOvVaw37HIWoN4qcq5DQg-xUYKdf', 20, 1),
('https://www.google.it/url?url=https://www.reichelt.com/it/it/arduino-uno-wifi-rev2-atmega-4809-arduino-uno-rev2-p248661.html%3FPROVID%3D2814&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjatMSsrvD3AhXGkIkEHVxGDP0QguUECIII&usg=AOvVaw2yKDmcC_Q8glxD--evjcfH', 17, 1),
('https://www.google.it/url?url=https://www.svb-marine.it/it/seatec-giubbotto-di-salvataggio-automatico-go-150-n-rosso.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECIkI&usg=AOvVaw2d2n6fjk3Ci9963818MJST', 22, 1),
('https://www.google.it/url?url=https://www.svb-marine.it/it/seatec-giubbotto-di-salvataggio-in-schiuma-100-n-10-120-kg.html%2357569&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj5pf6AmPb3AhXfhHIEHYaHDWQQguUECPQH&usg=AOvVaw2j6pbGPQ0T8PpBNWLLFSFN', 28, 1),
('https://www.google.it/url?url=https://www.svb-marine.it/it/spinlock-giubbotto-di-salvataggio-deckvest-6d-170n-bianco-nero.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECIkJ&usg=AOvVaw1d0pqDdl5JM5dAjHCtYEWj', 15, 1),
('https://www.google.it/url?url=https://www.tradeinn.com/dressinn/it/giorgio-beverly-hills-eau-de-toilette-30ml-i/135910632/p%3Futm_source%3Dgoogle_products%26utm_medium%3Dmerchant%26id_producte%3D2298751%26country%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECPcJ&usg=AOvVaw1qm_d6u0zZ0aAcsSXeiOPH', 20, 1),
('https://www.google.it/url?url=https://www.tradeinn.com/waveinn/it/spinlock-giubbotto-di-salvataggio-6d-275n/137632452/p%3Futm_source%3Dgoogle_products%26utm_medium%3Dmerchant%26id_producte%3D11079954%26country%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECMAI&usg=AOvVaw1pFfwgSefWd6OP9sesEiVB', 13, 1),
('https://www.google.it/url?url=https://www.unilibro.it/libro/9788866410393%3Fidaff%3Dgooglebase-DI%26srsltid%3DAWLEVJz074JEvnSdiHWSPiqs4D40PCI4lVeA-U6IffyCF2H_5LTRkOyiWbo&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiOjbmTwfP3AhVjnWoFHY9lAoAQguUECIMK&usg=AOvVaw13F377ZI1h6MeAqWZqflQS', 20, 1),
('https://www.google.it/url?url=https://www.vidaxl.it/e/vidaxl-giubbotti-di-salvataggio-4-pz-100-n-90-kg/.html/8718475606468.html%3F&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwj-hMftpPX3AhXphHIEHavlD2kQguUECOYH&usg=AOvVaw0l2L9c6YMovUeYi--Tfuin', 22, 1),
('https://www.google.it/url?url=https://www.wetsuitoutlet.it/2022-crewsaver-crewfit-165n-giubbotto-salvataggio-manuale-sport-9710blm-nero-p-38246.html%3Fproducts_id%3D38246%26source%3Dgoogleshopping%26lang_ovd%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECJkI&usg=AOvVaw1-dGU7RqOyKmvrW2SvtSH4', 13, 1),
('https://www.google.it/url?url=https://www.wetsuitoutlet.it/2022-crewsaver-crewfit-165n-giubbotto-salvataggio-manuale-sport-9710blm-nero-p-38246.html%3Fproducts_id%3D38246%26source%3Dgoogleshopping%26lang_ovd%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjdrMqDrfD3AhX-SvEDHdf1DasQguUECIEI&usg=AOvVaw09Gf3NsFLtPU2hsIKMT2qG', 20, 1),
('https://www.google.it/url?url=https://www.wish.com/c/5f2272abe4a653520424b29f%3Fhide_login_modal%3Dtrue%26from_ad%3Dgoog_shopping_organic%26_display_country_code%3DIT%26_force_currency_code%3DEUR%26pid%3Dgoogleadwords_int%26c%3D%257BcampaignId%257D%26ad_cid%3D5f2272abe4a653520424b29f%26ad_cc%3DIT%26ad_lang%3DIT%26ad_curr%3DEUR%26ad_price%3D122.00&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECJEI&usg=AOvVaw2ClJA3upvDvDOYPszWhyBl', 15, 1);

-- --------------------------------------------------------

--
-- Struttura della tabella `profilo`
--

CREATE TABLE `profilo` (
  `Username` varchar(20) NOT NULL,
  `Password` varchar(30) NOT NULL,
  `Email` varchar(50) NOT NULL,
  `ImmagineProfilo` varchar(255) DEFAULT NULL,
  `carrelloCorrente` int(11) DEFAULT 0,
  `seguaci` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `profilo`
--

INSERT INTO `profilo` (`Username`, `Password`, `Email`, `ImmagineProfilo`, `carrelloCorrente`, `seguaci`) VALUES
('admin', 'admin1', 'admin@admin.com', 'upload/admin.jpg', 3, 1),
('marc2000', 'africano2000', '2000mar@live.it', 'upload/marc2000.jpg', 4, 0),
('prova', 'asdf1', 'prova@prova.ot', 'upload/prova.jpg', 16, 0),
('root', 'admin1', 'root@root.it', NULL, 2, 0);

--
-- Trigger `profilo`
--
DELIMITER $$
CREATE TRIGGER `creaCarrello` AFTER INSERT ON `profilo` FOR EACH ROW BEGIN
if ((SELECT max(id) FROM `carrello`) >0) THEN
INSERT INTO `carrello`  
SELECT (max(id)+1),new.Username, '0', NULL, NULL, '0', '0' FROM `carrello`;
ELSE
	INSERT INTO `carrello` ( `proprietario`, `Totale`, `Nome`, `Descrizione`, `likes`, `commenti`) 
 VALUES
(1,new.Username, '0', NULL, NULL, '0', '0');
end IF;



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
-- Dump dei dati per la tabella `segui`
--

INSERT INTO `segui` (`seguace`, `seguito`) VALUES
('marc2000', 'admin');

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
  ADD PRIMARY KEY (`id`);

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
-- AUTO_INCREMENT per la tabella `commenti`
--
ALTER TABLE `commenti`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- Limiti per le tabelle scaricate
--

--
-- Limiti per la tabella `carrello`
--
ALTER TABLE `carrello`
  ADD CONSTRAINT `carrello_ibfk_1` FOREIGN KEY (`proprietario`) REFERENCES `profilo` (`Username`);

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
