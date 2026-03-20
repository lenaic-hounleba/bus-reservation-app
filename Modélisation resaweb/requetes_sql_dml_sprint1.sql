-- Actualites

-- 1. Requête listant toutes les actualités de la table des actualités et leur auteur (login) 

SELECT 
    t_actualite_act.act_id,
    t_actualite_act.act_titre,
    t_actualite_act.act_image,
    t_actualite_act.act_contenu,
    t_actualite_act.act_date_ajout,
    t_compte_cpt.cpt_pseudo
FROM t_actualite_act
JOIN t_compte_cpt ON t_actualite_act.cpt_id = t_compte_cpt.cpt_id
ORDER BY t_actualite_act.act_date_ajout DESC;


-- 2. Requête donnant les données d'une actualité dont on connaît l'identifiant (n°)

SELECT 
    t_actualite_act.act_id,
    t_actualite_act.act_titre,
    t_actualite_act.act_image,
    t_actualite_act.act_contenu,
    t_actualite_act.act_date_ajout,
    t_compte_cpt.cpt_pseudo
FROM t_actualite_act
JOIN t_compte_cpt ON t_actualite_act.cpt_id = t_compte_cpt.cpt_id
WHERE t_actualite_act.act_id = 1;   -- 1 sera remplacé par l'id 

-- 3. Requête listant les 5 dernières actualités dans l'ordre décroissant

SELECT 
    t_actualite_act.act_id,
    t_actualite_act.act_titre,
    t_actualite_act.act_image,
    t_actualite_act.act_contenu,
    t_actualite_act.act_date_ajout,
    t_compte_cpt.cpt_pseudo
FROM t_actualite_act
JOIN t_compte_cpt ON t_actualite_act.cpt_id = t_compte_cpt.cpt_id
ORDER BY t_actualite_act.act_date_ajout DESC
LIMIT 5;


-- 4. Requête recherchant et donnant la (ou les) actualité(s) contenant un mot particulier

SELECT 
    t_actualite_act.act_id,
    t_actualite_act.act_titre,
    t_actualite_act.act_image,
    t_actualite_act.act_contenu,
    t_actualite_act.act_date_ajout,
    t_compte_cpt.cpt_pseudo
FROM t_actualite_act
JOIN t_compte_cpt ON t_actualite_act.cpt_id = t_compte_cpt.cpt_id
WHERE t_actualite_act.act_contenu LIKE '%mot%';  -- mot sera remplacé par le mot recherché

-- 5. Requête listant toutes les actualités postées à une date particulière + le login de l’auteur

SELECT 
    t_actualite_act.act_id,
    t_actualite_act.act_titre,
    t_actualite_act.act_image,
    t_actualite_act.act_contenu,
    t_actualite_act.act_date_ajout,
    t_compte_cpt.cpt_pseudo
FROM t_actualite_act
JOIN t_compte_cpt ON t_actualite_act.cpt_id = t_compte_cpt.cpt_id
WHERE DATE(t_actualite_act.act_date_ajout) = '2025-10-07'
ORDER BY t_actualite_act.act_date_ajout DESC;



--  Prise de contact :

-- 1. Requête récupérant les données associées à un code de 20 caractères

SELECT 
    t_message_msg.msg_id,
    t_message_msg.msg_code,
    t_message_msg.msg_email,
    t_message_msg.msg_contenu,
    t_message_msg.msg_date,
    t_message_msg.msg_reponse,
    t_compte_cpt.cpt_pseudo AS administrateur_repondant
FROM t_message_msg
LEFT JOIN t_compte_cpt ON t_message_msg.cpt_id = t_compte_cpt.cpt_id
WHERE t_message_msg.msg_code = 'WDZRMH3FNBDVPINE9NNO';   -- le code sera remplacé

-- 2. Requête d’insertion d’une question d’un visiteur (contenant le code de 20 caractères)

INSERT INTO t_message_msg (msg_code, msg_email, msg_contenu, msg_date)
VALUES (
    'QWERTYUIOPASDFGHJKLZ',  
    'visiteur@example.com',
    'Bonjour, je souhaiterais connaître les conditions pour participer à une sortie.',
    NOW()
);

