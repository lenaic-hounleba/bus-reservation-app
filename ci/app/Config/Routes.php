<?php

use CodeIgniter\Router\RouteCollection;

/**
 * @var RouteCollection $routes
 */
// $routes->get('/', 'Home::index');


use App\Controllers\Accueil;
// $routes->get('/', [Accueil::class, 'afficher']);
$routes->get('/', [Accueil::class, 'index']);


// Route vers le controller Compte 
use App\Controllers\Compte;
$routes->get('compte/lister', [Compte::class, 'lister']);


// Route vers le controller Actualite
use App\Controllers\Actualite;
$routes->get('actualite/afficher', [Actualite::class, 'afficher']);
$routes->get('actualite/afficher/(:num)', [Actualite::class, 'afficher']);



//suivi message
use App\Controllers\Message;
$routes->get('message/faire_suivi', [Message::class, 'faire_suivi']);
$routes->get('message/faire_suivi/(:any)', [Message::class, 'faire_suivi']);

$routes->get('message/verifier', [Message::class, 'verifier']);   // charger le formulaire de code

$routes->post('message/verifier', [Message::class, 'verifier']);  // grace au formulaire pour le code


//création de compte
$routes->get('compte/creer', [Compte::class, 'creer']);
$routes->post('compte/creer', [Compte::class, 'creer']);


// Formulaire de contact (affichage + validation)
$routes->get('contact/ajouter', [Message::class, 'ajouter']);
$routes->post('contact/ajouter', [Message::class, 'ajouter']);


// connexion 
$routes->get('compte/connecter', [Compte::class, 'connecter']);
$routes->post('compte/connecter', [Compte::class, 'connecter']);

// profil
$routes->get('compte/afficher_profil', [Compte::class, 'afficher_profil']);

// déconnexion
$routes->get('compte/deconnecter', [Compte::class, 'deconnecter']);

//accueil membre
$routes->get('membre/accueil', [Compte::class, 'accueil_membre']);

//accueil admin
$routes->get('administrateur/accueil', [Compte::class, 'accueil_admin']);

// liste adhérents (espace membre)
$routes->get('membre/liste_adherents', [Compte::class, 'lister_adherents']);

// liste de tous les comptes et profils pour les admin
$routes->get('admin/comptes-profils', [Compte::class, 'comptes_profils']);


// gestion des messages par les admins
$routes->get('admin/contact', [Message::class, 'lister_messages']);
$routes->get('admin/contact/(:num)', [Message::class, 'afficher_message']);
$routes->post('admin/contact/(:num)/repondre', [Message::class, 'repondre']);