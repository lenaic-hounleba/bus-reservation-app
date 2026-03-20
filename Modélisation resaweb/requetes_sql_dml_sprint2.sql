-- Réservations :

-- 2. Requête donnant les réservations lors d’un jour particulier

SELECT 
    t_reservation_res.res_id,
    t_reservation_res.res_nom,
    t_reservation_res.res_date_debut,
    t_reservation_res.res_date_fin,
    t_reservation_res.res_bilan_reservation,
    t_reservation_res.res_statut,
    t_ressource_rsc.rsc_nom
FROM t_reservation_res
INNER JOIN t_ressource_rsc ON t_reservation_res.rsc_id = t_ressource_rsc.rsc_id
WHERE DATE(t_reservation_res.res_date_debut) = '2025-10-15'
ORDER BY t_reservation_res.res_date_debut ASC;

-- 3. Requête (+ code SQL) listant toutes les réservations à venir de l’utilisateur connecté (+ date, heure, ressource, liste des participants)

SET @id_utilisateur = 22; -- utilisateur 22 connecté

SELECT 
    t_reservation_res.res_id,
    t_reservation_res.res_nom,
    t_reservation_res.res_date_debut,
    t_reservation_res.res_date_fin,
    t_reservation_res.res_statut,
    t_ressource_rsc.rsc_nom,
    GROUP_CONCAT(CONCAT(t_profil_pfl.pfl_prenom, ' ', t_profil_pfl.pfl_nom) SEPARATOR ', ') AS liste_participants
FROM t_reservation_res
JOIN t_inscription_isc ON t_reservation_res.res_id = t_inscription_isc.res_id
JOIN t_ressource_rsc ON t_reservation_res.rsc_id = t_ressource_rsc.rsc_id
JOIN t_profil_pfl ON t_inscription_isc.cpt_id = t_profil_pfl.cpt_id
WHERE t_reservation_res.res_date_debut > NOW()
  AND t_reservation_res.res_id IN (
      SELECT res_id
      FROM t_inscription_isc
      WHERE cpt_id = @id_utilisateur
  )
GROUP BY 
    t_reservation_res.res_id,
    t_reservation_res.res_nom,
    t_reservation_res.res_date_debut,
    t_reservation_res.res_date_fin,
    t_reservation_res.res_statut,
    t_ressource_rsc.rsc_nom
ORDER BY t_reservation_res.res_date_debut ASC;

-- 4. Requête (+ code SQL) listant toutes les réservations à venir / en cours / passées de l’utilisateur connecté (+ date, heure, ressource, liste des participants), de la plus récente à la plus ancienne

SET @id_utilisateur = 22; -- utilisateur 22 connecté

SELECT 
    t_reservation_res.res_id,
    t_reservation_res.res_nom,
    t_reservation_res.res_date_debut,
    t_reservation_res.res_date_fin,
    t_reservation_res.res_statut,
    t_ressource_rsc.rsc_nom,
    GROUP_CONCAT(CONCAT(t_profil_pfl.pfl_prenom, ' ', t_profil_pfl.pfl_nom) SEPARATOR ', ') AS liste_participants
FROM t_reservation_res
JOIN t_inscription_isc ON t_reservation_res.res_id = t_inscription_isc.res_id
JOIN t_ressource_rsc ON t_reservation_res.rsc_id = t_ressource_rsc.rsc_id
JOIN t_profil_pfl ON t_inscription_isc.cpt_id = t_profil_pfl.cpt_id
WHERE t_reservation_res.res_id IN (
    SELECT res_id 
    FROM t_inscription_isc 
    WHERE cpt_id = @id_utilisateur
)
AND t_reservation_res.res_statut IN ('Planifiee', 'En cours', 'Terminee')
GROUP BY 
    t_reservation_res.res_id,
    t_reservation_res.res_nom,
    t_reservation_res.res_date_debut,
    t_reservation_res.res_date_fin,
    t_reservation_res.res_statut,
    t_ressource_rsc.rsc_nom
