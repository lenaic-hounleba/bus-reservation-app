<div class="container" style="margin-top:50px; margin-bottom:50px;">
    <h2 class="text-center fw-bold mb-4"><?= $titre ?></h2>

    <?= session()->getFlashdata('error') ?>

    <?php echo form_open_multipart('admin/ressources/ajouter'); ?>


    <?= csrf_field() ?>

    <div class="mb-3">
        <label>Nom *</label>
        <input type="text" name="rsc_nom" class="form-control" value="<?= set_value('rsc_nom') ?>">
        <?= validation_show_error('rsc_nom') ?>
    </div>

    <div class="mb-3">
        <label>Photo *</label>
        <input type="file" name="rsc_photo" class="form-control">
        <?= validation_show_error('rsc_photo') ?>
    </div>

    <div class="mb-3">
        <label>Jauge *</label>
        <input type="number" name="rsc_jauge" class="form-control" value="<?= set_value('rsc_jauge') ?>">
        <?= validation_show_error('rsc_jauge') ?>
    </div>

    <div class="mb-3">
        <label>Description</label>
        <textarea name="rsc_description" class="form-control"><?= set_value('rsc_description') ?></textarea>
    </div>

    <div class="mb-3">
        <label>PDF Matériel *</label>
        <input type="file" name="rsc_url" class="form-control">
        <?= validation_show_error('rsc_url') ?>
    </div>

    <button class="btn btn-success">Ajouter</button>

    </form>
</div>
