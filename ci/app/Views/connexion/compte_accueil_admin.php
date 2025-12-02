
<h2 class="mb-4">Mes prochaines réservations</h2>

<?php if (empty($reservations)) : ?>

    <div class="alert alert-info">
        Vous n’avez aucune réservation à venir.
    </div>

<?php else : ?>

<table class="table table-bordered table-hover">
    <thead class="table-dark">
        <tr>
            <th>Date et heure</th>
            
            <th>Ressource réservée</th>
            <th>Participants</th>
        </tr>
    </thead>
    <tbody>
        <?php foreach ($reservations as $res): ?>
            <tr>
                <td><?= $res['res_date_debut'] ?></td>
                
                <td><?= $res['rsc_nom'] ?></td>
                <td>
                    <?php foreach ($res['participants'] as $p): ?>
                        <?= $p['pfl_prenom'] . " " . strtoupper($p['pfl_nom']) ?><br>
                    <?php endforeach; ?>
                </td>
            </tr>
        <?php endforeach; ?>
    </tbody>
</table>

<?php endif; ?>
