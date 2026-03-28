![Bus Reservation](https://img.shields.io/badge/System-Bus%20Reservation-green)
![PHP](https://img.shields.io/badge/PHP-Backend-blue)
![CodeIgniter](https://img.shields.io/badge/Framework-CodeIgniter-orange)
![MySQL](https://img.shields.io/badge/Database-MySQL-blue)
![MVC](https://img.shields.io/badge/Architecture-MVC-green)
![Responsive](https://img.shields.io/badge/UI-Responsive-purple)

# 🚌 ResaWeb - Web Application for Vehicle Reservation & Resource Management

> Application web complète de gestion de ressources et de réservations pour une association, que j'ai développée dans le cadre du module **ISI (Ingénierie des Systèmes d'Information)** en L3 Informatique à l'**Université de Bretagne Occidentale (UBO)**.

---

## 📌 Description

ResaWeb est un système d'information web permettant aux membres d'une association de **réserver des véhicules** en ligne. L'application gère l'ensemble du cycle de vie d'une réservation : consultation des véhicules disponibles, réservation pour un groupe de passagers, gestion des indisponibilités, communication interne, et suivi des réunions.

Le système s'articule autour de **trois rôles distincts** :

| Rôle | Droits |
|---|---|
| 👤 Visiteur | Consulter les véhicules disponibles, envoyer un message à l'admin |
| 🙋 Membre | Réserver un véhicule, rejoindre des réunions, consulter son historique |
| 🛠️ Administrateur | Gérer les ressources, les comptes, les indisponibilités et les actualités |

---

## 📸 Aperçu de l'application

### Page d'accueil avec les dernières actualités
![Accueil](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/accueil_resaweb.png)

### Liste des véhicules (Admin)
![Véhicules](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/liste_vehicules_resaweb.png)

### Séances réservées (Admin)
![Réservations](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/liste_reservations.png)

### Gestion des comptes (Admin)
![Comptes](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/comptes_admin.png)

### Messages des visiteurs (Admin)
![Messages](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/messages%20des%20visiteurs.png)

### Formulaire de contact (Visiteur)
![Contact](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/contact_resaweb.png)

### Suivi de demande (Visiteur)
![Suivi](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/suivi_demande_resaweb.png)

---

## ⚙️ Stack technique

- **Backend** : PHP 8+ · CodeIgniter 4 (framework MVC)
- **Base de données** : MySQL - avec procédures stockées, triggers et fonctions PSM
- **Frontend** : HTML5 · CSS3 · Bootstrap
- **Serveur de déploiement** : Obiwan (serveur universitaire UBO) via SSH
- **Outils** : phpMyAdmin · Git · GitLab UBO

---

## 🧠 Fonctionnalités principales

### Côté membre
- 🔐 Inscription et connexion sécurisées (mot de passe hashé SHA-256 + sel)
- 🚗 Consultation des véhicules disponibles avec leur capacité (`rsc_jauge`)
- 📅 Réservation d'un véhicule pour un créneau donné (date, heure début/fin)
- 👥 Gestion des rôles dans une réservation : conducteur ou passager
- 📋 Participation aux réunions de l'association
- 💬 Messagerie interne avec l'administration

### Côté administrateur
- ➕ Ajout, modification et suppression de véhicules (ressources)
- 🚫 Gestion des indisponibilités avec motif, commentaire et statut (Terminée / En cours / Future)
- 📢 Publication d'actualités
- 👤 Gestion des comptes membres

### Règles métier clés
- ❌ Réservation refusée si le nombre de passagers dépasse la jauge du véhicule
- 🔗 Une indisponibilité peut concerner plusieurs véhicules (relation N-N via `t_etat_ett`)
- 📬 Les visiteurs peuvent envoyer des messages sans avoir de compte

---

## 🗄️ Modèle de données

Le projet repose sur un MLD relationnel complet avec **14 tables** :

```
t_profil_pfl             → informations personnelles des utilisateurs
t_compte_cpt             → comptes avec rôle (A = admin, M = membre)
t_ville_vll              → référentiel des villes
t_ressource_rsc          → véhicules (nom, photo, description, jauge, URL)
t_reservation_res        → réservations (date, heure début/fin, bilan)
t_inscription_isc        → liaison compte-réservation : rôle du membre (conducteur / passager) + date
t_reunion_reu            → réunions de l'association
t_participation_ptp      → participants aux réunions
t_document_dcm           → documents liés aux réunions (procès-verbal, PDF…)
t_indisponibilite_idp    → périodes d'indisponibilité des véhicules
t_etat_ett               → liaison N-N entre indisponibilités et ressources
t_motif_mtf              → motifs d'indisponibilité (panne, révision, accident…)
t_actualite_act          → actualités publiées par l'admin
t_message_msg            → messages (membres ou visiteurs sans compte)
```

---

## 🏗️ Architecture MVC (CodeIgniter)

```
ci/
├── app/
│   ├── Controllers/       # logique métier (Accueil, Reservation, Ressource, Compte…)
│   ├── Models/            # accès à la base de données (Db_model.php)
│   ├── Views/             # templates HTML/CSS (admin/, membre/, visiteur…)
│   ├── Config/
│   │   ├── Database.php   # ⚠️ à configurer localement (non versionnée)
│   │   └── Routes.php     # définition des routes
│   └── Filters/           # middlewares (auth, rôles…)
└── public/                # point d'entrée de l'application
```

---

## 🔄 Versions du projet

| Branche | Contenu |
|---|---|
| `V1` | Première version fonctionnelle (structure MVC, authentification, consultation) |
| `V2` | Version finale enrichie (réservations, indisponibilités, messagerie, triggers SQL) |
| `main` | Documentation, modélisation UML et schéma de base de données |

---

## 🚀 Installation locale

### Prérequis
- PHP 7.4+ · MySQL 5.7+ · XAMPP ou MAMP

### Étapes

```bash
# 1. Cloner le dépôt
git clone https://github.com/lenaic-hounleba/bus-reservation-app.git
cd bus-reservation-app

# 2. Basculer sur la branche V2
git checkout V2

# 3. Importer la base de données
# → Ce fichier se trouve sur la branche main
# → git checkout main, récupérer e22507733_db1.sql, puis revenir sur V2
# → Ouvrir phpMyAdmin, créer une base, importer database/e22507733_db1.sql

# 4. Configurer la connexion
# → Éditer ci/app/Config/Database.php
#    hostname, username, password, database

# 5. Lancer sur serveur local
# → Placer le dossier ci/ dans htdocs/ (XAMPP) ou Sites/ (MAMP)
# → Accéder via http://localhost/ci/
```

---

## 📂 Fichiers importants (branche `main`)

| Fichier | Description |
|---|---|
| `BD_MLD_ResaWeb.pdf` | Modèle Logique de Données (MLD) du projet |
| `BD_MLD_ResaWeb.mwb` | Fichier source MySQL Workbench |
| `Diagramme_UML_BD_ResaWeb.pdf` | Diagramme UML de la base de données |
| `e22507733_db1.sql` | Export complet de la base de données |
| `requetes_sql_dml_sprint1.sql` | Jeu de données Sprint 1 |
| `requetes_sql_dml_sprint2.sql` | Jeu de données Sprint 2 |

---

## 🔐 Sécurité

- Hash des mots de passe avec **SHA-256 + sel applicatif** (approche pédagogique - en production, bcrypt ou Argon2 seraient préférés)
- Gestion des rôles et **contrôle d'accès (RBAC)** par sessions CodeIgniter
- Pseudo généré automatiquement au format `prenom.nom`

---

## ⚠️ Limites et améliorations possibles

> Ce projet a été développé dans un cadre académique avec des délais contraints, en parallèle d'autres cours et projets. Certains aspects comme le design n'ont pas pu être finalisés faute de temps.

- Interface utilisateur perfectible - le design frontend n'a pas pu être entièrement optimisé faute de temps
- Authentification SHA-256 fonctionnelle mais améliorable (bcrypt / Argon2 en production)
- Absence d'API REST pour une séparation claire frontend / backend
- Déploiement non containerisé (Docker envisageable)

---

## 🔭 Perspectives d'évolution

- Refonte complète du design et de l'expérience utilisateur (UX/UI personnalisée)
- Mise en place d'une API REST
- Migration vers Laravel ou Symfony
- Intégration d'un système de notifications (email, push)
- Refonte de l'interface utilisateur (React / Vue.js)

---

## 📚 Compétences mobilisées

- Architecture **MVC** avec CodeIgniter
- Conception de base de données relationnelle (MLD → SQL)
- **SQL avancé** : procédures stockées, triggers, fonctions PSM
- Gestion des rôles et **contrôle d'accès (RBAC)**
- Développement **Full Stack** : PHP · MySQL · HTML/CSS · Bootstrap
- Déploiement sur serveur Linux via **SSH / SCP**
- Gestion de version avec **Git** (branches, merge, remote)

---

## 👨‍💻 Auteur

**Lenaïc Love HOUNLEBA**  
CEO & Développeur Full Stack - [ComeUp](https://comeup.com/fr/@lenaic-1)

🔗 GitHub : [github.com/lenaic-hounleba](https://github.com/lenaic-hounleba)  
📧 lovehounleba@gmail.com

---

> *Projet réalisé dans le cadre du module ISI - Licence 3 Informatique, Université de Bretagne Occidentale, 2025-2026.*
