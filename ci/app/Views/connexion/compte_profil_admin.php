<h2 class="mb-4">Mon profil</h2>

<table class="table table-bordered table-striped table-hover">
    <tbody>
        <tr><th>Nom</th><td><?= $profil->pfl_nom ?></td></tr>
        <tr><th>Prénom</th><td><?= $profil->pfl_prenom ?></td></tr>
        <tr><th>Pseudo</th><td><?= $profil->cpt_pseudo ?></td></tr>
        <tr><th>Email</th><td><?= $profil->pfl_email ?></td></tr>
        <tr><th>Téléphone</th><td><?= $profil->pfl_telephone ?></td></tr>
        <tr><th>Date de naissance</th><td><?= $profil->pfl_date_naissance ?></td></tr>
        <tr><th>Adresse</th><td><?= $profil->pfl_adresse ?></td></tr>
        <tr><th>Ville</th><td><?= $profil->ville ?> (<?= $profil->vll_code_postal ?>)</td></tr>
        <tr><th>Statut</th><td><?= $profil->pfl_statut ?></td></tr>
        <tr><th>État du compte</th><td><?= $profil->cpt_etat ?></td></tr>
    </tbody>
</table>
