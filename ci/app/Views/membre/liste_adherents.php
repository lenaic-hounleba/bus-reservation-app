<!-- content begin -->
<div class="no-bottom no-top" id="content">
            <div id="top"></div>
            
            <!-- section begin -->
            <section id="subheader" class="jarallax text-light">
                <img src="<?php echo base_url();?>bootstrap/images/background/subheader.jpg" class="jarallax-img" alt="">
                    <div class="center-y relative text-center">
                        <div class="container">
                            <div class="row">
                                <div class="col-md-12 text-center">
									<h1>Liste des adhérents</h1>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
            </section>
<!-- section close -->

















































<div class="container" style="margin-top:30px; margin-bottom:50px;">
    <h2 class="mb-4"><?= isset($titre) ? esc($titre) : 'Liste des adhérents' ?></h2>

    <?php if (! empty($adherents) && is_array($adherents)) : ?>

        <div class="table-responsive">
            <table class="table table-striped table-hover">
                <thead class="table-light">
                    <tr>
                        <th>Nom</th>
                        <th>Prénom</th>
                        <th>Adresse e-mail</th>
                        <th>Téléphone</th>
                    </tr>
                </thead>
                <tbody>
                    <?php foreach ($adherents as $a) : ?>
                        <tr>
                            <td><?= htmlspecialchars($a['pfl_nom'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td><?= htmlspecialchars($a['pfl_prenom'], ENT_QUOTES, 'UTF-8') ?></td>
                            <td>
                                <a href="mailto:<?= htmlspecialchars($a['pfl_email'], ENT_QUOTES, 'UTF-8') ?>">
                                    <?= htmlspecialchars($a['pfl_email'], ENT_QUOTES, 'UTF-8') ?>
                                </a>
                            </td>
                            <td>
                                <?= !empty($a['pfl_telephone']) ? htmlspecialchars($a['pfl_telephone'], ENT_QUOTES, 'UTF-8') : '—' ?>
                            </td>
                        </tr>
                    <?php endforeach; ?>
                </tbody>
            </table>
        </div>

    <?php else : ?>
        <div class="alert alert-warning text-center">
            Aucun adhérent pour le moment !
        </div>
    <?php endif; ?>
</div>
