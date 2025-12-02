<?php

namespace App\Controllers;
use App\Models\Db_model;
use CodeIgniter\Exceptions\PageNotFoundException;

class Message extends BaseController
{
    public function __construct()
    {
        helper('form');                    
        $this->model = model(Db_model::class); 
    }

    // fonction de suivi de demande avec le code en paramètre de lien
    public function faire_suivi($code = null)
    {
        $model = model(Db_model::class);
        $data['titre'] = "Suivi de la demande d’un visiteur";

        if ($code === null)
        {
            $data['erreur'] = "Aucun code n’a été transmis dans l’URL.";
            return view('templates/haut', $data)
                . view('menu_visiteur')
                . view('message_suivi', $data)
                . view('templates/bas');
        }

        $demande = $model->get_demande_par_code($code);

        if (! empty($demande))
        {
            $data['demande'] = $demande;
        }
        else
        {
            $data['erreur'] = "Aucune demande trouvée pour ce code.";
            $data['demande'] = null;  //ajouté
        }

        return view('templates/haut', $data)
            . view('menu_visiteur')
            . view('message_suivi', $data)
            . view('templates/bas');
    }





    // fonction verifier avec saisi du code par formulaire
    public function verifier()
    {
        $data['titre'] = "Suivi de la demande d’un visiteur";
        $data['erreur'] = null;
        $data['demande'] = null;

        // L’utilisateur arrive pour la première fois : afficher juste le formulaire
        if ($this->request->getMethod() === 'GET') {
            return view('templates/haut', $data)
                . view('menu_visiteur')
                . view('message_suivi_form', $data)
                . view('templates/bas');
        }

        // Si on arrive ici, c’est que la méthode = POST
        if (! $this->validate(
            [
                'code' => 'required|exact_length[20]',
            ],
            [
                'code' => [
                    'required' => 'Veuillez remplir le formulaire !',
                    'exact_length' => 'Le code doit faire exactement 20 caractères.',
                ]
            ]
        )) {
            // Retour avec messages d'erreurs automatiques
            return view('templates/haut', $data)
                . view('menu_visiteur')
                . view('message_suivi_form', $data)
                . view('templates/bas');
        }

        // Le champ est validé : on récupère la valeur
        $code = $this->request->getPost('code');

        // Recherche de la demande
        $demande = $this->model->get_demande_par_code($code);

        if ($demande === null) {

            $data['erreur'] = "Aucune demande trouvée correspondant au code saisi !";

            return view('templates/haut', $data)
                . view('menu_visiteur')
                . view('message_suivi_form', $data)
                . view('templates/bas');
        }

        // 4) Succès : affichage du récapitulatif
        $data['demande'] = $demande;

        return view('templates/haut', $data)
            . view('menu_visiteur')
            . view('message_suivi', $data)
            . view('templates/bas');
    }







    // ajout d'un message de contact
    public function ajouter()
    {
    // Affichage du formulaire
    if ($this->request->getMethod() != "POST")
    {
        return view('templates/haut', ['titre' => 'Formulaire de contact'])
            . view('menu_visiteur')
            . view('message/message_ajouter')
            . view('templates/bas');
    }

    // Validation du formulaire
    if (! $this->validate(
        [
            'sujet'   => 'required|max_length[255]',
            'email'   => 'required|valid_email|max_length[255]',
            'contenu' => 'required|max_length[600]',
        ],
        [
            'sujet' => [
                'required' => 'Veuillez entrer un sujet.',
            ],
            'email' => [
                'required'    => 'Veuillez entrer votre e-mail.',
                'valid_email' => 'Adresse e-mail invalide.',
            ],
            'contenu' => [
                'required' => 'Veuillez saisir votre message.',
            ]
        ]
    ))
    {
        // Échec : retour au formulaire
        return view('templates/haut', ['titre' => 'Formulaire de contact'])
            . view('menu_visiteur')
            . view('message/message_ajouter')
            . view('templates/bas');
    }

    // SUCCESS : récupération des données
    $donnees = $this->validator->getValidated();

    // Génération d'un code unique de 20 caractères
    $caracteres = 'ABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789';
    $code = substr(str_shuffle($caracteres . time()), 0, 20);
    $donnees['code'] = $code;

    // Insertion
    $this->model->set_message($donnees);

    // Données pour la vue succès
    $data['le_sujet']  = $donnees['sujet'];
    $data['le_code']   = $donnees['code'];

    return view('templates/haut', ['titre' => 'Message envoyé !'])
        . view('menu_visiteur')
        . view('message/message_succes', $data)
        . view('templates/bas');
    }











    // liste tous les messages
    public function lister_messages()
    {
        $session = session();

        // Sécurité ADMIN
        if (! $session->has('user') || $session->get('statut') !== "Administrateur") {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        $data['messages'] = $this->model->get_all_messages();
        $data['titre'] = "Messages des visiteurs";

        return view('templates/haut2')
            . view('menu_administrateur')
            . view('message/list_messages', $data)
            . view('templates/bas2');
    }


    // affichage d'un message et le champ de reponse
    public function afficher_message($id)
    {
        $session = session();

        if (! $session->has('user') || $session->get('statut') !== "Administrateur") {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        $data['message'] = $this->model->get_message($id);
        $data['titre'] = "Message du visiteur";

        return view('templates/haut2')
            . view('menu_administrateur')
            . view('message/repondre_message', $data)
            . view('templates/bas2');
    }

    // soumission de la reponse
    public function repondre($id)
    {
        $session = session();

        if (! $session->has('user') || $session->get('statut') !== "Administrateur") {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        if (! $this->validate([
            'reponse' => 'required'
        ], [
            'reponse' => [
                'required' => 'Veuillez répondre au message !'
            ]
        ])) {
            return redirect()->back()->with('error', 'Veuillez répondre au message !');
        }

        $admin_id = $session->get('cpt_id');
        $reponse  = $this->request->getPost('reponse');

        $this->model->repondre_message($id, $admin_id, $reponse);

        return redirect()->to(base_url('index.php/admin/contact'));
    }





}

