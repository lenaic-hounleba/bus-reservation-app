<div class="container" style="margin-top:50px; margin-bottom:50px;">
    <h2 class="text-center fw-bold mb-4">Ressource ajoutée avec succès !</h2>

    <p class="text-center">
        <strong>Nom :</strong> <?= esc($nom) ?>
    </p>

    <p class="text-center">
        <a href="<?= base_url('index.php/admin/ressources') ?>" class="btn btn-primary">
            Retour aux ressources
        </a>
    </p>
</div>
