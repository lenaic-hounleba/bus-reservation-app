<?php

namespace App\Controllers;
use App\Models\Db_model;

class Reservation extends BaseController
{
    protected $model;

    public function __construct()
    {
        $this->model = model(Db_model::class);
        helper(['form']);
    }


    // reservations pour une date precise membre
   public function reservations_par_jour()
{
    $session = session();

    // sécurité : membre uniquement
    if (! $session->has('user') || $session->get('statut') !== "Membre") {
        return redirect()->to(base_url('index.php/compte/connecter'));
    }

    $data['titre'] = "Séances réservées";

    // Formulaire non soumis : juste affichage du formulaire
    if ($this->request->getMethod() !== 'POST') {
        return view('templates/haut', $data)
             .view('menu_membre')
             .view('reservation/reservations_formulaire', $data)
             .view('templates/bas');
    }

    // Formulaire soumis : validation
    if (! $this->validate(
        [
            'date_resa' => 'required',
        ],
        [
            'date_resa' => [
                'required' => "Veuillez choisir une date.",
            ],
        ]
    )) {
        return view('templates/haut', $data)
             .view('menu_membre')
             .view('reservation/reservations_formulaire', $data)
             .view('templates/bas');
    }

    $date = $this->request->getPost('date_resa');

    // récupération des données en DB
    $data['reservations'] = $this->model->get_reservations_by_day($date);
    $data['date_choisie'] = $date;

    return view('templates/haut', $data)
         .view('menu_membre')
         .view('reservation/reservations_par_jour', $data)
         .view('templates/bas');
}


// réservations jour précise admin
public function reservations_admin()
{
    $session = session();

    // sécurité : admin uniquement
    if (! $session->has('user') || $session->get('statut') !== "Administrateur") {
        return redirect()->to(base_url('index.php/compte/connecter'));
    }

    $data['titre'] = "Séances réservées (administrateur)";

    // Formulaire non soumis : affichage
    if ($this->request->getMethod() !== 'POST') {
        return view('templates/haut2', $data)
             .view('menu_administrateur')
             .view('reservation/reservations_admin_formulaire', $data)
             .view('templates/bas2');
    }

    // Validation
    if (! $this->validate(
        [
            'date_resa' => 'required',
        ],
        [
            'date_resa' => [
                'required' => "Veuillez choisir une date.",
            ],
        ]
    )) {
        return view('templates/haut2', $data)
             .view('menu_administrateur')
             .view('reservation/reservations_admin_formulaire', $data)
             .view('templates/bas2');
    }

    $date = $this->request->getPost('date_resa');

    $data['reservations'] = $this->model->get_reservations_by_day($date);
    $data['date_choisie'] = $date;

    return view('templates/haut2', $data)
         .view('menu_administrateur')
         .view('reservation/reservations_admin_par_jour', $data)
         .view('templates/bas2');
}


}
