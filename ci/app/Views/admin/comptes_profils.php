<div class="container" style="margin-top:40px;margin-bottom:40px;">

    <h2 class="text-center fw-bold mb-4">Gestion des comptes et profils</h2>

    <div class="text-end mb-3">
        <a href="<?= base_url('index.php/compte/creer'); ?>" class="btn btn-success">
        Ajouter un compte invité
        </a>
        
    </div>

    <table class="table table-bordered table-hover table-striped">
        <thead class="table-dark">
            <tr>
                <th>Pseudo</th>
                <th>Nom</th>
                <th>Prénom</th>
                <th>Email</th>
                <th>Statut</th>
                <th>État</th>
                
            </tr>
        </thead>
        <tbody>
        <?php foreach ($comptes as $c): ?>
            <tr>
                <td><?= $c['cpt_pseudo']; ?></td>
                <td><?= $c['pfl_nom'] ?? '-'; ?></td>
                <td><?= $c['pfl_prenom'] ?? '-'; ?></td>
                <td><?= $c['pfl_email'] ?? '-'; ?></td>
                <td><?= $c['pfl_statut'] ?? 'Invité'; ?></td>
                <td><?= $c['cpt_etat']; ?></td>
                <!-- <td>
                    <i class="fa fa-eye text-secondary"></i>
                    <i class="fa fa-edit text-secondary"></i>
                    <i class="fa fa-ban text-secondary"></i>
                    <i class="fa fa-trash text-secondary"></i>
                </td> -->
            </tr>
        <?php endforeach; ?>
        </tbody>
    </table>

</div>