ORDER BY t_reservation_res.res_date_debut DESC;

-- 5. Requête listant les réservations à venir (& indisponibilités) d’une ressource particulière (ID connu)

SET @id_ressource = 3;

SELECT 
    t_ressource_rsc.rsc_nom AS Nom_Ressource,
    t_reservation_res.res_id AS Id,
    t_reservation_res.res_nom AS Nom,
    t_reservation_res.res_date_debut AS Date_Debut,
    t_reservation_res.res_date_fin AS Date_Fin,
    'Réservation' AS type
FROM t_reservation_res
JOIN t_ressource_rsc 
    ON t_reservation_res.rsc_id = t_ressource_rsc.rsc_id
WHERE t_ressource_rsc.rsc_id = @id_ressource
  AND t_reservation_res.res_statut = 'Planifiee'

UNION ALL

SELECT 
    t_ressource_rsc.rsc_nom AS Nom_Ressource,
    t_indisponibilite_idp.idp_id AS Id,
    t_indisponibilite_idp.idp_commentaire AS Nom,
    t_indisponibilite_idp.idp_date_debut AS Date_Debut,
    t_indisponibilite_idp.idp_date_fin AS Date_Fin,
    'Indisponibilité' AS type
FROM t_indisponibilite_idp
JOIN t_etat_ett
    ON t_indisponibilite_idp.idp_id = t_etat_ett.idp_id
JOIN t_ressource_rsc 
    ON t_etat_ett.rsc_id = t_ressource_rsc.rsc_id
WHERE t_ressource_rsc.rsc_id = @id_ressource
  AND t_indisponibilite_idp.idp_statut IN ('En cours', 'Future')

ORDER BY Date_Debut ASC;

-- 6. Requête vérifiant l’existence (ou non) d’une réservation sur un créneau particulier (date + heure) pour une ressource particulière (ID connu)

SELECT COUNT(*) -- affichera 1 si le créneau est occupé et 0 si c'est libre
FROM t_reservation_res
WHERE t_reservation_res.rsc_id = 3
  AND (
    ('2025-10-15 10:00:00' BETWEEN t_reservation_res.res_date_debut AND t_reservation_res.res_date_fin)
    OR ('2025-10-15 12:00:00' BETWEEN t_reservation_res.res_date_debut AND t_reservation_res.res_date_fin)
  );

-- 7. Requête vérifiant l’existence (ou non) d’une réservation pour l’utilisateur connecté sur un créneau particulier (date + heure)

SET @id_utilisateur = 13;  -- affichera 1 si l'uutilisateur a déjà une réservation sur ce créneau

SELECT COUNT(*)
FROM t_inscription_isc
JOIN t_reservation_res ON t_inscription_isc.res_id = t_reservation_res.res_id
WHERE t_inscription_isc.cpt_id = @id_utilisateur
  AND (
    ('2025-11-02 19:00:00' BETWEEN t_reservation_res.res_date_debut AND t_reservation_res.res_date_fin)
    OR ('2025-11-02 22:00:00' BETWEEN t_reservation_res.res_date_debut AND t_reservation_res.res_date_fin)
  );

-- 8. Requête comptant le nombre de personnes associées à une réservation particulière

SELECT COUNT(*) AS nb_participants
FROM t_inscription_isc
WHERE t_inscription_isc.res_id = 13;

-- 9. Requête (ou code SQL) ajoutant une participation de l’utilisateur connecté en tant que responsable (/participant) à une réservation déjà existante ou à créer si elle n’existe pas encore

SET @id_utilisateur = 53;

-- Si la réservation existe déjà :
INSERT INTO t_inscription_isc (cpt_id, res_id, isc_date, isc_role)
VALUES (@id_utilisateur, 12, NOW(), 'Conducteur');

-- Si elle n’existe pas :
INSERT INTO t_reservation_res (res_nom, res_date_debut, res_date_fin, res_bilan_reservation, res_statut, rsc_id)
VALUES ('Sortie spéciale', '2025-11-15 09:00:00', '2025-11-15 13:00:00', '', 'Planifiee', 2);

