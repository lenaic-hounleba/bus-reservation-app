-- phpMyAdmin SQL Dump
-- version 5.2.1deb1+deb12u1
-- https://www.phpmyadmin.net/
--
-- Hôte : localhost:3306
-- Généré le : jeu. 13 nov. 2025 à 00:37
-- Version du serveur : 10.11.11-MariaDB-0+deb12u1-log
-- Version de PHP : 8.2.29

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `e22507733_db1`
--

DELIMITER $$
--
-- Procédures
--
CREATE DEFINER=`e22507733sql`@`%` PROCEDURE `gestion_cr_reunion` (IN `p_reu_id` INT)   BEGIN
    DECLARE nb_participants INT;
    DECLARE titre_doc VARCHAR(255);

 
    SET nb_participants = nbpersonne(p_reu_id);

   
    IF nb_participants <> -1 THEN
        SET titre_doc = CONCAT('CR Réunion ', p_reu_id, ' - ', nb_participants, ' participants');

        IF NOT EXISTS (SELECT 1 FROM t_document_dcm WHERE reu_id = p_reu_id) THEN
            INSERT INTO t_document_dcm (dcm_intitule, dcm_url, reu_id)
            VALUES (titre_doc, 'CR en attente', p_reu_id);
        ELSE
            UPDATE t_document_dcm
            SET dcm_intitule = titre_doc
            WHERE reu_id = p_reu_id;
        END IF;
    END IF;
END$$

--
-- Fonctions
--
CREATE DEFINER=`e22507733sql`@`%` FUNCTION `liste_mails_participants` (`id_reunion` INT) RETURNS TEXT CHARSET utf8mb4 COLLATE utf8mb4_general_ci DETERMINISTIC BEGIN
    DECLARE mails TEXT;

    SELECT GROUP_CONCAT(p.pfl_email SEPARATOR ', ')
    INTO mails
    FROM t_participation_ptp AS ptp
    JOIN t_profil_pfl AS p ON ptp.cpt_id = p.cpt_id
    WHERE ptp.reu_id = id_reunion;

    RETURN mails;
END$$

CREATE DEFINER=`e22507733sql`@`%` FUNCTION `nbpersonne` (`p_ren_id` INT) RETURNS INT(11) DETERMINISTIC BEGIN
    DECLARE nb INT;
    IF NOT EXISTS (SELECT 1 FROM t_reunion_reu WHERE reu_id = p_ren_id) THEN
        RETURN -1;
    END IF;

    SELECT COUNT(*) INTO nb
    FROM t_participation_ptp
    WHERE reu_id = p_ren_id;

    RETURN nb;
END$$

DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_actualite_act`
--

CREATE TABLE `t_actualite_act` (
  `act_id` int(11) NOT NULL,
  `act_titre` varchar(100) NOT NULL,
  `act_image` varchar(100) NOT NULL,
  `act_date_ajout` datetime(1) NOT NULL,
  `act_contenu` varchar(1500) NOT NULL,
  `cpt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_actualite_act`
--

INSERT INTO `t_actualite_act` (`act_id`, `act_titre`, `act_image`, `act_date_ajout`, `act_contenu`, `cpt_id`) VALUES
(1, 'Ajout_nouveau_minibus', 'minibus_new.jpg', '2025-10-07 09:57:09.0', 'Un nouveau minibus 12 places a ete ajoute a la flotte.', 12),
(2, 'Annulation_sortie_Marseille', 'annul.jpg', '2025-10-07 09:57:09.0', 'La sortie a Marseille est annulee pour raisons meteo.', 12),
(4, 'Nouvelles_regles_reservation', 'rules.jpg', '2025-10-07 09:57:09.0', 'Publication des nouvelles regles de reservation.', 14),
(6, 'Assemblee_generale', 'ag.jpg', '2025-10-07 09:57:09.0', 'L assemblee generale aura lieu le 15 decembre.', 14),
(7, 'Hello actualité ', 'zdef.jpg', '2025-11-02 00:59:00.0', 'Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry\'s standard dummy text ever since the 1500s, when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting, remaining essentially unchanged. It was popularised in the 1960s with the release of Letraset sheets containing Lorem Ipsum passages, and more recently with desktop publishing software like Aldus PageMaker including versions of Lorem Ipsum.', 16);

-- --------------------------------------------------------

--
-- Structure de la table `t_compte_cpt`
--

CREATE TABLE `t_compte_cpt` (
  `cpt_id` int(11) NOT NULL,
  `cpt_pseudo` varchar(100) DEFAULT NULL,
  `cpt_mdp` char(64) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `cpt_etat` varchar(45) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_compte_cpt`
--

