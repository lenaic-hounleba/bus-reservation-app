<div class="container mt-4">
    <h2 class="mb-4"><?= esc($titre) ?></h2>

    <?= form_open('admin/reservations') ?>

    <div class="mb-3">
        <label class="form-label">Choisissez une date :</label>
        <input type="date" name="date_resa" class="form-control" value="<?= set_value('date_resa') ?>">
        <?= validation_list_errors() ?>
    </div>

    <button class="btn btn-primary">Voir les réservations</button>

    </form>
</div>