INSERT INTO t_inscription_isc (cpt_id, res_id, isc_date, isc_role)
VALUES (@id_utilisateur, LAST_INSERT_ID(), NOW(), 'Conducteur');

-- 10. Requête retirant une participation à une réservation de l’utilisateur connecté

SET @id_utilisateur = 13;

DELETE FROM t_inscription_isc
WHERE t_inscription_isc.res_id = 13
  AND t_inscription_isc.cpt_id = @id_utilisateur;

-- 11. Requête (ou code SQL) permettant à l’utilisateur connecté d’ajouter le bilan à l’une de ses réservations passées à laquelle il a participé comme responsable

SET @id_utilisateur = 81;

UPDATE t_reservation_res
SET t_reservation_res.res_bilan_reservation = 'Belle expérience, tout s’est bien déroulé.'
WHERE t_reservation_res.res_id = 30
  AND t_reservation_res.res_id IN (
      SELECT t_inscription_isc.res_id 
      FROM t_inscription_isc
      WHERE t_inscription_isc.cpt_id = @id_utilisateur
      AND t_inscription_isc.isc_role = 'Conducteur'
  )
  AND t_reservation_res.res_statut = 'Terminee';


-- 1. Requête listant toutes les ressources réservables

SELECT 
    rsc_id,
    rsc_nom,
    rsc_photo,
    rsc_description,
    rsc_jauge,
    rsc_url
FROM t_ressource_rsc;

-- 2. Requête listant toutes les données d’une ressource particulière (ID connu) et le récapitulatif du matériel, s’il y en a

SET @id_ressource = 3; -- ressource 3

SELECT 
    t_ressource_rsc.rsc_id,
    t_ressource_rsc.rsc_nom,
    t_ressource_rsc.rsc_photo,
    t_ressource_rsc.rsc_description,
    t_ressource_rsc.rsc_jauge,
    t_ressource_rsc.rsc_url,
    t_indisponibilite_idp.idp_id,
    t_indisponibilite_idp.idp_date_debut,
    t_indisponibilite_idp.idp_date_fin,
    t_indisponibilite_idp.idp_statut,
    t_indisponibilite_idp.idp_commentaire
FROM t_ressource_rsc
LEFT JOIN t_etat_ett ON t_ressource_rsc.rsc_id = t_etat_ett.rsc_id
LEFT JOIN t_indisponibilite_idp ON t_etat_ett.idp_id = t_indisponibilite_idp.idp_id
WHERE t_ressource_rsc.rsc_id = @id_ressource;

-- 3. Requête récupérant la jauge maximale (/minimale) d’une ressource particulière

SET @id_ressource = 3; -- id de la ressource

SELECT rsc_jauge
FROM t_ressource_rsc
WHERE rsc_id = @id_ressource;

-- 4. Requête d’ajout des données d’une ressource

INSERT INTO t_ressource_rsc (
    rsc_nom,
    rsc_photo,
    rsc_description,
    rsc_jauge,
    rsc_url
)
VALUES (
    'Minibus FK30',
    'minibusfk30.jpg',
    'Un nouveau minibus de 30 places.',
    30,
    'minibusfk30.pdf'
);

-- 5. Requête(s) de suppression d’une ressource


SET @id_ressource = 7;

START TRANSACTION;

-- Supprimer les inscriptions liées aux réservations de cette ressource
DELETE FROM t_inscription_isc
WHERE res_id IN (
    SELECT res_id
    FROM t_reservation_res
    WHERE rsc_id = @id_ressource
);

-- Supprimer les réservations liées à cette ressource
DELETE FROM t_reservation_res
WHERE rsc_id = @id_ressource;

-- Supprimer les lignes d’état associant la ressource à des indisponibilités
DELETE FROM t_etat_ett
WHERE rsc_id = @id_ressource;

-- Supprimer la ressource elle-même
DELETE FROM t_ressource_rsc
WHERE rsc_id = @id_ressource;

COMMIT;
