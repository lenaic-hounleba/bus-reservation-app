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
									<h1>Suivre une demande</h1>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
            </section>
<!-- section close -->
































<section aria-label="follow-request-section">
    <div class="container" style="margin-top: 50px; margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-8 offset-md-2">

                <h2 class="text-center fw-bold mb-4">
                    <?php echo $titre; ?>
                </h2>

                <p class="text-center mb-4">
                    Saisissez votre code de 20 caractères pour suivre votre demande.
                </p>

                <?php if (!empty($erreur)) : ?>
                    <div class="alert alert-danger text-center">
                        <?= $erreur ?>
                    </div>
                <?php endif; ?>

                <?php echo form_open('/message/verifier', ['id' => 'suivi_form', 'class' => 'form-border']); ?>
                <?= csrf_field() ?>

                <div class="field-set">
                    <label for="code">Code de suivi :</label>
                    <input type="text" name="code" id="code" class="form-control" value="<?= set_value('code') ?>">
                    <?= validation_show_error('code') ?>
                </div>

                <div class="text-center" style="margin-top: 30px;">
                    <input type="submit" value="Visualiser" class="btn-main color-2" style="margin-right: 15px;"> OU
                    <a href="<?php echo base_url('index.php/contact/ajouter'); ?>" class="btn-main" style="background:#444; margin-left: 15px;"> Faire une demande </a>
                </div>

                <?php echo form_close(); ?>

            </div>
        </div>
    </div>
</section>

