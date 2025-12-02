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
									<h1>Nous contacter</h1>
                                </div>
                                <div class="clearfix"></div>
                            </div>
                        </div>
                    </div>
            </section>
<!-- section close -->









<section aria-label="contact-section">
    <div class="container" style="margin-top: 50px; margin-bottom: 50px;">
        <div class="row">
            <div class="col-md-8 offset-md-2">

                <h2 class="text-center fw-bold mb-4">
                    <?php echo $titre; ?>
                </h2>

                <p class="text-center mb-4">
                    Remplissez le formulaire ci-dessous pour nous contacter.
                </p>

                <?= session()->getFlashdata('error') ?>

                <?php echo form_open('/contact/ajouter', ['id' => 'contact_form', 'class' => 'form-border']); ?>
                <?= csrf_field() ?>



                <div class="field-set">
                    <label for="email">Adresse e-mail :</label>
                    <input type="text" name="email" id="email" class="form-control" >
                    <?= validation_show_error('email') ?>
                </div>




                <div class="field-set">
                <label for="sujet">Sujet :</label>
                <select name="sujet" id="sujet" class="form-control" >
                    <option value="">-- Sélectionnez un sujet --</option>
                    <option value="Je souhaite me renseigner sur l'association.">Je souhaite me renseigner sur l'association.</option>
                    <option value="Je souhaite rejoindre l'association.">Je souhaite rejoindre l'association.</option>
                </select>
                <?= validation_show_error('sujet') ?>
                </div>


                
                <div class="field-set">
                    <label for="contenu">Message :</label>
                    <textarea name="contenu" id="contenu" class="form-control" rows="6" ></textarea>
                    <?= validation_show_error('contenu') ?>
                </div>

                <div class="text-center" style="margin-top: 30px;">
                    <input type="submit" value="Envoyer" class="btn-main color-2" style="margin-right: 15px;"> OU 
                    <a href="<?php echo base_url('index.php/message/verifier'); ?>" class="btn-main" style="background:#444; margin-left: 15px;"> Suivre une demande </a>
                </div>

                <?php echo form_close(); ?>

            </div>
        </div>
    </div>
</section>
