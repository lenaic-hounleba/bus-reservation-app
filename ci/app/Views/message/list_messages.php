<div class="container mt-4">
<h2><?= $titre ?></h2>

<?php if (empty($messages)): ?>
    <div class="alert alert-info">Aucune demande de visiteur pour le moment !</div>
<?php else: ?>

<table class="table table-hover table-bordered">
    <thead class="table-dark">
        <tr>
            <th>Code</th>
            <th>Email</th>
            <th>Date</th>
            <th>Sujet</th>
            <th>Contenu</th>
            <th>Réponse</th>
            <th>Repondu par :</th>
            <th>Actions</th>
        </tr>
    </thead>
    <tbody>

    <?php foreach ($messages as $m): ?>
        <tr class="<?= empty($m['msg_reponse']) ? 'table-warning' : '' ?>">
            <td><?= esc($m['msg_code']) ?></td>
            <td><?= esc($m['msg_email']) ?></td>
            <td><?= esc($m['msg_date']) ?></td>
            <td><?= esc($m['msg_sujet']) ?></td>
            <td><?= nl2br(esc($m['msg_contenu'])) ?></td>

            <td>
                <?php if (empty($m['msg_reponse'])): ?>
                    <span class="text-danger">-</span>
                <?php else: ?>
                    <?= nl2br(esc($m['msg_reponse'])) ?>
                <?php endif; ?>
            </td>

            <td><?= $m['admin_pseudo'] ? esc($m['admin_pseudo']) : '-' ?></td>

            <td>
                <?php if (empty($m['msg_reponse'])): ?>
                    <a href="<?= base_url('index.php/admin/contact/'.$m['msg_id']) ?>"
                       class="btn btn-sm btn-primary">
                        <i class="fa-solid fa-reply"></i>
                    </a>
                <?php else: ?>
                    <a href="<?= base_url('index.php/admin/contact/'.$m['msg_id']) ?>"
                       class="btn btn-sm btn-secondary">
                        <i class="fa-solid fa-eye"></i>
                    </a>
                <?php endif; ?>
            </td>

        </tr>
    <?php endforeach; ?>

    </tbody>
</table>

<?php endif; ?>
</div>
