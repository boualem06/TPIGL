-- phpMyAdmin SQL Dump
-- version 5.2.0
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1
-- Généré le : sam. 04 fév. 2023 à 15:48
-- Version du serveur : 10.4.27-MariaDB
-- Version de PHP : 8.1.12

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `darnab`
--

-- --------------------------------------------------------

--
-- Structure de la table `announces`
--

CREATE TABLE `announces` (
  `id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `public_id` varchar(255) NOT NULL,
  `type_announcement` varchar(255) DEFAULT NULL,
  `price` int(255) DEFAULT NULL,
  `street` varchar(255) DEFAULT NULL,
  `state` varchar(255) DEFAULT NULL,
  `city` varchar(255) DEFAULT NULL,
  `created_at` date DEFAULT current_timestamp(),
  `area` int(255) DEFAULT NULL,
  `rooms` int(11) DEFAULT 0,
  `type_of_property` varchar(255) DEFAULT NULL,
  `description` text DEFAULT NULL,
  `dimensions` int(11) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- --------------------------------------------------------

--
-- Structure de la table `images`
--

CREATE TABLE `images` (
  `id` int(11) NOT NULL,
  `announce_id` int(11) NOT NULL,
  `image` varchar(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `images`
--

INSERT INTO `images` (`id`, `announce_id`, `image`) VALUES
(2, 636, '20220120_142621.jpg'),
(3, 636, '9ddc0330-a3f9-4888-873f-68071bca9a84.jpg'),
(4, 636, '7fb327c8-fc51-43aa-91bd-04d3c40460c5.jpg'),
(5, 636, '6a5ce9cb-d744-4502-8c1c-981b71f807c4.jpg'),
(6, 636, 'e4364b8c-9f21-42d8-80ef-1f0e64c90ae0.jpg'),
(7, 636, 'b26045e5-2c94-41c6-b571-cfb72eb0f451.png'),
(8, 636, '20220120_142621.jpg'),
(9, 636, '20220120_142631.jpg'),
(10, 636, '20220120_142633.jpg'),
(11, 636, '20220120_142644.jpg');

-- --------------------------------------------------------

--
-- Structure de la table `notifications`
--

CREATE TABLE `notifications` (
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `announce_id` int(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `seen` int(1) NOT NULL DEFAULT 0,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `notifications`
--

INSERT INTO `notifications` (`id`, `user_id`, `announce_id`, `type`, `seen`, `created_at`) VALUES
(1, 10, 636, 'save', 0, '2023-02-04'),
(2, 10, 636, 'order', 0, '2023-02-04');

-- --------------------------------------------------------

--
-- Structure de la table `orders`
--

CREATE TABLE `orders` (
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `announce_id` int(255) NOT NULL,
  `status` tinyint(1) NOT NULL DEFAULT 0,
  `message` text NOT NULL,
  `created_at` date NOT NULL DEFAULT current_timestamp()
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `orders`
--

INSERT INTO `orders` (`id`, `user_id`, `announce_id`, `status`, `message`, `created_at`) VALUES
(2, 11, 636, -1, 'gg', '2023-02-04');

-- --------------------------------------------------------

--
-- Structure de la table `saved_announces`
--

CREATE TABLE `saved_announces` (
  `id` int(255) NOT NULL,
  `user_id` int(255) NOT NULL,
  `announce_id` int(255) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `saved_announces`
--

INSERT INTO `saved_announces` (`id`, `user_id`, `announce_id`) VALUES
(2, 11, 636);

-- --------------------------------------------------------

--
-- Structure de la table `user`
--

CREATE TABLE `user` (
  `id` int(255) NOT NULL,
  `public_id` varchar(255) NOT NULL,
  `nom` varchar(255) NOT NULL,
  `prenom` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `phone_number` varchar(11) DEFAULT NULL,
  `address` varchar(255) DEFAULT NULL,
  `is_admin` int(1) NOT NULL,
  `password` text NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

--
-- Déchargement des données de la table `user`
--

INSERT INTO `user` (`id`, `public_id`, `nom`, `prenom`, `email`, `phone_number`, `address`, `is_admin`, `password`) VALUES
(10, 'e236a5d0-a7a4-44f0-872c-d86c7c20a488', 'doudou', 'douou', 'nabila@esi.dz', '0565556549', 'ilolalalalaaaaaaa', 0, 'sha256$9ZJjZ3wRU66ArEwH$bea7216b1a1a7a505edac442c9cf5f1f1a98d04ed8eafcc5094fc911c359c0c9'),
(11, '52ebfe68-d777-4027-a62b-437b490e9c53', 'doudou', ' kkouou', 'nabillllla@esi.dz', '0565556549', 'ilolalalalaaaaaaa', 1, 'sha256$bMFm0uSMXN8i35nr$4730b79cff96726d2106ac518640949d6111178c8b3731d7adf6dd4f1dfc1599'),
(12, '6afca590-d1ce-4207-9790-0e1999b29661', 'Fake', 'User', '43dc637d-c062-4765-a301-a2edb18f60ae@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$w6BqUs5WzuShGDZs$e05ba168e3dfdceef3c395282f4f6b57005ded7877141eb7f83da9a7cd005575'),
(13, 'a04c556f-f97e-4212-8a80-32011def13e1', 'Fake', 'User', 'd732f70a-e48e-4ee7-85d9-b24a6aa7c483@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$4uMKJf4fuMCjXass$4a6ec3962fedb793bcc096b2ec6a41089d6ea4afaddb625b3e3849e61a167a13'),
(14, '1989f502-9f16-4dd0-93dc-f5416ddc6d24', 'Fake', 'User', 'e51f331f-77bc-4f2b-acd9-83a79a7682b4@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$9VYLD0DBauXM08Qn$ce77d4ba881bacd9564395fec57ac2dde97f6dc03b60cb57bd561362949887de'),
(15, '65549592-6f7a-4bca-9214-35d99424d6f3', 'Fake', 'User', '0828c23b-0ab9-45ed-ba8f-45edf3d10118@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$IzF21IeCaUC0VmQX$f80e1abadb4a002c99eaf88c988aa904a4e53e4374e5d2e79c9b25e0fccc1daf'),
(16, '9dd94c4d-ef61-402d-908a-99b46932da17', 'Fake', 'User', '6320ba59-8daf-4387-b9d3-f1468301e922@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$iFue7POBLPBPAOIr$cfdce1f65510a63015f33d9b1a1f98ef9d274d525e93f4e8451be191b69c76c4'),
(17, '11b4b75a-4a8f-4c73-bbb8-a26c239f75f8', 'Fake', 'User', 'e9c851f5-9c7d-4725-a1bf-972f3eda931d@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$HIfWDuzGW9svxCYA$f8e96efe9901a309f05834971ae1bba1bc8e73ca44dadb34e33ada32496d0eb0'),
(18, '2ec61fef-4296-4569-94a6-46889dfc440b', 'Fake', 'User', '91b1ddd3-7bcd-48b7-b628-542ecabf3cd9@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$mNdqKfTXPcBLTGHt$cc83532695c0181298ec7df368c8f8b9939e14495d41e42df14de8acd5e9975f'),
(19, '8d247ea0-241e-4f07-9e75-01f89fd856cf', 'Fake', 'User', '2dc74bbc-3857-4471-b476-e0c123db2bb2@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$buuntZtgRiiELlHH$9d5289d0eed908c2afd321bd9e4a0bbfbac9dc035f37fa793f6b1b8dd647b3a5'),
(20, '96c707dd-2430-4db0-9016-a24c61b50583', 'Fake', 'User', '2d5be5be-af58-4d71-a136-613661d9ae7a@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$ceMU1qnYN1ticjOR$95b28d64662d325de41fd7b18e85d2eddadca965fe0ba30d00ebe21cc4838c68'),
(21, 'ca01d895-f243-42a4-b1dd-cb59bd6f514f', 'Fake', 'User', '938f0663-79fa-4e27-bf7d-ae223aeec769@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$PSubedSp9Qv1oKlr$085f60c329075c63e94206f5c057ce91de87c97dff586a085a9032eb92bdbad5'),
(22, 'a0f31679-a8dc-480e-968b-b6e833b7bd57', 'Fake', 'User', '694529a8-7552-4c64-9a0d-164cb38f68fa@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$NVLx7BY73aHzc50O$1577e5a080dedd8fb6dcdf87b76f100ce7cc3c825da485f96fdc0e1703b42eda'),
(23, 'c56dc23e-bfe0-4a1d-8879-771dd4804e6a', 'Fake', 'User', 'd3c7b59e-6a6a-4749-bfa2-7778ebfb8540@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$HrvzNrFSYHB8bUzv$5ec96d6694c3302c50f264c952e3e7842ba3416a52e6180bd492cdfc0a0122c1'),
(24, '4646b0ad-0ded-457b-8dc3-f2d58cb68fde', 'Fake', 'User', 'ba3de0fa-ef5f-4685-8923-47df17903cff@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$FItIkiVVNxCMW4jm$d7780b1b31ca352b3c43b712f5d3f98033c6cf1c4b76f29c2b88fa6b04d59ef2'),
(25, '06dc4cf9-a1e1-4164-843a-0ababa11009a', 'Fake', 'User', '2e1055ef-4e8b-48b0-b10e-4eb5ad248109@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$D3rZ7yJQyjVQR0ys$4c38bbae21425b1b118971185f0db072b65223adfb2fde9b4324e6050a0d4168'),
(26, '034960b2-ad6d-419e-aa59-49ccc79e16ea', 'Fake', 'User', '281d5d8f-c755-4afe-bb76-2b2218fb7169@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$Ne1G5ofiqnF1ZGDk$2459793c40d98b7c60453deeba54069614b885dfbbbc8bd4ad8b649258efaf30'),
(27, 'd27ba978-bbf8-4197-9e59-d7b7e783a33f', 'Fake', 'User', 'ed1b2e21-c917-4bec-9c0e-091005ebe6fe@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$oJLfNckInSAkibgW$c6c39f35fe1bf92a23ac6d697f3578cb5b707139c0bf0be550ebb178a336f6ee'),
(28, '3901d73a-5cf5-402f-8ae0-ffe85415282f', 'Fake', 'User', '746339e6-e772-4a49-bd42-05eda264fb41@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$KeGlQhV7FhT0KG1a$525745e26649a49ee40c0b43ef3f2ade5735272ec13f7a0dfde8fd3b4a91bb33'),
(29, 'e773d261-c570-4001-a2d7-80990e1b1732', 'Fake', 'User', '2a83feeb-feec-4a81-8c0a-3ac3d40dba37@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$qO3KxfXFhtuXaA8M$83e7c802fb20732203c7dc81fe2b881baa28a28959120bf6425df5fb992767d8'),
(30, 'c0293bf5-59cd-4aa0-99fa-efd068e65ce9', 'Fake', 'User', '36b734c0-20a5-4fd5-a222-dedb63b7efa3@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$GSHc0MezAvGD3c3a$5d4126ed454788c765854ab5f630aa87f55f0521100ce5d382288b09fa8a6c95'),
(31, '7121b68d-3c8e-4777-af88-a6620e187547', 'Fake', 'User', '1659e699-bf98-469f-b887-8b3ffb965b2a@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$ZFW7k2O61s1iqige$f021a2388f810a2cbf2ca15e76d615cf96c6d0264fd3fa90d7ef44a0d6fdacbf'),
(32, '50fc05a9-e84f-4cc8-8799-cf354efea811', 'Fake', 'User', '75e99bd6-6165-4c28-93b2-d7e359d24e0f@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$0hKa5u8kMCIvtDYf$68fc587e4a5bfe43369b68cde4dcf39ddb81af544229f7baebd23f1740b57ad2'),
(33, '289aecc2-f80b-4b0c-b6d5-34b15f2f75a1', 'Fake', 'User', 'a53a9f8e-5a4a-489b-af5d-b4ee93e61a49@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$kCvB3aMHLMJ4GubH$64b31422a1dd829d332aefd26aba2cf9eab6543cdfc70eb7a466bba67993e62c'),
(34, 'ab407606-f0a5-416d-b1b3-c29cafea4e13', 'Fake', 'User', '708434b0-9d8d-4429-aaa4-22556270073a@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$UFymPMZU4VN5umMZ$344ba2ce0426ece55fbdd8f8f4021ebf079f36f7ceec6367b05229c0e67e531c'),
(35, '1dc63a46-3550-4462-9d10-3d1ce9e9c413', 'Fake', 'User', 'f8883eb1-682e-4505-a13f-d620c8986a07@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$Wah0Sevf9XUBp1AF$ff7eb874ca94c46a666a09cf7976b2772017e0f30a5db764d8b41c0db31ed588'),
(36, 'cbb1e0ef-523f-4604-90ed-9b0702c6ae07', 'Fake', 'User', 'af677cb4-7e8a-4e6c-997e-729e5f054225@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$nq1G3j90RUbRTvpf$0a27dd4895018c0ae6407a043ca9f898bbe32f9da28c7c2204f32d5364d37962'),
(37, '09c00131-eb4c-4d4f-8237-141eb7e03793', 'Fake', 'User', '915f8d1d-e8af-4ab2-9fa6-40c2d9ec57d5@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$GFMguuDOvTsAdud4$2f8f022d54890358653ae091739dc9cd3da81247e8977bc56218e4a7060319a2'),
(38, '210e708d-f149-4004-8fea-950893235c64', 'Fake', 'User', '27062090-f786-4ed5-8355-c77dff86eb20@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$WveBdVWah9O0obUe$cd2f8078b65cbe4d1f9227b6a4cfa93f87d8b5acd5dc8c9d11d9c51d6c4e3e6e'),
(39, 'c015063f-9992-4290-867e-ecbaf4c0744e', 'Fake', 'User', 'be2fd372-dbf4-4e42-b76e-62ae797a84ba@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$yJ3cPTszFVLXfQjq$ac2b29a9b3646b5648fb08cd408cfcc64edaf44dc5cb7b1e023695a2485fdb1a'),
(40, '3a330560-750f-4194-a3b3-322111d8ad60', 'Fake', 'User', 'b723054a-a256-4b0f-9a4b-6e4719d58313@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$yPaohcy1D5BSAEDl$f3b2c316e36c616d6221b7e034b5320c5125f36ad172646e8b0779ae157b66d2'),
(41, '46f6f043-2293-42bf-ae3a-f457bec88338', 'Fake', 'User', 'b47f8058-f789-4fb1-b556-6b71d68b1aca@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$LiooOUADDlOROAtk$a29d36c5b64e47e84c4089a5164079bd3d8f0309e34dce0dbfc4783081979186'),
(42, 'fc157983-9e40-42f0-9f92-62b97a85599e', 'Fake', 'User', 'aafe271b-a75d-4c5e-b945-761026338a3e@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$tYOfGcYI0KsqGDCW$6fd42f060bf3d009c800822aeb8f2ae025931d607dbba997da5add5fd5c9a3ea'),
(43, 'ca0f3eb9-7ee9-480f-9b15-6b0239924e0d', 'Fake', 'User', '63c10d02-b1da-46bd-93c6-a9a03e249075@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$l0mRAzqT1O3C7gUm$77e1213175badc77ac5df93b906b30ccde62572d73ea7a1ebf139de523a11741'),
(44, '5d1d2b6e-a063-4594-b266-cee94a0c163b', 'Fake', 'User', '1285a6fe-e138-4d25-8da9-8beb5f84a685@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$VDnak179Xe4eV2w2$54b47a7935b27d0c73e845dc0eed61d8b522736c85e703a1da6e26a9da5d3db1'),
(45, 'e6f28216-dc54-4353-a301-2b6a5815b69c', 'Fake', 'User', '4f5c7dec-afa3-4cfb-94ce-566f8e5919d9@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$urDvx0pEFosSQwt9$15b3d742917fe383741f8077a4f4c9268a7e961b6e17492eb9cf8cec80b9d092'),
(46, '2ec93547-8e53-484c-a592-6fa0e48c4b70', 'Fake', 'User', '62d3dd3e-42cf-4e29-91de-7cb1cdff3290@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$iAIooi43xXsJr0d4$46c26163ecea19ee7da9d40cced314d20de29e0c37f7ed3aab8decbc302b976c'),
(47, 'd377fbff-bb4e-44f1-ae04-10007ab14c5f', 'Fake', 'User', '78039054-6f8b-44cf-b9d7-cf92f05f40b3@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$7DcxcMzTZlUlMbhs$d77861ca43ff65d9ce2b4f2eef9a78277a3c4120d87f9f3cd1dd316bacf70c9b'),
(48, 'ba15c94d-9983-4c64-82c7-2d13de4d327d', 'Fake', 'User', 'c72a3403-f5a6-4566-be34-b7bd811dd8ef@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$PfYV7tCEGhJjufIP$21d1853e18a5d82e35dd7735517016df596bbd43bd420952727f4cf55c79d77e'),
(49, 'df29dc83-dd9e-4388-8d2c-895d54ea6ec8', 'Fake', 'User', '648443bd-ef68-4084-b9d3-c86498e69582@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$Fo7GVAfbkWyniEdm$55d5f0857302f21afaa6eecfe1bda4dbca39bf4e5515739b42123cdfa7b84f55'),
(50, '60fa365c-3f85-44b1-8665-4db898165009', 'Fake', 'User', '18fe2b68-7f4e-4af1-af8a-71f0ef19a0d7@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$l5ICeWtn0hrHUTw5$4c1b8dc1c4cf7dd585646e710469d821b785d3ad255383ba8a63e73fe76e5c8d'),
(51, 'ce3a0eac-08fa-4637-9b16-c62f71c7503d', 'Fake', 'User', '00353e02-f2f3-475c-a672-cba258820edf@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$suZSUOxj1TMTO0WK$e8f3f8e20e0a2ae85167dfa68463d2c578342b36543282eaab38a2a3a58e4a68'),
(52, '2f9ccc3e-43e5-4ec4-9dd6-a68b412bfcbd', 'Fake', 'User', 'd077e4c1-41d9-4276-8c67-4fa077fabf7e@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$L7UHTQZn7HSrR21L$14a2873263cc342abbd2d986d77f0a44647412955db523360cdf7e8a9c900ddf'),
(53, '7bed155f-1d4f-44a4-8004-c69b4e3bca76', 'Fake', 'User', 'fb511286-cb3b-43fc-924f-e5d02a3e7525@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$oNHEtoNQQUDMdQQY$1cb408358f3005c47407c44976a43e3659d4ccb622aeaba59c1bee925eec34cd'),
(54, '1a4b5031-36f8-4a0c-a74e-589f42972529', 'Fake', 'User', 'a1689726-1cc0-444f-b248-4beec84a5d1f@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$UDpIucqBSQ5lRSXc$62f09320c57ae2ce0ad36abd7a316dd0ff894649dec7444b99366e6c15dbad4c'),
(55, 'd87569be-36a5-4fa4-9754-f8cca8a1ab36', 'Fake', 'User', '4908a6d7-3f6e-4c42-ba2a-1a26a4f81ab7@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$c4vspE20qybMnARd$bdc1ebe916160b0ce03e96fcd0af6a089d3e51cba93dd6a6e45689c07cd92107'),
(56, '02a00cbf-a249-40f6-82d1-5f40ee177d45', 'Fake', 'User', 'ff5f419b-af0a-449e-bb75-b06a2b3dcf1d@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$kHTbAKK8CxfzTlm2$c3101c5a21d4b4d2bb0a8b4c40a717bb588de85ac97b0bebd57b4a1fab26d23a'),
(57, 'ee52fc30-af5b-4473-a3b9-6664a2bd99dc', 'Fake', 'User', 'dc419ca8-c572-4b45-983f-01ae9735bbf0@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$BidaY56Z4LHtftCD$8aa21f1f5399b93c9830632cfd6034986127a538f774b99ddbbbedd48f735e3a'),
(58, '19897525-913b-4511-9a38-73a69b3bc607', 'Fake', 'User', 'c128f946-141b-46a7-9d73-9c0d4372ad12@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$4sGSEXE1nQqwh9E6$4ae088cda9c7df7c99079c7122a765cb53b5da54448d69a0c4d967ca226e074d'),
(59, '2c01423f-7829-41df-adfb-4e9b9003a22b', 'Fake', 'User', 'aee94baa-ce23-41c6-b4ba-391cf87cfe2f@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$5tRWwqKmesgE8p6w$128c0d09e235b5c376c8db03ee7f7a6faf6a163417646401f96c4f50b41241bb'),
(60, '37020b35-b1e7-4293-8b6f-ae748c0ef3ff', 'Fake', 'User', 'c37e0f3b-9a20-431c-9154-0dc5139e9031@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$9yuqkYRpFJHLlUx2$892eb745cc03116869fd2e3131a0983c20d1f5df995d689a78e0060466976ca9'),
(61, '3e7240b5-7776-4d9d-ab01-bab54b3f9a51', 'Fake', 'User', 'c367e7d2-2fa2-4636-a4e9-58e9b47e7e32@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$nO7HHMJn7tses8Wi$b60349c41e7007c503c1134843bc8026866b1951107ceeb82b2ffef5e537cee7'),
(62, 'a054ec10-e715-44f0-98fd-5d916bef70cb', 'Fake', 'User', 'b05019c3-76d4-445e-98bd-69986d9501a9@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$tnC9JlEFr5vKGCeV$d7f3bea01890bf1d07941630dbc004567399d8494c932f3438d3e58ee21c458a'),
(63, '165de0e8-19ee-406e-8819-7daefb832f66', 'Fake', 'User', 'd92e8b5a-5d7f-4a6f-afda-b84317dd0d06@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$torMzLwbj3rLmNBk$26ce9972ff2826c5bed7b8440ec1b367bc13fde319a250c2d4665500cb29b74a'),
(64, '22f71a84-b19f-40dd-967e-cc2754d308f3', 'Fake', 'User', '7ca460ab-64fb-4bd4-aac4-06e8b265763f@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$i8v3rBJfsmv9s9PQ$3892ae8c07c56d49e0dacaacbc978818230541da131f2a755c24b3c6e73bf98e'),
(65, '5ea9ee1b-a96b-4881-896c-61207dece288', 'Fake', 'User', '92b08a5e-3d19-4993-851a-39d5032cbc85@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$JrH5oxa3Ai2f7ubU$9964979402cdbb2a155f3b6cfbc91dee98745315e4d3eba8697364943d541057'),
(66, 'ecb8459b-4ea9-4ade-93d9-f67a638ddbf5', 'Fake', 'User', 'e3c18f61-7426-4a99-90f3-da4a1293c125@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$CHSXqn10xh0SnM49$d2995fec5c1d657ee90ddc3a7ebfb501822e346d199c1bcbc81d06d1227f9701'),
(67, '77024b58-5018-452e-b187-93ef48c2d398', 'Fake', 'User', '548b7996-9b9d-477a-a4d8-41a537979fea@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$tJE6I3R3kpfruJVM$b59ce12f065b344051cc21bf88aeb9501d8e8d8c319e21a153bbb2d053be85cf'),
(68, 'eb421c5b-8c23-40a8-b6c8-4952db00bc08', 'Fake', 'User', '559018ad-dc8e-4ea8-9839-3ff4cbceca0c@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$0sWzdGMTPdjYGjDq$f438327f42722d59fb300982034ebc082943abad022643e9c8eac518e6c90c97'),
(69, '7d98f0a0-1204-44ae-a7fd-6492745bb602', 'Fake', 'User', 'e40b3940-e472-4873-97b3-a060663b0c3c@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$G9933jZsPYIclSTN$fb60ba07a00da491c968bc91f5074fca682db46d3699c6f3e4b15d2eb7e95e3e'),
(70, 'effce26d-993d-4fe7-9667-9462f6ecfb4c', 'Fake', 'User', '25b7f598-006a-45ab-818c-d52f148d2436@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$cFDZcgwHeH0yeYMI$5023e7328f470d83cb24ba0bb056a82f52a050a77899ca544c83ea4c834138ea'),
(71, '816b2e71-8006-49ea-b5ca-03aa7cf93089', 'Fake', 'User', '8a23492e-cf31-441d-8fce-f2c8a591b2ec@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$jA1ITQoIYHWLD6hB$3ef3abd44a084f47d48a781852b5055ce849a7f922bbe74d25a6a50a1fd181c0'),
(72, 'a5690a8b-eb8f-4eca-a8be-f6e59ceb7005', 'Fake', 'User', 'e68354af-3dc1-4bb4-af21-3543f22106ac@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$ivNDUHaADPFUgCvC$f482030a195cf0f14656db8915b05f7bbf88a77a705e6d4ff3ca49acb58f40f0'),
(73, '3e100832-9484-4a23-88e0-35657bc51ec8', 'Fake', 'User', '45add136-0ee0-44d6-b733-1a41c5e9c488@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$kK9LtOAySeHk3jay$ace40911167230cda1cb2373e7ca4ea6c1df95d0b2237cf759dccf95be2b912d'),
(74, '2fc8910f-c4cd-4a11-8fe4-8bf920a6e4ec', 'Fake', 'User', '9ea6e7a6-1e4b-4cc6-ae26-8cf566c64b81@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$E80APyr83cPy9zZ1$ac7289ccf40d14c574aa7144c6c1b67caa448a6b85a0436bd635a210ea9f7ff1'),
(75, 'c65404be-5ac7-4b8f-b32e-ad62a8a20a3d', 'Fake', 'User', '41ba55b9-6c47-49b0-8787-07d73471f582@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$tLKHAs72Z5JYeRCG$bf7c6c54af914b71434d2665a89229f14e2f3ed9d319eb2b359497e50f7faa50'),
(76, 'e6b8e543-cdbd-47bd-a0bf-e77fa02721b3', 'Fake', 'User', '0d3707f4-31fc-4d2c-9674-abe3530ffaaa@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$kvWI0QU6RhYOqpHx$a94b3563c45b84cdf0808e4124b4b725cc54104f52d68c5d6d7d57c6c1dd5882'),
(77, 'bae2e635-cdf2-4ee9-a357-da8bde9cfbb6', 'Fake', 'User', 'f3e09220-1ae3-4a04-a5e3-d506e7548e84@gmail.com', '023224482', 'Fake Address', 0, 'sha256$rUm9iGGjqx7GzFKq$abb20d99859849aa74ad2c99b2ad321998000cdbd4986ea793671f8e7633716b'),
(78, 'dad28a4f-d78f-4806-bc27-0a858317c560', 'Fake', 'User', '155fed4e-69c0-4f7a-b043-c75746cefa07@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$no7vSWdmXusyjQVh$f1bc0694f66b4f7e55b05466c31b1cc6832612cdaf0078ee02b94e3a46fd867e'),
(79, 'c7e87ac4-cb11-405b-b756-b9266745a314', 'Fake', 'User', '64b7c7af-e2ae-4b8f-ac7b-9850013c8858@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$ZEfkdYVvCJhwJ8CK$73f31e720c77af5bea73a2180e5b6bcee1496dfd174f76b4fab19826055f1258'),
(80, '202f18f2-5ff7-409b-8f82-6b7d534a2664', 'Fake', 'User', '4cccaab2-5402-45cf-9408-1f0c4920e9fe@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$m4S1cDTZE2Rq40cu$e778cb054552ddaa09af6c8366abbf56542749a099559b87289e7cdd12565f58'),
(81, 'c1023961-2fb8-4543-b41d-4931b9a8f143', 'Fake', 'User', '85e1697d-5754-437e-ab47-d16aebf4fdea@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$3VqEL7ngWJhOQ3qe$322b7eaea1dbc47f2c3aaad047894935a1fe301146f5d29406357f6ce6901d19'),
(82, '9a5ca68f-4a42-4ebd-b411-b81fdf469739', 'Fake', 'User', '4524017f-9192-4850-83f4-e0ebe502ad69@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$7zW9j7ss8ReSqFCm$acd4a113e2c9e54d10a8042528b3587fb0d393e8217c6cd978c38fed8b9a79d4'),
(83, '49bab435-777d-4b0a-992f-08d4cf425a3e', 'Fake', 'User', '04c59fed-f442-44b1-a4d7-fe7d5ae02180@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$QKVWam792sOXxHUN$e7fbd8a33936f98b2dc0c46642b5f08474ad404a55900914e28e09ca0b90254b'),
(84, '82edb100-2c3d-407a-87be-c6e7b0e6686d', 'Fake', 'User', '5f4ea056-dffe-4fc2-ab9c-5590e7761922@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$R8Any0xO8Czn21ua$897e4cee27e03455eca3564200c824ff75236f51b9a510074fbc40da622044bb'),
(85, '6cd8b709-4aca-49c2-96c8-923ad02bebbe', 'Fake', 'User', '537f2f56-abf1-4e96-bc28-515aa8493d07@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$wTldgrPjNsa5AGSa$fcad85caeb6090b90608744401d4bffe057cb06021842f07b0d3d2f47dbd2419'),
(86, '079f2d30-a745-4330-84a3-4a87c6f794be', 'Fake', 'User', 'c347c20f-93dc-4c99-b659-9a2903de7337@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$ud74GC5gBIy1xekq$8269d4b4a1a3433fd037f7d844c743a9fee69dc2b1d11372f031bafb304311c4'),
(87, '71ef2361-343c-4a32-9072-05a918d39890', 'Fake', 'User', '188ae836-3f25-4ee0-bfcd-56556ec07aeb@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$m6m7PuiAxa2qxJSi$d42e08d22f290f6dbeb0f58ee27798e962f89eb955ef0de87393c276e5e4ffdd'),
(88, '666074c8-6c32-49d5-b634-f912eb1f8e25', 'Fake', 'User', 'cdceb525-f2a5-4820-aece-daab4f94be1c@gmail.com', '023224482', 'Fake Address', 0, 'sha256$7PLs8NiHLI2WAr61$3f4e5c5521a572e96a51b58a479d0a8fe8b2ae29144309a3bcf2991325b04290'),
(89, '92bf0505-f50b-47f8-af78-d46fa393d35f', 'Fake', 'User', '1eba3027-e37f-45a2-a09d-778da26f241c@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$5uOIHW5UTlqJOBxS$5fe35800360a1d61a26ea508d36d49952a43575555ef87181d2f53c3f27259b8'),
(90, 'ee204ec4-6d39-4abf-8d98-d6a455515872', 'Fake', 'User', '2d9590c9-574d-4e01-a976-d81f4d99f23b@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$36Rzv94LPqT2d6wJ$3a225c21053b88db5116788718c0b7d78ea261180d96e12d0ac1d430d62e0789'),
(91, '10f7a5c3-54c0-4639-acd9-7d526b8b2fa8', 'Fake', 'User', '67ccc07b-8912-4058-978d-7aa574925313@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$IZ1WrCHF8qNJkiTd$495cf43fbeddcc2fe6c995b1f9dfdeb01b5cc1f3dc8fdf9f2c16c270bc5f376b'),
(92, 'bf2af50e-bdae-472a-aac6-4a5bf856d3ce', 'Fake', 'User', '05fcc16b-aefa-4ac0-ae5e-eee52abcaf90@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$vFYfPRSROmIwRWye$fcb7e983d8e3a005539c0e05d60710f7d5db1d3eb0c28543af3641512837638b'),
(93, '07716609-aefc-41eb-8d88-81cf235e7ae1', 'Fake', 'User', '6315e09a-f266-414f-84e5-d78467ee32d8@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$rk0WyO2AXM9pKB82$eadb3f32d2dce6d9df28621c00323c751208d223789b3b7aff542ff8af690582'),
(94, 'c4b14777-38bc-4b26-90db-2962b512839d', 'Fake', 'User', '0095ad14-3770-4708-9ccd-18e366f076a8@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$nUrpwTzkuQCwLRhT$8487b7012b6743138b5c5342a5012a309e4399ad85cff7553a86b8b91c3d2ee3'),
(95, 'b476d131-87fd-48a0-bc21-a4c32926d215', 'Fake', 'User', '2fa2ae6e-b4b5-4665-8894-428fe3c9afe9@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$aajh0jw7Om5VK9Ka$084f802c64ede8930aea2a002dec73cb6445039d39721b47c3d032b26c4f1f90'),
(96, '3fea14a1-2d6f-4b05-bd79-9cb7c06570dc', 'Fake', 'User', '19bfd813-5c85-4ee7-9e00-408e75ea4111@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$TsvF2h6b9eg9MUfW$227788cddc943310f0748249ce9cc740eaa14f7dab042855554e226d858de231'),
(97, 'd9e8152d-08c2-49ab-9dcf-fe7d58db7d77', 'Fake', 'User', '2880d313-3566-4c97-8413-bc9091209f74@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$cml0BLQOgo6rUVe9$0752d8c06cfd7a2f8fe61f0813784876c37d23aec66c5206edaa6ee4fd655413'),
(98, '53e16cdd-a136-44e7-bab6-806bd6aa869f', 'Fake', 'User', '43c49453-d62d-4c8d-ad5b-7744ae884014@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$m0FNWosPiVBiDtAM$88af5c187baefb999caad545d2b112beda7ca1e56aaf0c8eb447ff6c5345bad2'),
(99, '0a89d78a-6c6b-4ea7-83b1-c16157f9a49a', 'Fake', 'User', '5ef74f25-6d96-4256-a404-e937fe98da96@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$mVMfoh6VgZiEOEE6$b7fd67821ccc2c74c5601704a08d0e4eaa326dfb026058e67d625f1872caa59a'),
(100, '335501bf-e10e-4125-a487-3a02cf886fc7', 'Fake', 'User', '4bc9e820-dd54-41f9-88e1-cf9b2a5a84a4@gmail.com', '023224482', 'Fake Address', 0, 'sha256$jIDdJTDMh1q4j5as$0923b515b3bee5b43f49233836dace8e4ea9cad098b1e58c02d56ff5e45a70f5'),
(101, 'd93327a9-184c-4215-b48a-091a39fe1ee4', 'Fake', 'User', 'cb3fa8b6-c910-4623-9437-72a32e613c52@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$T8Md2Nuoab0xr0l3$6ea82b2eaa53391e2c0b91db55438442be5e11b63675d72bc530318d96a7a447'),
(102, 'bab842f2-01aa-41a6-8dd9-b0e62d49f8f2', 'Fake', 'User', 'cff9c197-4918-47be-9e2e-e18824a92f5d@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$TSSjyTgrFXsT5Qox$679fc112c79815c022f598c5d9da08d85453501dab68a4fa2edc35312290caa2'),
(103, 'bbcdf903-fd8f-49e1-bdca-f5fdc649524e', 'Fake', 'User', '62febf74-03bc-4dc4-be62-42fb3ca7a3cd@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$03gNORMDJwk7YKUJ$d1bf3fd6230302b8c1e63529f79dfecceee7d30bbc8862c917fec38802833470'),
(104, '6fed7436-89da-4f5f-90a8-4f46e4b409b3', 'Fake', 'User', '0ecd5289-2b76-4f22-87cd-1cd1019c83fa@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$hHc78Z1T6r3sas7L$99decceab865eae85c2469f7c8a898935ab59379dbb15a0b346f13726e680df0'),
(105, '126cd2b1-c5d0-48fb-8740-58b148f13f5c', 'Fake', 'User', 'a1a63b6f-853d-4fae-a838-1d50f8cfb9a6@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$LpyXgc3ljWjtKj0F$f3032ca8a0a4f9592f182f6b5fcd7c2a0ee36c43424b0af1b167e46ede2f460b'),
(106, '93db6780-704d-47b6-857c-65ed9cd05649', 'Fake', 'User', 'd4ea96d0-0e86-4680-bb93-5fbd46420b39@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$Ck63T7cXZtu8fbvi$aac62fca6c9be2a197cb9751406fa1827037da38d9141a63380ca8b955bc69e1'),
(107, 'f20e20fa-cbe6-420a-9d0d-6f442b8f2db1', 'Fake', 'User', '0beebb4f-4f12-4af9-a514-09d82d02637b@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$7HJVrZOyHeZnfGau$6ca4bb0d86351853ce49aca0591c556792a0936ace0f9d9ad630a74d55fd61d4'),
(108, '200f98d1-d5a1-4e20-8b4a-25a2aa5c57be', 'Fake', 'User', '76730357-dc13-49a9-85b5-7ac1441e867c@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$gSYnRcE3q8CyZGWm$52d76fb262c3ee4ccd10046d48819d796c27c5ebfdc2f19eafffff818ca45f77'),
(109, 'a3b7e630-15db-4210-895b-cbb0069f95b2', 'Fake', 'User', '726c7b0c-aa75-40d8-87ab-6f4b84e3ad9e@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$8Jzrp1Q8S2Ntf3IA$e921998760c7d7691a04f10ebaf76a3fcc1743f8e203e542e74bc9d22c2032bb'),
(110, '98c14dae-8454-4ada-93d6-a6b711492274', 'Fake', 'User', '3dcf2d53-a4aa-4ba4-a545-db69c601c6da@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$y6bTcbfP0YTFCCWc$b31e1899ce0424d443c625410084555b2090cd02620dc3b78f4e08ed9f529303'),
(111, '7540d5f2-8b1b-42e3-bd80-87fed6f086ad', 'Fake', 'User', 'dfa58566-420e-4cad-a375-33862a43ae68@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$jBQCKRRcJ4EmQvCc$7994e39da7952b084f7d23901321ab097673ee1a350f0fb7467127a02708e58f'),
(112, 'f7b2588b-1ad6-414a-a558-ae4860da9ba0', 'Fake', 'User', '2d35af39-630a-4866-beb4-af40765c9788@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$ZMqKK9LuQXMWinoY$2bd9825ada49056d7d467d580acdd050341fa2fd5558d03e7001b043ba8a8821'),
(113, 'bcdd9411-9995-4ee9-af74-8e4f66955e16', 'Fake', 'User', '729cb365-15eb-4f01-96fb-f1398796cc50@gmail.com', '023224482', 'Fake Address', 0, 'sha256$xdXnGNCvxnUIwLty$73e72e0b4b03b3ae220f8188e55aa15b9ce9a5740c5a20003709d825e17515e1'),
(114, '175d1d44-b262-4792-b71a-23c1ad7c871b', 'Fake', 'User', 'fd9bc3c2-ddf8-4c08-a49d-0f7f4c18abce@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$aijgJY05l1g3Bqrn$194545b1846a2cd840b44d89d1cb328343acbcc80c977580a976646e887f0b66'),
(115, '7ddc5321-be54-4b28-b993-bf14e37a1f6d', 'Fake', 'User', '0c2811de-7535-4ef6-bfd7-d8b29470e306@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$GYdYOx7ivXUslC9k$c5fb3958acfc18ed1ee1867e93f10ef692927e0ba14b8f9756c3f1960a0e2108'),
(116, 'bbe3aa10-ced5-44ec-b555-f5e11ca8f53d', 'Fake', 'User', '6494462e-1746-4e4e-96ca-6b35d76a39ba@gmail.com', '026158208', 'Fake Address', 0, 'sha256$L8slH9BVeWxvhoKg$938a0b6fa121c713832649f66c449364a34653a35651682a8d730cd77a60b6f2'),
(117, '62dbc302-d1b4-4a57-bc0a-4ab8a76aa554', 'Fake', 'User', '8f78f51b-1ae2-4292-b44e-d81b0e59831f@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$RbjGdMuI39fSSX4k$7e2d889749272d294f20340fed49c451ce596124f7e116977bb9feb9b498216c'),
(118, 'a659a43b-f86c-4448-a2b7-5a8f41e90d4c', 'Fake', 'User', '3b41ba34-31aa-4387-b5f8-4f9c77083a9a@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$QBGEdHUCQlLdUKys$a5cf3c6e2976ea5c3bd5bd016043596102a33d72d6fd16deca7bbf6ffd0eab84'),
(119, '19c1d256-8445-4876-9381-68f0f8dc8776', 'Fake', 'User', '9abe2412-f821-4601-b3d6-e8394262ce7e@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$ZAaMNIr9rk9tZSGm$04deca8900b509c9e45b5def6560c2e822d573941d2aafc67049d207a761c154'),
(120, 'df65ee80-0487-40dd-9326-17ce0b02ef62', 'Fake', 'User', '00182363-9cf0-4c17-9bc9-ac82654b3120@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$6cj5RXinw5ZFSj83$8089fcb3810e6d7be776a1a604791e6f45024001b4429a2d1ac8bc6bac4e156d'),
(121, '5d1cfd62-3cd6-43b9-960c-17240fb1aab9', 'Fake', 'User', '9bb31b2c-b218-4668-ace1-b1e60cf057da@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$TxqAYsZ7e6l4aELP$58b61343a6a06b06ef0fe0f43ea4481cfea8d914a2cc3081937862813ac2e41c'),
(122, '287ec0f3-45c2-4a15-809f-351862547ece', 'Fake', 'User', '6af9aadf-4ab2-4bea-96eb-d66b809290e6@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$HFemJhjPzIOOtNu4$05d23d7b1eb7c52af4db87ab4fea1944cb8ec6bed70f02b7f496d36063c68787'),
(123, '1f3ec17d-56be-41d3-9073-ef85ba228a7b', 'Fake', 'User', '967cfbc8-b214-4e72-9df0-9bad2637a8e4@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$KH4EiNXd2wyDRdzz$cbceaf6f87676924a7f14c54481964d374352516b32878fd02c805a8efc99b14'),
(124, '293e93c3-6c30-4a0b-b8c2-556b6b9f361a', 'Fake', 'User', '0e313bde-e715-44c2-bc88-23320ecb7429@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$WgwO5oRZLAFXFQA2$86d6f3cab9a476409a5df859fe62e13d3bfe25a87a947dec8147da38c36876a7'),
(125, 'e02deb25-e04b-4335-833c-62f8af0079d2', 'Fake', 'User', '53587d76-1955-4d8d-ae66-9bb31bf72517@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$QHiFMDp03thy8V0X$4dbeefa0743d76fc935fbb43cdb1c23a93ea5f8abd5807484b2f3bd8321fab0d'),
(126, '6f6722c9-677c-4d0d-bf8b-5604fa4309fc', 'Fake', 'User', '5cceff29-88b6-482b-a5da-a6ab2773f6ea@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$Od4wx9gAMhJPTSvr$175e3dd54bdbff465449161f0281f13c7a16ff46b942eeb060891176e5a69998'),
(127, '2f431d8d-94c7-4d49-8a64-5b47d59349a4', 'Fake', 'User', 'bbfba815-158a-4888-94df-0aa6fae9e0c9@gmail.com', '023224482', 'Fake Address', 0, 'sha256$mlzgqlzqsTxRiqVP$9f228dacae1f7b52087e05b095564b0b24379e540ab7f1223bc11d57781e3689'),
(128, '1f11d7a3-642b-4c8b-8493-6b44ae9e0071', 'Fake', 'User', '58c19af2-99f7-49df-8c87-7a4c5a22f55d@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$X7TGk6DErJguOR4v$f434e3aab241f13f477ce7d96d3c17a69cbcea6a9f2e89f15d03f7bb6a4e3366'),
(129, 'af1ad598-0082-4176-8d8a-348dbfcd7269', 'Fake', 'User', '5f61a61c-2c4b-46d9-80b7-04cd23f7b882@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$zM0yk6HnAqyrNLeW$55afceece1dc03cdc7290640dfc1058d06584f4452d12e30b5871efc091c19b6'),
(130, 'ae3536fa-a311-4911-90b4-eb9af17abdbc', 'Fake', 'User', '51b8793a-73fd-462e-b741-2fe6af3a5956@gmail.com', '026158208', 'Fake Address', 0, 'sha256$pfAIv7pPs2M2ybEX$61bb5e059c74ddf43c979163b01243b2246f999f28f56ad15e3b17a2f1c0d9f0'),
(131, '12822fd9-f1fe-4b5d-9af4-2d28e0fa3186', 'Fake', 'User', 'ce03375b-1121-4dca-9deb-5a4e2d59d82f@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$8715vjmMeoYGBhWK$6fc6f6c2eba3e84edd64096006fb46d89f974f228e1588b7f17718f85cd86a2f'),
(132, '8259c62e-ce47-474d-b523-c425fc3ae47a', 'Fake', 'User', 'beb647d4-00e6-412b-956c-b2828c26ddb5@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$ARoWZ1XGTUw8B44o$829159919356467c2a61e778355ffa7fb1ba5d90f6f1e853453a1690fc1e0a2c'),
(133, '107a93f4-3adb-4a40-a822-598c25db3989', 'Fake', 'User', '61bc9ad8-2e0a-4e16-a787-9b2e15da0600@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$NdjlmxLCJuset3tT$18fb2f19e867948d12718018db8a3881655b504025f3edaeab76b615dc5135c4'),
(134, '65cdf7f6-95c1-4e69-9540-1800737924a8', 'Fake', 'User', '51ae9908-4ba8-461e-b090-97a715d63c69@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$owVKyxPzBTbnZNjG$05c54ae3e85013c3909272783af33fa19e1a0be78dadb3fe3c5f3d690c3b5a7f'),
(135, '3644ad7c-ee8f-4ab4-9a80-88804e9f68be', 'Fake', 'User', '42892732-2c79-41a6-ae1c-5ef2ac696445@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$kh8VuIKT1tbHBnHG$533b2839c2a0f0bf10bb6e804a6f5c3eadaee23a557368525ed28f6c76780e2b'),
(136, '73b8c7ae-13bb-4f6c-9184-fd8ed4a40fe9', 'Fake', 'User', 'bffd2fbe-8561-4ff3-bbdb-8c000d507ccd@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$GpP2Sgch5ylkvwOG$064769ff10e5572cb79a1f98a0b23458a89c125bf067d560c51a49cdd9e26735'),
(137, 'abf58761-a3b4-44e6-8b7e-05b9a6c8a270', 'Fake', 'User', 'f6d21656-892d-427e-81c2-0d644a22f6d6@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$OIeovWs59zqwbTci$9bb89a19fa9c91e60c987d21fe98d6e0d87b46b0468e4d94a4787dc385f4a3e0'),
(138, 'edf29695-163b-481b-885d-a7a27d9a71b5', 'Fake', 'User', '962de842-dc30-4b24-8b46-a3b12ec23109@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$1Bf1vG2W8i2lFxq2$d85fb43a793bbef9f8a6f904e480575388267adb834a44c0bae93bea549fb252'),
(139, 'ae30bd0d-8ea4-4fe7-9d58-26dad43041de', 'Fake', 'User', '38857a44-42f7-4dd1-af97-c9032a49dbc1@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$lyQyyjCHWbrMV74A$485d6fafbb9bcded6a2fed98819b1db75620376485f2ca2eb50917c9c7580a8b'),
(140, '10c811b0-1ebe-4e6a-904b-cbe072bfff95', 'Fake', 'User', '2aa6308c-e309-4de6-be7d-78213c0e6b8f@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$dyDvUCnRTFtuHGfo$c4a54a8f10ac0d74f1f8b81c253e854292ce7550e996ed126246afa62450cb96'),
(141, '7156c54b-cd62-4fd2-a5b7-02521e6b27e6', 'Fake', 'User', 'd306737c-694d-48b3-a3b2-9963442b30b2@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$0vC6SwhKOAbQXh2X$5b02fab4ebdce2995828ef0abc2cf31e1e4f61203002b9cbadba8262c8014634'),
(142, '19ac885c-047f-43f0-8f9f-563673c09963', 'Fake', 'User', '346e0d0b-5fc1-4448-9e68-a4151f6e5e34@gmail.com', '023224482', 'Fake Address', 0, 'sha256$LuWBx68KLhRQKPdj$2cc800dc5f682e4a7b73187d438ec0c2ce02c1ee22d23f71e9de5bb3876dc2b3'),
(143, 'a902e55c-8314-48f7-ba47-99ee1d0e14d4', 'Fake', 'User', 'df498096-a3f1-496b-a951-6b8eb79a8a41@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$KsKxbdFW09UegOlv$10b0b0339edcbeb05317ec7e09b2edfb71fa2e549fff1daf8f44af4a3df962ea'),
(144, 'bb2526ab-1161-45c5-866a-0b077b1437fd', 'Fake', 'User', 'e38294f9-f3f0-4323-a75c-1dbefa9bd60c@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$henhnw1inSFmb7xz$8300956fd72e53e4612af1a8ed1a4101a52048d7a0ff3bf4c2e0ac31358f3e31'),
(145, '8887fdae-476f-4314-876d-3dbc09e26710', 'Fake', 'User', '5cf7a78b-32f6-4ecb-b4cf-d6bdadbd3f17@gmail.com', '026158208', 'Fake Address', 0, 'sha256$jjxlrIB0GJdHArn0$d6dbf36f358392d50af544f3e3aaf445fd6f45f6ef572d13afadddd938549976'),
(146, '61d3bb34-e83f-479f-b3db-79a63e0a1042', 'Fake', 'User', '8a3f8c59-61f4-40da-9a27-26e7bd4e8dd4@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$RMRdkhJmDFXqpr5i$ef784b52c271229d96335a6400c7ae1e482ac63061560dd28c96b09172bca764'),
(147, '5faf9451-504e-4539-aa9e-a871e1592795', 'Fake', 'User', '844b292f-4af1-4553-8859-d44f41780552@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$mMDHia3JgAshvJXj$dd542fb483f141a87437c64581ce43beb949c12057df698437cb7d449ee8679b'),
(148, '3bd97884-85a0-4be2-9176-21b1d7a9ad27', 'Fake', 'User', '0f42bcf1-9874-4b85-baa7-abbce6f55c1a@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$degj9ZPnxIbmZLS5$b0001dd5302ed01b3f9f9ffc496e6e8e24c74626bd1bdd0caf8510fb6e9e7a08'),
(149, 'f48e2f79-3e75-413c-9cdb-5e7200683fac', 'Fake', 'User', 'a311aa66-e041-4765-8f33-ee7e5e6eef5b@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$fGKzGRTvQJ2ZUc7x$6f1799eb76df452fc88e480fe340bd10aaa6fc0f51d49a4f742a41f60c2524ec'),
(150, 'c4592248-940f-4bac-aab3-d24088f79121', 'Fake', 'User', 'fc40ceac-32ee-49a1-94dd-6a170c5bbfa1@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$k6GyvkL7HA93VwWd$e079345cc38ba3aa3f8df4df436d99fae508a870a8d894f06ac3c608f5cd85d6'),
(151, '3d38e015-cbb4-46ec-8859-535e61c7331d', 'Fake', 'User', '307d5fec-acbf-41d1-9191-e470c33a3800@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$TLe6Y4pWYkMXyk21$6e2c78285c9474d39f8bba9e7fe4ade01f41d34d58bbd9822d0b2b294f58321f'),
(152, '004c5cee-09b8-41ae-989b-f027dcaff19c', 'Fake', 'User', '25f1b102-7730-4db9-bdbf-06c32250c04e@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$CdvmAtB0Yv57WnQC$ad123ecddbbca48d8efdfe5931a9b0a0aabebc7277fd0943d32b2bceba93e6cb'),
(153, 'b9188c5c-fc65-4872-a7d4-8367020408e5', 'Fake', 'User', '089f206b-da65-45a5-ae3c-3a846a151582@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$AzS2XTUIzQA4u6CL$63fef5e402d715c47392d9a3243df1290d6318a2fb83f90acdd60b7ac79dfb5f'),
(154, '581fc68f-536e-492c-a89f-c03dd95428f8', 'Fake', 'User', 'd7631a5e-5230-4ac4-affe-495c46c92ce3@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$CY8GzTI6APuUHBPN$d3abc96a0ec9d9b095976ee8f3a6639b3982110c4cf301c3a4f282fd68f9b346'),
(155, '0f4eeff2-0610-479d-bcf8-736da4e7791a', 'Fake', 'User', '05fa7573-c488-4cbe-a208-cb1d41dff260@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$dD3TdXx4Tqq5SGUk$bd6b57bedf3bfdb83ebce727258d76b573aa974640b6c000c0bb9a3630ce41bb'),
(156, 'b9b2bd47-6290-4b67-830e-faa658dcefb7', 'Fake', 'User', 'e6aa6dbd-f46f-4e49-b9fd-5d4b627046ac@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$zYVfSX1UEWmIggIk$0b29049d3aff17a5319d784367bf4c4e014975c892efceaebf2e7991f7cad7b6'),
(157, 'c561639f-ca67-4f13-8078-fdbf96de5df7', 'Fake', 'User', 'f27c26b7-9235-4e91-8ed5-487183ca7b26@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$7lhJZtOGVLUDazO3$638c7649ac68b8b8feb3705f2540cb33bc03511a95840840c31c8c9868a56f96'),
(158, '4429c6ad-71a7-4507-a2a1-8c7207a4e2fb', 'Fake', 'User', '867b1e62-92a6-4522-95b6-2def244edbfc@gmail.com', '023224482', 'Fake Address', 0, 'sha256$SRaItFpsy4pwYsu7$ed5ba649e91e0ec2fedcfc494e081a35fd45ad88058f8b51d9b66d49e347f54c'),
(159, '86e5a48c-40e1-4c31-aa73-e87b1a491d60', 'Fake', 'User', 'df2008d8-72ff-4651-8314-2fbd16e00708@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$nNR1SlZ8zVaVOvS4$de1d48ed6f160d21e45bee97403cf6150c904f3d870f72c5424f40317c0f7503'),
(160, '4cda425f-1130-42bd-81b3-d6112cfe326d', 'Fake', 'User', 'c2889c87-7605-4d27-aeaf-b7ccd8d7b3a2@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$CdlMoerTdACacQe3$129e03fefd93d7a93a13928605f97d95c3a61e11e2b62b1ac2d68375a55618a6'),
(161, '11c81faf-de1e-4772-85b3-4915962ecc29', 'Fake', 'User', 'cbf0c2b9-a6c6-4aa9-8dff-0ee6f75b66b6@gmail.com', '026158208', 'Fake Address', 0, 'sha256$g2UDXpE384l4cCVn$62e49c83456df783e0aca12d0e010e3acab789d8b6f63d554759d0c882e7f22c'),
(162, 'de04363d-86a3-4961-9231-e83ff56c328a', 'Fake', 'User', 'a601f9e3-5d32-47aa-83a3-5294633193fb@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$2IPDuByAhMHedGKx$ffb47c53325fa6880d1497ff88646928d09c2230d18437a78eab68c181fe3257'),
(163, 'bf8e7491-1d97-4a66-b551-1671a8bf348b', 'Fake', 'User', '2ad0833b-e964-4522-84b7-051f6f9eb9fe@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$YT8rGbCfNTxme0l1$7cccaf42f541900f23ed131a0e8779c06b39f3c0555baf140b8d022e3b9f6668'),
(164, 'cb83bb59-6a9e-4bdd-ac4d-5e54140eb5bd', 'Fake', 'User', 'cba4d5b2-200d-4813-a4bd-108980abae2d@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$4NpepttwUYtyKeAb$9ee379829582f6b4ee399a586c83c8a2f630fe4662ebdf20d3a997e07d86b14d'),
(165, '8ad9b855-e1a3-4610-b40b-4065948feebd', 'Fake', 'User', '0d5c114d-dc77-420d-9d37-cee70b61104a@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$WITuJaW8yIYrXtMn$f48e56b64f4ed0f8a0f8773876176b08e1e615c863e95ea02ee2521deeb2316f'),
(166, '32d1f15d-9765-44ba-a32c-89a1942a2e9d', 'Fake', 'User', '39789df3-370c-4139-b6de-c0b8ff2a2014@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$NyXfDoifOCLbxAh5$4a0c65958b5ee6abf5addd1115e97649ff183a058b151af18ccd1532120061f6'),
(167, '19850304-71fb-4b3a-9e13-59ee2018c8c4', 'Fake', 'User', '0c39e077-8c4f-405e-bcbe-7f57fd53a463@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$X8jC1w9brdLF5myx$1f85ed74d6949f7c53571658c16eb13d84535cf9c501c1572071cd98f8e1f49c'),
(168, '6d7f4ad9-0f92-4dde-ac8f-30b5a67f95f7', 'Fake', 'User', 'fe646e26-452f-404d-8380-14fc07cce01d@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$aztCgRCTQQFWLlGP$fe3b0224564d4b7d18ee2d0a90004e69e81c3954ac8db7a5b623ffe820c39b14'),
(169, 'b4f6c1b1-9f41-4da5-89db-496d3cd74fde', 'Fake', 'User', '5adc2a09-f9f5-4826-94ea-e5575edadc74@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$SOgjHPYz06tNQ8ZV$009f6962ab456f047aa2041dd344117a612f4a652f76ce70ff0d5cc03d8b0abd'),
(170, '0df4fea0-8136-4b8e-8603-a5fac3a4fbbe', 'Fake', 'User', '16c7a782-9968-4b37-ace2-47bf76b177c4@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$fxWB5sS8rE9TTf23$0b2afb46f2b02baeacd59dab30a8274bf40e3609a609a2d493770e8482857d89'),
(171, 'b92d5ca8-4f4e-423c-862c-de4f68f4cb67', 'Fake', 'User', 'e2e706a8-1668-4f73-b43d-c011ecedd255@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$AgBrM6FjnrWTiFnP$fcde952ce337e09ef5b9704a32a9378466b7dd9c7d993dd88c95330c052e0935'),
(172, '024bd199-7a45-4d42-98c5-3827a6dabe5e', 'Fake', 'User', '93586740-3e19-45ba-ad6c-9252e4f4d580@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$m0J8K6J1Pg45U2NV$9654cf13a555e9983cd8e2f077721a03579b6a8f049699f58a29ddba3c605cb6'),
(173, '08c64020-0363-42bd-87f1-84015db3c738', 'Fake', 'User', '2acfdd16-ac12-4998-a9af-1cb9b858b601@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$BDfVMSnkasxmNgy7$01714534e3acfad02e1811628c30a16489cb41cdd8000fb5fca03c73ae23ba9b'),
(174, 'ac735faa-1e65-4123-bc4d-dc77ca76ca76', 'Fake', 'User', '6ad62cc7-aa47-4638-9dc2-07381b084474@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$ubqkKqrxQn9E9Vqe$cdf7acc25f686d0e8fea1f4f36cb4e53d616db439cb83db3778e143f89d8ccaf'),
(175, 'd4cd3466-8993-419b-b6b1-dcef58eef4ab', 'Fake', 'User', '65dd0681-8d0f-4ad5-927d-3287b7e155e8@gmail.com', '023224482', 'Fake Address', 0, 'sha256$5S3ndvuIAwZXxLHd$106fa771cf9abfe10f0f64002f3ca8572c75aafa3c4e025df7c0c2f4b21d0deb'),
(176, 'fac6f6f8-de37-4b3c-a5ff-20e488c44c70', 'Fake', 'User', 'f9ad6155-8808-4d38-b070-42b7808b6b9f@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$LOrdQXElnPY7LK1y$e37ff7213cb900ce58fc1ac1525a7ca10d65fb20fd2119f0bd50b385e934adf9'),
(177, '611967ed-56d8-4991-b49f-31acd8a57a2b', 'Fake', 'User', 'ca8c7285-1b21-4fae-9dd8-12caa1835d0a@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$7xgZ05wY96dkPvAt$4d7514a67acf035985bb0532898de0677db9f772f85328738917adc169c65372'),
(178, '5d2c27a9-11f4-4707-a89d-a42c628e84e3', 'Fake', 'User', '4b56dd94-46d5-431e-a470-8771ad613330@gmail.com', '026158208', 'Fake Address', 0, 'sha256$3JVuj4q69l38bsnH$60b58861903449f94ad649e2c0fcb38f86ddbc6ff1a8211476def305940fc382'),
(179, '95a2f3bd-520d-4058-93b8-1c5096084703', 'Fake', 'User', '71da28f6-207f-4367-b7e2-d5cf309f00c0@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$Lv3EZ1DysB8E8q2r$e77658960b44578a8edb5bb96dbbe663ad4a57960a2621beb7e5f12facd191a7'),
(180, 'ad91114a-6fd7-45ac-8ce0-7b73d59f6cee', 'Fake', 'User', '8d7441bc-1dc4-472b-b602-c2060c3801a2@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$WrB4khT53Dz0mDmB$8e3c3a1063d6dbed94cc8932691be93325c357e05f6f8416da5d83a7d4fdda19'),
(181, 'b6a1e8d9-ed47-4138-b49b-f36c694ac5e0', 'Fake', 'User', '8e9b4dc7-9369-44a5-be9e-caed61e2b79d@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$qW6vFZAGzedeW7am$2c3262fed8c770cad90290c1f63d0cd7ee60d559df7ad11cb077c41a93b9cb1d'),
(182, '3d617e36-93a8-4e1c-bf6a-31fe91d390dc', 'Fake', 'User', 'ad24be04-b93c-4bc7-9b57-aecc9939deea@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$iwReBQZ0rCRLvNyu$227b82429b4e00896b839306e8ce60d713390a7452e5a7f2e96f6bec3d99d3ee'),
(183, '60628b95-e017-489c-aa25-4a1b22a651fe', 'Fake', 'User', '60d841ca-8858-4dcf-aba7-2a5513ed0382@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$VuSlsH4ijpZb6iGD$8cab92ba624bdae0a6f7badec50a82c2e1599cfa7b901d573834afb2b1f6dd85'),
(184, 'cfe7bace-60e8-4bd8-8700-b6e9555f7c0d', 'Fake', 'User', 'b8a52b9e-0219-4076-9eac-17f926497e86@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$CTdrRsKqOXdGFvOV$01e535f8964ed6aec3a43e80ef2604ea4c70ed21ee37ca59f5798c66e244c1de'),
(185, 'e266816e-e6b7-49d0-97fa-dfd5dd414f15', 'Fake', 'User', '1fc88121-b410-4e2a-8fbb-bb669416919a@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$58mCPRpjbHxfVOpN$bec87740a113965d934605fb622cf8f0456d18cad6b4628b3ac043a577b4e844'),
(186, 'c7d47ef9-6b09-47be-b501-43b2853e8e01', 'Fake', 'User', '4d38063b-7838-470a-b9a6-2fb511a177e8@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$1ArTeYyQM6gn4FEy$80a01a596af5e20c70fc5a641f45d964e90e7076a664373cee633e96b77c1070'),
(187, '2cb0e5f1-a76a-4e74-be97-86534634de45', 'Fake', 'User', '352a0781-0bde-4bc3-ac02-aa28c9501337@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$YWtHMWBLMRjGAOK3$3e225c4830820a4be7ededa350bfe8d747b978a2988b869f411571ddda3d834d'),
(188, '57a6a28e-7ac6-470a-9493-15755d878e71', 'Fake', 'User', 'e4430d63-8177-4775-ad5d-1b532a7c640b@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$56H1uID0nrewecCL$6df1ee9872dd7100fd4fe8fb21b33fe3a084a61d6aa0f4af750e08d661284a2e'),
(189, '896fa1c5-ad2c-4d0f-ba99-0d75ab06d14d', 'Fake', 'User', 'c17875c1-a747-4f8e-b0e7-8309ee55347b@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$3iCsh8MddWW0kDa0$5e86477ec28799fc126436c14dfc0bfd10f98fab7e774baffdcb721a129a1877'),
(190, 'afce8f5d-bd27-4528-b888-28c960fe9bfb', 'Fake', 'User', 'b834b1d6-6e4a-4dee-9613-2270e6c27aa9@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$2uqWGdJ2w9kgQOe6$e2963377e42a6dfc2179978dbc0832a83771c23d58a328a4d7e7370308d8483a'),
(191, 'c05a0233-09e0-4f04-90be-60761dcd9c95', 'Fake', 'User', '32a09287-062e-45f0-975f-d58b5e0418ee@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$o9jXH6zatICKNALh$8d7dc8c3d7236e6ce24cc5a40866759fdc075e7b7b22a1e3bb0b6f1c7d86174a'),
(192, '1e5cd399-0cea-4a46-a58b-eb8fabada823', 'Fake', 'User', '6a4caecc-8b2d-4ce0-a6ef-54e8c8bea348@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$MzG9U4jtj6o9fOiE$e60e7762d04fe262284a24a7f2987c0f8f0dd767742140f0ee63652d33372e3f'),
(193, '9c301898-55c3-4cdc-ad5a-792b41457c19', 'Fake', 'User', 'fe1eb9f1-1dd7-440f-a25a-a55acfc24f7d@gmail.com', '023224482', 'Fake Address', 0, 'sha256$zmMnP3Opgbfq42pZ$f0c452e10e5109f30da9f050708b11f8f02b597eb4831ff6ba0757e015a7d7de'),
(194, 'ff708805-97af-4572-a14c-d4b47eabfdcb', 'Fake', 'User', '3b02eda7-4dde-4576-8cfc-024ff423c928@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$5roxRlZ6MYClIlZA$7999b007c1cc6e99b9d98a4e8db622ccc7f83e4e1ce69410066973cd2670049d'),
(195, '880c424a-714e-4d05-80a0-ff60e049f5d8', 'Fake', 'User', 'aed52d2e-1db6-4cc0-8624-a4bf580011c5@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$Hpyto4VxYMMhl3gQ$f7efb50ced6406776f7587aa85c3a2e4ed9f21aec2f2623f2182ee6a85bb6255'),
(196, '8923a826-fc0e-454c-a931-502b04c4ac82', 'Fake', 'User', '9b4be9bd-e2c7-4a8c-90f9-174e2beaabc7@gmail.com', '026158208', 'Fake Address', 0, 'sha256$36j00dCOlty14UF5$1d546a102aaf25272fed6d3114f16a7a6f87c604c28961d2e661eaee6f564279'),
(197, 'e5fbeb1e-f917-4991-aed4-8843bf3cb3d4', 'Fake', 'User', 'db6a14f6-a415-47e1-8c8d-904c00475a85@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$u2IjCal2DWpzbjQ5$32c18dcdd7773c49967c01b6fd86849a11fb96600919de7f21be9fb0866dac43'),
(198, '429530d6-84e0-492e-ac5c-9d75b0d4d87b', 'Fake', 'User', 'ce5d0d9d-41cb-4ea0-a4f4-f582cae88ef6@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$bsyb4JAMg3UfyKZO$9fdfba83cb1c4a06fd0a5a8848f0f3bfb7fe9e0b67d316161415e23102e08d00'),
(199, '55c6cdb3-dbb7-4164-9906-f863cb9a19a3', 'Fake', 'User', '09aa49c4-15f4-4f6a-bf52-48ac6f70973c@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$jHsGnN1t55sd9vO3$617c4c55cc91ddc20417480c55c83c921771d42521b28b18ff7e14531221ae04'),
(200, 'a66203b9-f3ac-4f1b-bbea-38a090c5c914', 'Fake', 'User', '18c551ab-bc5d-43df-992b-93926f8f64cf@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$KiLuOCOT3UUOZv4b$30be70c7953a8c7bd878d6906977cd9cc4a3050c1d89135bab6fc19c7aa76a5b'),
(201, '302f1082-ee89-4e5f-9a5c-7b5a31f0a9b9', 'Fake', 'User', '618645b2-bdd8-46b6-b3d9-b91f34367db5@gmail.com', '06 67 45 84', 'Fake Address', 0, 'sha256$AfUWHxchCQN4gyUQ$e92f1b69229e15ea2cbc8d332a0a1ba759ecdfb3f0d219abd19eeeaeae33bc3d'),
(202, 'ade82cec-f39f-47e7-9491-f95c72673933', 'Fake', 'User', 'a9c34e87-b78d-46ee-a64e-f52a66d34709@gmail.com', '0556778085', 'Fake Address', 0, 'sha256$XDqKZiO9r4ZWlxBI$339c50b3198a165a64c6a7922c9096e4844ae63fc9e33f4394981c33a187aaa3'),
(203, 'ff28cf83-82fd-41f5-9992-00831cf93f49', 'Fake', 'User', 'e55b4ca0-070e-42a3-8262-fb85b1b2bba2@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$3bMFm16xWVMcbLic$8d69104825d5a7de10bc45f40b7fcd9de31a346f507f6ba2815ac0cc57e64a04'),
(204, 'd913bf36-7417-4e3a-a099-af5353fb930b', 'Fake', 'User', '8b60f98d-5320-4fda-a544-b82946eb2c52@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$3I6dkNcs7XrTCZZX$6b9476c59a5d7c6a2e05d1ed5f9f261c45332d2eefcefdf6e2ee8d31d7f20ddd'),
(205, '6a20cd78-42c0-460b-8466-50f3de51e1be', 'Fake', 'User', 'c9e52931-5768-4120-9c08-9d5febe4ed7a@gmail.com', '0656333902', 'Fake Address', 0, 'sha256$8VnfeD907zat338S$2ffa72c0c0d0efa8247012e5fce8ee3e890b6f9720ae0cf09d3da5257ad57d6f'),
(206, 'c711c8fc-0a2d-4b83-bc62-e5491caf6124', 'Fake', 'User', '670bdf8c-7cb4-474b-b2d8-9177259615b8@gmail.com', '0540901710', 'Fake Address', 0, 'sha256$Rxy30e7f6BkEAzqN$532bd87598c64e247416332355ea36af34ed88804fee10d8d377c1a93179cce6'),
(207, '2177eb7c-8b94-478f-a7c9-75084ec3e5ce', 'Fake', 'User', 'f1d3ad6a-3401-44c2-bc32-6b2f61da8221@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$M4YYxs0DUalNdXrm$685c8585de02f3503ba977440c975bafbec61d93744d48a100f303b98c60eea5'),
(208, '691b86b9-968f-4b6a-a96a-14d92d2b4217', 'Fake', 'User', '752682d4-4095-4807-953d-2dfca4fbac66@gmail.com', '05 53 53 86', 'Fake Address', 0, 'sha256$vxsBuCCycTt5oSYZ$3ff3fccabe4b3c10a4e4b8fa7d77b24a0f6c251bd7ba5a866f96e07bd5b995e8'),
(209, 'd3bba187-5f86-4281-bfa1-7e3259b1d017', 'Fake', 'User', 'f4e438c8-9463-47be-b3cb-59ad7311c5fd@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$wyIILFjpmYja8co1$dabcf6b8b0bb766c266e8f66aeb4363704f634b38629b33ea2ffce83effc52a5'),
(210, '915b3ea4-df75-4609-8be5-fdd676cf72a3', 'Fake', 'User', '27d15ad8-4682-45b3-a20d-50ceff9b662a@gmail.com', '0554158549', 'Fake Address', 0, 'sha256$pK4BVk3fMRDVn5Qd$e7e806b0c9e079b5687b6d64f2fcf9cc3af14de138ec5bc582f969512aa967b3'),
(211, 'e6ae6319-7e0b-422b-bcde-4c8980df5e84', 'Fake', 'User', '91fcab8d-8f26-4036-bbff-6587889b9312@gmail.com', '0662222245', 'Fake Address', 0, 'sha256$70DrT58aEMUmQqpv$c28e76e825860fc3fc7d34bbef77612d0a6a1d019ad01d054f42cf7d34d2d7d4'),
(212, '5f34945b-c4b7-4fcc-93d4-8c8cfb50bcf1', 'Fake', 'User', 'a0fb2258-17ed-4b1e-be13-7a5cd31f11fb@gmail.com', '023224482', 'Fake Address', 0, 'sha256$cL9YDolFgKVKQKV8$f03e5824abdd2f51040a29a08eb8085d762d79abee3752283607bf2dcc8cddfa'),
(213, '5a4bfd2d-dd79-45e6-989f-5ae538d7a017', 'Fake', 'User', '66c25449-1525-4249-bfee-d14f15d7c598@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$4POVxzJnskCUKPK7$ee45bb1c728a5c01c32bc57c709b901e55af9daec39268230db3d756c213a30a'),
(214, '5ffee2e5-b452-4f8b-bf8d-dfed8da4e79f', 'Fake', 'User', '46fe7ce9-7540-4f4a-aba8-d697b5760e23@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$UBm1V674YEdxvEEF$cb7a6f16c7ca4a8772649c1f15089fd78da76386ad83ec43c308e1d1a1e32015'),
(215, '86802f1d-b349-431d-aa60-44ca7ebbc879', 'Fake', 'User', '8454bb09-e73b-46ec-930e-f7e5a567f81a@gmail.com', '026158208', 'Fake Address', 0, 'sha256$Crn4tlNMbEIZha2f$20ab518e5e9c88e4fd6992b3273d1e829dd97793389f5cac9971d55f9c169e72'),
(216, 'e780dd9d-5595-4e89-965a-f570489ab96d', 'Fake', 'User', '61ac51b4-b874-4253-bdbc-e09ba1366b33@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$PZN0tjSk1ZAnAVzA$f3d78b1866716fea4ac47a0819ba546b26a1e1d69a31165d03617eb7d92817da'),
(217, '3299aae3-cf94-438a-8091-c84db227e9f6', 'Fake', 'User', '94d14bfc-bf6a-4ede-b66d-bf4ecf7d12c1@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$gkESwiFFZdewEV93$8ba674c245781f08bfebb5eef1e0c4b5029b0f9877c2383f1aee6c573a21ddbf'),
(218, '04d99b85-07b6-48b3-9eed-e4766472b86b', 'Fake', 'User', '08915d7a-119f-4f98-8dc9-aac49043bba1@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$W2wYVhcS5GSfxkuQ$77a5de243459cb23c409d8e481c0e3bbe10953c74d49d7a7d0d656c2bdd71ef6'),
(219, 'fec486e3-7fb3-4f4e-8d5c-fc3d266c5ba3', 'Fake', 'User', '00428625-ab63-4d19-8ef3-984294e72a8b@gmail.com', '0559 05 05 ', 'Fake Address', 0, 'sha256$y5UMikvpT6DNLCBX$5b37109bf9ec5ddf111e6ece3b3fc1b578b47ed8ffdd50573889ed9d53113e31'),
(220, '1a0915fe-b275-4873-a270-383d85294d80', 'Fake', 'User', '93954b20-a0ce-4499-92b4-e2506779041c@gmail.com', '06 67 45 84', 'Fake Address', 0, 'sha256$ypd9WyAqgxZpN5K6$c0a269f9d0d5007d3b48982c9e72d49f5eb88213f12915703f9c9f32749343a9');
INSERT INTO `user` (`id`, `public_id`, `nom`, `prenom`, `email`, `phone_number`, `address`, `is_admin`, `password`) VALUES
(221, '38f2d705-81de-4f3d-a718-8c85588ebe46', 'Fake', 'User', '11f2eb77-d624-470f-af22-20ea6f0aed65@gmail.com', '0552050210', 'Fake Address', 0, 'sha256$R6vjJlfzXF5APDaw$1955eaf34bee322b9f9753c54b912b26c89ce24037cb149aa22eddd0f4621185'),
(222, '0645ca54-8f4a-46e6-9cf7-d777983d8860', 'Fake', 'User', '1aadb1c4-bab2-4396-a3d7-7db5d2899753@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$3sGVG3TfI00Q24OG$2eed897eb4a034670b4664d35dc12694a8c4603288ca564a073fdcd10f80d9a6'),
(223, 'dafe94ed-8dac-44ba-902d-ff048a426ba8', 'Fake', 'User', '01b8e4f0-5fda-45d1-97e0-3383c342e798@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$uYAf2QtxEn5zH7hf$72f0df5c98e2d0f643b41126f16ecc02ad8e3a60c7799db94e6b20df0ddb2ecf'),
(224, '56708724-66c3-43e7-babf-5c573c91a022', 'Fake', 'User', 'f568d151-8480-40eb-af13-0cb95aad8bec@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$EBC4n6lOUYaHsfRG$26bfa260f7154057623b170cd2ee8446f8582557ee375183171ee6e18d063f65'),
(225, 'b89ad513-66b0-4edc-97fb-b2e92f3f5405', 'Fake', 'User', '6fd24ab7-4252-46ba-8fc4-4f46363a7d15@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$6rDEu6ifVtSL2DUO$62875532da02204b7f5e8957ec4d469b7b95c3fe9e7babe01ae11434a50ee5d3'),
(226, '4044197b-8515-4c5f-b612-34b33dde4558', 'Fake', 'User', '3c01b650-6d92-4a41-9c4d-b3a97c641409@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$YK5qnvP9lINHjBZ7$555f4da48d128a182c030f3496274bf39727055a0b0047cc41df58ca7605ddc7'),
(227, 'f82326b7-a8f3-4d2a-b33c-f514f7834046', 'Fake', 'User', '65827345-1c5e-4e6b-bedc-aa0466e78867@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$ke3NSyk38Av8IewQ$1a8dd5f2089520e56f18c8b4e47da5b4800cb25eec0b632497ec0a528bcd06c2'),
(228, 'faf047fb-cbdf-4d1e-b843-3ce864dc61c6', 'Fake', 'User', '3a45ce33-5aff-422e-b683-cb904c9f231a@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$PZBE0jWJa0lAyPcH$004f5ce01f79899fbb1324bf70d98782a14c6aeff00e76ddcba7722db734e66d'),
(229, 'a06cefad-6458-4b68-87cc-2a2cdf263e5a', 'Fake', 'User', '37543d54-48a0-4140-9ccb-420b8bbdfef9@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$QjsYlrlttM26kWqe$581d375432a6cf99ff390642db8ceec10dd9bbc546cbe1a966ac74541998bcb8'),
(230, '9a1f8f7a-1872-491e-b49b-542aaefb44b7', 'Fake', 'User', 'ea8cbed1-96f3-4c3e-bcc0-e8ddde63dc5a@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$O23ZJiqsc2SlwkVO$dd04ffe8b1f3daa80d7d9edf60d9e7ac3502bd3e8c151a708be355ce184cdf7d'),
(231, '20e920b1-1640-4d24-a945-3974ab2ce7db', 'Fake', 'User', '67f485b2-622a-4ba9-9c02-fc9157ae73f1@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$lxGQFldarKomGdzT$9c61e681469faa165715c9a6279810e4c7fbbceea479296177608afec5ceb317'),
(232, '3f9970bf-d969-406f-87c1-a8d71bca4125', 'Fake', 'User', '9831222e-a614-41a4-9cfa-3e0a2c590577@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$fr6V4PUa7Jcehzcz$810e7f2d636cf1e3ad231d4997346651e2c1aed275be3aac625c2063ebc03240'),
(233, 'ad4a636b-d8cb-4fee-ae22-0053feca4b7c', 'Fake', 'User', 'e2a95b9e-7bc4-4e66-bba3-f6a5fa18ec59@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$LWY9aKVxNLhDCAzD$a92aceb2b34dc692e71b906dc7f81c14299309c354a27bb9275f68f815427157'),
(234, '8da241e9-5e55-493b-96f2-f59eea4fdfce', 'Fake', 'User', '58c7b596-f2f8-4fe4-8651-413383c8a62f@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$LOuoVXGr4ds1BmRu$a28a711fe2f57edd5afa20d59cc46811c14a3053eff631276649e568eecaabbc'),
(235, '9e8d6844-480d-4f34-b956-e40338b20a56', 'Fake', 'User', '7144809c-d588-4b04-a5ae-d8890c7e255c@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$TXAkY6E2pTPGh9Ac$df63ff7ba1f59112e385451f5ea1af59437f3e89434355a6c4ebc3488914ef89'),
(236, '7edc25f2-0972-4595-85f3-4739e1ab6e22', 'Fake', 'User', '60c1ec02-dd3e-47db-bbd8-b3c6904d19c3@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$78PdmfbLRD0wEqV6$61652676075cc92e16d4b274e2332a5f4d7fa3f60c27a49127ee2c80eb2f4d5b'),
(237, 'cc21871a-005f-4489-a47e-cd23f0c95fe2', 'Fake', 'User', '572ad12a-c466-47db-8509-6379e3b15761@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$zqPDABNhMJw1cVcR$b2e5170359a2d3cee3b2f5bec42340fb639c943b53b49d00dde436e5f33c9cd2'),
(238, 'ed449e35-31c6-4358-a64d-c591eb3fa2ba', 'Fake', 'User', '24cf5340-926b-46fe-a5cc-e344ebdfefb2@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$Lkwv1Apn2IFFyYzT$85a9ac199141aa42dd66873106017b2e32b8087c3aae053d85c14694e6f24e3c'),
(239, 'c877c9d2-6c64-4ccf-a9d1-2ea3ae9f93f2', 'Fake', 'User', '62a06984-695a-4ec1-a042-f7f10853ff2b@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$rJZpe5KFsTgEETE6$9688a9d31892961b25df9029bbce6a07875ae6562e125aaf6d18ee6bd5cfd3e4'),
(240, '8c37682e-7920-4392-a5d7-df04727d0012', 'Fake', 'User', 'd45716d6-5c0a-407a-853d-5afb77d7befa@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$JdmWEKEQpYcw3gjB$3696ca676b61410db46dd932b8dad46f584ace0bca69f27b38cff5402f38d37c'),
(241, '1c810017-fac8-4666-ae63-ba9dd76e27f4', 'Fake', 'User', 'ddf1e7d9-3a39-4ed3-9573-3dd2fb7ef5fb@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$uN0joF92vqwEl8Vc$54d94e4d34df5bb8e7fa849e205d0af7cbe40a64c99be0d3daefcbff267cddc4'),
(242, '734d38c9-b1d8-4a6e-ab93-9deafb6dfda8', 'Fake', 'User', '811420fc-1fa2-450f-bc5f-e7eaa8f2b35d@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$OJjn0uJUtsC3DOXt$0e62f6fdc97186efb3fb65e38f125b79ddd3bdb2a187365ade5f4c746eb4ca18'),
(243, '5016d431-6a7b-476e-85c0-8dd3c2a8a065', 'Fake', 'User', 'b4ce39f7-d23d-44f9-bc76-182d1ffcc06e@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$2PcaXIuY6qT9Adoj$dddd5c6580a28058cbb02361821f39fa73bcc8ca1961f08863cd24433c473f78'),
(244, '45433c17-6d15-4b71-9dd6-a1e8b1b75cd2', 'Fake', 'User', 'f1703abe-b3a5-4711-8b51-03352e3a53f5@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$qpi3u83TAt4MPzNh$37731a1322782b1b755d9cfbab2a0ce23761c746cf515330b08f50b59c2bb4cc'),
(245, 'd5c00b5d-ed72-4959-a1ff-d45f1ed1bfd4', 'Fake', 'User', '3f0279eb-5fec-4e95-a0ba-40d002323530@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$X9ObiE5PjEOHqOlA$a95ae64c893972c117c7b2ab3244757475592b2f89f32ec4c565f0ae8e6ead00'),
(246, 'f018bfb8-5bb9-4ff4-a713-2ebe83ac34b6', 'Fake', 'User', '2d7c6bc2-317a-46ad-95c3-eb537e3158eb@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$0wxfOvkS1gEFvnV8$c63801602e432473a3d25ca0ce92e7c64f5357668a7a06799d93c002f7ffc491'),
(247, 'd8d9ad67-3861-4ac7-b858-47ca5b798fdb', 'Fake', 'User', 'ccd3d48d-4881-4b03-9f07-d88b854621dd@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$6E70QVJsUP53ily8$7ac275f9a55aa02b76d906cf42879ed6f09b5340c05273007e63dd4332d17b0f'),
(248, '3d858438-955d-47df-ad91-bbf6316f2eea', 'Fake', 'User', 'f7bfb28b-97a1-4cec-a714-f6b8cac68044@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$MGag1y8gASecL7r2$632633203a0f8b4c821e0ab987540d05923af955042a56da5f2c3d45f548bacb'),
(249, '74adc8cd-9760-47aa-83b0-7d4086d23e30', 'Fake', 'User', '249c12fb-4b08-44e9-8ad9-9749ea39426a@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$OMOfAxqjOZEnMW1i$068896146ceb5e7b6366c5e17583a6e4b8088a3de9832aa7a5e0ba44c1546be4'),
(250, '3c341ef3-8bbb-4626-b65a-95c927fbd758', 'Fake', 'User', 'be0fa8cd-28f4-4850-993b-6d6fd164cc9e@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$3CBRRbfigtxzVc3j$fe0ff61d60343c6ac20206315d11ae20a1e44e28fd5c386c310ad2a3cc47649d'),
(251, '801ec97a-cd1e-4a3c-b233-376f66e70889', 'Fake', 'User', '02df9516-ee92-4753-a51c-7118dafe8d7f@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$gqCPBKsOzS49JKHd$b90b726426a309058f67abf326c2c74fae85b3d904b30ec4a507bac3b9304946'),
(252, '624e3ff0-f00a-46e1-bba6-603aa89d5579', 'Fake', 'User', 'ff7a73de-48f3-44a6-a77d-b735c47b8bbd@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$BPzswbZWnCDmLELy$131110e80018e0b43f11df0717c37cbcf70e266198306b9dfc2e296ff432b795'),
(253, '5a2e6214-b1e0-4a74-8368-8d9d029aa56a', 'Fake', 'User', 'bc1bf664-9ee8-4901-95d2-50657a3379c4@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$QIY4T7UXmh822uif$530bd917dc93aeb4154dea5896fc733e79a55624349d1add34291ba9642af228'),
(254, '60d6f3ad-3e33-4102-ad90-da6f79dd6623', 'Fake', 'User', '2a8b758f-cab7-42ea-a3ca-67416c9d3c1a@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$38Owh3GSmByXrtpZ$dbc18d616329d8fdfc4ef5bd8bae70521f6f82103913acf74779fc2d7fb0ca18'),
(255, '016425e5-ba13-4446-9223-7ea3b2069079', 'Fake', 'User', '6627f835-f882-441e-a8d7-4a041b617ea2@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$z92Gx9srWCRq2Yuj$aefbe99c091e75e60bfba1c082a3bce77bb2fba2b02e565074ec9555525de1ad'),
(256, '8f331743-124c-4181-91a7-ffc3cb45105c', 'Fake', 'User', '75dd6a2c-4de9-46f7-b648-daced6ab3f9c@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$vIqqDCYqDY6Lgjfq$53cc62df9f86a4c8825c68f6f3afff7c8d1e42f05b50a414fde6ec1585cc9652'),
(257, 'be406569-0a18-49a9-b9fd-d1969b0f51fc', 'Fake', 'User', '097daccf-d9a7-42d9-a8f6-947a863c6094@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$Xvrei7Nq8fl3ipMg$3f56d14a81b6de64f01b0037cd6647df6c1bf67c5dfdfb6c445002a47494e907'),
(258, '5210971e-c119-4906-83e2-2e1c37701954', 'Fake', 'User', '5fba51d4-f683-4abe-85d3-d75cb0a4a4ba@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$AJ2bQjWAXqylZW12$9705863e99d07f85df768817504abd79f9ecb83819e69c28380b5bf941361e21'),
(259, '07b0ed1b-4c7c-41e2-b8dc-8dbc94e2b552', 'Fake', 'User', '6d56691f-2f5c-45e2-95ba-4cc763c89d2c@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$usdOow62D7JwUvfO$b8ab15d2127a609d1e13ae71a69e4e446a84cb8571394b42abf1f353b51ffd6d'),
(260, '548545a7-ccce-4737-8956-08a762abc698', 'Fake', 'User', 'd3f2de01-163a-435b-bd61-ed62b0ffe16f@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$0QpC3FoZxncRhK8y$688d14fe737558b667e7ba0a1f14460d57b4c18b981e348493d592f0f5d719c3'),
(261, '26ed55d1-6f6e-4749-9cdc-211a29c4f7a1', 'Fake', 'User', 'ba539ea1-4c03-4ff8-b52a-66176d864823@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$H0wSfueHilurc7wr$b3436c96cad50bd515fa13330fa28311b29ae4dbccfb735e1a2799b8ae5eaf47'),
(262, '2314204a-a65b-47c1-9790-8b4fc6164619', 'Fake', 'User', '21447602-698b-40af-b385-82f3874c2b9d@gmail.com', '0555555555', 'Fake Address', 0, 'sha256$7bcs4sgHmBsmDott$2ad690bc0adbc345162a854436e5018a0502b58fb9c1e21484f2d137a3a33a5d');

--
-- Index pour les tables déchargées
--

--
-- Index pour la table `announces`
--
ALTER TABLE `announces`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `images`
--
ALTER TABLE `images`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `notifications`
--
ALTER TABLE `notifications`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `orders`
--
ALTER TABLE `orders`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `saved_announces`
--
ALTER TABLE `saved_announces`
  ADD PRIMARY KEY (`id`);

--
-- Index pour la table `user`
--
ALTER TABLE `user`
  ADD PRIMARY KEY (`id`);

--
-- AUTO_INCREMENT pour les tables déchargées
--

--
-- AUTO_INCREMENT pour la table `announces`
--
ALTER TABLE `announces`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=850;

--
-- AUTO_INCREMENT pour la table `images`
--
ALTER TABLE `images`
  MODIFY `id` int(11) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=13;

--
-- AUTO_INCREMENT pour la table `notifications`
--
ALTER TABLE `notifications`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `orders`
--
ALTER TABLE `orders`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `saved_announces`
--
ALTER TABLE `saved_announces`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=3;

--
-- AUTO_INCREMENT pour la table `user`
--
ALTER TABLE `user`
  MODIFY `id` int(255) NOT NULL AUTO_INCREMENT, AUTO_INCREMENT=263;
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
