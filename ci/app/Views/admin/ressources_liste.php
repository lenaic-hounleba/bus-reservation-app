<div class="container mt-4">
    <h2 class="mb-4"><?= esc($titre) ?></h2>


    <!-- bouton ajouter -->
    <?php if (session()->getFlashdata('message')): ?>
    <div class="alert alert-success"><?= session()->getFlashdata('message') ?></div>
<?php endif; ?>
<?php if (session()->getFlashdata('error')): ?>
    <div class="alert alert-danger"><?= session()->getFlashdata('error') ?></div>
<?php endif; ?>

<div class="mb-3">
    <a href="<?= base_url('index.php/admin/ressources/ajouter') ?>" class="btn btn-success">
        <i class="fa-solid fa-plus"></i> Ajouter une ressource
    </a>
</div>
<!-- fin btn -->

    <?php if (empty($ressources)): ?>
        <div class="alert alert-info">Aucune ressource réservable pour l'instant !</div>

    <?php else: ?>

    <table class="table table-bordered table-striped table-hover">
        <thead class="table-dark">
            <tr>
                <th>Photo</th>
                <th>Intitulé</th>
                <th>Jauge</th>
                <th>Détails</th>
            </tr>
        </thead>
        <tbody>
            <?php foreach ($ressources as $r): ?>
                <tr>
                    <td style="width:130px;">
                        <img src="<?= base_url('bootstrap2/assets/images/' . $r['rsc_photo']); ?>"
                             alt="photo ressource"
                             class="img-fluid rounded"
                             style="max-width:120px;">
                    </td>
                    <td><?= esc($r['rsc_nom']) ?></td>
                    <td><?= esc($r['rsc_jauge']) ?></td>
                    <td>
                       


                        <a href="<?= base_url('index.php/admin/ressources/'.$r['rsc_id']) ?>" class="btn btn-sm btn-primary">
        <i class="fa-solid fa-eye"></i>
    </a>

    <!-- Supprimer  -->
    <form action="<?= base_url('index.php/admin/ressources/supprimer/' . $r['rsc_id']) ?>"
          method="post"
          style="display:inline"
          onsubmit="return confirm('Confirmer la suppression de la ressource <?= addslashes($r['rsc_nom']) ?> ?');">
        <?= csrf_field() ?>
        <button type="submit" class="btn btn-sm btn-danger">
            <i class="fa-solid fa-trash"></i>
        </button>
    </form>
                    </td>
                </tr>
            <?php endforeach; ?>
        </tbody>
    </table>

    <?php endif; ?>
</div>

<style>
.table-hover tbody tr:hover {
    background-color: #f2f7fb;
}
</style>
