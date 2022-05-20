-- phpMyAdmin SQL Dump
-- version 5.1.1
-- https://www.phpmyadmin.net/
--
-- Host: 127.0.0.1
-- Creato il: Mag 20, 2022 alle 18:01
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
  `commenti` int(11) DEFAULT 0
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

--
-- Dump dei dati per la tabella `carrello`
--

INSERT INTO `carrello` (`ID`, `proprietario`, `Totale`, `Nome`, `Descrizione`, `likes`, `commenti`) VALUES
(2, 'root', 0, NULL, NULL, 0, 0),
(3, 'admin', 0, NULL, NULL, 0, 0),
(4, 'marc2000', 0, NULL, NULL, 0, 0),
(12, 'marc2000', 5527.73, 'prova', 'prova', 0, 0),
(13, 'marc2000', 1486.84, 'Marco', 'asd', 0, 0),
(15, 'marc2000', 25874.7, 'katana', 'spade XD', 0, 0);

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
('https://www.google.it/url?url=/shopping/product/2129237302702179378%3Fhl%3Dit%26prds%3Doid:4148295202826405884%26sts%3D9%26lsf%3Dseller:6786366,store:3093374873564888626,s:h&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQ_uQECNsH&usg=AOvVaw0hEF', 'Decathlon', 'Plastimo. Giubbotto salvataggio Storm 100N', 13.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS1UpeplwRAkgi5NnNK4mhE2rvmZ92v1hcGaYQHIYRodA39KQxhdQ-Lauzf6nUSXBtRC1TMuhBYfZYfP4Cot2SKlk2G4bjGCSBsF67Gc4_-8PQgF6pCjHFT&usqp=CAE'),
('https://www.google.it/url?url=https://cablematic.com/it/prodotti/scheda-programmabile-arduino-micro-AR102/%3Fcr%3DEUR%26ct%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECOMI&usg=AOvVaw3KV8tiL3YntUzg80YSMUfn', 'Cablematic', 'Arduino Micro', 23.06, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ6qmZio7jKy0C5KJm_rlTogDYgRPWKJxPti4ob8lgCBRnzjg3sqJzcksivKkuCG7LBNCK-iD35W_C0keIda1EhKbJWvyQ2MPQNqNVQyNzCWh0nnKgrEMuv&usqp=CAE'),
('https://www.google.it/url?url=https://campoelettrico.it/materiale-elettrico/scheda-arduino-mega-2560-a000067.html%3Fsrsltid%3DAWLEVJyUYv4TWXd3KRN-8ToGKS3fn_2Ag1xa6ZFvD5K337bV-NnWPLMfi00&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECPAI&us', 'CampoElettrico.it', 'Arduino Scheda Mega 2560 A000067', 38.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTdeQJeaLlmPcwWN7MJTIU8MmC2LkbhoX04Tf1zKfVMGvMskmqilsnXSVOkfaiIiFsNvx4rX04RDa10PLe6c2d_8NKKU4XcWOqP90DkyGrSNwHKNNf8-F7bQw&usqp=CAE'),
('https://www.google.it/url?url=https://ricambiagricoltura.com/prodotto/forbici-elettriche-da-potatura-brumi-con-display/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QgOUECLQJ&usg=AOvVaw1c1_cIkkwpWQMQrL_0zmLi', 'Ricambi Agricoltura', 'FORBICI DA POTATURA ELETTRICHE BRUMI CON DISPLAY E 2 BATTERIE AL LITIO DIAMETRO ...', 350, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcR_w818iZr-svD-6UNOzbaXamGVnecWhPufN4YrzpU71b9NxRVr1OdCLlU6-z9PAp13jHOpelLIScW9ZyqdyNdZWUiiyn8Dds7UWLQhVL1_w2SGxqpzNYib&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002248206928.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%', 'AliExpress.com', 'Giubbotto di salvataggio per adulti nuoto galleggiamento giubbotto di salvataggio ...', 20.88, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTaERZESWh3SyJ6n5apWajx0cIh3odrRIA6KnngBBUCvBzgOZLli0v9qv0cZKOmCFJksr3vpFANcnpE7vPlJcH1FaDdxBK8owagByJZwEcKQFNZJ3O-AqmrMw&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002885424120.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%', 'AliExpress.com', 'Forbici da potatura elettriche cesoie da potatura 500W potatore da giardino ...', 8.34, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSFEZBIAEZA3P-N6ce__oW9kYdA3NGmxbNCdt9FgQirEE9ruODu6b3e09spO7-Jx7JXk8WWsdmg890DQ3lpKgmkDjWSdYco2TCQmzNdhK1FvB9oQT6sPXjIIA&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002912679332.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%', 'AliExpress.com', 'Sacchetto di nuoto gonfiabile boa di nuoto sacchetto di salvataggio rimorchio ...', 4.66, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQZ5gM0t3SoMoA73kGwpGwYZI6A4spB2AovGD9-RXHicPzaSx7p1--5GQ5WlPhdmEtdpASvqYinLAhyxFujS7KGRIZS9ur1AaSK4vfHMBRAusv5JZoaVWib&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005003117768294.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%', 'AliExpress.com', 'UNO R3 MEGA328P CH340 CH340G ATMEGA16U2   Chip MEGA328P per scheda di sviluppo ...', 0.75, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQ2VFTF_fjxXgRYFFfJs4UglztI_YNq99GwfvODLfH7eKr7CcHcEeiy3I5sXTV8e4QXr6Xu0cyBxdS4lhhrNz0sP-bRFWJz6KH6zjU3st8GeyY8tTnNqs9L0Q&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F32680845470.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dg', 'AliExpress.com', 'Di alta qualità di Un set di UNO R3 CH340G   MEGA328P Chip di 16Mhz per arduino ...', 1.29, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSzpaR9H49IiKBzMAJrRudGg1ekZJme33eKRQN1EX3HkecWZUTxpauRfHbFDFelucCQJwkr-KGmExqXv-ziwoa1_PejIsv4hYByoWEEX0zE0qAh8yFJ7z-JUA&usqp=CAE'),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F4001309679133.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253', 'AliExpress.com', 'Adulto Giubbotto di Salvataggio di Nuotata di Nuoto Galleggiante Maglia Giubbotto ...', 29.18, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcR1_AVQuyFs8fWN3jq_Udo_2bN8jy5D5jEJNDeW8Ynk9ijyeW3OhRzRGPhRMnPgOh7JcnCSniWe_pfmOlEplI0HnQChkmxeh28Q23qP1Hr-_3rjAx8bFzzN&usqp=CAE'),
('https://www.google.it/url?url=https://store.arduino.cc/products/arduino-uno-rev3/%3Fsrsltid%3DAWLEVJyQkyFJxVrKLImHbjmaDouE-3AS2ZH8TH8Bu79ZnbTQTD0drvFd51M&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECJcI&usg=AOvVaw26pLRK4wEbygCGOfGRM6oA', 'Arduino Official Store', 'Arduino Uno REV3 [A000066]', 20, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTNFj5ahb2rljsQ-3kygftelnUWcb98qFTvR6ZsoSoKEnyIkBa55c1zen20Fvc2Ckq1uNTwcG8F5q_iJU6jk1i48EsRKRdnNaI7buJvrK6x&usqp=CAE'),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECIsI&usg=AOvVaw3-cv6nRREj7IcWxXX9prG1', 'Tutto Cantiere Online', 'Dispositivo di salvataggio ed evacuazione   sacco TC013', 1450, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ3hHJvoLRip-SEYqcxd-bgafL_MJbOj60HI4WYZkHiwkxbsFPWKfaasc1Z1dQCZTampLiYrs9FHtKP6ByVXsbCcXSgNqy6fCRdKgMDWSOC1e6lzIHfhJ7Z&usqp=CAE'),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjp6ZWilu73AhUYkGoFHVQmCqcQgOUECPoH&usg=AOvVaw3Eea6jU_bt5NfUnWLcySXm', 'Tutto Cantiere Online', 'Dispositivo di salvataggio ed evacuazione   sacco TC013', 1450, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQ3hHJvoLRip-SEYqcxd-bgafL_MJbOj60HI4WYZkHiwkxbsFPWKfaasc1Z1dQCZTampLiYrs9FHtKP6ByVXsbCcXSgNqy6fCRdKgMDWSOC1e6lzIHfhJ7Z&usqp=CAE'),
('https://www.google.it/url?url=https://wixsoo.com/prodotto/polo-salvataggio-rossa-manica-lunga-uomo-personalizzata-con-logo/%3Fattribute_opzioni%3D%252BBANDIERA%2B(%252B%25E2%2582%25AC1%252C50)&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiH0_-_h-73AhWRq3IEHeIWAcQQguUE', 'wixsoo.com', 'Polo salvataggio Rossa Manica lunga Uomo Personalizzata con Logo', 22.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSrVDiyq8u1s9nhpSNasUtB8aDQYA9lgr2fbyWYfVJfJ5TkodTvDWn7em3foXLEeq3BT8mAyfACF4erEi3aT1_V6b1L8EzVXQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.armiantichesanmarino.eu/katana-di-kokushibou-tsugikuni-michikatsu-dall-anime-demon-slayer.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECJwI&usg=AOvVaw0W3zKein1hGTv8P8n7oFLV', 'AAnticheSanMarino', 'Katana di kokushibou tsugikuni michikatsu dall\'anime demon slayer', 48, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRgjiiTl1tRdHQPfpGXbapL7Tkv2Q5CthbFLubPuy7EtMMw9TkyJW5-4s53bi1Nj2q2w3kaxwo&usqp=CAE'),
('https://www.google.it/url?url=https://www.armiantichesanmarino.eu/katana-maledetta-di-ronoroa-one-piece.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECPsH&usg=AOvVaw32gUOyp50Wb79Qjyg0W9PN', 'AAnticheSanMarino', 'Katana maledetta di ronoroa one piece shusui-acqua d\'autunno', 33.9, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSR_sQ1AjS9hCtmXs1i2-b4x_CVyZVYCPfqOw6IHQu7FSv_Rety_mMHiuvMhdtO2GXNynfCxHGT&usqp=CAE'),
('https://www.google.it/url?url=https://www.chioscodellestreghe.com/index.php/katana-dell-ultimo-samurai.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECKcI&usg=AOvVaw1I_lA4_qLvUQlYIhJUjx1R', 'Chiosco Delle Streghe', 'Katana dell\'Ultimo Samurai', 30, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTN5n_mjPGoKdQ80LKBTC5nD1JUeEBxdtf4s4xBAPArDr72M01aPMZIt-LinLo&usqp=CAE'),
('https://www.google.it/url?url=https://www.compass24.it/sicurezza/giubbotti-di-salvataggio/giubbotti-di-salvataggio-automatici/221415/giubbotto-di-salvataggio-spinlock-6d-automatic-vest%3FsPartner%3Dgoogle_products%26number%3D398250_11%26utm_source%3Dgoogl', 'compass24.it', 'Giubbotto di salvataggio Spinlock 6D Automatic Vest', 379.99, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcROPyDSz1s4Cj0ST-aKJErFgkyBGwHzw8N8rG5U8Z_ABSJN2EeUt-OyTBledceXB6AWwLeAW3AHVqqn9_msoJ6hrCiEmxLZLV7Kg66D8lkQn-VVeaeBltDwoA&usqp=CAE'),
('https://www.google.it/url?url=https://www.compass24.it/sicurezza/giubbotti-di-salvataggio/giubbotti-di-salvataggio-solidi/220435/set-di-giubbotti-di-salvataggio-plastimo%3FsPartner%3Dgoogle_products%26number%3D214651_11%26utm_source%3Dgoogle%26utm_medium%', 'compass24.it', 'Giubbotto di salvataggio Storm 100N Plastimo Storm 100N Pacchetto di 4', 109.99, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQW8pcdFzUEv_2RHIgEZBO8y77BJf2FOXOGbDuaCaEiFi8rKhzwrv_ioeGZjTUBUYzqCekjhs9BekhkvwTh8VO8tmTau52n8wHDI5J_TztYRtUfxu42fNpS3Q&usqp=CAE'),
('https://www.google.it/url?url=https://www.corvezzogiuseppe.it/product/potatore-elettronico-volpi-kv600/&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QguUECKgJ&usg=AOvVaw2HamQerMII8J-VXd6dEiqu', 'Corvezzo Giuseppe', 'Forbice Forbici da potatura a Batteria elettriche Volpi Professionale KV600', 739, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcTmz1yHENvAgGVAl8bsjK9BJVCcZE7VrnyImltg3YxWzAYwCea5gV0dKBlzYYaWof6YU6R4Et4J5oE8BEjUFhYNMlKtHMlRr2H_tINd6mVgic4846jEghEC&usqp=CAE'),
('https://www.google.it/url?url=https://www.decathlon.it/p/giubbotto-salvataggio-storm-100n/_/R-p-X8161467%3Fmc%3D8161467%26utm_medium%3Dorganic-shopping&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiH0_-_h-73AhWRq3IEHeIWAcQQ_uQECM4H&usg=AOvVaw2JdZHIvrTTBaghAPdpSCWi', 'Decathlon', 'Plastimo. Giubbotto salvataggio Storm 100N', 13.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcS1UpeplwRAkgi5NnNK4mhE2rvmZ92v1hcGaYQHIYRodA39KQxhdQ-Lauzf6nUSXBtRC1TMuhBYfZYfP4Cot2SKlk2G4bjGCSBsF67Gc4_-8PQgF6pCjHFT&usqp=CAE'),
('https://www.google.it/url?url=https://www.dhm-online.com/board/5019-arduino-uno-rev3-smd-8058333490137.html%3Futm_campaign%3Dpro%26utm_source%3Dgmc%26utm_medium%3Dgs&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECNYI&usg=AOvVaw1x6CMU5lKsJx', 'Compass DHM projects', 'Arduino Uno REV3 SMD', 24.34, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTMXxMQW8i2w5YpJalnnFoUfSBUN7H5Phq_5CWkA1xqotuIQUID9EeO4xsMbEn0m-ddy6hwd66X16aAHxB0pDqWuKSLn_PSx8gl1p7JyBYdMwAC34zVavso&usqp=CAE'),
('https://www.google.it/url?url=https://www.distrelec.it/it/arduino-nano-every-arduino-abx00028/p/30150884&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECMkI&usg=AOvVaw1_xxDVKNYQGNAJG-qz6SkY', 'Distrelec Italia', 'Arduino Nano Every', 12.74, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTRfxJMk29I5vAU3sO1ekTYGyLoj9vUPxGeY5NWodya7xDk4sM65mSI9YSEj-8Hks8pdA3OHIJHtUR1JEtAlkQJvCiHUtZZQJO5yuatkuATfzVASRjMEBKMzQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.dodax.it/it-it/dp/MP3V5UAE3PQ%3FofferId%3Ded64adcce82437e895e78b866fcc3ca5%26srsltid%3DAWLEVJxytJY2wx_5jFuroDhBxv-O5v-HYqidMeXY9Riq2TwRv_GQUKtm62g&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECLwI', 'Dodax.it', 'Arduino - Starter Kit', 125.15, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTDI-knt_aruoHGlDr519RbeC--KtYEIowbe5U0FpNraeNZo00tKyZKjXK7uQ8o9RDjRU9vGVeHIewisgQ553KOz4iLGkZmqUUVuqntFpo&usqp=CAE'),
('https://www.google.it/url?url=https://www.ebay.it/itm/202675088074%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECMkJ&usg=AOvVaw2MnMvQIMsFS6ddnAMuphDU', 'eBay - outdoorfan_de', 'Tattico Tomahawk TF2 Nero con Kopftasche Ascia salvataggio Esercito Campeggio', 23.57, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcT_Z-YpyW6H2qSommDBlDCr1HtpY9dhsRd3RQICycX6u7zp6NaILGB2Cs48z6YOfbZI03AGi2XfZah8iCXjrkZT6XV1pHufUPzkR1772uB3UkN1tH2zbujk&usqp=CAE'),
('https://www.google.it/url?url=https://www.ebay.it/itm/253370699449%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjp6ZWilu73AhUYkGoFHVQmCqcQguUECMoK&usg=AOvVaw1ozIcgRYLsoQ7w4drNf2cP', 'eBay - oltrevela', 'Giubbotto di salvataggio Spinlock Deckvest Lite 170N - Nero', 231.99, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcQBhwdIum7fx9jHb2urCiEI6YXXq4pi-YfxltxKme2bnJ0ex1tajYcJRqtTLLiwErRx4TXwainKV3EBTO9zH-i4FQfZ-0cfmPYTArZaRGKXAVXDHYmZKaXbsA&usqp=CAE'),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1026026646/katana-di-nuova-classe-master%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECIYI&usg=AOvVaw3qltazb9c5eh4LBJClQj4k', 'Etsy - StormwindCity', 'Katana di nuova classe master completamente fatta a mano, katana giapponese ...', 25387.4, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcR2srGk1kfbzi7_4UWtfH155E3MhRNfYYOAwxHxMYb_o7241Jb4Kg6Dfw77jm-gYRbUbkFQsh0&usqp=CAE'),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/400661661/convoglio-559-salvataggio-in-mare-olio%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECPwI&usg=AOvVaw1NuVK-VCBldfBsVqkWFZd0', 'Etsy - Seller', 'Convoglio 559 - salvataggio in mare olio originale', 1541.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcSerUNUGvgDEmpOstvEYsNlBeoYOvCslxehQSWYuztnRXNr7WC0UNooOuMH_kYIvA_E8ZazV79B1yuVtQloImNFFzqnp6PCQODAnq7I3Z8&usqp=CAE'),
('https://www.google.it/url?url=https://www.eurobrico.com/it/forb-potatura-batt-16v-con-2-batt-lithio-C000393831&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QguUECJAJ&usg=AOvVaw0FkNlRB90xeT-y-LQnypYk', 'Eurobrico.com', 'Armour - Forbice da potatura Elettrica a Batteria 16V con 2 Batterie al LITIO incluse', 99.5, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTny5NXljZAHvalGu97ZjdLdrS4NBT9raL6OHHW-1DLuCcG1PlCbXiQcJJW45V9DtGoNsHTqksBoFKmwfNYAff7j4RVHhcSeRlXt0FCpalWgJZWiqIa7ytfLg&usqp=CAE'),
('https://www.google.it/url?url=https://www.fruugo.it/bambini-e-adulti-giubbotto-di-salvataggio-nuoto-galleggiante-aid-giubbotti-di-salvataggio/p-72578130-145872575%3Flanguage%3Dit%26ac%3Dcroud%26utm_source%3Dorganic_shopping%26utm_medium%3Dorganic&rct=j&q=', 'fruugo.it', 'Wangst bambini e Adulti Giubbotto di salvataggio Nuoto Galleggiante Aid Giubbotti ...', 48.95, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcQv3HhMsyn_ERyV_-4daWKTYXyh3Jab1KjmE3Da1nr_qZ7-xOMAtfoZnan5BtbRNSnK49pF6EnS5m5OCGTgt_ipk37b9pmZBO6h7CmiuB2W_VDQ20c9UAXyTg&usqp=CAE'),
('https://www.google.it/url?url=https://www.gamaronline.com/4189-giubbotto-di-salvataggio-per-bambini-auto-manuale.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjp6ZWilu73AhUYkGoFHVQmCqcQgOUECPcK&usg=AOvVaw1YVtH-LO4Ynl9uJlqhCtM2', 'GaMar', 'GIUBBOTTO DI SALVATAGGIO PER BAMBINI AUTO/MANUALE', 101.92, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcR7bvnNJPSMewsrL2iIEXDy6v_lI3V01iwWSqbE0QT5c7CVMNLdtJCB1gruvr4JhwYNCH4Wel2m_TQaJdqQ5yrkOhcf5mdTBa2kuLk9SMdWlpHckvmwgRJjig&usqp=CAE'),
('https://www.google.it/url?url=https://www.gardenbedettishop.com/attrezzi-a-batteria/5178-forbice-da-potatura-a-batteria-stocker-vulcano-e-30-tp-8016604003110.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QgOUECIIJ&usg=AOvVaw0aZyD2heNWJwDpF', 'GardenBedettiShop', 'Forbice da potatura a batteria Stocker vulcano E-30 TP', 88.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTesapLnBtqpBBHUklUwOhUoq3tNhfJJNYhDwatC3RW_B2MHRAEpmkcQIb3kXNjA71raY_P3Bg8eTdP5fkPni9Xb5VMeLyO71pb9Uzn__8xk_h550Q889ajZg&usqp=CAE'),
('https://www.google.it/url?url=https://www.hinelson.com/it/16315-39166-plastimo-cruise-entro-12-miglia-revisione-zatterera-salvataggio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECPEI&usg=AOvVaw06SGXv41z-YYOPnS6K', 'HiNelson', 'Plastimo Cruise entro 12 miglia - Revisione zattera salvataggio 12', 646.6, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcSfUx9xpeEJnTr6Sjs03cxAUkrBa_ndja6RBhw8xC6KAIdHcvKUjvmi6EkVoQ6rI8QkAwBEbE8yL1aELumWJ35_NBsVmo1jGtswyhlMsjJLDJajWFvaZkWooQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.hinelson.com/it/16317-39178-zodiac-open-sea-iso-9650-senza-limiti-revisione-zatterera-salvataggio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECOEJ&usg=AOvVaw15oSyZ5ljXiw', 'HiNelson', 'Zodiac Open Sea ISO 9650 senza limiti - Revisione zattera salvataggio 8', 756.4, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcTp2b-t8WfzlcnadIcI0yZ3noLdiCoXEBdXpYcMnhVjwyA-mzAv-_ofC3ckxrUkS2FZT5MaJy3yrb0JJmEtc-R8n2f4djp3oOMjY6PuT403HU4sgLWL9Ts9&usqp=CAE'),
('https://www.google.it/url?url=https://www.ibs.it/storie-dei-furetti-salvataggio-in-libro-rizzoli/e/9788817108119%3Flgw_code%3D1122-W9788817108119&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECNoI&usg=AOvVaw3Y9-YJ_be72h_ighpFcs0g', 'IBS.it', 'Rizzoli Le Storie dei furetti. salvataggio in Mare - Richard Bach', 7.5, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcRqihfD65iToZrXdc9zAU8-J_IUUdajopOGPHgMlO5XJwfEb8tuc1RSlypXvzZrQ7PTKzkRM03bOP95jewO7R71ZxHwOONbUf4uu01lj9zYGHQJ5Kc-xKehnQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiH0_-_h-73AhWRq3IEHeIWAcQQguUECNwH&usg=AOvVaw2sbAkAPCpxhO4Uv1ibxTFJ', 'MagellanoStore.it', 'Giubbotto salvataggio Antille 100 N - XXS', 29.34, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQQ-JEPmiP6c7k40U23hrJ_dcIGGh56v1-MQ6itjPlJRnk5RtL4iw8BreC33oGB6Fs_sZo5zW2og9x8NcrUvMG3wL0PGm8XrQgBcsG0L2SxSqZ9yefpbVjP&usqp=CAE'),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECPQH&usg=AOvVaw2l3bqM3CmBH4icSEnrdRBh', 'MagellanoStore.it', 'Giubbotto salvataggio Antille 100 N - XXS', 29.34, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQQ-JEPmiP6c7k40U23hrJ_dcIGGh56v1-MQ6itjPlJRnk5RtL4iw8BreC33oGB6Fs_sZo5zW2og9x8NcrUvMG3wL0PGm8XrQgBcsG0L2SxSqZ9yefpbVjP&usqp=CAE'),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-nadir-100-n-tg-adulto-P7497.htm%3Fmid%3D7497&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECOYI&usg=AOvVaw3glD_-Pn4koEaAtLiF-GOo', 'MagellanoStore.it', 'Giubbotto salvataggio Nadir 100 N TG. Adulto', 13.18, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcR86m6_6jFOtdIMvCg4W6j1jblSVIiuKxRBtKugqtvZpE_rMLkphVyFoszTAbiX0pPehWgM32xlQkzwnk6rqNnYqEdAk3Lyjo6JmrKHhaHRqVmCOaHZ-VLibg&usqp=CAE'),
('https://www.google.it/url?url=https://www.mouser.it/ProductDetail/Arduino/AKX00002%3Fqs%3DfAHHVMwC%25252BbjuZX12Z140WQ%253D%253D%26mgh%3D1%26vip%3D1&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECPwI&usg=AOvVaw2zJEg0fWNfflN9pCfVmtn8', 'Mouser Italia', 'Arduino CTC 101 Program - Full', 2173.13, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcQA8wczcLF4uYig7kX5yDy83gr0X9Yi9zNE6TujZmixUTYLstU1-z_WmUKREQat1ZbuOOy8vr88BUMkMaceIvV9hCdbV_pLeYpb9HeJ0dP_hOQg_JbtPlNQNTc&usqp=CAE'),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-chico-lifejacket-15-30kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwiH0_-_h-73AhWRq3IEHeIWAcQQguUECIsI&usg=AOvVaw12XNTgbzEIeJJvzSE0doaS', 'Muziker IT', 'Lalizas Giubbotto di salvataggio Chico 100N 15-30 kg', 29.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRG7BaCrsz0VuKDmRnGkskJxGcYLXFVtPOcEqxJ1aX0USx3NKujrOPvUoRHq80iqYGWJjKr6RviKJxkASjtmYRD5FqAhFrlYcwXoTPoBpXvSuUs6VpftUhV&usqp=CAE'),
('https://www.google.it/url?url=https://www.muziker.it/lalizas-chico-lifejacket-15-30kg&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECKgI&usg=AOvVaw0qBmqK5SOEJ5RLfa9yyAxz', 'Muziker IT', 'Lalizas Giubbotto di salvataggio Chico 100N 15-30 kg', 29.9, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcRG7BaCrsz0VuKDmRnGkskJxGcYLXFVtPOcEqxJ1aX0USx3NKujrOPvUoRHq80iqYGWJjKr6RviKJxkASjtmYRD5FqAhFrlYcwXoTPoBpXvSuUs6VpftUhV&usqp=CAE'),
('https://www.google.it/url?url=https://www.prezziaffare.com/Forbici-potatura-elettriche-AMC-2-batterie-caricatore-valigetta-e-accessori/id/41&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjv-tmym-73AhXGj2oFHQ6OBV4QgOUECMsJ&usg=AOvVaw1pA7MzCvzyyli6L7Ig9O1X', 'Prezziaffare', 'Forbici potatura elettriche AMC 2 batterie caricatore valigetta e accessori', 104.99, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcTQeuQzt60HPN-_vbdMk0lcitln86ZMrZCDSt3FRExQHjE3MIfp5yHB5KFZiAdra3Wfu2c1p5wqUd1-rlkVYqfjVqa8WTt2s6mz0Ubx42rAK0RUnyH2rBbP&usqp=CAE'),
('https://www.google.it/url?url=https://www.reichelt.com/it/it/arduino-uno-wifi-rev2-atmega-4809-arduino-uno-rev2-p248661.html%3FPROVID%3D2814&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjGx86qqu73AhUxhIkEHRRIDkgQguUECK8I&usg=AOvVaw3CWvQeqR_ZxZPWdEF89-zt', 'reichelt.com', 'Arduino Uno Wifi REV2', 43.01, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcREbKq6rUfsQiqJSjO4zvaUmYbUUykQzfJ2EwwaJNrzCGXg1DXfK48a-GP6KgLVI4Ze8yrY8bXeqoU00ZelGOzBTTbt39Scno5Znt6zsKCHQTVuNTT0rGI2NA&usqp=CAE'),
('https://www.google.it/url?url=https://www.svb-marine.it/it/spinlock-giubbotto-di-salvataggio-deckvest-6d-170n-bianco-nero.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECIkJ&usg=AOvVaw1d0pqDdl5JM5dAjHCtYEWj', 'SVB-Marine.it', 'Spinlock Giubbotto di salvataggio Deckvest 6D / 170N / Bianco-Nero', 314.95, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcS0-tvf-SDLzZ4YNByuu0m-kBx6Wdm1zkF_3sdc5TduoBkepWmEqBkeA6jctgmWthgvTX8DiFAghi35IIcKG4thfIW4ry6walDvykD-FRr0ij2rQIcGxEwfwA&usqp=CAE'),
('https://www.google.it/url?url=https://www.svb-marine.it/it/spinlock-lite-giubbotto-di-salvataggio-170-n.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjp6ZWilu73AhUYkGoFHVQmCqcQguUECLIK&usg=AOvVaw3vDh6KBf9ODBlw90yRINnH', 'SVB-Marine.it', 'Giubbotto di salvataggio Spinlock Deckvest Lite 170N - Blu', 179.95, 'https://encrypted-tbn2.gstatic.com/shopping?q=tbn:ANd9GcTVUE6xeKgDEKkR_uQA5RPvLk9n790jOEyG4TEJOhA6Y3VJU_5swYj1vqKN37EnHTvhLtWRQHklXkedNP4ka1tNJyGezE_XX6--mly8nlu3Y-kszA2iSKFnRA&usqp=CAE'),
('https://www.google.it/url?url=https://www.thinksafe.it/scarpe-antinfortunistiche-u-power/315-1296-scarpe-antinfortunistiche-alte-u-power-real-s1p.html%23/134-misura-37&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwif74Sfm-73AhVXrHIEHWi-AT8QguUECKMJ&usg=AOvVaw3uqD3u3R3r', 'Think Safe Italia', 'U-Power Scarpe antinfortunistiche Real S1P Taglia 37', 35.9, 'https://encrypted-tbn0.gstatic.com/shopping?q=tbn:ANd9GcRHzNdZeFu7ouDcOSRZ_gEfzLo910Ou60VcsN01EMmBw1k1jv1T4pDQdOBFLDfJ07hkGMp9uLd-qvBj0BihKPQe00CThZBnGJhwlUxvQkQJYPdJXhDVfNro&usqp=CAE'),
('https://www.google.it/url?url=https://www.tradeinn.com/waveinn/it/spinlock-giubbotto-di-salvataggio-6d-275n/137632452/p%3Futm_source%3Dgoogle_products%26utm_medium%3Dmerchant%26id_producte%3D11079954%26country%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-', 'Waveinn.com', 'Spinlock Giubbotto di salvataggio Deckvest 6D / 275N', 371.99, 'https://encrypted-tbn1.gstatic.com/shopping?q=tbn:ANd9GcR_EgvihWm49benq7Qtsx9IjP2fcC7JK4hAnYm9Hs3DChu-bvm_9TOd4ZqSilqeU7MPWf-BYuct2D4iRDnTAnJhKmwxwMoQJFpVXZJOwWJC6mIBt2DG0tnpMA&usqp=CAE'),
('https://www.google.it/url?url=https://www.wetsuitoutlet.it/2022-crewsaver-crewfit-165n-giubbotto-salvataggio-manuale-sport-9710blm-nero-p-38246.html%3Fproducts_id%3D38246%26source%3Dgoogleshopping%26lang_ovd%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwicweHlp-73', 'Wetsuit Outlet IT', 'Giubbotto di salvataggio sportivo Crewsaver Crewfit 165N - Manuale - Nero - 9710', 86.35, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQFSk_-XkiGZr_44WMFrBvYdb6OwGMCSNc7ysPQga9HpNWv7ILvG8O6MW26b71xm_Z0JzIbyAb2sRljzZx8p6600PmUjQ-UIo6F3KaZgddnSmdet5tVnjXJaQ&usqp=CAE'),
('https://www.google.it/url?url=https://www.wetsuitoutlet.it/2022-crewsaver-crewfit-165n-giubbotto-salvataggio-manuale-sport-9710blm-nero-p-38246.html%3Fproducts_id%3D38246%26source%3Dgoogleshopping%26lang_ovd%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73', 'Wetsuit Outlet IT', 'Giubbotto di salvataggio sportivo Crewsaver Crewfit 165N - Manuale - Nero - 9710', 86.35, 'https://encrypted-tbn3.gstatic.com/shopping?q=tbn:ANd9GcQFSk_-XkiGZr_44WMFrBvYdb6OwGMCSNc7ysPQga9HpNWv7ILvG8O6MW26b71xm_Z0JzIbyAb2sRljzZx8p6600PmUjQ-UIo6F3KaZgddnSmdet5tVnjXJaQ&usqp=CAE'),
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
('https://www.google.it/url?url=/shopping/product/2129237302702179378%3Fhl%3Dit%26prds%3Doid:4148295202826405884%26sts%3D9%26lsf%3Dseller:6786366,store:3093374873564888626,s:h&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQ_uQECNsH&usg=AOvVaw0hEFZREpJfUeiUGWFLqF3f', 13, 1),
('https://www.google.it/url?url=https://s.click.aliexpress.com/deep_link.htm%3Faff_short_key%3DUneMJZVf%26dl_target_url%3Dhttps%253A%252F%252Fwww.aliexpress.com%252Fitem%252F1005002912679332.html%253F_randl_currency%253DEUR%2526_randl_shipto%253DIT%2526src%253Dgoogle&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECKQJ&usg=AOvVaw0ABw2YjQMQGeyD4ylAafsY', 15, 1),
('https://www.google.it/url?url=https://tuttocantiereonline.com/dispositivo-di-salvataggio-ed-evacuazione-sacco-tc013&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECIsI&usg=AOvVaw3-cv6nRREj7IcWxXX9prG1', 13, 1),
('https://www.google.it/url?url=https://www.armiantichesanmarino.eu/katana-di-kokushibou-tsugikuni-michikatsu-dall-anime-demon-slayer.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECJwI&usg=AOvVaw0W3zKein1hGTv8P8n7oFLV', 15, 1),
('https://www.google.it/url?url=https://www.armiantichesanmarino.eu/katana-maledetta-di-ronoroa-one-piece.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECPsH&usg=AOvVaw32gUOyp50Wb79Qjyg0W9PN', 15, 1),
('https://www.google.it/url?url=https://www.chioscodellestreghe.com/index.php/katana-dell-ultimo-samurai.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECKcI&usg=AOvVaw1I_lA4_qLvUQlYIhJUjx1R', 15, 1),
('https://www.google.it/url?url=https://www.ebay.it/itm/202675088074%3Fchn%3Dps%26mkevt%3D1%26mkcid%3D28&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECMkJ&usg=AOvVaw2MnMvQIMsFS6ddnAMuphDU', 15, 1),
('https://www.google.it/url?url=https://www.etsy.com/it/listing/1026026646/katana-di-nuova-classe-master%3Fgpla%3D1%26gao%3D1%26&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjIjbqFue73AhWOAjQIHRwdAAwQgOUECIYI&usg=AOvVaw3qltazb9c5eh4LBJClQj4k', 15, 1),
('https://www.google.it/url?url=https://www.fruugo.it/bambini-e-adulti-giubbotto-di-salvataggio-nuoto-galleggiante-aid-giubbotti-di-salvataggio/p-72578130-145872575%3Flanguage%3Dit%26ac%3Dcroud%26utm_source%3Dorganic_shopping%26utm_medium%3Dorganic&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECM0I&usg=AOvVaw09EnHVaoKQI35fpH88dDHh', 13, 1),
('https://www.google.it/url?url=https://www.hinelson.com/it/16315-39166-plastimo-cruise-entro-12-miglia-revisione-zatterera-salvataggio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECPEI&usg=AOvVaw06SGXv41z-YYOPnS6KE4J2', 13, 1),
('https://www.google.it/url?url=https://www.hinelson.com/it/16317-39178-zodiac-open-sea-iso-9650-senza-limiti-revisione-zatterera-salvataggio.html%3Fcountryselect%3DIT&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQgOUECOEJ&usg=AOvVaw15oSyZ5ljXiwalLk0adk6R', 15, 1),
('https://www.google.it/url?url=https://www.ibs.it/storie-dei-furetti-salvataggio-in-libro-rizzoli/e/9788817108119%3Flgw_code%3D1122-W9788817108119&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECNoI&usg=AOvVaw3Y9-YJ_be72h_ighpFcs0g', 13, 1),
('https://www.google.it/url?url=https://www.ibs.it/storie-dei-furetti-salvataggio-in-libro-rizzoli/e/9788817108119%3Flgw_code%3D1122-W9788817108119&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECNoI&usg=AOvVaw3Y9-YJ_be72h_ighpFcs0g', 15, 1),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECPQH&usg=AOvVaw2l3bqM3CmBH4icSEnrdRBh', 13, 1),
('https://www.google.it/url?url=https://www.magellanostore.it/giubbotto-salvataggio-antille-100-n-xxs-P7499.htm%3Fmid%3D7499&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECPQH&usg=AOvVaw2l3bqM3CmBH4icSEnrdRBh', 15, 1),
('https://www.google.it/url?url=https://www.svb-marine.it/it/spinlock-giubbotto-di-salvataggio-deckvest-6d-170n-bianco-nero.html&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECIkJ&usg=AOvVaw1d0pqDdl5JM5dAjHCtYEWj', 15, 1),
('https://www.google.it/url?url=https://www.tradeinn.com/waveinn/it/spinlock-giubbotto-di-salvataggio-6d-275n/137632452/p%3Futm_source%3Dgoogle_products%26utm_medium%3Dmerchant%26id_producte%3D11079954%26country%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECMAI&usg=AOvVaw1pFfwgSefWd6OP9sesEiVB', 13, 1),
('https://www.google.it/url?url=https://www.wetsuitoutlet.it/2022-crewsaver-crewfit-165n-giubbotto-salvataggio-manuale-sport-9710blm-nero-p-38246.html%3Fproducts_id%3D38246%26source%3Dgoogleshopping%26lang_ovd%3Dit&rct=j&q=&esrc=s&sa=U&ved=0ahUKEwjBt-_at-73AhVToHIEHdOoDLQQguUECJkI&usg=AOvVaw1-dGU7RqOyKmvrW2SvtSH4', 13, 1),
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
('admin', 'admin1', 'admin@admin.com', NULL, 3, 0),
('marc2000', 'africano2000', '2000mar@live.it', NULL, 4, 0),
('root', 'admin1', 'root@root.it', NULL, 2, 0);

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
  MODIFY `ID` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=16;

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