INSERT INTO `t_compte_cpt` (`cpt_id`, `cpt_pseudo`, `cpt_mdp`, `cpt_etat`) VALUES
(1, 'Invite1', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(2, 'Invite2', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(3, 'Invite3', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(4, 'Invite4', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(5, 'Invite5', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(6, 'Invite6', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(7, 'Invite7', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(8, 'Invite8', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(9, 'Invite9', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(10, 'Invite10', '4b3b24430adb04e512c7fdcdd75f4c090a6ab5a48ae2d71fdd1306d6abce931e', 'Actif'),
(11, 'john.paul', 'db9bba53bd2c624145c7b2fbe82916b86ac52add6dd165d1329cfc754867d2c2', 'Actif'),
(12, 'principal', 'db9bba53bd2c624145c7b2fbe82916b86ac52add6dd165d1329cfc754867d2c2', 'Actif'),
(13, 'paul.dupont', '19e1a7b8373ed21040d8aa8850a58ea7e0de892e2d8b9bc1f3bb139051974226', 'Actif'),
(14, 'anne.martin', '12db371a530f2bb14582554ed14b7ac4b0587a7aa78fb242df9e880ca0e128d0', 'Actif'),
(16, 'sophie.moreau', 'c789363a71e8a6693346c1db57c2eff069fa1c615dbbe4702e8f58a9581a3063', 'Actif'),
(17, 'adrien.bernard', '7641e40d02e9746ade897231845488f9c09e44c6df40fd4ab14645c7b77c9c57', 'Actif'),
(18, 'sophie.renaud', '65ca41eef8e319315124ce478067be1a3cc1ad610f70376193db7c940bd188b8', 'Actif'),
(19, 'quentin.muller', '65b55e2f11d3e1db1022a3f53d48cb11dd8358bed7b7d20e4d36e8c77070a049', 'Actif'),
(20, 'leo.mercier', '40b4984c7e7846edc8a2da41f2a1132a18a63bd692ee58f6af0cdf86fa0b8db1', 'Actif'),
(21, 'clara.garcia', 'a0b05812c55354086be103fe86d4cf3630c4f3c8984bda6efa47e380cd666c98', 'Actif'),
(22, 'helene.blanc', 'f62bac7d4014bd7a3d8b5bb87ec7679ef1b1dfc660272904d07fc3cc8d754f85', 'Actif'),
(23, 'sophie.fournier', '94f6705da1dfc78384590a8d1cc05e95569acec74caab3542a04ce0d7ea9ed3e', 'Actif'),
(24, 'laurent.simon', 'a374217e3af7553ee67161a1b754cd21e9ff219e74a8bd2a1cb2799ac663206b', 'Actif'),
(25, 'gregory.odet', '2c2a84df675504d889097a54aee28dc33b8aa12e4d92eb50aa2f1e97958d1b85', 'Actif'),
(26, 'nicolas.colin', 'c718a290e0bfa7c7748baec3d6a0fcbc31be9f5c07b6b0d179c267ed027e63af', 'Actif'),
(27, 'alice.moreau', 'f877d867705548a1030c3a454514127cd7502a98b2a35059b47c8322463609a6', 'Actif'),
(28, 'julien.simon', 'cc369b2a6407535bb5176deb80b1a95d7342665349ca23f9fa7e935a9b52a467', 'Actif'),
(29, 'hugo.noel', '960f6df8a48fd3de2ed312e66fee23ab32f755083c323f1a67b7f2136da9739b', 'Actif'),
(30, 'marion.rodriguez', '48062b6faa9ee5a590721a835b33a0a91eb5a89b3e7748a31c1599625ad740b0', 'Actif'),
(31, 'anais.renaud', '1526e5aee4e59397d02f72293106e35bf574cccdc70a1d7961473c7a2bf08ef9', 'Actif'),
(32, 'elodie.noel', 'b0b5d73cf6741fe8c2765b3a7f288f17717cbfac0a4ff110c6b92ab6561e5b31', 'Actif'),
(33, 'pierre.colin', '43ce499cf15b33063df3372dc48f5eafdfa0ca8e6d9bb6e98e2249eec2f6f13a', 'Actif'),
(34, 'julien.fournier', '26fc7b9f14e7e8dd73df5c28dc69697616542f59c830c7532a882adc47ce48f7', 'Actif'),
(35, 'adrien.dasilva', '21e2ed8428968b5d80655152b9e338a880aa7e531b593f4600862e802dba3b02', 'Actif'),
(36, 'emilie.martin', 'a43145c913244b1ab473c3c7601cbe4c025ba5ad711a33569b452dc0df9e891e', 'Actif'),
(37, 'gregory.boucher', '75b8f6fb76a2bfb549978eea6b320d83eee5003b1aaa43ae68ff989149b8c125', 'Actif'),
(38, 'pierre.martin', '127d168bf69377420cdba1cd029e42b452f13bdc8c82beb075204bb7f9c4c1d1', 'Actif'),
(39, 'samuel.bernard', '63f1bbd78db4108d6f09ac5785f8214a02c6b5a9b6b3b6f7a08411f25e955a9b', 'Actif'),
(40, 'marie.moreau', 'e859ae0aae672e423c1ccdafd79d793b488903ad61b294e2f38c29e2b3aebd0f', 'Actif'),
(41, 'emilie.faure', '5c82b88c157fe592f904e9482d69b3e96a1d4f5fcc96d12505d3f216710c1a64', 'Actif'),
(42, 'helene.rodriguez', '52e3b8fb7fc9a1272134a18151b49bf6bcafb4809192df814d0983be49242516', 'Actif'),
(43, 'thomas.odet', '42fc05fe6126a69e16390f860e50d4f30b399a15a2c81a4ae3f8ca3f4ffedd96', 'Actif'),
(44, 'leo.renard', '60a7eddb5000b48d32f66dc19c5d12c77aaeaa09cd12cf37b97fb41476b297c4', 'Actif'),
(45, 'isabelle.noel', 'c27c206e2650bc55302bf7fd9581ab1b4f1e383a9648860bde50f0c0c31a8ae8', 'Actif'),
(46, 'helene.leclerc', 'dec864aeb2d7d74073e97249ae13453e9208a60e0c1ade588228ecbd2b4b97dc', 'Actif'),
(47, 'mathieu.dasilva', '59691145619c0b1d92c5e389ee67377ab2a65bd06f212e24e2aa5e1099fa647f', 'Actif'),
(48, 'pierre.durand', '0d40c5b1d3d6957bf71191d3b2ed5aa7926213e3133aba4bbd9769ff0c4a8d1f', 'Actif'),
(49, 'gregory.dasilva', 'f8fd73fae9875d9a6ac516337c342330e22a76d68cbe3d5b9b4ff089faa98ebd', 'Actif'),
(50, 'sophie.bertrand', 'e5e73f6c63eac47c014623036e5c27cfdcca7a8cd88e0b975449bac7f9a1ea3e', 'Actif'),
(51, 'leo.simon', '5aee53cfbe88b76b2268c01ff3c19cbeb9f6772292b5d10f05805c000ff726dc', 'Actif'),
(52, 'alice.rousseau', '4f55865ab69a0096f7c2321f573bcf4fbb456ef1fd48599d72daabd0314ac061', 'Actif'),
(53, 'victor.perrin', '77ae9d1879bb974577f68d5f0304f90f589dc5cabba3cae7001e91c4e65ec53a', 'Actif'),
(54, 'mathieu.dupont', '03ffea83e4638a5b024a3a988044b220c152a4287936d3c91fd446ca48ad010a', 'Actif'),
(55, 'alex.moreau', '57ec484eaa3f20ac38d40d20702a4520f2f8a205c6b4afd7f4b7fe66f2210770', 'Actif'),
(56, 'samuel.lambert', '183b797278164276d4d404668a6017c5b4d7333b01033604829ac1bb09aff822', 'Actif'),
(57, 'lucie.faure', '2be6950ec3b7c9ff7f713c8164557cbcc16b2e0e2964e172985237fa59b1a472', 'Actif'),
(58, 'pierre.blanc', '98de5f8bddeddfa6a4191f5049fcc7622b4d77807f446d25a7cc6cbda7a97805', 'Actif'),
(59, 'camille.bertrand', '1f2accf0aad12f725e20397dbd116553d76abc7206a2713b7bafd09b8dfae929', 'Actif'),
(60, 'samuel.renaud', 'fd738ad22e9d5ea9227780bfe624d7df1340f5a93d755ad0faf446f1ccc7d9a9', 'Actif'),
(61, 'maxime.chevalier', 'c7fb3e6bc499efb1b2f3e4e68ea384b7dd9ff94d1bc1e69b675911676dbbef11', 'Actif'),
(62, 'hugo.martin', '2daf8e593640b6f308c2f0e608e1596ad062468d7b89faf088e3042ff67043c0', 'Actif'),
(63, 'samuel.hubert', '7bc3ec318dbf749add98dda6cabfdca955ef5f5636dea1c4d3124ad53f743b13', 'Actif'),
(64, 'adrien.faure', '121a48fd94884a51802cd5f6d5d0472d73c128670ebcc197eac374cdccdf1054', 'Actif'),
(65, 'manon.dasilva', 'ea24f8905211ca8c7c7ef54f94d087765999aa7ea32a88cf834d527d936245cd', 'Actif'),
(66, 'paul.dupont', 'f01764dd473707889589bc9abc083ddf24d87f386e919cacbe466ee747024d25', 'Actif'),
(67, 'alice.renaud', '9c45cad18aa390ce3cb426e6a2a2ce4c88bfb55f87371200851aecdd1dba9ed1', 'Actif'),
(68, 'lucie.rousseau', '43012a082e57208fdceb4097f0562b93c2faab1548646fa4463708bfa1d455f1', 'Actif'),
(69, 'maxime.renaud', 'b9ef219697700b3c8ef72907e55c53336df84d69db21414d088024a481001ae1', 'Actif'),
(70, 'leo.hubert', '6dba632075118ee5a263b0075c848348eca0e2680e5adbb07305bde9b7b11469', 'Actif'),
(71, 'samuel.leclerc', 'b6bcdda2bf5de4ce4b329dca248fb324fdbd348f0ec82c27d8c2a89b520b9fa1', 'Actif'),
(72, 'paul.bernard', '7da64688cbc8b9d448c156da1b2fca6bc4831cda18c8b0452303be1918f0c344', 'Actif'),
(73, 'clara.bertrand', 'f7064f17d966c06de4d5a46d96b487ff2aa876dab7792ab56da9896fa5e44ede', 'Actif'),
(74, 'lucie.bertrand', 'a24fb5c2cb72ad59d3c953375cd6292e4275ff9b56cb2831899e7f3afef00094', 'Actif'),
(75, 'marion.noel', '617c84c6992e984a07730e47787f7343de9883ca6ab301de781c9b183291e44d', 'Actif'),
(76, 'alex.odet', '13c9717f3a53a74b06050b7ff673f2c26ae6003359e9ed37a9c586b6b2ac7d68', 'Actif'),
(77, 'lucie.perrin', 'db395cecaf91efcf4b48668bf4d812819927dce2afa80bc8b41bd49ef1ad36ee', 'Actif'),
(78, 'laurent.rousseau', '74d5441d8e03053556019c27e15ffb3e70b9705ff964b54cdd291df1505a651b', 'Actif'),
(79, 'marie.blanc', 'c40f3ba27e16ce5d5e17341ee115ec37187873d7792f8a86946d479c2d011295', 'Actif'),
(80, 'nicolas.hubert', '3a6fc5f31adc8796ff2345fb42d1c8cb9c862b5c2ff47e48970e004f82fb21f3', 'Actif'),
(81, 'victor.bernard', 'ab5ff8f352c01f70384acda541e8a84979373c698a2f8752b06cb214058719bc', 'Actif'),
(82, 'lucie.gillet', 'fb80b27ff3c79ce34755c6b46fb5fb475310574f830428a515221e5209b8fba5', 'Actif'),
(83, 'leo.dasilva', 'f31c6fdd43996824cac97af0f004d96a46a5710ea553b2d1d2b4bf65d28cafff', 'Actif'),
(84, 'isabelle.rodriguez', '7eea903f1cb3e3d97421ce8c76c12445bc8feb8bba6536d5022534c358ccdea1', 'Actif'),
(85, 'adrien.rodriguez', 'dd4cbfbbd00001744a3a6da21e771bb8d989a7a1259286f7adff3f30d351e91a', 'Actif'),
(86, 'anais.dupont', 'e7d6954dc072f33e6debbe2e4144bd3297b52b3aa18b5dadcc54e3b36712eefe', 'Actif'),
(87, 'maxime.colin', '038a758c7131098654bb7c8dd7ebf476a654a16f80e1a222baf0a1f23c31406e', 'Actif'),
(88, 'sophie.durand', '6fd40c9500b5064c4d87dfc1feaa29b6ddb805499c9ae9bcc7f5ba197b48e17b', 'Actif'),
(89, 'marion.garcia', 'd9002ab0996bc202ac65591d86587045b62ba314a9944cda8b3e3e06c10f992b', 'Actif'),
(90, 'victor.simon', 'ac0389dcc856b1105f0a101bd81078e208fc7c4ec8dbf82cfc8d995bfa35e99d', 'Actif'),
(91, 'olivier.blanc', 'd5cd85157e984703c06d63e55c624764a9fea653d7398d36a19fc0f7964d1a7c', 'Actif'),
(92, 'gregory.hubert', 'be7f05a5c5fa8e7e5f35322cd9d25981276b6128fbeb75323d949ffd0da2bf26', 'Actif'),
(93, 'emilie.leclerc', 'a0a014c9d1c35eeb21bee68b44e2d28721d7675e8f825210b385709d846db874', 'Actif'),
(94, 'pierre.fournier', '8a1323aec7a68017c999c7444c8260b8746195df8e54e5d2ef3d4c5f0e4e56b3', 'Actif'),
(95, 'pierre.dupont', '407d41a5c8ff5ab78a6406d9624374c7ffd3a6c0e930c1c4424576ee79d42b18', 'Actif'),
(96, 'samuel.moreau', 'b6fbe2815fbd2f77ad4bedc62ea1d7139a24e60587752ca7538318d9cf814225', 'Actif'),
(97, 'marion.colin', '9b7f24183ef80f3028cbf86bc4c817dec6d8386ea88addf21b7721679ead6f7e', 'Actif'),
(98, 'thomas.boucher', 'd9fa6c6b9e393160755d9001e6dbeaa9918ded496300204abc7af2c48cdd7a52', 'Actif'),
(99, 'laurent.renaud', '2992da6a0f4cd9b67a3e8de8cb8dafa51a289644e323f2eb19427c5645e1cfe7', 'Actif'),
(100, 'paul.robin', 'bc7cb4c8532e4076ced21ea0bf12e55c7d5b680d6dec41017708dd23189aeaef', 'Actif'),
(101, 'alex.perrin', '72fbeb874cdb7e86ccc074914742a75b62fd6e317044bf2097209d81ff3728dd', 'Actif'),
(102, 'laurent.muller', '35eb1ce074d811354ac89902ad0cb8a3983d4a72d8c0808ff64897f07a7d2ae0', 'Actif'),
(103, 'mathieu.bertrand', '0cb7c7219a58e8092363ceb71969941f340b1cc4705589e70242dfba25d0b272', 'Actif'),
(104, 'marion.muller', '1a4b6dcbadaa8b53a72c87676e0aba9fde47b60ca6e3ad1d6d4631ec5d9c544e', 'Actif'),
(105, 'paul.bertrand', '19b283f52fec2f13c44daffde7d12a8a50a37920996caab3c7e234a4d9747f53', 'Actif'),
(106, 'anais.colin', '0b0b7125c0808b7dd180edb8182d1d23eddd39c57366e137b738fb7245381c34', 'Actif'),
(107, 'olivier.boucher', '6d1315f39ab60422e461d4f08ed78a953cd329105cccd4f61d0a35f1a68d47bb', 'Actif'),
(108, 'hugo.bertrand', '7a7ff7da0000fdd12f6e414dbf97f014004217f6cc6c42e4895b4934d52c5899', 'Actif'),
(109, 'marion.moreau', '0eed41d41aeb94b81db97c79d7d4dedbc9956f629951c1695ac2e5b726e5f139', 'Actif'),
(110, 'mathieu.moreau', '71f9b8298850f8059e50556c77f2d0204964b487ce4ca2e5cab8c9c88205bd85', 'Actif'),
(111, 'sophie.dupont', '161a2d6368a156a67572fd3cce73d4b8ec8e6bf2688742a4f2bcd12f7153a9a7', 'Actif'),
(112, 'hugo.muller', '83f8f19769784f7f24ccdf6db1dd7258b7777e4a452f21322cdd63adcc6b0bfe', 'Actif'),
(113, 'manon.chevalier', '7baa4433e599839dcbb8f4e156444b7d20c81d1ca76326f9f527060d98b0d8b3', 'Actif'),
(114, 'victor.renard', '339e6b94963a937a23a72d2c47b91aae2fbd6120a9282a92e336a14d8b778024', 'Actif'),
(115, 'olivier.gillet', 'e81c5d58c7669b3c6d379f17f7eee6afbb2786bbebf8ef83606201b6f2dd2eb7', 'Actif'),
(116, 'elodie.simon', '04541b982fc95e13a31ff239b6ca02528f338f77ed19668248d9a037541eaf22', 'Actif'),
(117, 'marion.perrin', '30bdb634a0da7315502d0533184128e9a297174f9ecf3a924c5fce43536e1f1c', 'Actif'),
(118, 'marie.colin', 'f681cbc94477a26b51d83d398b793621859d07e0b952020743ac72cfbfcc7a3d', 'Actif'),
(119, 'gregory.simon', '43546b85908b51599d4ed82e8aaf5dc39d3054f91277984bbd4fd9ae5e087199', 'Actif'),
(120, 'emilie.renard', '6f087f37afc60253449099d343911c3dfa54c2e05c7a257432ebfc306a0e3f09', 'Actif'),
(121, 'hugo.moreau', '880c0cc61113a547eb9e7057e4a4e30ed43c4ea334d8e894fc62cd12a2a441c2', 'Actif'),
(122, 'victor.faure', 'd0f6ce4c2ba2a8aca111e4d0a8212fb4071a16c7924a16019dc2d999dfd9d1a2', 'Actif'),
(123, 'alice.martin', 'a2b979ff5b5eb0b6eeae1617fbf3e24309a566f4767c14361871112589b2b110', 'Actif'),
(124, 'anais.odet', '4269332e910ffd4e6807699fe405b2d986a9826f78197ee3a270a97d4b61701a', 'Actif'),
(125, 'helene.boucher', 'e7170a83c91e993c20e3c501ba8cea5f952e726628ef850bcc898edfc9ebedc9', 'Actif'),
(126, 'alex.garnier', '45a774e1537e27b77bd3749cff355a80f67fdfc96aa7e68b6c2610b0e4090700', 'Actif'),
(127, 'gregory.faure', '77e809db357857b25127884cbdbc43f7943af2d51ae3d461912a3f98c33614f7', 'Actif'),
(128, 'emilie.muller', '650bdf39d5fd1130ea5b424d63f5324d668c648c02041f6d1ad0e8c1070c2c66', 'Actif'),
(129, 'gregory.leclerc', '8035cc42ef7e6ce98ebe90bfdc58182fbe827b8af00745b3f9fea95ba5bdf8cb', 'Actif'),
(130, 'alex.hubert', '263b581888c490e0bd0ea7a21e9821c7a610b16d6d58d781f83dabaadaddbcf8', 'Actif'),
(131, 'julien.noel', 'ad809abd0de7cdc1c5d242973af0be2af75587ee490bee6169d5028fce508c02', 'Actif'),
(132, 'emilie.chevalier', 'f4ca7c831830e9f1bca2fb9b13e1d0beaee69a08444ee95e747f0f7eb186ff03', 'Actif'),
(133, 'helene.robin', '4c78601dc936beffce5d473e239b33ed363805c4759f94ab28d3967fc9866c38', 'Actif'),
(134, 'manon.dupont', 'd71f4ff25953359e012bf4f3c3ce97ea5f9ce6f283d9be968ddd15d1d16dcd8e', 'Actif'),
(135, 'helene.noel', '7eaf5078ff07f04ae716839ef1e4adc731fbd690cb5b3ab3791eabf8eccce562', 'Actif'),
(136, 'isabelle.dupont', 'a9488abf0091b6e5f1ad9d6d868bcec0afd97655d298fc87597f73b9e16b1d28', 'Actif'),
(137, 'marion.bernard', '4add71815860d14f66fa4f9b7ed1f5c40c98b14b154e1610acb21e0087c10b77', 'Actif'),
(138, 'helene.garnier', '636312ce1e3c4644f81f0801ae9ae29baa58796936cd68283d677a86bd336339', 'Actif'),
(139, 'helene.colin', '94d5dc77e5fbb6b26865c201f0906f8f27157d8c845de4692e4dc5cc8597f18c', 'Actif'),
(140, 'nicolas.boucher', 'b17abb07d4db1ddb95b796719d2abb8a33d5e3a9f5b5369809a20246bfeba4ad', 'Actif'),
(141, 'quentin.gillet', '206cfacc844ccb0c2db8539f504c939f9d39ffa5e2cebd5493fece56c05e1c6e', 'Actif'),
(142, 'samuel.bertrand', '923f71fbacfa214f478668e7dd671e3ac6d375b75f173a793932eecc13f740e6', 'Actif'),
(143, 'olivier.durand', 'a7d3ccae9bb13d675568ebd83781597adda0282f46b56b574ca3fd0d5e3c6c92', 'Actif'),
(144, 'julien.perrin', '11c3c442166d6309725a0bb61e0a082506e38af2fa3dc80c045aeef643bb6b6e', 'Actif'),
(145, 'isabelle.dasilva', '61a41e250552dd8ef0239f8d9307692f52627a57758c1fa1a08894e01a654e2f', 'Actif'),
(146, 'clara.leclerc', 'a67891347b2d0d7bbc1d0e9a016ab2a575451db25c30cfd5c89a2ed00591ba1a', 'Actif'),
(147, 'olivier.hubert', 'f80fd96b4dcce17ff927605948dfc4fb5308e68a84f9008993b0c3a4fce53731', 'Actif'),
(148, 'isabelle.renaud', '6f91a9a67ceda05cbfe0036c162ad7b0ba263f2d03029f0d9cdc31ebbebe5bc2', 'Actif'),
(149, 'isabelle.hubert', 'f139920311397781790251edb929829871ef576390c610ff33a890068c90fae1', 'Actif'),
(150, 'quentin.mercier', '5f315066897c5ba1418d3c77d109ae743246b2c0df5a607e0024bc6afcb0dcac', 'Actif'),
(151, 'thomas.dasilva', '4da035bc3d1dbf12c67e8fce33c1ec6968c055824b310f90934a4e23e0ec14c7', 'Actif'),
(152, 'victor.mercier', '63eb1d14f99d21213cbc027c38566e1153fe3bb2b7e936fc098159a77b95c35b', 'Actif'),
(153, 'julien.garcia', 'cc1cde6f777afaec591f3a8fa09b318846460dcda13ca63d5f6963acef0e1e2a', 'Actif'),
(154, 'alice.dasilva', '389e5fcbf2c70196d390b8d1500b8c59bfa0f59935a3075cc9b4addb0726dca9', 'Actif'),
(155, 'julien.rousseau', '5793746df413a31ca46d15d8fadfc4634ec37c679f2fa03eb6cb555c6fd9a1c5', 'Actif'),
(156, 'marion.boucher', '8fb5f3afe862d0e6527ac405d4ba167eef9ba8038a2ad08e53199b9e1a5cc507', 'Actif'),
(157, 'clara.renaud', '1bfc7cc3c98236dbdb08de43bfe81af1403029d11d45e3fd1c7ef72569a49f49', 'Actif'),
(158, 'emilie.rousseau', '5cb2119c9608e629734745f32c1c4bab7bc41bba14529b1a6692bb8769883ff0', 'Actif'),
(159, 'mathieu.bernard', 'c5287f127c5cc288efae7f1bb98dd600427a9cb16b745ac06d7d8643d3bce0e2', 'Actif'),
(160, 'lucie.renaud', '15e97a768e906f5ca49db760f67ea7a2ccdfeaaa12c2ac59940bd268e3a4ce36', 'Actif'),
(161, 'marie.rousseau', 'db4b4861cb8ead8a3ece3db115de02ce9dd7de9f7493a3429ffa1bd7a4e473e6', 'Actif'),
(162, 'laurent.leclerc', '85c701a03ee13ddc3da36032da8e516d4a8ea78e7f4613b31445a022fc1ee975', 'Actif'),
(163, 'emilie.durand', 'b654d88bdc6f6ea38ffb673a35a2982423542869deaa8e66f4de2ffaf7f13262', 'Actif'),
(164, 'adrien.simon', '131fe2e44e74d418567d45a244b34247f211faa92d4d801a798a409937373b52', 'Actif'),
(165, 'hugo.lambert', 'facde412201280ef398760e864b96ce0895cb7ca344efcc5e9aed98c2dee4857', 'Actif'),
(166, 'camille.colin', '588a774ac19da5fbf53494826722d51389e3bdb11eb074c8eca2902a920bcdfe', 'Actif'),
(167, 'adrien.bertrand', '86dea8de0c5ee8c4b26bf2d33fec50b4fb942ca7e6033445bb26cea746e2211e', 'Actif'),
(168, 'nicolas.moreau', '08d7fb48a8a31013a96e387c8565d4f8bca807a27ec97c0123f6564743a02bec', 'Actif'),
(169, 'marie.mercier', 'b33153a56e051338850b803c4534b4076d24df6de417e52e4734e7a42130fd00', 'Actif'),
(170, 'elodie.odet', '0f4a03440c2fdc2ebc72860402db3fc6533215e486f56de360a9b97c4a516367', 'Actif'),
(171, 'maxime.mercier', '40abed6227ca7ff7328f0f518ba117690e4eed1daf3df58f4c10edb4a405083c', 'Actif'),
(172, 'emilie.bertrand', 'bf188c830dd10aaa642e57eaaa7b954567ec290acc0639c975ab5dcbf7ac45a8', 'Actif'),
(173, 'julien.leclerc', 'd877a7c0364194f6f7b124c6126de9b017206041d927180e6986807e2aa0ad76', 'Actif'),
(174, 'manon.rousseau', '0db8053ef2b05aedc31bed44a8abca49fe388c65b3c9d0267ef3fa013076bde4', 'Actif'),
(175, 'alice.simon', '84ef931b2fb62699e436c8f8a321a61fd28709da79ea9f38f1e5a357f87fa838', 'Actif'),
(176, 'adrien.boucher', 'fa4bb4deef1a47ca405e1cc4ec4b4db74296931bd0d2a7e4a2f86936428ed6fa', 'Actif'),
(177, 'anais.garcia', '5950326485951298ecac757307b10e4c5ccc408bbab20003f345815bec93be54', 'Actif'),
(178, 'julien.durand', 'e1e6976e2fb387f3a152acfe82f7f2c9fb66162d0497f4445b98549ef0553a56', 'Actif'),
(179, 'elodie.rousseau', '4bc257ef33624cdabef51d897b99c3a7ca546ed74b292407be49737f64ba0b81', 'Actif'),
(180, 'alice.chevalier', '3750ca764133a0bca1a1ae043cd6b8fbf53a88098e01e9420a6ccc5dc068376e', 'Actif'),
(181, 'julien.mercier', '606b1057c27f0ff5fea4ad8e6668dc0c0f345b9ec141caf89a19badb33ab49f6', 'Actif'),
(182, 'marie.rodriguez', '9aeb60f020c47f839e9ee54d000edd4b4fcdeabab633e18d146c4b36ccf9d97c', 'Actif'),
(183, 'quentin.dupont', '74b951b7aef310d2283abec9e1725030fa194035c56e141ada8208d2ed193a9c', 'Actif'),
(184, 'manon.perrin', 'd026d5cf1c501828f82cfc07264182eeae5cf9409bac18f09e1e9414fb99cc53', 'Actif'),
(185, 'clara.noel', 'afede902c470e414ee9acbfbc0dd6a5014b40ec846752863a5022d020c03bcac', 'Actif'),
(186, 'mathieu.lambert', '22a5dac270b47a4aae3e36123c90850a50a4faa48c7cd2ac842d000c4b6d18c4', 'Actif'),
(187, 'nicolas.bertrand', '5cb2013361b236ed3d2c4119c9c861cdb12b3fc80e8385e4db0022ef809717ef', 'Actif'),
(188, 'julien.lambert', '450d2763d9b69d0513ce49a88dbb3c423365f19a94c354af5cbc26125f90181c', 'Actif'),
(189, 'samuel.perrin', '13175b4b84c042559a50ff43f9208bf5a8ac9f7f7f6340a8af1e29252dfb230a', 'Actif'),
(190, 'maxime.fournier', 'e9e04c869e6d18844b7943030a71cad9dc1cdd29b121b7f458f4ca6e54a6f712', 'Actif'),
(191, 'adrien.odet', 'e0f54b667b1979f5a287f32e264af294285ff9f22f4f4baa3c646310c0bd925f', 'Actif'),
(192, 'hugo.robin', '5523c96663c9e69a4f7559b8449c40fd6af596d4cc8d04fe88456989d01dc9e8', 'Actif'),
(193, 'olivier.garcia', '8dc737a92737d78bd1d26f87df652dbb43580af030bdc288927042c59e40a897', 'Actif'),
(194, 'clara.moreau', '8d9b9f0e27b990fc99b9fef62a3cf02a98b242efe93f4560cd27b738a4a90284', 'Actif'),
(195, 'adrien.colin', 'cbe5204c79d61a404a9a84230134c5e5f64944493de02188fa5eaf6548c8d586', 'Actif'),
(196, 'alice.rodriguez', '7018637397cc600aa2ca6f70da1548071a0f5360bb932bbe2e334e38fc4cf9ec', 'Actif'),
(197, 'hugo.faure', '7d3ee30aa245a5a6acb687be9d57ba31d3df71f0ecf85e0ff37d9fee9d9757ab', 'Actif'),
(198, 'gregory.robin', '61dc1709e9388e141b42a494b6277b59a38d72f46096459f921fac142147cb2d', 'Actif'),
(199, 'mathieu.hubert', '7df4c279ce31355869e2ab5aa9c56677eb95bd5c189196b1a8d392b89b2679c4', 'Actif'),
(200, 'isabelle.boucher', 'f8953a56bcd864c5578ab231896baaae7971313fb11e152de5c59c20e01dcf92', 'Actif'),
(201, 'manon.garnier', '3bed37c8b4d6eb5be262b584c53f6996c1218ecc9e2b432d8aa175c1268aec72', 'Actif'),
(202, 'elodie.lambert', 'eda284fe78fb68341ad95e10aa52950df66792d97c84222a21aefec53a1a3838', 'Actif'),
(203, 'pierre.simon', 'f7cb37b755d8cd1ab99e557d65875176b1152dbfd544a16a8b13b640fd98af06', 'Actif'),
(204, 'alice.hubert', '111ef8487c6a59c6e5f46d399d0c190251ced2606ec61bb77ad51a0a17992faa', 'Actif'),
(205, 'manon.durand', '6fa883b3ebcc1e08c54626046337977469d2281a3c356ef38b347a3bd554f180', 'Actif'),
(206, 'samuel.simon', '721f1fc2d23c9afaa33a93c7706bfe2ee0071f8da44fd71f53517d70eadb7607', 'Actif'),
(207, 'gregory.martin', '147834122cf8ce017dd07118b6f733fbef3993b6fe9c1662e2f3e2bfe814f330', 'Actif'),
(208, 'manon.blanc', '0ffeae71390b565e3cd06f8eb210fbd5eb2c79888969eea7b51e9da458e8d3db', 'Actif'),
(209, 'adrien.moreau', '7015b10b4a04faaa8f9f8ed62266311a8ba346f5f627551d3b0be5824fc6dade', 'Actif'),
(210, 'paul.lambert', 'b97f885a403ae48612fd5db7f97ad6c42212d5f28f575e4afba0abd2e2156b05', 'Actif'),
(211, 'pierre.renaud', '1a855c8ea2d90f84802021f52f7c8fff0a32834f4c64b6184b9395e56a6f89fa', 'Actif'),
(212, 'hugo.leclerc', '3366e88b12fe189c0448ac8067a896bb9ca57576f605625f304234bcb7c2951a', 'Actif'),
(213, 'nicolas.garnier', '10fe0f31e60fdcd442f263ad807d43550e8a7d21a3674708db35ceea3e5138f1', 'Actif'),
(214, 'clara.boucher', '06a1391cd3cae68402bbe52a69f937d6748a86cb3ca5f38ad6ded468217f96dc', 'Actif'),
(215, 'samuel.chevalier', 'c2e29b8b4fc906b9996fadca09b5b8cf15919ff22e22c26bc762bf8301f722e2', 'Actif'),
(216, 'sophie.garcia', 'e61613f998654c76c93b3e8f0e51d52de75fae68e764843e64f3cdb77e8424a2', 'Actif'),
(217, 'jule.paul', 'defrgefrbgfrgfdfzedsvgfr', 'Actif'),
(218, 'jean.dupont', '97d73cc480ceda4fd641964549d5b946ff539496900c65f9c7b41bbcd8014cb8', 'Actif'),
(219, 'Invite 11', '9ba3541e3235338dcd4105ff59ea837ae676ae9a073f07bf40924a1db16b9fd3', 'Actif');

--
-- Déclencheurs `t_compte_cpt`
--
DELIMITER $$
CREATE TRIGGER `trg_delete_admin` BEFORE DELETE ON `t_compte_cpt` FOR EACH ROW BEGIN
    DECLARE id_admin_principal INT;
    DECLARE statut_utilisateur VARCHAR(50);

    -- 1️⃣ Récupérer le statut du profil lié au compte supprimé
    SELECT pfl_statut INTO statut_utilisateur
    FROM t_profil_pfl
    WHERE cpt_id = OLD.cpt_id
    LIMIT 1;

    -- 2️⃣ Récupérer l'identifiant du compte administrateur principal
    SELECT cpt_id INTO id_admin_principal
    FROM t_compte_cpt
    WHERE cpt_pseudo = 'principal'
    LIMIT 1;

    -- 3️⃣ Si le compte supprimé est bien un administrateur
    IF statut_utilisateur = 'Administrateur' THEN

        -- Supprimer toutes les actualités qu'il a publiées
        DELETE FROM t_actualite_act
        WHERE cpt_id = OLD.cpt_id;

        -- Réaffecter ses réponses aux messages au compte principal
        UPDATE t_message_msg
        SET cpt_id = id_admin_principal
        WHERE cpt_id = OLD.cpt_id;

    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_document_dcm`
--

CREATE TABLE `t_document_dcm` (
  `dcm_id` int(11) NOT NULL,
  `dcm_intitule` varchar(255) DEFAULT NULL,
  `dcm_url` varchar(100) NOT NULL,
  `reu_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_document_dcm`
--

INSERT INTO `t_document_dcm` (`dcm_id`, `dcm_intitule`, `dcm_url`, `reu_id`) VALUES
(1, 'CR Réunion 1 - 2 participants - CR mis en ligne le 21/10/2025', 'truc.pdf', 1),
(2, 'CR Réunion 2 - 2 participants', 'docs/ag_2025.pdf', 2),
(4, 'CR Réunion 2 - 2 participants', 'docs/annexe_ag.pdf', 2),
(6, 'CR Réunion 5 - 1 participants - CR mis en ligne le 21/10/2025', 'CR_reunion5.pdf', 5);

--
-- Déclencheurs `t_document_dcm`
--
DELIMITER $$
CREATE TRIGGER `trg_mise_en_ligne_cr_pdf` BEFORE UPDATE ON `t_document_dcm` FOR EACH ROW BEGIN
    -- Vérifie si le nouveau fichier est un PDF et si l'ancien était "CR en attente"
    IF NEW.dcm_url LIKE '%.pdf' AND OLD.dcm_url = 'CR en attente' THEN
        SET NEW.dcm_intitule = CONCAT(
            OLD.dcm_intitule,
            ' - CR mis en ligne le ',
            DATE_FORMAT(NOW(), '%d/%m/%Y')
        );
    END IF;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_etat_ett`
--

CREATE TABLE `t_etat_ett` (
  `rsc_id` int(11) NOT NULL,
  `idp_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_etat_ett`
--

INSERT INTO `t_etat_ett` (`rsc_id`, `idp_id`) VALUES
(1, 1),
(1, 6),
(2, 1),
(2, 7),
(3, 3),
(3, 8),
(5, 4),
(5, 5),
(5, 8),
(6, 5);

-- --------------------------------------------------------

--
-- Structure de la table `t_indisponibilite_idp`
--

CREATE TABLE `t_indisponibilite_idp` (
  `idp_id` int(11) NOT NULL,
  `idp_date_debut` datetime(1) NOT NULL,
  `idp_date_fin` datetime(1) NOT NULL,
  `idp_statut` varchar(45) NOT NULL,
  `idp_commentaire` varchar(600) DEFAULT NULL,
  `mtf_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_indisponibilite_idp`
--

INSERT INTO `t_indisponibilite_idp` (`idp_id`, `idp_date_debut`, `idp_date_fin`, `idp_statut`, `idp_commentaire`, `mtf_id`) VALUES
(1, '2025-01-15 08:00:00.0', '2025-01-16 18:00:00.0', 'Terminee', 'Revision moteur plaquettes frein', 1),
(3, '2025-06-10 00:00:00.0', '2025-06-12 23:59:00.0', 'Terminee', 'Nettoyage complet interieur et exterieur', 6),
(4, '2025-10-05 08:00:00.0', '2025-10-08 18:00:00.0', 'En cours', 'Remplacement batterie et diagnostic', 2),
(5, '2025-10-20 09:00:00.0', '2025-10-20 12:00:00.0', 'En cours', 'Controle technique rapide', 4),
(6, '2025-11-02 07:00:00.0', '2025-11-04 19:00:00.0', 'Future', 'Revision pre hivernage', 1),
(7, '2025-12-01 08:00:00.0', '2025-12-03 18:00:00.0', 'Future', 'Reparation suite accident mineur', 3),
(8, '2026-01-10 08:00:00.0', '2026-01-12 18:00:00.0', 'Future', 'Nettoyage profond apres evenement', 6);

-- --------------------------------------------------------

--
-- Structure de la table `t_inscription_isc`
--

CREATE TABLE `t_inscription_isc` (
  `cpt_id` int(11) NOT NULL,
  `res_id` int(11) NOT NULL,
  `isc_date` datetime(1) NOT NULL,
  `isc_role` varchar(20) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_inscription_isc`
--

INSERT INTO `t_inscription_isc` (`cpt_id`, `res_id`, `isc_date`, `isc_role`) VALUES
(18, 21, '2025-10-07 09:58:20.0', 'Conducteur'),
(18, 31, '2025-11-02 22:23:12.0', 'Conducteur'),
(20, 3, '2025-10-07 09:58:20.0', 'Conducteur'),
(22, 13, '2025-10-07 09:58:20.0', 'Passager'),
(22, 15, '2025-10-07 09:58:20.0', 'Passager'),
(22, 19, '2025-10-07 09:58:20.0', 'Passager'),
(22, 27, '2025-10-07 09:58:20.0', 'Passager'),
(23, 14, '2025-10-07 09:58:20.0', 'Passager'),
(28, 27, '2025-10-07 09:58:20.0', 'Passager'),
(33, 8, '2025-10-07 09:58:20.0', 'Passager'),
(35, 2, '2025-10-07 09:58:20.0', 'Passager'),
(41, 5, '2025-10-07 09:58:20.0', 'Passager'),
(41, 23, '2025-10-07 09:58:20.0', 'Conducteur'),
(41, 24, '2025-10-07 09:58:20.0', 'Passager'),
(48, 8, '2025-10-07 09:58:20.0', 'Passager'),
(48, 26, '2025-10-07 09:58:20.0', 'Conducteur'),
(50, 7, '2025-10-07 09:58:20.0', 'Passager'),
(51, 12, '2025-10-07 09:58:20.0', 'Passager'),
(53, 12, '2025-11-02 22:25:41.0', 'Conducteur'),
(53, 24, '2025-10-07 09:58:20.0', 'Conducteur'),
(53, 32, '2025-11-02 22:25:41.0', 'Conducteur'),
(54, 18, '2025-10-07 09:58:20.0', 'Passager'),
(66, 30, '2025-10-07 09:58:20.0', 'Passager'),
(67, 20, '2025-10-07 09:58:20.0', 'Passager'),
(69, 7, '2025-10-07 09:58:20.0', 'Conducteur'),
(70, 6, '2025-10-07 09:58:20.0', 'Conducteur'),
(72, 23, '2025-10-07 09:58:20.0', 'Passager'),
(80, 8, '2025-10-07 09:58:20.0', 'Conducteur'),
(81, 19, '2025-10-07 09:58:20.0', 'Passager'),
(81, 30, '2025-10-07 09:58:20.0', 'Conducteur'),
(88, 21, '2025-10-07 09:58:20.0', 'Passager'),
(95, 18, '2025-10-07 09:58:20.0', 'Passager'),
(96, 11, '2025-10-07 09:58:20.0', 'Passager'),
(101, 30, '2025-10-07 09:58:20.0', 'Passager'),
(103, 17, '2025-10-07 09:58:20.0', 'Passager'),
(106, 1, '2025-10-07 09:58:20.0', 'Passager'),
(111, 25, '2025-10-07 09:58:20.0', 'Passager'),
(114, 29, '2025-10-07 09:58:20.0', 'Conducteur'),
(116, 15, '2025-10-07 09:58:20.0', 'Passager'),
(119, 5, '2025-10-07 09:58:20.0', 'Conducteur'),
(119, 26, '2025-10-07 09:58:20.0', 'Passager'),
(120, 21, '2025-10-07 09:58:20.0', 'Passager'),
(121, 13, '2025-10-07 09:58:20.0', 'Conducteur'),
(126, 15, '2025-10-07 09:58:20.0', 'Conducteur'),
(127, 17, '2025-10-07 09:58:20.0', 'Conducteur'),
(128, 3, '2025-10-07 09:58:20.0', 'Passager'),
(128, 20, '2025-10-07 09:58:20.0', 'Passager'),
(131, 6, '2025-10-07 09:58:20.0', 'Passager'),
(134, 1, '2025-10-07 09:58:20.0', 'Passager'),
(136, 12, '2025-10-07 09:58:20.0', 'Conducteur'),
(138, 20, '2025-10-07 09:58:20.0', 'Conducteur'),
(142, 27, '2025-10-07 09:58:20.0', 'Conducteur'),
(147, 2, '2025-10-07 09:58:20.0', 'Conducteur'),
(148, 11, '2025-10-07 09:58:20.0', 'Passager'),
(151, 3, '2025-10-07 09:58:20.0', 'Passager'),
(151, 11, '2025-10-07 09:58:20.0', 'Conducteur'),
(152, 26, '2025-10-07 09:58:20.0', 'Passager'),
(153, 12, '2025-10-07 09:58:20.0', 'Passager'),
(158, 18, '2025-10-07 09:58:20.0', 'Conducteur'),
(163, 9, '2025-10-07 09:58:20.0', 'Conducteur'),
(168, 29, '2025-10-07 09:58:20.0', 'Passager'),
(170, 14, '2025-10-07 09:58:20.0', 'Conducteur'),
(172, 5, '2025-10-07 09:58:20.0', 'Passager'),
(174, 19, '2025-10-07 09:58:20.0', 'Conducteur'),
(176, 24, '2025-10-07 09:58:20.0', 'Passager'),
(182, 23, '2025-10-07 09:58:20.0', 'Passager'),
(187, 6, '2025-10-07 09:58:20.0', 'Passager'),
(191, 9, '2025-10-07 09:58:20.0', 'Passager'),
(192, 2, '2025-10-07 09:58:20.0', 'Passager'),
(192, 7, '2025-10-07 09:58:20.0', 'Passager'),
(192, 25, '2025-10-07 09:58:20.0', 'Passager'),
(196, 1, '2025-10-07 09:58:20.0', 'Conducteur'),
(198, 14, '2025-10-07 09:58:20.0', 'Passager'),
(200, 17, '2025-10-07 09:58:20.0', 'Passager'),
(207, 25, '2025-10-07 09:58:20.0', 'Conducteur'),
(214, 9, '2025-10-07 09:58:20.0', 'Passager'),
(216, 29, '2025-10-07 09:58:20.0', 'Conducteur');

-- --------------------------------------------------------

--
-- Structure de la table `t_message_msg`
--

CREATE TABLE `t_message_msg` (
  `msg_id` int(11) NOT NULL,
  `msg_code` char(20) CHARACTER SET utf8mb3 COLLATE utf8mb3_bin NOT NULL,
  `msg_contenu` varchar(600) DEFAULT NULL,
  `msg_email` varchar(150) NOT NULL,
  `msg_reponse` varchar(600) DEFAULT NULL,
  `cpt_id` int(11) DEFAULT NULL,
  `msg_date` datetime DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_message_msg`
--

INSERT INTO `t_message_msg` (`msg_id`, `msg_code`, `msg_contenu`, `msg_email`, `msg_reponse`, `cpt_id`, `msg_date`) VALUES
(1, 'A3S8KE2WT1Q3TMY4GPYW', 'Bonjour je souhaite rejoindre votre association pouvez vous m expliquer les conditions d adhesion', 'visitor1@example.com', '', NULL, '2025-10-07 10:03:28'),
(2, 'SSBZRAD5SOWOMQIGCT2C', 'Bonsoir je voudrais savoir si on peut reserver le minibus pour la sortie de samedi', 'visitor2@example.com', '', NULL, '2025-10-07 10:03:28'),
(3, 'XIFSU0LMI8X76RKQ4SVH', 'Bonjour est ce que vous acceptez les nouveaux benevoles pour le projet social', 'visitor3@example.com', '', NULL, '2025-10-07 10:03:28'),
(4, '3EJOZ9XFZAQ8H3XQYXGO', 'Bonjour pouvez vous me donner des informations sur les tarifs de location', 'visitor4@example.com', '', NULL, '2025-10-07 10:03:28'),
(5, '4B9UOE3T0HICCT5HGP8I', 'Je suis interesse pour participer a la prochaine sortie comment m inscrire', 'visitor5@example.com', 'Bonjour, merci pour votre message. Vous pouvez venir assister à notre prochaine réunion avant de vous inscrire officiellement.', 1, '2025-10-07 10:03:28'),
(6, 'Y3X80J0G50RCXN22PXGX', 'Merci pour l organisation de la sortie c etait tres bien', 'member1@example.com', '', 13, '2025-10-07 10:03:28'),
(7, 'WDZRMH3FNBDVPINE9NNO', 'Le vehicule Renault a encore une anomalie le phare arriere ne fonctionne pas', 'member2@example.com', '', 13, '2025-10-07 10:03:28'),
(8, 'JARJI8QLHBIAWPUBLQDI', 'Peut on avoir la liste des participants pour la prochaine sortie', 'member3@example.com', '', 14, '2025-10-07 10:03:28'),
(9, '07HE42X6G26OC7T3BD4Z', 'J ai un souci de connexion je ne recois pas le code de verification', 'member4@example.com', '', 14, '2025-10-07 10:03:28'),
(10, 'G52EFUJEIR9UY7S361GH', 'Proposition organiser une formation secourisme pendant la prochaine sortie', 'member5@example.com', '', 14, '2025-10-07 10:03:28'),
(11, 'QWERTYUIOPASDFGHJKLZ', 'Bonjour, je souhaiterais connaître les conditions pour participer à une sortie.', 'visiteur@example.com', NULL, NULL, '2025-11-02 02:09:25');

-- --------------------------------------------------------

--
-- Structure de la table `t_motif_mtf`
--

CREATE TABLE `t_motif_mtf` (
  `mtf_id` int(11) NOT NULL,
  `mtf_intitule` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_motif_mtf`
--

INSERT INTO `t_motif_mtf` (`mtf_id`, `mtf_intitule`) VALUES
(1, 'Revision_moteur'),
(2, 'Panne_batterie'),
(3, 'Accident_mineur'),
(4, 'Probleme_admin'),
(5, 'Vidange_periodique'),
(6, 'Nettoyage_complet');

-- --------------------------------------------------------

--
-- Structure de la table `t_participation_ptp`
--

CREATE TABLE `t_participation_ptp` (
  `cpt_id` int(11) NOT NULL,
  `reu_id` int(11) NOT NULL,
  `ptp_date_inscription` datetime(1) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_participation_ptp`
--

INSERT INTO `t_participation_ptp` (`cpt_id`, `reu_id`, `ptp_date_inscription`) VALUES
(12, 1, '2025-10-07 09:57:33.0'),
(15, 1, '2025-10-07 09:57:33.0'),
(16, 2, '2025-10-07 09:57:33.0'),
(30, 5, '2025-10-09 14:59:09.0'),
(60, 2, '2025-10-16 11:42:57.0');

--
-- Déclencheurs `t_participation_ptp`
--
DELIMITER $$
CREATE TRIGGER `trg_inscription_reunion` AFTER INSERT ON `t_participation_ptp` FOR EACH ROW BEGIN
    CALL gestion_cr_reunion(NEW.reu_id);
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_profil_pfl`
--

CREATE TABLE `t_profil_pfl` (
  `pfl_id` int(11) NOT NULL,
  `pfl_nom` varchar(80) NOT NULL,
  `pfl_prenom` varchar(80) NOT NULL,
  `pfl_email` varchar(150) NOT NULL,
  `pfl_telephone` char(12) DEFAULT NULL,
  `pfl_date_naissance` date NOT NULL,
  `pfl_adresse` varchar(200) DEFAULT NULL,
  `pfl_statut` varchar(45) NOT NULL,
  `vll_id` int(11) NOT NULL,
  `cpt_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_profil_pfl`
--

INSERT INTO `t_profil_pfl` (`pfl_id`, `pfl_nom`, `pfl_prenom`, `pfl_email`, `pfl_telephone`, `pfl_date_naissance`, `pfl_adresse`, `pfl_statut`, `vll_id`, `cpt_id`) VALUES
(1, 'Principal', 'Admin', 'principal.admin@example.com', '0123456789', '1975-01-01', '157 Avenue de la Gare', 'Administrateur', 1, 12),
(2, 'Dupont', 'Paul', 'paul.dupont@example.com', '0601020304', '1980-05-12', '72 Boulevard de la Paix', 'Administrateur', 2, 13),
(3, 'Martin', 'Anne', 'anne.martin@example.com', '0602030405', '1978-11-22', '88 Rue de la Gare', 'Administrateur', 3, 14),
(4, 'Bernard', 'Luc', 'luc.bernard@example.com', '0603040506', '1982-07-07', '108 Boulevard Victor Hugo', 'Administrateur', 4, 15),
(5, 'Moreau', 'Sophie', 'sophie.moreau@example.com', '0604050607', '1979-03-03', '36 Avenue des Fleurs', 'Administrateur', 5, 16),
(6, 'Bernard', 'Adrien', 'adrien.bernard1@example.com', '0613356886', '1993-05-08', '98 Avenue des Champs', 'Membre', 4, 17),
(7, 'Renaud', 'Sophie', 'sophie.renaud2@example.com', '0623756669', '1991-12-18', '30 Allée de la République', 'Membre', 2, 18),
(8, 'Muller', 'Quentin', 'quentin.muller3@example.com', '0614265799', '1970-02-07', '150 Rue du Moulin', 'Membre', 4, 19),
(9, 'Mercier', 'Leo', 'leo.mercier4@example.com', '0613561597', '1987-04-23', '154 Rue de la Gare', 'Membre', 9, 20),
(10, 'Garcia', 'Clara', 'clara.garcia5@example.com', '0670291817', '1988-05-26', '28 Avenue de la Gare', 'Membre', 1, 21),
(11, 'Blanc', 'Helene', 'helene.blanc6@example.com', '0631429110', '1992-07-11', '85 Allée Victor Hugo', 'Membre', 5, 22),
(12, 'Fournier', 'Sophie', 'sophie.fournier7@example.com', '0655176955', '1973-02-13', '49 Boulevard de la République', 'Membre', 2, 23),
(13, 'Simon', 'Laurent', 'laurent.simon8@example.com', '0656164955', '1989-05-26', '180 Allée Victor Hugo', 'Membre', 1, 24),
(14, 'Odet', 'Gregory', 'gregory.odet9@example.com', '0681971316', '1973-07-03', '71 Avenue de l\'Église', 'Membre', 9, 25),
(15, 'Colin', 'Nicolas', 'nicolas.colin10@example.com', '0694374605', '1989-06-19', '197 Avenue du Moulin', 'Membre', 4, 26),
(16, 'Moreau', 'Alice', 'alice.moreau11@example.com', '0616150444', '1991-04-25', '191 Allée Victor Hugo', 'Membre', 5, 27),
(17, 'Simon', 'Julien', 'julien.simon12@example.com', '0641244663', '1997-02-13', '137 Rue de la Paix', 'Membre', 5, 28),
(18, 'Noel', 'Hugo', 'hugo.noel13@example.com', '0658966946', '1975-06-12', '19 Avenue de la République', 'Membre', 4, 29),
(19, 'Rodriguez', 'Marion', 'marion.rodriguez14@example.com', '0696977837', '1972-10-21', '154 Rue du Moulin', 'Membre', 3, 30),
(20, 'Renaud', 'Anais', 'anais.renaud15@example.com', '0642857966', '1975-08-13', '172 Boulevard des Fleurs', 'Membre', 5, 31),
(21, 'Noel', 'Elodie', 'elodie.noel16@example.com', '0684752529', '1977-11-11', '198 Allée de la République', 'Membre', 1, 32),
(22, 'Colin', 'Pierre', 'pierre.colin17@example.com', '0614308421', '1995-06-13', '4 Avenue Victor Hugo', 'Membre', 5, 33),
(23, 'Fournier', 'Julien', 'julien.fournier18@example.com', '0686125617', '1998-12-11', '111 Rue Jean Jaurès', 'Membre', 4, 34),
(24, 'DaSilva', 'Adrien', 'adrien.dasilva19@example.com', '0663100814', '1998-11-15', '137 Allée de l\'Église', 'Membre', 3, 35),
(25, 'Martin', 'Emilie', 'emilie.martin20@example.com', '0643101783', '1993-09-18', '107 Allée du Moulin', 'Membre', 5, 36),
(26, 'Boucher', 'Gregory', 'gregory.boucher21@example.com', '0667503414', '1998-10-13', '64 Allée du Moulin', 'Membre', 6, 37),
(27, 'Martin', 'Pierre', 'pierre.martin22@example.com', '0678387461', '1985-02-25', '185 Boulevard des Champs', 'Membre', 1, 38),
(28, 'Bernard', 'Samuel', 'samuel.bernard23@example.com', '0630514014', '1990-03-26', '63 Allée des Fleurs', 'Membre', 7, 39),
(29, 'Moreau', 'Marie', 'marie.moreau24@example.com', '0661642594', '1982-10-15', '23 Boulevard Jean Jaurès', 'Membre', 9, 40),
(30, 'Faure', 'Emilie', 'emilie.faure25@example.com', '0611540956', '1991-12-04', '119 Boulevard du Moulin', 'Membre', 9, 41),
(31, 'Rodriguez', 'Helene', 'helene.rodriguez26@example.com', '0696028436', '1980-02-10', '69 Rue Victor Hugo', 'Membre', 7, 42),
(32, 'Odet', 'Thomas', 'thomas.odet27@example.com', '0610435578', '2000-12-24', '100 Rue du Moulin', 'Membre', 5, 43),
(33, 'Renard', 'Leo', 'leo.renard28@example.com', '0633978249', '1986-02-28', '127 Boulevard Saint Martin', 'Membre', 5, 44),
(34, 'Noel', 'Isabelle', 'isabelle.noel29@example.com', '0678137358', '1989-04-05', '188 Boulevard Victor Hugo', 'Membre', 6, 45),
(35, 'Leclerc', 'Helene', 'helene.leclerc30@example.com', '0682394227', '2000-09-01', '167 Allée de la République', 'Membre', 10, 46),
(36, 'DaSilva', 'Mathieu', 'mathieu.dasilva31@example.com', '0612614124', '1973-06-27', '91 Boulevard du Moulin', 'Membre', 5, 47),
(37, 'Durand', 'Pierre', 'pierre.durand32@example.com', '0642329237', '1998-10-03', '100 Allée de l\'Église', 'Membre', 2, 48),
(38, 'DaSilva', 'Gregory', 'gregory.dasilva33@example.com', '0619289546', '1994-09-25', '144 Allée de la Gare', 'Membre', 3, 49),
(39, 'Bertrand', 'Sophie', 'sophie.bertrand34@example.com', '0673791320', '2000-09-06', '198 Boulevard de l\'Église', 'Membre', 5, 50),
(40, 'Simon', 'Leo', 'leo.simon35@example.com', '0691415657', '1983-04-18', '148 Rue de l\'Église', 'Membre', 4, 51),
(41, 'Rousseau', 'Alice', 'alice.rousseau36@example.com', '0663551839', '1991-11-12', '32 Avenue de l\'Église', 'Membre', 8, 52),
(42, 'Perrin', 'Victor', 'victor.perrin37@example.com', '0670597444', '1973-04-08', '122 Avenue de la Paix', 'Membre', 2, 53),
(43, 'Dupont', 'Mathieu', 'mathieu.dupont38@example.com', '0688961459', '1987-04-19', '68 Avenue des Champs', 'Membre', 4, 54),
(44, 'Moreau', 'Alex', 'alex.moreau39@example.com', '0694705205', '1971-04-03', '88 Avenue de l\'Église', 'Membre', 1, 55),
(45, 'Lambert', 'Samuel', 'samuel.lambert40@example.com', '0619510312', '1986-04-09', '26 Allée Jean Jaurès', 'Membre', 8, 56),
(46, 'Faure', 'Lucie', 'lucie.faure41@example.com', '0627758595', '1993-10-19', '36 Boulevard de la Gare', 'Membre', 8, 57),
(47, 'Blanc', 'Pierre', 'pierre.blanc42@example.com', '0673481353', '1995-07-07', '143 Avenue de la Gare', 'Membre', 2, 58),
(48, 'Bertrand', 'Camille', 'camille.bertrand43@example.com', '0667854710', '1981-07-14', '87 Rue de l\'Église', 'Membre', 8, 59),
(49, 'Renaud', 'Samuel', 'samuel.renaud44@example.com', '0617270733', '1991-11-21', '72 Rue Jean Jaurès', 'Membre', 2, 60),
(50, 'Chevalier', 'Maxime', 'maxime.chevalier45@example.com', '0655540424', '1995-02-08', '10 Allée des Champs', 'Membre', 4, 61),
(51, 'Martin', 'Hugo', 'hugo.martin47@example.com', '0666623995', '1975-05-15', '54 Boulevard de la Gare', 'Membre', 4, 62),
(52, 'Hubert', 'Samuel', 'samuel.hubert48@example.com', '0620117988', '1984-09-04', '46 Allée de la Gare', 'Membre', 1, 63),
(53, 'Faure', 'Adrien', 'adrien.faure49@example.com', '0611980765', '1972-04-06', '12 Rue de la Paix', 'Membre', 7, 64),
(54, 'DaSilva', 'Manon', 'manon.dasilva50@example.com', '0638688676', '1997-07-02', '53 Rue Jean Jaurès', 'Membre', 3, 65),
(55, 'Dupont', 'Paul', 'paul.dupont51@example.com', '0662401521', '1978-08-10', '65 Rue Saint Martin', 'Membre', 7, 66),
(56, 'Renaud', 'Alice', 'alice.renaud52@example.com', '0684593961', '1991-12-16', '179 Avenue de la Gare', 'Membre', 3, 67),
(57, 'Rousseau', 'Lucie', 'lucie.rousseau53@example.com', '0639219319', '2000-01-19', '96 Rue Saint Martin', 'Membre', 9, 68),
(58, 'Renaud', 'Maxime', 'maxime.renaud54@example.com', '0652091325', '1971-01-19', '17 Boulevard Jean Jaurès', 'Membre', 8, 69),
(59, 'Hubert', 'Leo', 'leo.hubert55@example.com', '0681286543', '1975-01-17', '116 Boulevard Victor Hugo', 'Membre', 2, 70),
(60, 'Leclerc', 'Samuel', 'samuel.leclerc56@example.com', '0619196777', '1989-02-22', '28 Rue des Fleurs', 'Membre', 4, 71),
(61, 'Bernard', 'Paul', 'paul.bernard57@example.com', '0686460539', '1977-10-20', '84 Allée de la République', 'Membre', 1, 72),
(62, 'Bertrand', 'Clara', 'clara.bertrand59@example.com', '0688339168', '1988-09-11', '154 Avenue des Champs', 'Membre', 5, 73),
(63, 'Bertrand', 'Lucie', 'lucie.bertrand60@example.com', '0652169044', '1977-05-13', '13 Avenue des Champs', 'Membre', 3, 74),
(64, 'Noel', 'Marion', 'marion.noel61@example.com', '0650264926', '1984-06-25', '76 Rue des Fleurs', 'Membre', 2, 75),
(65, 'Odet', 'Alex', 'alex.odet62@example.com', '0693370583', '1988-02-03', '116 Allée de la Paix', 'Membre', 9, 76),
(66, 'Perrin', 'Lucie', 'lucie.perrin63@example.com', '0645594597', '1974-06-03', '26 Avenue de la République', 'Membre', 4, 77),
(67, 'Rousseau', 'Laurent', 'laurent.rousseau64@example.com', '0631172421', '1984-09-23', '117 Avenue de la République', 'Membre', 5, 78),
(68, 'Blanc', 'Marie', 'marie.blanc65@example.com', '0697775215', '1986-01-22', '195 Rue Victor Hugo', 'Membre', 9, 79),
(69, 'Hubert', 'Nicolas', 'nicolas.hubert66@example.com', '0699038526', '1973-03-09', '62 Allée de l\'Église', 'Membre', 2, 80),
(70, 'Bernard', 'Victor', 'victor.bernard67@example.com', '0684252420', '1974-05-10', '84 Boulevard du Moulin', 'Membre', 10, 81),
(71, 'Gillet', 'Lucie', 'lucie.gillet68@example.com', '0656020613', '1976-11-21', '178 Boulevard du Moulin', 'Membre', 5, 82),
(72, 'DaSilva', 'Leo', 'leo.dasilva69@example.com', '0643704923', '1998-01-03', '133 Avenue des Fleurs', 'Membre', 7, 83),
(73, 'Rodriguez', 'Isabelle', 'isabelle.rodriguez70@example.com', '0615917225', '1970-06-25', '44 Rue des Champs', 'Membre', 3, 84),
(74, 'Rodriguez', 'Adrien', 'adrien.rodriguez71@example.com', '0631687165', '1993-08-18', '109 Boulevard Victor Hugo', 'Membre', 7, 85),
(75, 'Dupont', 'Anais', 'anais.dupont72@example.com', '0625015458', '1972-12-05', '65 Avenue des Fleurs', 'Membre', 9, 86),
(76, 'Colin', 'Maxime', 'maxime.colin73@example.com', '0659555330', '1988-09-05', '24 Avenue de l\'Église', 'Membre', 7, 87),
(77, 'Durand', 'Sophie', 'sophie.durand74@example.com', '0651373735', '1981-01-12', '160 Boulevard du Moulin', 'Membre', 4, 88),
(78, 'Garcia', 'Marion', 'marion.garcia75@example.com', '0699514287', '1973-06-25', '112 Rue de l\'Église', 'Membre', 9, 89),
(79, 'Simon', 'Victor', 'victor.simon76@example.com', '0664543049', '1989-12-05', '194 Avenue Jean Jaurès', 'Membre', 4, 90),
(80, 'Blanc', 'Olivier', 'olivier.blanc78@example.com', '0633763566', '1998-07-01', '49 Allée du Moulin', 'Membre', 3, 91),
(81, 'Hubert', 'Gregory', 'gregory.hubert79@example.com', '0654585178', '1995-07-26', '35 Rue Jean Jaurès', 'Membre', 4, 92),
(82, 'Leclerc', 'Emilie', 'emilie.leclerc80@example.com', '0624508349', '1982-01-28', '100 Rue de la Gare', 'Membre', 8, 93),
(83, 'Fournier', 'Pierre', 'pierre.fournier81@example.com', '0671780854', '1981-05-27', '1 Allée de l\'Église', 'Membre', 4, 94),
(84, 'Dupont', 'Pierre', 'pierre.dupont82@example.com', '0698588154', '1976-07-11', '164 Boulevard Saint Martin', 'Membre', 5, 95),
(85, 'Moreau', 'Samuel', 'samuel.moreau83@example.com', '0647463522', '1981-11-17', '80 Rue des Champs', 'Membre', 7, 96),
(86, 'Colin', 'Marion', 'marion.colin84@example.com', '0681969657', '1980-01-04', '127 Avenue de la Gare', 'Membre', 5, 97),
(87, 'Boucher', 'Thomas', 'thomas.boucher85@example.com', '0645630292', '1971-02-20', '169 Allée des Champs', 'Membre', 7, 98),
(88, 'Renaud', 'Laurent', 'laurent.renaud86@example.com', '0652101056', '1983-10-17', '34 Allée de la Paix', 'Membre', 2, 99),
(89, 'Robin', 'Paul', 'paul.robin87@example.com', '0687388337', '1976-05-02', '121 Allée du Moulin', 'Membre', 7, 100),
(90, 'Perrin', 'Alex', 'alex.perrin88@example.com', '0682269803', '1991-12-24', '173 Boulevard de la Paix', 'Membre', 4, 101),
(91, 'Muller', 'Laurent', 'laurent.muller89@example.com', '0619391725', '2000-11-11', '100 Avenue de la Gare', 'Membre', 10, 102),
(92, 'Bertrand', 'Mathieu', 'mathieu.bertrand90@example.com', '0626726926', '1993-05-17', '96 Rue de la Paix', 'Membre', 5, 103),
(93, 'Muller', 'Marion', 'marion.muller91@example.com', '0653779528', '1982-12-10', '159 Allée du Moulin', 'Membre', 9, 104),
(94, 'Bertrand', 'Paul', 'paul.bertrand94@example.com', '0633357554', '1989-10-10', '127 Avenue Saint Martin', 'Membre', 7, 105),
(95, 'Colin', 'Anais', 'anais.colin95@example.com', '0610054484', '1979-05-07', '65 Boulevard du Moulin', 'Membre', 7, 106),
(96, 'Boucher', 'Olivier', 'olivier.boucher96@example.com', '0691424737', '1990-06-15', '104 Boulevard des Champs', 'Membre', 8, 107),
(97, 'Bertrand', 'Hugo', 'hugo.bertrand97@example.com', '0638682516', '1986-08-26', '159 Rue Saint Martin', 'Membre', 3, 108),
(98, 'Moreau', 'Marion', 'marion.moreau98@example.com', '0648089166', '1986-11-21', '50 Avenue Saint Martin', 'Membre', 10, 109),
(99, 'Moreau', 'Mathieu', 'mathieu.moreau99@example.com', '0641523529', '1991-05-08', '97 Avenue Saint Martin', 'Membre', 4, 110),
(100, 'Dupont', 'Sophie', 'sophie.dupont100@example.com', '0616202700', '1977-08-20', '184 Boulevard Saint Martin', 'Membre', 2, 111),
(101, 'Muller', 'Hugo', 'hugo.muller101@example.com', '0694525678', '1988-04-23', '66 Boulevard de la Paix', 'Membre', 7, 112),
(102, 'Chevalier', 'Manon', 'manon.chevalier102@example.com', '0642747037', '1974-11-23', '67 Boulevard des Champs', 'Membre', 1, 113),
(103, 'Renard', 'Victor', 'victor.renard103@example.com', '0624305904', '1994-07-08', '183 Allée de la Paix', 'Membre', 3, 114),
(104, 'Gillet', 'Olivier', 'olivier.gillet104@example.com', '0679519112', '1984-01-18', '18 Rue de l\'Église', 'Membre', 4, 115),
(105, 'Simon', 'Elodie', 'elodie.simon105@example.com', '0626288475', '1984-03-26', '83 Boulevard de l\'Église', 'Membre', 8, 116),
(106, 'Perrin', 'Marion', 'marion.perrin106@example.com', '0685017682', '1989-06-25', '103 Allée Victor Hugo', 'Membre', 8, 117),
(107, 'Colin', 'Marie', 'marie.colin107@example.com', '0677750178', '1983-09-15', '200 Avenue Jean Jaurès', 'Membre', 3, 118),
(108, 'Simon', 'Gregory', 'gregory.simon108@example.com', '0673709724', '1984-05-25', '147 Avenue de la République', 'Membre', 4, 119),
(109, 'Renard', 'Emilie', 'emilie.renard110@example.com', '0679967676', '1985-11-08', '137 Allée de l\'Église', 'Membre', 5, 120),
(110, 'Moreau', 'Hugo', 'hugo.moreau111@example.com', '0648349783', '1977-05-11', '189 Rue de l\'Église', 'Membre', 6, 121),
(111, 'Faure', 'Victor', 'victor.faure112@example.com', '0620814950', '1974-03-08', '10 Boulevard Saint Martin', 'Membre', 7, 122),
(112, 'Martin', 'Alice', 'alice.martin113@example.com', '0638716269', '1972-07-14', '101 Boulevard de la République', 'Membre', 6, 123),
(113, 'Odet', 'Anais', 'anais.odet114@example.com', '0665804273', '1971-04-27', '144 Rue Victor Hugo', 'Membre', 7, 124),
(114, 'Boucher', 'Helene', 'helene.boucher116@example.com', '0612621534', '1997-10-13', '153 Rue de l\'Église', 'Membre', 8, 125),
(115, 'Garnier', 'Alex', 'alex.garnier117@example.com', '0650079111', '1994-07-28', '102 Rue Saint Martin', 'Membre', 7, 126),
(116, 'Faure', 'Gregory', 'gregory.faure119@example.com', '0690967191', '1998-04-16', '36 Allée de la Paix', 'Membre', 4, 127),
(117, 'Muller', 'Emilie', 'emilie.muller120@example.com', '0675181765', '1970-07-11', '86 Rue des Champs', 'Membre', 7, 128),
(118, 'Leclerc', 'Gregory', 'gregory.leclerc121@example.com', '0672732043', '1999-03-20', '102 Allée du Moulin', 'Membre', 9, 129),
(119, 'Hubert', 'Alex', 'alex.hubert122@example.com', '0662884503', '1988-10-22', '188 Allée de la Paix', 'Membre', 1, 130),
(120, 'Noel', 'Julien', 'julien.noel123@example.com', '0667527432', '1974-08-06', '71 Boulevard des Champs', 'Membre', 1, 131),
(121, 'Chevalier', 'Emilie', 'emilie.chevalier124@example.com', '0653936531', '1976-08-11', '171 Avenue de l\'Église', 'Membre', 6, 132),
(122, 'Robin', 'Helene', 'helene.robin125@example.com', '0660885459', '1978-07-09', '135 Allée Jean Jaurès', 'Membre', 2, 133),
(123, 'Dupont', 'Manon', 'manon.dupont126@example.com', '0682399599', '1971-06-08', '144 Rue Jean Jaurès', 'Membre', 2, 134),
(124, 'Noel', 'Helene', 'helene.noel127@example.com', '0615403355', '1994-01-08', '15 Allée du Moulin', 'Membre', 4, 135),
(125, 'Dupont', 'Isabelle', 'isabelle.dupont128@example.com', '0693394260', '1974-04-05', '111 Rue Jean Jaurès', 'Membre', 8, 136),
(126, 'Bernard', 'Marion', 'marion.bernard129@example.com', '0685694715', '2000-04-15', '73 Avenue Saint Martin', 'Membre', 5, 137),
(127, 'Garnier', 'Helene', 'helene.garnier130@example.com', '0632520277', '1989-10-24', '21 Boulevard de l\'Église', 'Membre', 2, 138),
(128, 'Colin', 'Helene', 'helene.colin131@example.com', '0631980274', '2000-05-04', '85 Boulevard du Moulin', 'Membre', 10, 139),
(129, 'Boucher', 'Nicolas', 'nicolas.boucher133@example.com', '0660372847', '1982-12-07', '187 Allée de la Paix', 'Membre', 2, 140),
(130, 'Gillet', 'Quentin', 'quentin.gillet134@example.com', '0694187049', '1977-02-23', '29 Avenue de la Gare', 'Membre', 5, 141),
(131, 'Bertrand', 'Samuel', 'samuel.bertrand135@example.com', '0690585882', '1995-02-26', '89 Allée de la République', 'Membre', 10, 142),
(132, 'Durand', 'Olivier', 'olivier.durand136@example.com', '0656600900', '1987-07-22', '125 Boulevard Victor Hugo', 'Membre', 6, 143),
(133, 'Perrin', 'Julien', 'julien.perrin137@example.com', '0696911784', '1980-01-28', '167 Allée Jean Jaurès', 'Membre', 7, 144),
(134, 'DaSilva', 'Isabelle', 'isabelle.dasilva138@example.com', '0624165187', '1983-06-21', '184 Rue des Fleurs', 'Membre', 8, 145),
(135, 'Leclerc', 'Clara', 'clara.leclerc140@example.com', '0680027662', '2000-11-09', '191 Allée Victor Hugo', 'Membre', 10, 146),
(136, 'Hubert', 'Olivier', 'olivier.hubert141@example.com', '0682232344', '1994-08-15', '106 Rue Saint Martin', 'Membre', 7, 147),
(137, 'Renaud', 'Isabelle', 'isabelle.renaud142@example.com', '0689520597', '1978-06-28', '51 Rue des Fleurs', 'Membre', 4, 148),
(138, 'Hubert', 'Isabelle', 'isabelle.hubert143@example.com', '0621631697', '1978-08-08', '19 Avenue de la Gare', 'Membre', 8, 149),
(139, 'Mercier', 'Quentin', 'quentin.mercier144@example.com', '0699682738', '1982-06-01', '94 Rue du Moulin', 'Membre', 8, 150),
(140, 'DaSilva', 'Thomas', 'thomas.dasilva146@example.com', '0638470244', '1981-05-11', '168 Avenue de la Gare', 'Membre', 5, 151),
(141, 'Mercier', 'Victor', 'victor.mercier147@example.com', '0647080140', '1987-01-17', '77 Boulevard du Moulin', 'Membre', 4, 152),
(142, 'Garcia', 'Julien', 'julien.garcia148@example.com', '0664549859', '1985-09-25', '18 Allée Saint Martin', 'Membre', 4, 153),
(143, 'DaSilva', 'Alice', 'alice.dasilva149@example.com', '0696691619', '1992-08-15', '165 Rue Saint Martin', 'Membre', 1, 154),
(144, 'Rousseau', 'Julien', 'julien.rousseau150@example.com', '0639742165', '1982-12-08', '109 Allée du Moulin', 'Membre', 5, 155),
(145, 'Boucher', 'Marion', 'marion.boucher151@example.com', '0659529086', '1985-09-17', '10 Avenue de l\'Église', 'Membre', 6, 156),
(146, 'Renaud', 'Clara', 'clara.renaud152@example.com', '0683871890', '1980-06-23', '23 Allée de la République', 'Membre', 8, 157),
(147, 'Rousseau', 'Emilie', 'emilie.rousseau153@example.com', '0643742830', '1977-02-24', '142 Allée Saint Martin', 'Membre', 4, 158),
(148, 'Bernard', 'Mathieu', 'mathieu.bernard154@example.com', '0681922443', '2000-12-06', '106 Boulevard des Fleurs', 'Membre', 4, 159),
(149, 'Renaud', 'Lucie', 'lucie.renaud155@example.com', '0674988034', '1978-12-19', '12 Rue de la Gare', 'Membre', 9, 160),
(150, 'Rousseau', 'Marie', 'marie.rousseau156@example.com', '0623492385', '1996-04-10', '61 Rue de la Paix', 'Membre', 4, 161),
(151, 'Leclerc', 'Laurent', 'laurent.leclerc157@example.com', '0650569669', '1970-12-18', '135 Rue de la Paix', 'Membre', 3, 162),
(152, 'Durand', 'Emilie', 'emilie.durand158@example.com', '0617318358', '1987-05-23', '139 Avenue du Moulin', 'Membre', 3, 163),
(153, 'Simon', 'Adrien', 'adrien.simon159@example.com', '0675884623', '1973-01-19', '55 Boulevard de l\'Église', 'Membre', 5, 164),
(154, 'Lambert', 'Hugo', 'hugo.lambert161@example.com', '0634744872', '2000-01-09', '37 Avenue de la Gare', 'Membre', 8, 165),
(155, 'Colin', 'Camille', 'camille.colin162@example.com', '0618770247', '1982-08-03', '4 Allée des Champs', 'Membre', 10, 166),
(156, 'Bertrand', 'Adrien', 'adrien.bertrand163@example.com', '0617195288', '1974-03-26', '101 Boulevard du Moulin', 'Membre', 10, 167),
(157, 'Moreau', 'Nicolas', 'nicolas.moreau164@example.com', '0643311626', '1973-09-25', '154 Allée de la République', 'Membre', 7, 168),
(158, 'Mercier', 'Marie', 'marie.mercier165@example.com', '0693002706', '1977-09-13', '175 Boulevard de l\'Église', 'Membre', 8, 169),
(159, 'Odet', 'Elodie', 'elodie.odet166@example.com', '0649910061', '1997-10-14', '51 Boulevard Jean Jaurès', 'Membre', 5, 170),
(160, 'Mercier', 'Maxime', 'maxime.mercier168@example.com', '0623318904', '2000-04-21', '95 Allée Victor Hugo', 'Membre', 4, 171),
(161, 'Bertrand', 'Emilie', 'emilie.bertrand169@example.com', '0620896797', '1975-04-06', '5 Boulevard du Moulin', 'Membre', 9, 172),
(162, 'Leclerc', 'Julien', 'julien.leclerc170@example.com', '0610359129', '1983-08-23', '15 Boulevard Jean Jaurès', 'Membre', 10, 173),
(163, 'Rousseau', 'Manon', 'manon.rousseau171@example.com', '0614380847', '1977-05-23', '7 Allée de la Paix', 'Membre', 5, 174),
(164, 'Simon', 'Alice', 'alice.simon172@example.com', '0670939053', '1972-11-08', '168 Allée Jean Jaurès', 'Membre', 5, 175),
(165, 'Boucher', 'Adrien', 'adrien.boucher174@example.com', '0698742485', '1995-04-14', '43 Boulevard de la Paix', 'Membre', 2, 176),
(166, 'Garcia', 'Anais', 'anais.garcia175@example.com', '0696924061', '1974-05-27', '41 Allée Victor Hugo', 'Membre', 3, 177),
(167, 'Durand', 'Julien', 'julien.durand176@example.com', '0632269779', '1995-05-20', '97 Allée Jean Jaurès', 'Membre', 10, 178),
(168, 'Rousseau', 'Elodie', 'elodie.rousseau177@example.com', '0668942178', '1973-08-23', '55 Rue des Fleurs', 'Membre', 5, 179),
(169, 'Chevalier', 'Alice', 'alice.chevalier178@example.com', '0646540265', '1986-09-16', '154 Boulevard Victor Hugo', 'Membre', 8, 180),
(170, 'Mercier', 'Julien', 'julien.mercier179@example.com', '0615350023', '1998-07-24', '168 Boulevard Saint Martin', 'Membre', 6, 181),
(171, 'Rodriguez', 'Marie', 'marie.rodriguez180@example.com', '0613471527', '1972-04-22', '75 Allée des Fleurs', 'Membre', 10, 182),
(172, 'Dupont', 'Quentin', 'quentin.dupont181@example.com', '0646173157', '1988-01-25', '3 Rue Victor Hugo', 'Membre', 3, 183),
(173, 'Perrin', 'Manon', 'manon.perrin182@example.com', '0697444123', '1984-05-06', '171 Boulevard de la Gare', 'Membre', 10, 184),
(174, 'Noel', 'Clara', 'clara.noel183@example.com', '0675998319', '1972-08-12', '159 Boulevard de la Paix', 'Membre', 7, 185),
(175, 'Lambert', 'Mathieu', 'mathieu.lambert184@example.com', '0699943797', '1973-03-11', '49 Rue des Fleurs', 'Membre', 7, 186),
(176, 'Bertrand', 'Nicolas', 'nicolas.bertrand186@example.com', '0663747791', '1996-09-02', '175 Rue des Fleurs', 'Membre', 8, 187),
(177, 'Lambert', 'Julien', 'julien.lambert187@example.com', '0643876400', '1980-02-25', '46 Rue Saint Martin', 'Membre', 7, 188),
(178, 'Perrin', 'Samuel', 'samuel.perrin188@example.com', '0610154493', '1991-09-15', '173 Avenue de l\'Église', 'Membre', 7, 189),
(179, 'Fournier', 'Maxime', 'maxime.fournier189@example.com', '0679583757', '1981-10-25', '147 Rue de la République', 'Membre', 8, 190),
(180, 'Odet', 'Adrien', 'adrien.odet190@example.com', '0616927215', '1976-05-18', '32 Rue de la Gare', 'Membre', 3, 191),
(181, 'Robin', 'Hugo', 'hugo.robin192@example.com', '0675056916', '1973-01-21', '16 Rue du Moulin', 'Membre', 10, 192),
(182, 'Garcia', 'Olivier', 'olivier.garcia193@example.com', '0631257157', '1979-09-01', '8 Avenue de l\'Église', 'Membre', 9, 193),
(183, 'Moreau', 'Clara', 'clara.moreau194@example.com', '0640158811', '1996-02-15', '1 Boulevard de la République', 'Membre', 2, 194),
(184, 'Colin', 'Adrien', 'adrien.colin195@example.com', '0630665654', '1985-12-10', '14 Allée de la Gare', 'Membre', 9, 195),
(185, 'Rodriguez', 'Alice', 'alice.rodriguez196@example.com', '0665766169', '1996-08-16', '46 Allée du Moulin', 'Membre', 4, 196),
(186, 'Faure', 'Hugo', 'hugo.faure197@example.com', '0629413516', '1982-04-20', '51 Boulevard des Champs', 'Membre', 9, 197),
(187, 'Robin', 'Gregory', 'gregory.robin198@example.com', '0628321839', '1997-02-09', '59 Boulevard Saint Martin', 'Membre', 7, 198),
(188, 'Hubert', 'Mathieu', 'mathieu.hubert199@example.com', '0678147397', '1978-01-10', '136 Avenue des Fleurs', 'Membre', 5, 199),
(189, 'Boucher', 'Isabelle', 'isabelle.boucher200@example.com', '0687835998', '1991-08-28', '40 Rue de la République', 'Membre', 3, 200),
(190, 'Garnier', 'Manon', 'manon.garnier202@example.com', '0654619335', '1987-09-13', '114 Rue de la République', 'Membre', 8, 201),
(191, 'Lambert', 'Elodie', 'elodie.lambert203@example.com', '0635320492', '1992-04-19', '195 Rue du Moulin', 'Membre', 7, 202),
(192, 'Simon', 'Pierre', 'pierre.simon204@example.com', '0665133300', '1971-06-24', '116 Rue de l\'Église', 'Membre', 8, 203),
(193, 'Hubert', 'Alice', 'alice.hubert205@example.com', '0661167978', '1982-11-26', '8 Boulevard Saint Martin', 'Membre', 3, 204),
(194, 'Durand', 'Manon', 'manon.durand206@example.com', '0626944487', '1986-10-11', '79 Rue de la République', 'Membre', 2, 205),
(195, 'Simon', 'Samuel', 'samuel.simon207@example.com', '0669096899', '1973-09-15', '44 Boulevard de l\'Église', 'Membre', 1, 206),
(196, 'Martin', 'Gregory', 'gregory.martin208@example.com', '0665026398', '1997-11-05', '157 Avenue des Fleurs', 'Membre', 2, 207),
(197, 'Blanc', 'Manon', 'manon.blanc209@example.com', '0645570755', '1980-10-23', '141 Avenue du Moulin', 'Membre', 7, 208),
(198, 'Moreau', 'Adrien', 'adrien.moreau210@example.com', '0654099326', '1997-11-28', '6 Avenue du Moulin', 'Membre', 9, 209),
(199, 'Lambert', 'Paul', 'paul.lambert211@example.com', '0694127561', '1992-08-28', '90 Avenue Victor Hugo', 'Membre', 9, 210),
(200, 'Renaud', 'Pierre', 'pierre.renaud216@example.com', '0622130508', '1983-02-25', '11 Allée de la République', 'Membre', 2, 211),
(201, 'Leclerc', 'Hugo', 'hugo.leclerc217@example.com', '0650193656', '1998-01-02', '190 Rue Jean Jaurès', 'Membre', 6, 212),
(202, 'Garnier', 'Nicolas', 'nicolas.garnier219@example.com', '0660310319', '1983-03-08', '50 Allée Victor Hugo', 'Membre', 9, 213),
(203, 'Boucher', 'Clara', 'clara.boucher220@example.com', '0634166826', '1975-03-03', '53 Allée de la Paix', 'Membre', 10, 214),
(204, 'Chevalier', 'Samuel', 'samuel.chevalier221@example.com', '0693176117', '1991-04-16', '42 Allée des Fleurs', 'Membre', 10, 215),
(205, 'Garcia', 'Sophie', 'sophie.garcia222@example.com', '0671894493', '1990-05-15', '147 Boulevard des Champs', 'Membre', 5, 216),
(206, 'Paul', 'John', 'pauljohn@gmail.com', '0756232652', '1994-05-02', '179 Boulevard du Moulin', 'Membre', 3, 11),
(208, 'Paul', 'Jule', 'pauljule@gmail.com', '41415154842', '2015-11-04', '16 rue de Karl', 'Administrateur', 5, 217),
(209, 'Dupont', 'Jean', 'jean.dupont@mail.com', '0601020304', '1985-07-14', '25 Rue des Lilas, Lyon', 'Administrateur', 3, 218);

--
-- Déclencheurs `t_profil_pfl`
--
DELIMITER $$
CREATE TRIGGER `trg_after_insert_profil` AFTER INSERT ON `t_profil_pfl` FOR EACH ROW BEGIN
  UPDATE t_compte_cpt SET cpt_pseudo = LOWER(CONCAT(NEW.pfl_prenom, '.', NEW.pfl_nom)) WHERE cpt_id = NEW.cpt_id;
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_reservation_res`
--

CREATE TABLE `t_reservation_res` (
  `res_id` int(11) NOT NULL,
  `res_nom` varchar(100) NOT NULL,
  `res_date_debut` datetime(1) NOT NULL,
  `res_date_fin` datetime(1) NOT NULL,
  `res_bilan_reservation` varchar(600) NOT NULL DEFAULT 'RAS',
  `res_statut` varchar(45) NOT NULL,
  `rsc_id` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_reservation_res`
--

INSERT INTO `t_reservation_res` (`res_id`, `res_nom`, `res_date_debut`, `res_date_fin`, `res_bilan_reservation`, `res_statut`, `rsc_id`) VALUES
(1, 'Sortie_associative_a_Paris', '2025-10-01 09:00:00.0', '2025-10-01 13:00:00.0', 'Voyage bien passe belle ambiance', 'Terminee', 1),
(2, 'Mission_caritative_a_Nantes', '2025-10-02 08:00:00.0', '2025-10-02 17:00:00.0', 'Retard leger au depart mais journee reussie', 'Terminee', 2),
(3, 'Sortie_culturelle_a_Lille', '2025-10-03 09:00:00.0', '2025-10-03 14:00:00.0', 'Bonne participation des membres', 'Planifiee', 3),
(5, 'Excursion a La Rochelle', '2025-10-05 09:00:00.0', '2025-10-05 15:00:00.0', 'Trajet agreable meteo favorable', 'Terminee', 5),
(6, 'Sortie decouverte de Saint Etienne', '2025-10-06 10:00:00.0', '2025-10-06 13:00:00.0', 'Sortie annulee a cause de la pluie', 'Annulee', 6),
(7, 'Voyage_humanitaire_a_Lyon', '2025-10-07 07:00:00.0', '2025-10-07 20:00:00.0', 'Belle mobilisation des membres', 'Terminee', 1),
(8, 'Sortie_detente_des_membres', '2025-10-08 09:00:00.0', '2025-10-08 14:00:00.0', 'Moment convivial entre adherents', 'Terminee', 2),
(9, 'Visite_orphelinat_Dijon', '2025-10-09 08:30:00.0', '2025-10-09 16:00:00.0', 'Don de vivres effectue avec succes', 'Terminee', 3),
(11, 'Mission_medicale_Rennes', '2025-10-11 06:00:00.0', '2025-10-11 18:00:00.0', 'Bilan positif forte participation', 'Terminee', 5),
(12, 'Voyage_touristique', '2025-10-12 09:00:00.0', '2025-10-12 18:00:00.0', 'Sortie agreable quelques retards', 'Planifiee', 6),
(13, 'Transport_materiel_evenementiel', '2025-11-02 19:00:00.0', '2025-11-02 22:00:00.0', 'Probleme mecanique remplace par un autre vehicule', 'En cours', 1),
(14, 'Sortie_commemorative', '2025-10-13 09:00:00.0', '2025-10-13 14:00:00.0', 'Tout s est bien deroule ambiance festive', 'Terminee', 2),
(15, 'Deplacement_conference', '2025-10-15 08:00:00.0', '2025-10-15 18:00:00.0', 'Voyage reussi conference enrichissante', 'Terminee', 3),
(17, 'Voyage_communautaire', '2025-10-17 10:00:00.0', '2025-10-17 14:00:00.0', 'Bonne ambiance generale', 'Terminee', 5),
(18, 'Sortie_decouverte_patrimoine', '2025-10-18 09:00:00.0', '2025-10-18 16:00:00.0', 'Sortie annulee indisponibilite vehicule', 'Annulee', 6),
(19, 'Voyage_suivi_projets', '2025-11-19 08:00:00.0', '2025-11-19 19:00:00.0', 'Travaux bien avances', 'Terminee', 1),
(20, 'Sortie_champetre', '2025-10-20 09:00:00.0', '2025-10-20 13:00:00.0', 'Journee conviviale a la campagne', 'Terminee', 2),
(21, 'Sortie_plage', '2025-10-21 09:00:00.0', '2025-10-21 15:00:00.0', 'Sortie confirmee 12 inscrits', 'Terminee', 3),
(23, 'Collecte_fonds', '2025-10-23 08:00:00.0', '2025-10-23 17:00:00.0', 'Mission annulee faute de participants', 'Annulee', 5),
(24, 'Excursion_educative', '2025-10-24 09:00:00.0', '2025-10-24 14:00:00.0', 'Belle experience pour nouveaux membres', 'Terminee', 6),
(25, 'Voyage_social', '2025-10-25 07:00:00.0', '2025-10-25 20:00:00.0', 'Bonne coordination generale', 'Terminee', 1),
(26, 'Transport_interne', '2025-10-26 10:00:00.0', '2025-10-26 13:00:00.0', 'Reservation confirmee vehicule pret', 'Planifiee', 2),
(27, 'Sortie_benevolat', '2025-10-27 09:00:00.0', '2025-10-27 15:00:00.0', 'Activite benevole annulee suite a indispo', 'Annulee', 3),
(29, 'Sortie_fin_annee', '2025-10-29 09:00:00.0', '2025-10-29 17:00:00.0', 'Belle expérience, tout s’est bien déroulé.', 'Terminee', 5),
(30, 'Voyage_supervision', '2025-10-30 08:00:00.0', '2025-10-30 17:00:00.0', 'Belle expérience, tout s’est bien déroulé.', 'Terminee', 6),
(31, 'Sortie spéciale', '2025-11-15 09:00:00.0', '2025-11-15 13:00:00.0', '', 'Planifiee', 2),
(32, 'Sortie spéciale', '2025-11-15 09:00:00.0', '2025-11-15 13:00:00.0', '', 'Planifiee', 2);

-- --------------------------------------------------------

--
-- Structure de la table `t_ressource_rsc`
--

CREATE TABLE `t_ressource_rsc` (
  `rsc_id` int(11) NOT NULL,
  `rsc_nom` varchar(100) NOT NULL,
  `rsc_photo` varchar(100) NOT NULL,
  `rsc_description` varchar(300) NOT NULL,
  `rsc_jauge` int(11) NOT NULL,
  `rsc_url` varchar(100) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_ressource_rsc`
--

INSERT INTO `t_ressource_rsc` (`rsc_id`, `rsc_nom`, `rsc_photo`, `rsc_description`, `rsc_jauge`, `rsc_url`) VALUES
(1, 'Minibus_Toyota_12_places', 'minibus1.jpg', 'Minibus Toyota 12 places clim coffre spacieux', 12, 'docs/minibus_toyota_12.pdf'),
(2, 'Fourgon_Mercedes_9_places', 'tulipe.webp', 'Fourgon Mercedes 9 places ideal pour sorties', 9, 'doctest2.pdf'),
(3, 'Voiture_Peugeot_5_places', 'love.jpg', 'Peugeot 5 places economique fiable', 5, 'doc1.pdf'),
(5, 'Minibus_Renault_15_places', 'leno.jpeg', 'Renault 15 places GPS integre', 15, 'doc2.pdf'),
(6, 'Van_Ford_8_places', 'logo.jpg', 'Ford Transit 8 places grande soute', 8, 'docs/ford_van_8.pdf'),
(8, 'Minibus FK60', 'minibusfk60.jpg', 'Un nouveau minibus de 60 places.', 60, 'minibusfk60.pdf'),
(9, 'Minibus FK50', 'minibusfk50.jpg', 'Un nouveau minibus de 50 places.', 50, 'minibusfk50.pdf');

-- --------------------------------------------------------

--
-- Structure de la table `t_reunion_reu`
--

CREATE TABLE `t_reunion_reu` (
  `reu_id` int(11) NOT NULL,
  `reu_date_debut` datetime(1) NOT NULL,
  `reu_theme` varchar(100) NOT NULL,
  `reu_lieu` varchar(45) NOT NULL,
  `reu_fin` time NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_reunion_reu`
--

INSERT INTO `t_reunion_reu` (`reu_id`, `reu_date_debut`, `reu_theme`, `reu_lieu`, `reu_fin`) VALUES
(1, '2025-10-10 18:00:00.0', 'Conseil_administration_Octobre', 'Salle_A', '20:00:00'),
(2, '2025-12-15 10:00:00.0', 'Assemblee_generale_2025', 'Salle_B', '12:00:00'),
(5, '2025-10-15 14:41:26.0', 'Nomination du nouveau DG', 'Salle 6', '18:41:26'),
(6, '2025-10-17 14:42:46.0', 'Controle du personnel', 'Salle P', '15:42:46'),
(7, '2025-10-13 14:44:05.0', 'Reconnaissance des membres actifs', 'Salle B', '18:44:05'),
(8, '2025-11-25 15:06:00.0', 'Reunion mois', 'Salle 3', '18:20:00');

--
-- Déclencheurs `t_reunion_reu`
--
DELIMITER $$
CREATE TRIGGER `trg_before_delete_reunion` BEFORE DELETE ON `t_reunion_reu` FOR EACH ROW BEGIN
    -- Supprime d'abord les participations liées à cette réunion
    DELETE FROM t_participation_ptp WHERE reu_id = OLD.reu_id;

    -- Supprime aussi les documents associés à la réunion
    DELETE FROM t_document_dcm WHERE reu_id = OLD.reu_id;

    -- (Facultatif) Supprimer d'autres dépendances s’il y en a (ex: notifications, etc.)
END
$$
DELIMITER ;

-- --------------------------------------------------------

--
-- Structure de la table `t_ville_vll`
--

CREATE TABLE `t_ville_vll` (
  `vll_id` int(11) NOT NULL,
  `vll_code_postal` int(11) NOT NULL,
  `vll_nom` varchar(200) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `t_ville_vll`
--

INSERT INTO `t_ville_vll` (`vll_id`, `vll_code_postal`, `vll_nom`) VALUES
(1, 75001, 'Paris'),
(2, 69001, 'Lyon'),
(3, 13001, 'Marseille'),
(4, 33000, 'Bordeaux'),
(5, 59000, 'Lille'),
(6, 6000, 'Nice'),
(7, 44000, 'Nantes'),
(8, 67000, 'Strasbourg'),
(9, 31000, 'Toulouse'),
(10, 21000, 'Dijon');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `t_actualite_act`
--
ALTER TABLE `t_actualite_act`
  ADD PRIMARY KEY (`act_id`),
  ADD KEY `fk_t_actualite_act_t_compte_cpt1_idx` (`cpt_id`);

--
-- Index pour la table `t_compte_cpt`
--
ALTER TABLE `t_compte_cpt`
  ADD PRIMARY KEY (`cpt_id`);

--
-- Index pour la table `t_document_dcm`
--
ALTER TABLE `t_document_dcm`
  ADD PRIMARY KEY (`dcm_id`),
  ADD KEY `fk_t_document_dcm_t_reunion_reu1_idx` (`reu_id`);

--
-- Index pour la table `t_etat_ett`
--
ALTER TABLE `t_etat_ett`
  ADD PRIMARY KEY (`rsc_id`,`idp_id`),
  ADD KEY `fk_t_ressource_rsc_has_t_indisponibilite_idp_t_indisponibil_idx` (`idp_id`),
  ADD KEY `fk_t_ressource_rsc_has_t_indisponibilite_idp_t_ressource_rs_idx` (`rsc_id`);

--
-- Index pour la table `t_indisponibilite_idp`
--
ALTER TABLE `t_indisponibilite_idp`
  ADD PRIMARY KEY (`idp_id`),
  ADD KEY `fk_t_indisponibilite_idp_t_motif_mtf1_idx` (`mtf_id`);

--
-- Index pour la table `t_inscription_isc`
--
ALTER TABLE `t_inscription_isc`
  ADD PRIMARY KEY (`cpt_id`,`res_id`),
  ADD KEY `fk_t_compte_cpt_has_t_reservation_res_t_reservation_res1_idx` (`res_id`),
  ADD KEY `fk_t_compte_cpt_has_t_reservation_res_t_compte_cpt1_idx` (`cpt_id`);

--
-- Index pour la table `t_message_msg`
--
ALTER TABLE `t_message_msg`
  ADD PRIMARY KEY (`msg_id`),
  ADD UNIQUE KEY `msg_code_UNIQUE` (`msg_code`),
  ADD KEY `fk_t_message_msg_t_compte_cpt1_idx` (`cpt_id`);

--
-- Index pour la table `t_motif_mtf`
--
ALTER TABLE `t_motif_mtf`
  ADD PRIMARY KEY (`mtf_id`);

--
-- Index pour la table `t_participation_ptp`
--
ALTER TABLE `t_participation_ptp`
  ADD PRIMARY KEY (`cpt_id`,`reu_id`),
  ADD KEY `fk_t_compte_cpt_has_t_reunion_reu_t_reunion_reu1_idx` (`reu_id`),
  ADD KEY `fk_t_compte_cpt_has_t_reunion_reu_t_compte_cpt1_idx` (`cpt_id`);

--
-- Index pour la table `t_profil_pfl`
--
ALTER TABLE `t_profil_pfl`
  ADD PRIMARY KEY (`pfl_id`,`cpt_id`),
  ADD KEY `fk_t_profil_pfl_t_ville_vll_idx` (`vll_id`),
  ADD KEY `fk_t_profil_pfl_t_compte_cpt1_idx` (`cpt_id`);

--
-- Index pour la table `t_reservation_res`
--
ALTER TABLE `t_reservation_res`
  ADD PRIMARY KEY (`res_id`,`rsc_id`),
  ADD KEY `fk_t_reservation_res_t_ressource_rsc1_idx` (`rsc_id`);

--
-- Index pour la table `t_ressource_rsc`
--
ALTER TABLE `t_ressource_rsc`
  ADD PRIMARY KEY (`rsc_id`);

--
-- Index pour la table `t_reunion_reu`
--
ALTER TABLE `t_reunion_reu`
  ADD PRIMARY KEY (`reu_id`);

--
-- Index pour la table `t_ville_vll`
--
ALTER TABLE `t_ville_vll`
  ADD PRIMARY KEY (`vll_id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `t_actualite_act`
--
ALTER TABLE `t_actualite_act`
  MODIFY `act_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=8;

--
-- AUTO_INCREMENT pour la table `t_compte_cpt`
--
ALTER TABLE `t_compte_cpt`
  MODIFY `cpt_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=220;

--
-- AUTO_INCREMENT pour la table `t_document_dcm`
--
ALTER TABLE `t_document_dcm`
  MODIFY `dcm_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `t_indisponibilite_idp`
--
ALTER TABLE `t_indisponibilite_idp`
  MODIFY `idp_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `t_message_msg`
--
ALTER TABLE `t_message_msg`
  MODIFY `msg_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=12;

--
-- AUTO_INCREMENT pour la table `t_motif_mtf`
--
ALTER TABLE `t_motif_mtf`
  MODIFY `mtf_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=7;

--
-- AUTO_INCREMENT pour la table `t_profil_pfl`
--
ALTER TABLE `t_profil_pfl`
  MODIFY `pfl_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=210;

--
-- AUTO_INCREMENT pour la table `t_reservation_res`
--
ALTER TABLE `t_reservation_res`
  MODIFY `res_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=33;

--
-- AUTO_INCREMENT pour la table `t_ressource_rsc`
--
ALTER TABLE `t_ressource_rsc`
  MODIFY `rsc_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=10;

--
-- AUTO_INCREMENT pour la table `t_reunion_reu`
--
ALTER TABLE `t_reunion_reu`
  MODIFY `reu_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=9;

--
-- AUTO_INCREMENT pour la table `t_ville_vll`
--
ALTER TABLE `t_ville_vll`
  MODIFY `vll_id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=11;

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `t_actualite_act`
--
ALTER TABLE `t_actualite_act`
  ADD CONSTRAINT `fk_t_actualite_act_t_compte_cpt1` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_document_dcm`
--
ALTER TABLE `t_document_dcm`
  ADD CONSTRAINT `fk_t_document_dcm_t_reunion_reu1` FOREIGN KEY (`reu_id`) REFERENCES `t_reunion_reu` (`reu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_etat_ett`
--
ALTER TABLE `t_etat_ett`
  ADD CONSTRAINT `fk_t_ressource_rsc_has_t_indisponibilite_idp_t_indisponibilit1` FOREIGN KEY (`idp_id`) REFERENCES `t_indisponibilite_idp` (`idp_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_ressource_rsc_has_t_indisponibilite_idp_t_ressource_rsc1` FOREIGN KEY (`rsc_id`) REFERENCES `t_ressource_rsc` (`rsc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_indisponibilite_idp`
--
ALTER TABLE `t_indisponibilite_idp`
  ADD CONSTRAINT `fk_t_indisponibilite_idp_t_motif_mtf1` FOREIGN KEY (`mtf_id`) REFERENCES `t_motif_mtf` (`mtf_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_inscription_isc`
--
ALTER TABLE `t_inscription_isc`
  ADD CONSTRAINT `fk_t_compte_cpt_has_t_reservation_res_t_compte_cpt1` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_compte_cpt_has_t_reservation_res_t_reservation_res1` FOREIGN KEY (`res_id`) REFERENCES `t_reservation_res` (`res_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_message_msg`
--
ALTER TABLE `t_message_msg`
  ADD CONSTRAINT `fk_t_message_msg_t_compte_cpt1` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_participation_ptp`
--
ALTER TABLE `t_participation_ptp`
  ADD CONSTRAINT `fk_t_compte_cpt_has_t_reunion_reu_t_compte_cpt1` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_compte_cpt_has_t_reunion_reu_t_reunion_reu1` FOREIGN KEY (`reu_id`) REFERENCES `t_reunion_reu` (`reu_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_profil_pfl`
--
ALTER TABLE `t_profil_pfl`
  ADD CONSTRAINT `fk_t_profil_pfl_t_compte_cpt1` FOREIGN KEY (`cpt_id`) REFERENCES `t_compte_cpt` (`cpt_id`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `fk_t_profil_pfl_t_ville_vll` FOREIGN KEY (`vll_id`) REFERENCES `t_ville_vll` (`vll_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Contraintes pour la table `t_reservation_res`
--
ALTER TABLE `t_reservation_res`
  ADD CONSTRAINT `fk_t_reservation_res_t_ressource_rsc1` FOREIGN KEY (`rsc_id`) REFERENCES `t_ressource_rsc` (`rsc_id`) ON DELETE NO ACTION ON UPDATE NO ACTION;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
