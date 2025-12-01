<?php

namespace App\Controllers;
use App\Models\Db_model;
use CodeIgniter\Exceptions\PageNotFoundException;

class Compte extends BaseController
{
    public function __construct()
    {
        helper('form');                    
        $this->model = model(Db_model::class); 
    }

    // lister tous les comptes
    public function lister()
    {
        $model = model(Db_model::class);
        
        $data['titre']="Liste de tous les comptes";
        $data['logins'] = $model->get_all_compte();
        $data['total']  = $model->count_all_compte();

        return view('templates/haut', $data)
            . view('affichage_comptes')
            . view('templates/bas');
    }



 

    // validation du formulaire de création de compte (ADMIN ONLY)
    public function creer()
    {
        $session = session();

        // accès réservé aux administrateurs 
        if (! $session->has('user') || $session->get('statut') !== "Administrateur") {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        // Soumission du formulaire 
        if ($this->request->getMethod() == "POST") 
        {
            // Validation
            if (! $this->validate(
                [
                    'pseudo' => 'required|max_length[255]|min_length[2]',
                    'mdp'    => 'required|max_length[255]|min_length[8]'
                ],
                [
                    'pseudo' => [
                        'required'   => 'Veuillez entrer un pseudo pour le compte !',
                        'min_length' => 'Le pseudo saisi est trop court !',
                    ],
                    'mdp' => [
                        'required'   => 'Veuillez entrer un mot de passe !',
                        'min_length' => 'Le mot de passe saisi est trop court !',
                    ],
                ]
            )) {
                // Erreur : réaffichage du formulaire admin
                return view('templates/haut2', ['titre' => 'Créer un compte invité'])
                    . view('menu_administrateur')
                    . view('compte/compte_creer')
                    . view('templates/bas2');
            }

            // Validation OK 
            $recuperation = $this->validator->getValidated();

            // Vérification si le compte existe déjà 
            if ($this->model->compteExiste($recuperation['pseudo'])) {
                session()->setFlashdata('error', "Ce compte existe déjà !");
                return view('templates/haut2', ['titre' => 'Créer un compte invité'])
                    . view('menu_administrateur')
                    . view('compte/compte_creer')
                    . view('templates/bas2');
            }

            // Création du compte invité
            $this->model->set_compte($recuperation);

            // Données pour écran de succès
            $data['le_compte']  = $recuperation['pseudo'];
            $data['le_message'] = "Nouveau nombre de comptes : ";
            $data['le_total']   = $this->model->count_all_compte();

            // Succès : affichage version ADMIN
            return view('templates/haut2', $data)
                . view('menu_administrateur')
                . view('compte/compte_succes')
                . view('templates/bas2');
        }

        // Affichage du formulaire admin
        return view('templates/haut2', ['titre' => 'Créer un compte invité'])
            . view('menu_administrateur')
            . view('compte/compte_creer')
            . view('templates/bas2');
    }






    // Connexion d'un utilisateur à l'espace privé 
    public function connecter()
    {
        if ($this->request->getMethod() == "POST") {

            // Validation du formulaire
            if (! $this->validate(
                [
                    'pseudo' => 'required',
                    'mdp'    => 'required'
                ],
                [
                    'pseudo' => [
                        'required' => 'Veuillez entrer votre pseudo.'
                    ],
                    'mdp' => [
                        'required' => 'Veuillez entrer votre mot de passe.'
                    ]
                ]
            )) {
                return view('templates/haut', ['titre' => 'Se connecter'])
                    . view('menu_visiteur')
                    . view('connexion/compte_connecter')
                    . view('templates/bas');
            }

            // Récupération des données
            $username = $this->request->getVar('pseudo');
            $password = $this->request->getVar('mdp');

            // Appel du modèle
            $user = $this->model->connect_compte($username, $password);

            if ($user !== null) {

                // Ouverture de session
                $session = session();
                $session->set('user', $user->cpt_pseudo);
                $session->set('statut', $user->pfl_statut);
                $session->set('cpt_id', $user->cpt_id);


                // REDIRECTION SELON STATUT
                if ($user->pfl_statut == "Administrateur") {

                    return redirect()->to(base_url('index.php/administrateur/accueil'));

                    /* return view('templates/haut2')
                        . view('menu_administrateur')
                        . view('connexion/compte_accueil_admin')
                        . view('templates/bas2'); */

                } else { // MEMBRE

                    return redirect()->to(base_url('index.php/membre/accueil'));

                    /* return view('templates/haut')
                        . view('menu_membre')
                        . view('connexion/compte_accueil_membre')
                        . view('templates/bas'); */
                }
            }

            // Identifiants incorrects
            $data['titre'] = "Se connecter";
            $data['erreur'] = "Identifiants erronés ou inexistants !";

            return view('templates/haut', $data)
                . view('menu_visiteur')
                . view('connexion/compte_connecter')
                . view('templates/bas');
        }

        // GET : afficher le formulaire
        return view('templates/haut', ['titre' => 'Se connecter'])
            . view('menu_visiteur')
            . view('connexion/compte_connecter')
            . view('templates/bas');
    }










    // affichage du profil de la personne
    public function afficher_profil()
    {
        $session = session();

        // Pas connecté, redirection
        if (! $session->has('user')) {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        $statut = $session->get('statut');
        $cpt_id = $session->get('cpt_id'); // On l'a stocké lors de la connexion

        // On récupère toutes les infos du profil
        $data['profil'] = $this->model->getProfilComplet($cpt_id);

        
        // ADMINISTRATEUR
        if ($statut === "Administrateur") {
            return view('templates/haut2')
                . view('menu_administrateur')
                . view('connexion/compte_profil_admin', $data)
                . view('templates/bas2');
        }

        
        // MEMBRE
        if ($statut === "Membre") {
            return view('templates/haut')
                . view('menu_membre')
                . view('connexion/compte_profil_membre', $data)
                . view('templates/bas');
        }

        // Statut inconnu, retour connexion
        return redirect()->to(base_url('index.php/compte/connecter'));
    }






    // Déconnexion
    public function deconnecter()
    {
        $session = session();
        $session->destroy();

        return view('templates/haut', ['titre' => 'Se connecter'])
            . view('menu_visiteur')
            . view('connexion/compte_connecter')
            . view('templates/bas');
    }





    // Accueil de l’espace Membre
    public function accueil_membre()
    {
        $session = session();

        //  L’utilisateur doit être connecté
        if (! $session->has('user')) {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        //  Vérifier le statut
        if ($session->get('statut') !== "Membre") {
            // Admin ou visiteur, accès interdit
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        // 3. Chargement de la page membre
        $data['titre'] = "Espace membre";
        
        // récupérer les réservations à venir
        // $data['reservations'] = [];

        // Récupérer les réservations à venir
        $cpt_id = $session->get('cpt_id'); 

        $reservations = $this->model->get_reservations_a_venir($cpt_id);

        // Pour chaque réservation, récupérer les participants
        foreach ($reservations as &$res) {
            $res['participants'] = $this->model->get_participants($res['res_id']);
        }

        $data['reservations'] = $reservations;


        return view('templates/haut')
            . view('menu_membre')
            . view('connexion/compte_accueil_membre', $data)
            . view('templates/bas');
    }


    // Accueil de l'espace Admin
    public function accueil_admin()
    {
        $session = session();

        // Pas connecté
        if (! $session->has('user')) {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        // Connecté mais MEMBRE → accès interdit
        if ($session->get('statut') !== "Administrateur") {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        
        // Récupérer les réservations à venir
        $cpt_id = $session->get('cpt_id'); 

        $reservations = $this->model->get_reservations_a_venir($cpt_id);

        // Pour chaque réservation, récupérer les participants
        foreach ($reservations as &$res) {
            $res['participants'] = $this->model->get_participants($res['res_id']);
        }

        $data['reservations'] = $reservations;

        // afficher l'accueil admin avec les réservations à venir
        return view('templates/haut2')
            . view('menu_administrateur')
            . view('connexion/compte_accueil_admin', $data)
            . view('templates/bas2');

        
    }



    // Liste des adhérents (accessible uniquement aux membres connectés)
    public function lister_adherents()
    {
        $session = session();

        //  doit être connecté
        if (! $session->has('user')) {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        //  doit être de statut "Membre"
        if ($session->get('statut') !== "Membre") {
            // Admin ou autre, interdit
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        // récupération des adhérents (exclut l'utilisateur courant)
        $cpt_id = $session->get('cpt_id');
        $adherents = $this->model->get_all_adherents($cpt_id);

        // préparation des données pour la vue
        $data['titre'] = "Liste des adhérents";
        $data['adherents'] = $adherents;

        // affichage
        return view('templates/haut', $data)
            . view('menu_membre')
            . view('membre/liste_adherents', $data)
            . view('templates/bas');
    }



    // page qui affiche tous les comptes et profils
    public function comptes_profils()
    {
        $session = session();

        // doit être admin
        if (! $session->has('user') || $session->get('statut') !== "Administrateur") {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        $liste = $this->model->getComptesEtProfils();

        if (count($liste) <= 1) { // Seulement soi-même
            $data['erreur'] = "Aucun compte/profil pour le moment !";

            return view('templates/haut2', $data)
                . view('menu_administrateur')
                . view('admin/comptes_profils_vide', $data)
                . view('templates/bas2');
        }

        $data['comptes'] = $liste;

        return view('templates/haut2')
            . view('menu_administrateur')
            . view('admin/comptes_profils', $data)
            . view('templates/bas2');
    }


}