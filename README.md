# 🚌 ResaWeb - Web Application for Vehicle Reservation & Resource Management

![Bus Reservation](https://img.shields.io/badge/System-Bus%20Reservation-green)
![PHP](https://img.shields.io/badge/PHP-Backend-blue)
![CodeIgniter](https://img.shields.io/badge/Framework-CodeIgniter-orange)
![MySQL](https://img.shields.io/badge/Database-MySQL-blue)
![MVC](https://img.shields.io/badge/Architecture-MVC-green)
![Responsive](https://img.shields.io/badge/UI-Responsive-purple)

> Complete web application for resource and reservation management for an association, developed as part of the **ISI (Information Systems Engineering)** module in L3 Computer Science at the **Université de Bretagne Occidentale (UBO)**.

---

## 📌 Description

ResaWeb is a web information system allowing members of an association to **reserve vehicles** online. The application manages the entire lifecycle of a reservation: browsing available vehicles, booking for a group of passengers, managing unavailabilities, internal communication, and meeting tracking.

The system is built around **three distinct roles**:

| Role | Rights |
|---|---|
| 👤 Visitor | Browse available vehicles, send a message to the admin |
| 🙋 Member | Reserve a vehicle, join meetings, view their history |
| 🛠️ Administrator | Manage resources, accounts, unavailabilities and news |

---

## 📸 Application Preview

### Home page with latest news
![Home](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/accueil_resaweb.png)

### Vehicle list (Admin)
![Vehicles](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/liste_vehicules_resaweb.png)

### Reserved sessions (Admin)
![Reservations](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/liste_reservations.png)

### Account management (Admin)
![Accounts](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/comptes_admin.png)

### Visitor messages (Admin)
![Messages](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/messages%20des%20visiteurs.png)

### Contact form (Visitor)
![Contact](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/contact_resaweb.png)

### Request tracking (Visitor)
![Tracking](https://raw.githubusercontent.com/lenaic-hounleba/bus-reservation-app/V2/docs/screenshots/suivi_demande_resaweb.png)

---

## ⚙️ Tech Stack

- **Backend** : PHP 8+ · CodeIgniter 4 (MVC framework)
- **Database** : MySQL - with stored procedures, triggers and PSM functions
- **Frontend** : HTML5 · CSS3 · Bootstrap
- **Deployment server** : Obiwan (UBO university server) via SSH
- **Tools** : phpMyAdmin · Git · GitLab UBO

---

## 🧠 Main Features

### Member side
- 🔐 Secure registration and login (SHA-256 hashed password + salt)
- 🚗 Browse available vehicles with their capacity (`rsc_jauge`)
- 📅 Reserve a vehicle for a given time slot (date, start/end time)
- 👥 Role management within a reservation: driver or passenger
- 📋 Participation in association meetings
- 💬 Internal messaging with the administration

### Administrator side
- ➕ Add, modify and delete vehicles (resources)
- 🚫 Manage unavailabilities with reason, comment and status (Ended / Ongoing / Upcoming)
- 📢 Publish news
- 👤 Manage member accounts

### Key business rules
- ❌ Reservation rejected if the number of passengers exceeds the vehicle capacity
- 🔗 An unavailability can affect multiple vehicles (N-N relationship via `t_etat_ett`)
- 📬 Visitors can send messages without having an account

---

## 🗄️ Data Model

The project is based on a complete relational MLD with **14 tables**:

```
t_profil_pfl             → users' personal information
t_compte_cpt             → accounts with role (A = admin, M = member)
t_ville_vll              → cities reference table
t_ressource_rsc          → vehicles (name, photo, description, capacity, URL)
t_reservation_res        → reservations (date, start/end time, summary)
t_inscription_isc        → account-reservation link: member role (driver / passenger) + date
t_reunion_reu            → association meetings
t_participation_ptp      → meeting participants
t_document_dcm           → documents linked to meetings (minutes, PDF…)
t_indisponibilite_idp    → vehicle unavailability periods
t_etat_ett               → N-N link between unavailabilities and resources
t_motif_mtf              → unavailability reasons (breakdown, service, accident…)
t_actualite_act          → news published by the admin
t_message_msg            → messages (members or visitors without an account)
```

---

## 🏗️ MVC Architecture (CodeIgniter)

```
ci/
├── app/
│   ├── Controllers/       # business logic (Home, Reservation, Resource, Account…)
│   ├── Models/            # database access (Db_model.php)
│   ├── Views/             # HTML/CSS templates (admin/, member/, visitor…)
│   ├── Config/
│   │   ├── Database.php   # ⚠️ to be configured locally (not versioned)
│   │   └── Routes.php     # route definitions
│   └── Filters/           # middlewares (auth, roles…)
└── public/                # application entry point
```

---

## 🔄 Project Versions

| Branch | Content |
|---|---|
| `V1` | First functional version (MVC structure, authentication, browsing) |
| `V2` | Final enriched version (reservations, unavailabilities, messaging, SQL triggers) |
| `main` | Documentation, UML modeling and database schema |

---

## 🚀 Local Installation

### Prerequisites
- PHP 7.4+ · MySQL 5.7+ · XAMPP or MAMP

### Steps

```bash
# 1. Clone the repository
git clone https://github.com/lenaic-hounleba/bus-reservation-app.git
cd bus-reservation-app

# 2. Switch to the V2 branch
git checkout V2

# 3. Import the database
# → This file is on the main branch
# → git checkout main, retrieve e22507733_db1.sql, then switch back to V2
# → Open phpMyAdmin, create a database, import database/e22507733_db1.sql

# 4. Configure the connection
# → Edit ci/app/Config/Database.php
#    hostname, username, password, database

# 5. Run on local server
# → Place the ci/ folder in htdocs/ (XAMPP) or Sites/ (MAMP)
# → Access via http://localhost/ci/
```

---

## 📂 Important Files (`main` branch)

| File | Description |
|---|---|
| `BD_MLD_ResaWeb.pdf` | Project Logical Data Model (LDM) |
| `BD_MLD_ResaWeb.mwb` | MySQL Workbench source file |
| `Diagramme_UML_BD_ResaWeb.pdf` | Database UML diagram |
| `e22507733_db1.sql` | Complete database export |
| `requetes_sql_dml_sprint1.sql` | Sprint 1 dataset |
| `requetes_sql_dml_sprint2.sql` | Sprint 2 dataset |

---

## 🔐 Security

- Password hashing with **SHA-256 + application salt** (academic approach - in production, bcrypt or Argon2 would be preferred)
- Role management and **access control (RBAC)** via CodeIgniter sessions
- Username automatically generated in `firstname.lastname` format

---

## ⚠️ Limits & Possible Improvements

> This project was developed in an academic context with tight deadlines, alongside other courses and projects. Some aspects such as the design could not be finalized due to time constraints.

- Improvable user interface - the frontend design could not be fully optimized due to time constraints
- SHA-256 authentication functional but improvable (bcrypt / Argon2 in production)
- No REST API for a clear frontend / backend separation
- Non-containerized deployment (Docker feasible)

---

## 🔭 Future Improvements

- Complete redesign of the design and user experience (custom UX/UI)
- Implementation of a REST API
- Migration to Laravel or Symfony
- Integration of a notification system (email, push)
- Frontend redesign (React / Vue.js)

---

## 📚 Skills Demonstrated

- **MVC** architecture with CodeIgniter
- Relational database design (LDM → SQL)
- **Advanced SQL**: stored procedures, triggers, PSM functions
- Role management and **access control (RBAC)**
- **Full Stack** development: PHP · MySQL · HTML/CSS · Bootstrap
- Deployment on Linux server via **SSH / SCP**
- Version control with **Git** (branches, merge, remote)

---

## 👨‍💻 Author

**Lenaïc Love HOUNLEBA**  
CEO & Full Stack Developer - [ComeUp](https://comeup.com/fr/@lenaic-1)

🔗 GitHub : [github.com/lenaic-hounleba](https://github.com/lenaic-hounleba)  
📧 lovehounleba@gmail.com

---

> *Project carried out as part of the ISI module - L3 Computer Science, Université de Bretagne Occidentale, 2025-2026.*