-- 3. Requête donnant la liste de toutes les demandes des visiteurs

SELECT 
    t_message_msg.msg_id,
    t_message_msg.msg_code,
    t_message_msg.msg_email,
    t_message_msg.msg_contenu,
    t_message_msg.msg_date
FROM t_message_msg
WHERE t_message_msg.cpt_id IS NULL
ORDER BY t_message_msg.msg_date DESC;


-- 4. Requête d’ajout de la réponse d’un administrateur à la question d’un visiteur

UPDATE t_message_msg
SET 
    msg_reponse = 'Bonjour, merci pour votre message. Vous pouvez venir assister à notre prochaine réunion avant de vous inscrire officiellement.',
    cpt_id = 1  
WHERE msg_code = '4B9UOE3T0HICCT5HGP8I';

-- Profils (administrateurs / membres) :

-- 1. Requête listant toutes les données de tous les profils/comptes classés par statut

SELECT 
    t_profil_pfl.*,
    t_compte_cpt.*
FROM t_profil_pfl
INNER JOIN t_compte_cpt ON t_profil_pfl.cpt_id = t_compte_cpt.cpt_id
ORDER BY t_profil_pfl.pfl_statut ASC;

-- 2. Requête donnant tous les nom / prénom / adresse e-mail / n° de téléphone des adhérents de la structure

SELECT 
    t_profil_pfl.pfl_nom,
    t_profil_pfl.pfl_prenom,
    t_profil_pfl.pfl_email,
    t_profil_pfl.pfl_telephone
FROM t_profil_pfl
WHERE t_profil_pfl.pfl_statut = 'Membre';

-- 3. Requête de vérification des données de connexion (login et mot de passe)

SELECT *
FROM t_compte_cpt
WHERE cpt_pseudo = 'nicolas.colin'
  AND cpt_mdp = SHA2(CONCAT('2919ef5f4r94ld,f3#0@', 'resaweb_salt_2025'), 256);

-- 4. Requête récupérant les données d'un profil/compte particulier (utilisateur connecté)

SELECT 
    t_profil_pfl.*,
    t_compte_cpt.*
FROM t_profil_pfl
INNER JOIN t_compte_cpt ON t_profil_pfl.cpt_id = t_compte_cpt.cpt_id
WHERE t_compte_cpt.cpt_id = 49;    -- 49 sera remplacé par l'id de la personne connectée

-- 5. Requête vérifiant l’existence (ou non) d’un pseudo

SELECT COUNT(*) AS nb_pseudo
FROM t_compte_cpt
WHERE cpt_pseudo = 'clara.garcia';  -- ça retournera 1 si le pseudo existe déjà, et 0 si ça n'existe pas

-- 6. Requête d'ajout des données d'un profil/compte administrateur (/ membre)

INSERT INTO t_compte_cpt (cpt_mdp, cpt_etat)
VALUES (SHA2(CONCAT('zfrg\@^nanjn', 'resawe_salt_2025'), 256), 'Actif');

INSERT INTO t_profil_pfl (
  pfl_nom,
  pfl_prenom,
  pfl_email,
  pfl_telephone,
  pfl_date_naissance,
  pfl_adresse,
  pfl_statut,
  vll_id,
  cpt_id
)
VALUES (
  'Dupont',
  'Jean',
  'jean.dupont@mail.com',
  '0601020304',
  '1985-07-14',
  '25 Rue des Lilas, Lyon',
  'Administrateur', -- administrateur peut être remplacé par membre s'il s'agit d'un membre
  3,
  LAST_INSERT_ID()
);

-- 7. Requête d’ajout d’un compte invité

INSERT INTO t_compte_cpt (cpt_pseudo, cpt_mdp, cpt_etat)
VALUES ('Invite 11', SHA2(CONCAT('bhdcbhb@@#[', 'resaweb_salt_2025'), 256), 'Actif');

