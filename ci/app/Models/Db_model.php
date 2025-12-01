<?php

namespace App\Models;
use CodeIgniter\Model;

class Db_model extends Model
{
    protected $db;

    public function __construct()
    {
        $this->db = db_connect(); //charger la base de données
        // ou
        // $this->db = \Config\Database::connect();
    }


    /* Fonction membre qui retourne les pseudos de tous les comptes de la DB */
    public function get_all_compte()
    {
        $resultat = $this->db->query("SELECT cpt_pseudo FROM t_compte_cpt;");
        return $resultat->getResultArray();
    }

    /* Fonction membre qui retourne le nombre de compte dans t_compte_cpt */
    public function count_all_compte()
    {
        $resultat = $this->db->query("SELECT COUNT(*) AS total FROM t_compte_cpt;");
        return $resultat->getRow()->total;
    }


    /* Fonction membre qui affiche les 5 dernières actualités sur accueil */
    public function get_last_actualites()
    {
        $resultat = $this->db->query("SELECT t_actualite_act.act_id, t_actualite_act.act_titre, t_actualite_act.act_contenu, t_actualite_act.act_date_ajout, t_compte_cpt.cpt_pseudo FROM t_actualite_act JOIN t_compte_cpt ON t_actualite_act.cpt_id = t_compte_cpt.cpt_id ORDER BY t_actualite_act.act_id DESC LIMIT 5;");
        return $resultat->getResultArray();
    }



    /* Fonction membre qui retourne les informations de l'actualité dont on passe l'id en parametre */
    public function get_actualite($numero)
    {
        $requete="SELECT * FROM t_actualite_act WHERE act_id=".$numero.";";
        $resultat = $this->db->query($requete);
        return $resultat->getRow();
    }

    

    // Récupération des données d'un message grace au code passé en paramètre de lien
    public function get_demande_par_code($code)
    {   
        $requete = "SELECT msg_date, msg_sujet, msg_contenu, msg_email, msg_reponse, msg_code FROM t_message_msg WHERE msg_code = '" . $code . "';";
        $resultat = $this->db->query($requete);
        return $resultat->getRow();
    }


    // ajout d'un compte
    public function set_compte($saisie)
    {
    //Récuparation (+ traitement si nécessaire) des données du formulaire
        $login= $this->db->escapeString($saisie['pseudo']);
        $mdp_original = $saisie['mdp'];

        $salt = "resaweb_salt_2025";
        $mot_de_passe_hash = $this->db->escapeString(hash("sha256", $salt . $mdp_original));

        $sql="INSERT INTO t_compte_cpt (cpt_pseudo, cpt_mdp, cpt_etat) VALUES('$login','$mot_de_passe_hash','Actif');";
        return $this->db->query($sql);
    }



    // Insertion d'un message envoyé par un visiteur
    public function set_message($data)
    {
        $sujet   = $this->db->escapeString($data['sujet']);
        $email   = $this->db->escapeString($data['email']);
        $contenu = $this->db->escapeString($data['contenu']);
        $code    = $this->db->escapeString($data['code']); // généré dans le controller
        $date    = date("Y-m-d H:i:s");

        $sql = "INSERT INTO t_message_msg (msg_sujet, msg_email, msg_contenu, msg_code, msg_date) VALUES ('$sujet', '$email', '$contenu', '$code', '$date');";

        return $this->db->query($sql);
    }


    // Connexion d'un utilisateur (avec récupération du statut)
    public function connect_compte($u, $p)
    {
        // calcul du hash du mot de passe entré
        $hash = hash('sha256', "resaweb_salt_2025" . $p);

        $sql = "SELECT 
                    t_compte_cpt.cpt_id,
                    t_compte_cpt.cpt_pseudo,
                    t_profil_pfl.pfl_statut
                FROM t_compte_cpt
                JOIN t_profil_pfl ON t_compte_cpt.cpt_id = t_profil_pfl.cpt_id
                WHERE t_compte_cpt.cpt_pseudo = '".$u."'
                AND t_compte_cpt.cpt_mdp = '".$hash."';";

        $resultat = $this->db->query($sql);

        if ($resultat->getNumRows() > 0) {
            return $resultat->getRow(); 
        } else {
            return null;
        }
    }



    // Réservations à venir pour un utilisateur (Membre ou Admin)
    public function get_reservations_a_venir($cpt_id)
    {
        $sql = "
            SELECT 
                t_reservation_res.res_id,
                t_reservation_res.res_nom,
                t_reservation_res.res_date_debut,
                t_reservation_res.res_date_fin,
                t_ressource_rsc.rsc_nom
            FROM t_reservation_res
            JOIN t_inscription_isc 
                ON t_reservation_res.res_id = t_inscription_isc.res_id
            JOIN t_ressource_rsc
                ON t_reservation_res.rsc_id = t_ressource_rsc.rsc_id
            WHERE t_inscription_isc.cpt_id = ?
            AND t_reservation_res.res_date_debut > NOW()
            ORDER BY t_reservation_res.res_date_debut ASC;
        ";

        return $this->db->query($sql, [$cpt_id])->getResultArray();
    }

