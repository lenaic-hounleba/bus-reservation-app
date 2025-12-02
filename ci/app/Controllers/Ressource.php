<?php

namespace App\Controllers;
use App\Models\Db_model;

class Ressource extends BaseController
{
    protected $model;

    public function __construct()
    {
        helper(['form']);
        $this->model = model(Db_model::class);
        

    }

    public function liste_ressources()
    {
        $session = session();

        // Sécurité : ADMIN uniquement
        if (! $session->has('user') || $session->get('statut') !== "Administrateur") {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        $data['titre'] = "Gestion des ressources";
        $data['ressources'] = $this->model->get_all_resources_full();

        return view('templates/haut2')
            . view('menu_administrateur')
            . view('admin/ressources_liste', $data)
            . view('templates/bas2');
    }








// ajout de ressource
public function ajouter()
    {
        $session = session();

        // sécurité : admin uniquement
        if (! $session->has('user') || $session->get('statut') !== "Administrateur") {
            return redirect()->to(base_url('index.php/compte/connecter'));
        }

        // titre
        $data['titre'] = "Ajouter une ressource";

        // FORMULAIRE SOUMIS 
        if ($this->request->getMethod() === "POST")
        {
            // VALIDATION
            if (! $this->validate(
                [
                    'rsc_nom' => 'required|min_length[2]',
                    'rsc_jauge' => 'required|integer',

                    'rsc_photo' => [
                        'label' => 'Photo',
                        'rules' => 'uploaded[rsc_photo]'
                                   .'|is_image[rsc_photo]'
                                   .'|mime_in[rsc_photo,image/jpg,image/jpeg,image/png]'
                                   .'|max_size[rsc_photo,2048]',
                    ],

                    'rsc_url' => [
                        'label' => 'PDF matériel',
                        'rules' => 'uploaded[rsc_url]'
                                   .'|mime_in[rsc_url,application/pdf]'
                                   .'|max_size[rsc_url,4096]',
                    ],
                ],
                [
                    'rsc_nom' => [
                        'required' => 'Veuillez saisir un nom.',
                        'min_length' => 'Le nom est trop court.'
                    ],
                    'rsc_jauge' => [
                        'required' => 'Veuillez préciser la jauge.',
                        'integer' => 'La jauge doit être un entier.'
                    ],
                    'rsc_photo' => [
                        'uploaded' => 'Veuillez ajouter une photo.',
                        'is_image' => 'Le fichier doit être une image.',
                        'mime_in' => 'Format image invalide.',
                        'max_size' => 'Image trop lourde (max 2 Mo).'
                    ],
                    'rsc_url' => [
                        'uploaded' => 'Veuillez ajouter le PDF.',
                        'mime_in' => 'Format PDF requis.',
                        'max_size' => 'PDF trop volumineux (max 4 Mo).'
                    ]
                ]
            )) 
            {
                // ERREUR VALIDATION , réaffichage du formulaire
                return view('templates/haut2', $data)
                     .view('menu_administrateur')
                     .view('admin/ressources_ajouter', $data)
                     .view('templates/bas2');
            }

            // VALIDE: récupérer données
            $valid = $this->validator->getValidated();

            // gérer les fichiers
            $photo = $this->request->getFile('rsc_photo');
            $pdf   = $this->request->getFile('rsc_url');

            // $photoName = $photo->getRandomName();
            // $pdfName   = $pdf->getRandomName();

            $base = 'resaweb_' . url_title($valid['rsc_nom'], '_', true);

            $photoExt = $photo->getExtension();
            $pdfExt   = $pdf->getExtension();

            $photoName = $base . '_photo.' . $photoExt;
            $pdfName   = $base . '_pdf.' . $pdfExt;


            // déplacer fichiers
            $photo->move(FCPATH . "bootstrap2/assets/images/", $photoName);
            $pdf->move(FCPATH . "bootstrap2/assets/pdf/", $pdfName);
            

            // insertion en DB
            $this->model->insert_ressource(
                $valid['rsc_nom'],
                $photoName,
                $this->request->getPost('rsc_description'),
                $valid['rsc_jauge'],
                $pdfName
            );

            // données page de succès
            $data['nom'] = $valid['rsc_nom'];
            $data['photo'] = $photoName;

            // vue de succès
            return view('templates/haut2', $data)
                 .view('menu_administrateur')
                 .view('admin/ressource_succes', $data)
                 .view('templates/bas2');
        }

        // AFFICHAGE PAGE FORMULAIRE
        return view('templates/haut2', $data)
             .view('menu_administrateur')
             .view('admin/ressources_ajouter', $data)
             .view('templates/bas2');
    }



    
     

 
     // suppression (POST)
     public function supprimer($id)
{
    $session = session();
    if (! $session->has('user') || $session->get('statut') !== "Administrateur") {
        return redirect()->to(base_url('index.php/compte/connecter'));
    }

    $this->model->delete_ressource_cascade($id);

    return redirect()->to(base_url('index.php/admin/ressources'));
}


}
