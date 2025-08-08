# 📽️ Projet Vidéo Center

---

## 🇫🇷 Version Française

### 📌 Description
Projet Vidéo Center est une application web développée avec **Symfony**, permettant aux utilisateurs de publier, gérer et visionner des vidéos en ligne (similaire à YouTube).  
Le site propose un système de vidéos publiques et de vidéos *premium* accessibles uniquement aux utilisateurs inscrits et vérifiés.  

Le projet inclut :  
- Un système de recherche avec filtres par catégories (vidéos, musique, dessins animés, bandes-annonces, formation, etc.).
- Une pagination et un affichage responsive.
- Une interface multilingue en **français**, **ukrainien** et **anglais**.

---

### 🎯 Fonctionnalités
- Création, modification, suppression et visualisation de vidéos (*CRUD*).
- Gestion des utilisateurs avec inscription, connexion et vérification par email (Mailtrap).
- Vidéos *premium* réservées aux utilisateurs connectés et vérifiés.
- Recherche avancée avec filtres par catégories.
- Pagination des résultats.
- Profil utilisateur avec photo (VichUploader) et liste des vidéos publiées.
- Interface responsive avec **Bootstrap**.
- Traductions complètes en français, ukrainien et anglais.

---

### 🛠️ Technologies
- **Backend :** Symfony (PHP)
- **Frontend :** Twig, HTML, CSS, JavaScript, Bootstrap
- **Base de données :** MySQL
- **Composants :**
  - VichUploaderBundle
  - KnpPaginatorBundle
  - Traduction Symfony
- **Outils :**
  - Git & GitHub
  - Mailtrap (confirmation email)
  - Composer

---

### 📋 Prérequis
- PHP 8.1+
- Composer
- MySQL
- Symfony CLI
- Node.js & npm (pour la partie front si nécessaire)

---

### 🚀 Installation
1. Cloner le dépôt :
   ```bash
   git clone https://github.com/votre-utilisateur/projet_video_center_symfony.git
   cd projet_video_center
   ```
2. Installer les dépendances :
   ```bash
   composer install
   npm install
   ```
3. Configurer le fichier `.env` avec vos informations de base de données et Mailtrap.
4. Créer la base de données et exécuter les migrations :
   ```bash
   symfony console doctrine:database:create
   symfony console doctrine:migrations:migrate
   ```
5. Lancer le serveur :
   ```bash
   symfony serve
   ```

---

### 🌍 Multilingue
Le site est disponible en **français**, **ukrainien** et **anglais**.

---

### 📂 Structure du projet
- `/src/Entity` — Entités (User, Video, Category, etc.)
- `/src/Controller` — Contrôleurs
- `/templates` — Templates Twig
- `/translations` — Fichiers de traduction
- `/public/uploads` — Images de profil

---

### 🖋️ Auteur
Développé dans le cadre d’un projet de formation Symfony.

---

---

## 🇺🇦 Українська версія

### 📌 Опис
**Vidéo Center** — це веб-застосунок, розроблений на **Symfony**, який дозволяє користувачам публікувати, керувати та переглядати відео онлайн (схоже на YouTube).  
Сайт пропонує систему публічних та *преміум*-відео, доступних лише зареєстрованим та підтвердженим користувачам.  

Проєкт включає:  
- Пошук з фільтрами за категоріями (відео, музика, мультфільми, трейлери, навчання тощо).
- Пагінацію та адаптивний інтерфейс.
- Багатомовність: **французька**, **українська** та **англійська**.

---

### 🎯 Функції
- Створення, редагування, видалення та перегляд відео (*CRUD*).
- Керування користувачами з реєстрацією, входом та підтвердженням email (Mailtrap).
- *Преміум*-відео для зареєстрованих та підтверджених користувачів.
- Розширений пошук з фільтрами за категоріями.
- Пагінація результатів.
- Профіль користувача з фото (VichUploader) та списком опублікованих відео.
- Адаптивний інтерфейс з **Bootstrap**.
- Повний переклад на французьку, українську та англійську мови.

---

### 🛠️ Технології
- **Backend:** Symfony (PHP)
- **Frontend:** Twig, HTML, CSS, JavaScript, Bootstrap
- **База даних:** MySQL
- **Компоненти:**
  - VichUploaderBundle
  - KnpPaginatorBundle
  - Symfony Translation
- **Інструменти:**
  - Git & GitHub
  - Mailtrap (підтвердження email)
  - Composer

---

### 📋 Необхідні умови
- PHP 8.1+
- Composer
- MySQL
- Symfony CLI
- Node.js & npm (для front-частини, якщо потрібно)

---

### 🚀 Встановлення
1. Клонувати репозиторій:
   ```bash
   git clone https://github.com/ваш-користувач/projet_video_center_symfony.git
   cd projet_video_center
   ```
2. Встановити залежності:
   ```bash
   composer install
   npm install
   ```
3. Налаштувати `.env` з параметрами бази даних та Mailtrap.
4. Створити базу даних і виконати міграції:
   ```bash
   symfony console doctrine:database:create
   symfony console doctrine:migrations:migrate
   ```
5. Запустити сервер:
   ```bash
   symfony serve
   ```

---

### 🌍 Багатомовність
Сайт доступний **французькою**, **українською** та **англійською** мовами.

---

### 📂 Структура проєкту
- `/src/Entity` — Сутності (User, Video, Category та ін.)
- `/src/Controller` — Контролери
- `/templates` — Шаблони Twig
- `/translations` — Файли перекладів
- `/public/uploads` — Фото профілю

---

### 🖋️ Автор
Розроблено в межах навчального проєкту Symfony.
