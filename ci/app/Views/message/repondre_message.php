<div class="container mt-4">

<h2><?= $titre ?></h2>

<div class="card mb-3">
    <div class="card-body">
        <p><strong>Sujet :</strong> <?= esc($message->msg_sujet) ?></p>
        <p><strong>De :</strong> <?= esc($message->msg_email) ?></p>
        <p><strong>Date :</strong> <?= esc($message->msg_date) ?></p>
        <p><strong>Message :</strong><br><?= nl2br(esc($message->msg_contenu)) ?></p>
    </div>
</div>

<?php if (! empty($message->msg_reponse)): ?>

<div class="card">
    <div class="card-header">Réponse existante (Par : <?= esc($message->admin_pseudo) ?>)</div>
    <div class="card-body">
        <?= nl2br(esc($message->msg_reponse)) ?>
    </div>
</div>

<?php else: ?>

    <form action="<?= base_url('index.php/admin/contact/'.$message->msg_id.'/repondre') ?>" method="post">


    <?= csrf_field() ?>

    <?php if (session()->getFlashdata('error')): ?>
        <div class="alert alert-danger"><?= session()->getFlashdata('error') ?></div>
    <?php endif; ?>

    <div class="mb-3">
        <label for="reponse" class="form-label">Votre réponse :</label>
        <textarea name="reponse" id="reponse" class="form-control" rows="6"></textarea>
    </div>

    <button class="btn btn-success">Répondre</button>
<?= form_close() ?>

<?php endif; ?>

</div>
