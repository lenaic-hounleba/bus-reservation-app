<?php
namespace App\Controllers;

use App\Models\Db_model;
use CodeIgniter\Exceptions\PageNotFoundException;

class Accueil extends BaseController
{

    public function __construct()
    {
        //...
    }


    // public function afficher()
    // {
    //     return view('templates/haut')
    //         . view('affichage_accueil')
    //         . view('templates/bas');
    // }


    public function index()
    {
        $model = model(Db_model::class);

        $data['titre'] = "Accueil";
        $data['actualites'] = $model->get_last_actualites();

        return view('templates/haut', $data)
             . view('menu_visiteur')
             . view('affichage_accueil')
             . view('templates/bas');
    }
}
?>
