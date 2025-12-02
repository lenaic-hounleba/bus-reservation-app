<div class="container mt-4">
    <h2 class="mb-4">
        Séances réservées du <?= esc($date_choisie) ?> (Admin)
    </h2>

    <?php if (empty($reservations)): ?>
        <div class="alert alert-info">
            Aucune ressource trouvée.
        </div>
        <?php return; ?>
    <?php endif; ?>

    <?php
    // déterminer si au moins une réservation existe réellement
    $hasAnyReservation = false;
    foreach ($reservations as $r) {
        if (!empty($r['res_id'])) {
            $hasAnyReservation = true;
            break;
        }
    }
    ?>

    <?php if (! $hasAnyReservation): ?>
        <div class="alert alert-info">
            Aucune réservation pour l'instant !
        </div>
    <?php endif; ?>

    <table class="table table-bordered table-hover">
    <thead class="table-dark">
        <tr>
            <th>Ressource</th>
            <th>Date début</th>
            <th>Conducteur</th>
            <th>Passagers</th>
        </tr>
    </thead>

    <tbody>
<?php
$lastRsc = null;

foreach ($reservations as $r):

    if ($lastRsc !== $r['rsc_id']) {
        $lastRsc = $r['rsc_id'];
?>
        <tr style="background:#ffe4ff;font-weight:bold;">
            <td><?= esc($r['rsc_nom']) ?></td>
            <td></td>
            <td></td>
            <td></td>
        </tr>

        <?php if ($r['res_id'] === null): ?>
            <tr>
                <td></td>
                <td colspan="3" class="text-muted">
                    Aucune réservation pour cette ressource.
                </td>
            </tr>
        <?php endif; ?>
<?php
    }

    if ($r['res_id'] !== null):
?>
        <tr>
            <td></td>
            <td><?= esc($r['res_date_debut']) ?></td>
            <td><?= esc($r['responsable']) ?></td>
            <td><?= esc($r['participants']) ?></td>
        </tr>
<?php 
    endif;

endforeach;
?>
</tbody>

</table>

</div>