    // les participants d'une réservation
    public function get_participants($res_id)
    {
        $sql = "
            SELECT 
                t_profil_pfl.pfl_nom,
                t_profil_pfl.pfl_prenom
            FROM t_inscription_isc
            JOIN t_profil_pfl
                ON t_inscription_isc.cpt_id = t_profil_pfl.cpt_id
            WHERE t_inscription_isc.res_id = ?;
        ";

        return $this->db->query($sql, [$res_id])->getResultArray();
    }




    // recuperation des donnees d'un profil
    public function getProfilComplet($cpt_id)
    {
        $sql = "SELECT 
                    p.pfl_nom,
                    p.pfl_prenom,
                    c.cpt_pseudo,
                    p.pfl_email,
                    p.pfl_telephone,
                    p.pfl_date_naissance,
                    p.pfl_adresse,
                    v.vll_nom AS ville,
                    v.vll_code_postal,
                    p.pfl_statut,
                    c.cpt_etat
                FROM t_profil_pfl p
                JOIN t_compte_cpt c ON p.cpt_id = c.cpt_id
                JOIN t_ville_vll v ON p.vll_id = v.vll_id
                WHERE p.cpt_id = " . (int)$cpt_id . ";";

        $resultat = $this->db->query($sql);
        return $resultat->getRow(); 
    }



    
    // Liste de tous les adhérents (depuis membre)
    public function get_all_adherents($cpt_id_exclu)
    {
        $sql = "SELECT
                    t_profil_pfl.pfl_nom,
                    t_profil_pfl.pfl_prenom,
                    t_profil_pfl.pfl_email,
                    t_profil_pfl.pfl_telephone
                FROM t_profil_pfl
                JOIN t_compte_cpt ON t_profil_pfl.cpt_id = t_compte_cpt.cpt_id
                WHERE t_profil_pfl.pfl_statut = 'Membre'
                AND t_profil_pfl.cpt_id <> ?
                ORDER BY t_profil_pfl.pfl_nom, t_profil_pfl.pfl_prenom;";

        $query = $this->db->query($sql, [(int)$cpt_id_exclu]);
        return $query->getResultArray();
    }


    // Récupérer la liste des comptes + profils (s'il y en a)
    public function getComptesEtProfils()
    {
        $sql = "
            SELECT 
                t_compte_cpt.cpt_id,
                t_compte_cpt.cpt_pseudo,
                t_compte_cpt.cpt_etat,
                t_profil_pfl.pfl_nom,
                t_profil_pfl.pfl_prenom,
                t_profil_pfl.pfl_email,
                t_profil_pfl.pfl_statut
            FROM t_compte_cpt
            LEFT JOIN t_profil_pfl ON t_compte_cpt.cpt_id = t_profil_pfl.cpt_id
            ORDER BY 
                t_compte_cpt.cpt_etat = 'Actif' DESC,
                t_compte_cpt.cpt_pseudo ASC;
        ";

        return $this->db->query($sql)->getResultArray();
    }
    // si le pseudo existe deja
    public function compteExiste($pseudo)
    {
        $pseudo = $this->db->escapeString($pseudo);
        $sql = "SELECT * FROM t_compte_cpt WHERE cpt_pseudo = '$pseudo'";
        return $this->db->query($sql)->getNumRows() > 0;
    }
















    // recuperer tous les messages avec le pseudo de l'admin qui a repondu
    public function get_all_messages()
    {
        $sql = "
            SELECT 
                msg.msg_id,
                msg.msg_code,
                msg.msg_email,
                msg.msg_date,
                msg.msg_sujet,
                msg.msg_contenu,
                msg.msg_reponse,
                msg.cpt_id,
                cpt.cpt_pseudo AS admin_pseudo
            FROM t_message_msg msg
            LEFT JOIN t_compte_cpt cpt ON msg.cpt_id = cpt.cpt_id
            ORDER BY msg.msg_date DESC;
        ";

        $res = $this->db->query($sql);
        return $res->getResultArray();
    }

    // recuperer un message avec le pseudo de l'admin
    public function get_message($id)
    {
        $sql = "
            SELECT 
                msg.msg_id,
                msg.msg_code,
                msg.msg_email,
                msg.msg_date,
                msg.msg_sujet,
                msg.msg_contenu,
                msg.msg_reponse,
                msg.cpt_id,
                cpt.cpt_pseudo AS admin_pseudo
            FROM t_message_msg msg
            LEFT JOIN t_compte_cpt cpt ON msg.cpt_id = cpt.cpt_id
            WHERE msg.msg_id = ?
        ";

        $res = $this->db->query($sql, [$id]);
        return $res->getRow();
    }

    // enregistrer une reponse
    public function repondre_message($id, $admin_id, $reponse)
    {
        $sql = "
            UPDATE t_message_msg
            SET msg_reponse = ?, cpt_id = ?
            WHERE msg_id = ?
        ";

        return $this->db->query($sql, [$reponse, $admin_id, $id]);
    }




}



