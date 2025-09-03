-- phpMyAdmin SQL Dump
-- version 5.2.1
-- https://www.phpmyadmin.net/
--
-- Hôte : 127.0.0.1:3306
-- Généré le : mar. 02 sep. 2025 à 19:02
-- Version du serveur : 8.3.0
-- Version de PHP : 8.2.18

SET SQL_MODE = "NO_AUTO_VALUE_ON_ZERO";
START TRANSACTION;
SET time_zone = "+00:00";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;

--
-- Base de données : `projet_video_center`
--

-- --------------------------------------------------------

--
-- Structure de la table `comment`
--

DROP TABLE IF EXISTS `comment`;
CREATE TABLE IF NOT EXISTS `comment` (
  `id` int NOT NULL AUTO_INCREMENT,
  `video_id` int DEFAULT NULL,
  `user_id` int DEFAULT NULL,
  `content` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `craeted_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `author` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `IDX_9474526C29C1004E` (`video_id`),
  KEY `IDX_9474526CA76ED395` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `doctrine_migration_versions`
--

DROP TABLE IF EXISTS `doctrine_migration_versions`;
CREATE TABLE IF NOT EXISTS `doctrine_migration_versions` (
  `version` varchar(191) COLLATE utf8mb3_unicode_ci NOT NULL,
  `executed_at` datetime DEFAULT NULL,
  `execution_time` int DEFAULT NULL,
  PRIMARY KEY (`version`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_unicode_ci;

--
-- Déchargement des données de la table `doctrine_migration_versions`
--

INSERT INTO `doctrine_migration_versions` (`version`, `executed_at`, `execution_time`) VALUES
('DoctrineMigrations\\Version20250808122953', '2025-08-08 12:32:58', 1204),
('DoctrineMigrations\\Version20250809101120', '2025-08-09 10:12:03', 256),
('DoctrineMigrations\\Version20250810101605', '2025-08-10 10:16:41', 744),
('DoctrineMigrations\\Version20250810102948', '2025-08-10 10:30:39', 1620);

-- --------------------------------------------------------

--
-- Structure de la table `messenger_messages`
--

DROP TABLE IF EXISTS `messenger_messages`;
CREATE TABLE IF NOT EXISTS `messenger_messages` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `body` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `headers` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `queue_name` varchar(190) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `available_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `delivered_at` datetime DEFAULT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_75EA56E0FB7336F0` (`queue_name`),
  KEY `IDX_75EA56E0E3BD61CE` (`available_at`),
  KEY `IDX_75EA56E016BA31DB` (`delivered_at`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `reset_password_request`
--

DROP TABLE IF EXISTS `reset_password_request`;
CREATE TABLE IF NOT EXISTS `reset_password_request` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `selector` varchar(20) COLLATE utf8mb4_unicode_ci NOT NULL,
  `hashed_token` varchar(100) COLLATE utf8mb4_unicode_ci NOT NULL,
  `requested_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `expires_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  PRIMARY KEY (`id`),
  KEY `IDX_7CE748AA76ED395` (`user_id`)
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

-- --------------------------------------------------------

--
-- Structure de la table `types`
--

DROP TABLE IF EXISTS `types`;
CREATE TABLE IF NOT EXISTS `types` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `types`
--

INSERT INTO `types` (`id`, `name`) VALUES
(1, 'Musique'),
(2, 'Bandes-annonces'),
(3, 'Films'),
(4, 'Formation'),
(5, 'Dessins animés'),
(6, 'Sport'),
(7, 'Jeux vidéos'),
(8, 'Documentaires'),
(9, 'Actualités'),
(10, 'Voyages'),
(11, 'Célébrités'),
(12, 'Sériales'),
(13, 'Recipes');

-- --------------------------------------------------------

--
-- Structure de la table `users`
--

DROP TABLE IF EXISTS `users`;
CREATE TABLE IF NOT EXISTS `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `email` varchar(180) COLLATE utf8mb4_unicode_ci NOT NULL,
  `roles` json NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `firstname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `lastname` varchar(50) COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `is_verified` tinyint(1) NOT NULL,
  `image_name` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image` varchar(255) COLLATE utf8mb4_unicode_ci DEFAULT NULL,
  `image_size` int DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `UNIQ_IDENTIFIER_EMAIL` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `users`
--

INSERT INTO `users` (`id`, `email`, `roles`, `password`, `firstname`, `lastname`, `created_at`, `updated_at`, `is_verified`, `image_name`, `image`, `image_size`) VALUES
(1, 'admin@ex.com', '[]', '$2y$13$Q2Wkm.6nL9dnUzzSl4fPM..T1nTCHzYjw0bpoc8OmReKCyfVYtmF2', 'Olga', 'Petrenko', '2025-08-10 09:57:40', '2025-08-10 09:57:40', 0, 'sans_photo.png', NULL, NULL),
(4, 'tony3@ex.com', '[]', '$2y$13$qdDZTbVeuHaL96siYFvVV.9kzIXYmGXLd7NLWQ7ScsVX/uu7z8ra6', 'tony', 'tony', '2025-08-14 09:00:23', '2025-08-14 09:00:23', 1, 'sans_photo.png', NULL, NULL),
(5, 'tony4@ex.com', '[]', '$2y$13$waJyM/RMADKuENEXL4b3FO83At9KEpEXRi8cf4FzKOwDm3O0dbxKm', 'tony', 'tony', '2025-08-14 09:41:38', '2025-08-30 21:31:31', 1, 'sans_photo.png', NULL, NULL),
(7, 'piter@ex.com', '[]', '$2y$13$kLpyWOS0zHAz4xZS0xVQ0ejll6STCliw.eQTuzyd8DR3UtMd3.a82', 'piter', 'piter', '2025-08-14 15:36:02', '2025-08-15 21:09:03', 1, 'screenshot-1-686e2090cbcd3580430218-689fa1efd8fee973954305.png', NULL, 632487),
(9, 'alex@gmail.com', '[]', '$2y$13$b.yrv4Wlzid9AJHtZLVJCOahblzvXDhfcueC/EkIXXeQQt0SdfJ8y', 'Alex', 'Axel', '2025-08-15 07:47:32', '2025-08-15 08:21:30', 1, 'fb-img-1749979263819-689eee0adfece894861209.jpg', NULL, 42942),
(10, 'thomas@ex.com', '[]', '$2y$13$tHXIviOSmYm1V4OwULAU5.c7oLjT1zllhSIDsiCDLxdZntaaaFL4a', 'Thomas', 'Naem', '2025-08-25 07:50:42', '2025-08-25 07:50:43', 1, '3011fc6e7e4411ee8071ceda526c50ab-upscaled-68ac15d34505b438644280.jpg', NULL, 112737);

-- --------------------------------------------------------

--
-- Structure de la table `videos`
--

DROP TABLE IF EXISTS `videos`;
CREATE TABLE IF NOT EXISTS `videos` (
  `id` int NOT NULL AUTO_INCREMENT,
  `user_id` int NOT NULL,
  `type_id` int NOT NULL,
  `title` varchar(255) COLLATE utf8mb4_unicode_ci NOT NULL,
  `video_link` varchar(500) COLLATE utf8mb4_unicode_ci NOT NULL,
  `description` longtext COLLATE utf8mb4_unicode_ci NOT NULL,
  `created_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `updated_at` datetime NOT NULL COMMENT '(DC2Type:datetime_immutable)',
  `premium_video` tinyint(1) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `IDX_29AA6432A76ED395` (`user_id`),
  KEY `IDX_29AA6432C54C8C93` (`type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_unicode_ci;

--
-- Déchargement des données de la table `videos`
--

INSERT INTO `videos` (`id`, `user_id`, `type_id`, `title`, `video_link`, `description`, `created_at`, `updated_at`, `premium_video`) VALUES
(1, 1, 1, 'БЕЗ ОБМЕЖЕНЬ – Забрала ніч (OFFICIAL VIDEO)', 'https://www.youtube.com/watch?v=dg4JpcHJ_kA&list=RDdg4JpcHJ_kA&start_radio=1', '«Забрала ніч (2025 Version)» вже доступна для прослуховування та завантаження на усіх музичних платформах: https://orcd.co/zabrala_nich_2025 \r\n\r\n«Це дуже красива пісня, але свого часу вона не отримала того, чого варта», – лідер гурту Сергій Танчинець. \r\n\r\nМи презентуємо оновлену версію пісні «Забрала ніч», яка вперше побачила світ ще у 2021 році в альбомі «Вільні люди». Тоді композиція, попри свій емоційний потенціал, залишилась поза увагою широкої аудиторії – і саме це стало поштовхом до її повернення у новій, глибшій формі.\r\n\r\n«Ми виконували її на акустичних концертах і бачили, як сильно вона відгукується людям. Саме це й переконало нас дати нове життя цій пісні. Ми її перезаписали, зробили більш потужне звучання: змінили оркестровку струнних, перезаписали вокал, додали живе звучання ударних і т.д. Тепер вона звучить так, як мала звучати від самого початку», – Сергій Танчинець. \r\n\r\nУ цій версії ми заглибились в інтимніші відтінки звучання. Нове аранжування стримане, але напружене, що дозволяє прожити емоції без зайвих думок.\r\n\r\nРежисером відеороботи став Влад Разіховський, це вже наша 12-та спільна робота.\r\nУ зйомках було залучено близько 35 музикантів: увесь склад гурту БЕЗ ОБМЕЖЕНЬ та струнний оркестр. \r\n\r\n«Оскільки «Забрала ніч», через стільки років, знову виконували на акустичних концертах, то ми вирішили, що буде символічно відтворити цю камерну атмосферу, яка була на сцені, і у відеороботі. Напівтемрява, свічки та струнні – все це, аби занурити глядача в інтимність моменту та допомогти їм прожити суть пісні на максимум», – додає режисер.\r\n\r\n«Забрала ніч (2025 Version)» – не просто ремастеринг, це приклад того, як пісня може переродитись. Вона не змінює свого змісту, але трансформується, щоб торкнутися ще глибше. \r\n\r\n\r\nБЕЗ ОБМЕЖЕНЬ – Забрала ніч \r\n\r\nНебо вже забрала ніч\r\nТи пішла, ти вже мовчиш\r\nРозпливається, торкається\r\nВолога моїх віч\r\nКрізь темряву і тишу\r\n\r\nНебо вже забрала ніч  \r\nНебо не палає, небо гасне    \r\nМало ж бути вічно пліч-о-пліч   \r\nТа наше небо гасне\r\nА най би було вічно ясне\r\n\r\nОбіймай\r\nОбіймай\r\nЯ дивлюсь на тебе, бачиш\r\nБачиш, як на рай\r\nПритулись\r\nПритули\r\nЯ дивитимусь на тебе так завжди\r\n\r\nНебо вже забрала ніч\r\nНіч забрала мою душу\r\nЯ стою з собою віч-на-віч\r\nЗі мною є лиш тиша\r\nЗі мною темна-темна тиша\r\n\r\nОбіймай\r\nОбіймай\r\nЯ дивлюсь на тебе, бачиш\r\nБачиш, як на рай\r\nПритулись\r\nПритули\r\nОбійми мене, благаю, обійми\r\nПідкорись\r\nПідкори\r\nЯ дивитимусь на тебе так завжди\r\nЯ дивитимусь на тебе\r\nДивитимусь на тебе так завжди\r\n\r\n\r\nСлова: Олег Ходачук, Сергій Танчинець\r\nМузика: Сергій Танчинець\r\n\r\n\r\nБЕЗ ОБМЕЖЕНЬ:\r\nСергій Танчинець – лідер гурту\r\nОлександр Адаменко – бас-гітара \r\nІгор Рибар – гітара\r\nОлексій Бережний – барабани\r\n\r\nСаундпродюсери – Артур Данієлян, Сергій Танчинець\r\nМастерінг – Олександр Павлюков\r\nАранжування струнних – Ганна Мозолевич\r\n1 скрипка – Ніна Руденко\r\n2 скрипка – Тетяна Хоменко\r\nАльт – Соф\'я Зайцева\r\nВіолончель – Євгенія Дячук\r\nЗвукорежисер – Олександр Збродський \r\n\r\nРежисер/оператор – Влад Разіховський (  / vlad_razikhovsky  )\r\nСпіврежисер – Сергій Танчинець\r\nІдея відеороботи – Юліана Корецька\r\nМеханік камери/Focus Puller – Єгор Паламарчук\r\nОператор дрона – Роман Воронцов\r\nGrip/Dolly – Володимир Петух\r\nDolly – Ілля Кондраєв, Миколай Кагитін\r\nТранспорт – Дмитро Мамцев\r\nГафер – Юрій Хількевич\r\nОсвітлювач – Руслан Галькевич\r\nGrip – Констянтин Чеба \r\nЕлектрик – Сергій Березуцький\r\nТехнічне забезпечення – Garage Rental\r\nPostproduction – FreeFilm\r\n\r\nУ зйомках брали участь: \r\nГурт БЕЗ ОБМЕЖЕНЬ \r\nСкрипки – Ніна Руденко, Максим Романюк, Ольга Михайлюк, Ганна Фролова, Микола Ківільов, Олександр Ківільов, Іван Івах, Олександра Алтухова, Валентина Сьомочкіна, Олена Чигир, Діана Байдун, Дарія Гнатів, Ярослава Милявська, Кристина Гордієнко, Дар\'я Шутенко,\r\nМихайло Золотов, Юлія Карпова, Джульєта Михайлюк\r\nАльти – Олена Нестеровська, Соф\'я Зайцева, Максим Ощепков, Микола Іванов, Софія Кірсова, Серафим Одріховський\r\nВіолончелі – Євгенія Дячук, Христина Мерчук, Валерія Швець, Поліна Цобенко\r\nФортепіано – Поль Солонар\r\nКларнет – Микола Шостов\r\n\r\nГример – Євгенія Антоненко\r\nБекстейдж фото – Андрій Харламов\r\nДизайн обкладинки – Ігор Фомін\r\nSMM – Дана Сорочук \r\nАдміністратор – Анастасія Чемко\r\nDigital marketing – Леонід Ласточкін\r\n\r\nБЕЗ ОБМЕЖЕНЬ Agency:\r\nОлег Ходачук – генеральний продюсер\r\nМаксим Ткаченко – творчий продюсер\r\nСергій Танчинець – продюсер\r\nЮліана Корецька – PR&management\r\nМикола Шостов – менеджер гурту\r\n\r\n\r\nСлідкуйте за новинами!\r\n• Facebook:   / bezobmezhenua   \r\n• Instagram:   / bezobmezhen  \r\n• TikTok:   / bezobmezhen  \r\n• Official site: https://www.bezobmezhen.ua \r\n• Мерч: https://www.bezobmezhen.ua/shop/\r\n\r\nBooking: Шостов Микола +380936222210\r\n\r\n#безобмежень  #українськийрок', '2025-08-14 18:36:31', '2025-08-14 18:36:31', 0),
(2, 7, 1, 'MUSE - Full Concert [HD] | Live at Pinkpop 2000', 'https://www.youtube.com/embed/VeNQRb6mPvk', '0:00 - New Born\r\n6:30 - Uno\r\n10:00 - Sober\r\n13:50 - Riff\r\n14:39 - Sunburn\r\n18:39 - Falling Down\r\n23:15 - Feeling Good\r\n26:35 - Cave\r\n31:20 - Muscle Museum\r\n35:35 - Plug In Baby\r\n39:57 - Filip\r\n44:15 - Unintended\r\n48:56 - Minimum\r\n51:00 - Showbiz (incomplete)\r\n\r\nThis is Muse\'s first performance at Pinkpop. Next Sunday June 22, 2025  they will be performing their 6th show at Pinkpop 2025.  Enjoy!\r\nApologies for the end, this is what we have 😔\r\n\r\nMuse are an English rock band from Teignmouth, Devon, formed in 1994. The band consists of Matt Bellamy (lead vocals, guitar, keyboards), Chris Wolstenholme (bass guitar, backing vocals), and Dominic Howard (drums, percussion).\r\n\r\nMuse released their debut album, Showbiz, in 1999, showcasing Bellamy\'s falsetto and a melancholic alternative rock style. Their second album, Origin of Symmetry (2001), incorporated wider instrumentation and romantic classical influences and earned them a reputation for energetic live performances. Absolution (2003) saw further classical influence, with strings on tracks such as \"Butterflies and Hurricanes\", and was the first of seven consecutive UK number-one albums.\r\n\r\nWelcome to the official Pinkpop Archive YouTube channel!\r\nOn our channel you will find live performances of international icons such as Bruce Springsteen, Ed Sheeran, The Rolling Stones, Paul McCartney, P!NK, Metallica, Coldplay, The Cure, Pearl Jam, Rage Against The Machine, U2, The Police, Dire Straits, Fleetwood Mac, Robbie Williams and many more, who have performed at the legendary Pinkpop Festival in the Netherlands.', '2025-08-15 22:19:31', '2025-08-19 11:22:03', 1),
(5, 7, 11, 'Steve Jobs - TED - How To Live Before You Die', 'https://www.youtube.com/embed/lcZDWo6hiuI', '(1955 - 2011) Rest In Peace - Apple Co-Finder Steve Jobs in 2005 giving his Stanford Commencement Address', '2025-08-19 09:59:52', '2025-08-19 09:59:52', 0),
(7, 7, 1, 'Sia ft. Damian Marley – Wrong Direction', 'https://www.youtube.com/embed/4wGK8DpX140', '🎶 Experience the Emotion – Official Lyric Video 🎶\r\nFeel the raw emotions through this beautifully crafted lyric video. Let the haunting melodies and powerful lyrics take you on a journey of love, loss, and unforgettable memories. Every line tells a story — every note echoes the heart.\r\n\r\n🔥 If this video moves you, don’t forget to LIKE, COMMENT & SUBSCRIBE for more incredible lyric videos! 🔥\r\n\r\n📌 DISCLAIMER: This lyric video is created purely for entertainment and artistic expression. It is NOT an official release by the original artist or their label. All rights to the original song and music belong to their respective owners. If you are the rightful owner and would like this video removed, please contact me directly, and I will take it down immediately.\r\n\r\n📌 DISCLAIMER: This music is generated using AI and is not an official release by the artist. It is created for entertainment and creative exploration. All rights to the original artist and their work remain with them.\r\n\r\n🔔 Turn on notifications so you never miss an upload that touches your soul.', '2025-08-19 15:50:22', '2025-08-19 15:50:22', 1),
(8, 7, 12, 'PeP\'s - Parents, Élèves, Profs - Épisode 268', 'https://www.youtube.com/embed/qNQ0vh9If9s', 'Les élèves désespèrent les profs, qui exaspèrent les parents, qui insupportent les profs, qui gonflent les élèves, qui mentent à leurs parents...\r\nQu\'on la déteste ou qu\'on en garde un merveilleux souvenir, qu\'on y travaille ou qu\'on y emmène ses enfants, qu\'on veuille la supprimer ou la réinventer, l\'école fait partie intégrante de notre vie…et ne laisse personne indifférent !', '2025-08-19 15:52:23', '2025-08-19 15:52:23', 0),
(9, 7, 12, 'PeP\'s - Parents, Élèves, Profs - Épisode 267', 'https://www.youtube.com/embed/QW1rdAMdl64/', 'Les élèves désespèrent les profs, qui exaspèrent les parents, qui insupportent les profs, qui gonflent les élèves, qui mentent à leurs parents...\r\nQu\'on la déteste ou qu\'on en garde un merveilleux souvenir, qu\'on y travaille ou qu\'on y emmène ses enfants, qu\'on veuille la supprimer ou la réinventer, l\'école fait partie intégrante de notre vie…et ne laisse personne indifférent !', '2025-08-19 16:03:59', '2025-08-19 16:03:59', 0),
(10, 7, 12, 'PeP\'s - Parents, Élèves, Profs - Épisode 261', 'https://www.youtube.com/embed/IPko9WG5XCE', 'Les élèves désespèrent les profs, qui exaspèrent les parents, qui insupportent les profs, qui gonflent les élèves, qui mentent à leurs parents...\r\nQu\'on la déteste ou qu\'on en garde un merveilleux souvenir, qu\'on y travaille ou qu\'on y emmène ses enfants, qu\'on veuille la supprimer ou la réinventer, l\'école fait partie intégrante de notre vie…et ne laisse personne indifférent !', '2025-08-19 16:04:59', '2025-08-19 16:04:59', 0),
(11, 7, 12, 'PeP\'s - Parents, Élèves, Profs - Épisode 266', 'https://www.youtube.com/embed/1ZZz2Bf8cCE', 'Les élèves désespèrent les profs, qui exaspèrent les parents, qui insupportent les profs, qui gonflent les élèves, qui mentent à leurs parents...\r\nQu\'on la déteste ou qu\'on en garde un merveilleux souvenir, qu\'on y travaille ou qu\'on y emmène ses enfants, qu\'on veuille la supprimer ou la réinventer, l\'école fait partie intégrante de notre vie…et ne laisse personne indifférent !', '2025-08-19 16:08:10', '2025-08-19 16:08:10', 0),
(12, 9, 4, 'Faites évoluer votre cerveau : preuves scientifiques pouvoir de la pensée - Joe Dispenza Livre Audio', 'https://www.youtube.com/embed/Pq5rGj1avk4', 'Faites évoluer votre cerveau : preuves scientifiques pouvoir de la pensée - Joe Dispenza Livre Audio\r\n\r\nFaites évoluer votre cerveau : plongez dans la révolution neuroscientifique qui transformera votre existence !\r\n\r\nPar l\'auteur du best-seller « Devenir super-conscient » !\r\n\r\nCe livre audio captivant est une exploration fascinante qui vous dévoile les secrets les mieux gardés de votre esprit. À travers une approche révolutionnaire alliant neurosciences et développement personnel, le Dr Joe Dispenza, expert reconnu mondialement, vous guide dans les méandres fascinants de votre cerveau pour vous révéler son potentiel illimité de transformation.\r\n\r\nChaque chapitre est une découverte stupéfiante qui vous permettra de comprendre comment vos pensées sculptent littéralement votre réalité biologique. C\'est une plongée extraordinaire dans l\'univers neuronal, une cartographie précise des mécanismes mentaux, qui vous apprendra à briser les chaînes des schémas comportementaux destructeurs et à reprogrammer votre cerveau pour une vie épanouie.\r\n\r\nLors de l\'écoute de ce livre audio, vous découvrirez :\r\n\r\nComment vos pensées créent des réactions chimiques qui vous maintiennent prisonnier de vos habitudes ;\r\n\r\nPourquoi votre cerveau perpétue sans cesse les mêmes schémas comportementaux ;\r\n\r\nComment développer votre capacité de concentration au milieu du chaos ;\r\n\r\nQuels sont les mécanismes neurologiques de l\'apprentissage et de la guérison ;\r\n\r\nComment briser les patterns émotionnels qui vous rendent malheureux ;\r\n\r\nPourquoi certaines dépendances comportementales se créent et persistent ;\r\n\r\nComment reprogrammer votre esprit pour créer de nouvelles habitudes positives ;\r\n\r\nQuelles sont les techniques pour faire évoluer votre cerveau de manière consciente ;\r\n\r\nComment guérir votre corps et votre psyché par la maîtrise mentale ;\r\n\r\nEt beaucoup d\'autres révélations scientifiques !\r\n\r\nCe livre est un guide indispensable pour tous ceux qui souhaitent prendre le contrôle de leur destinée neurologique et transformer leur existence. Le Dr Joe Dispenza ne vous propose pas simplement des théories ; il vous offre les clés scientifiques pour recâbler votre cerveau et créer la vie que vous méritez.\r\n\r\nAcceptez l\'invitation à cette révolution intérieure et laissez « Faites évoluer votre cerveau » devenir l\'architecte de votre nouvelle réalité. Commencez dès maintenant votre métamorphose neuronale !\r\n\r\n🟢 Votre confiance revêt une importance capitale à mes yeux. Pour garantir une totale transparence, je tiens à préciser que les liens Amazon que je fournis sont des liens d\'affiliation sur lesquels je touche une commission mais cela ne change rien pour vous.', '2025-08-20 10:23:09', '2025-08-20 10:23:09', 0),
(13, 9, 4, 'SAY These 3 Words and He’ll Think About You All Day | Matthew Hussey', 'https://www.youtube.com/embed/G8rayR1ElWw', 'SAY These 3 Words and He’ll Think About You All Day | Matthew Hussey  \r\n\r\nSay these three words and he’ll think about you all day Discover the powerful secret phrases that can capture a man’s attention and make him crave your presence In this video inspired by Matthew Hussey you’ll learn the three words that create deep emotional connections and make a man unable to get you out of his mind This relationship advice is perfect for anyone looking to build strong connections attract a man and understand the psychology of love and dating Watch now and transform your conversations to make a man think about you all day', '2025-08-20 10:24:01', '2025-08-20 10:24:01', 1),
(14, 7, 1, 'Teddy Swims ft P!nk - Somebody Save Me From Myself (2025 Official Music Video)', 'https://www.youtube.com/embed/Es44ATiAmmQ', '\"Somebody Help Me From Myself\" by Teddy Swims ft. P!nk is a powerful emotional anthem about inner battles, vulnerability, and the cry for healing. With raw vocals and soul-stirring lyrics, Teddy and P!nk unite their signature voices to deliver a deeply relatable message for anyone struggling within. Let this song be your voice when words fall short.', '2025-08-20 12:17:18', '2025-08-20 12:17:18', 0),
(15, 10, 1, 'Arcane League of Legends | Ramsey - Goodbye | Music Video', 'https://www.youtube.com/embed/1Lhco_Ee0nw', 'From Riot Games Netflix Animation Series \"Arcane\".\r\n\r\nOriginal Track here:    • Ramsey - Goodbye  | Arcane League of Legen...   \r\n\r\nDISCLAIMER - \r\nI own none of the content shown in the video.\r\nAll video and audio are owned by Riot Games & Netflix.\r\n\r\nLYRICS\r\nI can hear the sound of a heartbeat before it goes out\r\nWon’t ever leave my memory of bloodshed all around\r\nI can see a tear on my father’s face before it falls out\r\nOh my enemy, how could I have ever let you down, oh\r\nWhen all these trees saw us grow, cut our teeth, and make our bones right here\r\nWe’d play with shields made of stone, share our dreams and sit our thrones\r\n\r\nBe still, ’cause I see smoke up ahead and I got steel in my hands\r\nWe will return like warriors I swear that we’ll find glory up ahead\r\n\r\nTell me, where is my home? I don’t recognize the faces anymore, no\r\nWhere is my friend? The one I’ve known since I was only just a kid\r\n\r\nI think it\'s time to say goodbye\r\nGoodbye, Goodbye\r\nGoodbye, Goodbye, woh\r\nIt\'s time to say Goodbye\r\nGoodbye, Goodbye\r\nGoodbye, Goodbye, woh\r\n\r\nIt\'s time to say goodbye\r\nGoodbye, Goodbye\r\nGoodbye, Goodbye, woh\r\nIt\'s time to say Goodbye\r\nGoodbye, Goodbye\r\nGoodbye, Goodbye, woh\r\n\r\nIs it time to say goodbye?\r\nGoodbye, Goodbye\r\nGoodbye, Goodbye, woh\r\nIt\'s time to say Goodbye\r\nGoodbye, Goodbye\r\nGoodbye, Goodbye, woh\r\n\r\nIt\'s time to say goodbye\r\nGoodbye, Goodbye\r\nGoodbye, Goodbye, woh\r\nIt\'s time to say Goodbye\r\nGoodbye, Goodbye\r\nGoodbye, Goodbye, woh', '2025-08-25 07:55:39', '2025-08-25 07:55:39', 0),
(17, 10, 7, 'BEST ROBLOX Compilation', 'https://www.youtube.com/embed/beb_bdFTgeE', 'Today, we\'re looking back at our biggest and best adventures in Roblox! Come and join us on more epic adventures coming soon!\r\n\r\nWe hope you enjoy our videos! Have a great day!', '2025-08-30 18:30:50', '2025-08-30 18:30:50', 0),
(18, 10, 7, 'Evolution of ROBLOX GAMES (2003 - 2025)', 'https://www.youtube.com/embed/WIYMUvacdrA', 'Today, FLUSH will look into both the OLDEST and NEWEST ROBLOX GAMES that made ROBLOX what they are today! DATING back from ROBLOX 2003 when it was still called DYNABLOCKS, FLUSH will explore POPULAR GAMES from EACH YEAR and see if they still hold up, or if the NEW ROBLOX GAMES are MORE POPULAR!', '2025-08-30 18:36:15', '2025-08-30 18:36:15', 1),
(19, 10, 7, 'ULTRA REALISTIC F1 25 Gameplay - Ferrari SF-25 Lewis Hamilton SILVERSTONE', 'https://www.youtube.com/embed/doMa7SSMagU', 'Racing in the Ferrari SF-25 Formula 1 car as Lewis Hamilton.\r\nBritish Grand Prix at Silverstone\r\n\r\nWheel base: Simucube 2 Pro\r\nPedals: Simgrade VX Pro \r\nCockpit: Simlab\r\nHaptic/Tactile feedback: 4 Dayton Audio transducers \r\nButton box: Custom built with stream deck\r\nAsus Bezel free kit\r\n\r\nPC Specs:\r\nCPU: Intel i9 10900k\r\nGPU Nvidia RTX4080 Super\r\nRAM: 32GB \r\nSSD: Intel NVME\r\nMonitors: Triple Samsung G5  32\" 1440p 144Hz\r\n\r\n⏱️TIMESTAMPS⏱️\r\n00:00 Intro and Formation lap\r\n02:02 Race\r\n05:20 vs Leclerc\r\n06:06 Race\r\n07:16 vs Antonelli\r\n08:16 Race\r\n15:46 Pit stop\r\n16:40 Critical laps for the undercut\r\n19:45 vs Verstappen for P1\r\n22:29 Race\r\n26:16 Safety car\r\n29:24 Safety car Drama - \"We are checking\"\r\n31:14 \" We have damage, retire the car\"', '2025-08-30 18:51:27', '2025-08-30 18:51:27', 1);

--
-- Contraintes pour les tables déchargées
--

--
-- Contraintes pour la table `comment`
--
ALTER TABLE `comment`
  ADD CONSTRAINT `FK_9474526C29C1004E` FOREIGN KEY (`video_id`) REFERENCES `videos` (`id`),
  ADD CONSTRAINT `FK_9474526CA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `reset_password_request`
--
ALTER TABLE `reset_password_request`
  ADD CONSTRAINT `FK_7CE748AA76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`);

--
-- Contraintes pour la table `videos`
--
ALTER TABLE `videos`
  ADD CONSTRAINT `FK_29AA6432A76ED395` FOREIGN KEY (`user_id`) REFERENCES `users` (`id`),
  ADD CONSTRAINT `FK_29AA6432C54C8C93` FOREIGN KEY (`type_id`) REFERENCES `types` (`id`);
COMMIT;

/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
